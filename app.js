const config = require('./config.json');
const axios = require('axios');
const qs = require('qs');
const database = require('data-access');
const luxon = require('luxon');


async function requestToken() {
    if (luxon.DateTime.fromISO(config.testBench.token.expiration).plus({ seconds: config.testBench.token.expires_in }).diff(luxon.DateTime.now()).milliseconds > 0) {
        return config.testBench.token;
    }

    let data = {
        "grant_type": "password",
        "username": config.testBench.username,
        "password": config.testBench.password
    };

    let reqOptions = {
        url: config.baseUrl + '/token',
        method: "post",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
        },
        data: qs.stringify(data)
    }
    try {
        const { data } = await axios(reqOptions);
        console.log(data, "UPDATE CONFIG");
        return data;
    } catch (error) {
        console.log(error);
    }
}

async function fetchClients(reqOptions, clients) {
    try {
        reqOptions['url'] = config.baseUrl + '/api/Client/GetClient';

        clients.client.map(async clientData => {

            reqOptions.data = clientData;

            const { data } = await axios(reqOptions);

            data.client.map(async client => {
                console.log(await database.whiteLabelDB.insertClient(client.ClientId, client.IsClientEmailEnabled, client.IsClientSmsEnabled, client.SMSMonthlyClientLimit, client.Address || null, client.City || null, client.Region || null, client.IsActive, client.CustomClientLink1 || null,
                    client.CustomClientLink1DisplayName || null, client.CustomClientLink2 || null, client.CustomClientLink2DisplayName || null, client.CustomClientLink3 || null, client.CustomClientLink3DisplayName || null,
                    client.vCompanyName, client.CustomClientLink1ToolTip || null, client.CustomClientLink2ToolTip || null, client.CustomClientLink3ToolTip || null));
            });

        });
    } catch (error) {
        console.log(error, "fetchClients");
    }
}

async function fetchAssets(reqOptions, clients) {
    try {
        reqOptions['url'] = config.baseUrl + '/api/Asset/GetAllAssets';

        clients.client.map(async clientData => {

            reqOptions.data = clientData;

            const { data } = await axios(reqOptions);

            console.log(clientData.ClientId, data.Asset.length, "assets");

        });
    } catch (error) {
        console.log(error, "fetchAssets");
    }
}

async function importData(tokenData) {
    // check that the token data isn't expired
    let expiration = luxon.DateTime.fromISO(tokenData.expiration, { zone: 'utc' }).plus({ seconds: tokenData.expires_in });
    if (expiration.diff(luxon.DateTime.now()).milliseconds > 0) {
        let reqOptions = {
            url: config.baseUrl + '/api/Client/GetAllClients',
            method: "post",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${tokenData.access_token}`
            },
            data: {}
        }

        // get all clients
        const { data } = await axios(reqOptions);

        // fetch records
        // await fetchClients(reqOptions, data);
        await fetchAssets(reqOptions, data);
    }
}

//execute on Startup
requestToken().then(tokenData => {
    importData(tokenData);
}).catch(error => {
    console.log(error, "reuestTokenError");
})

