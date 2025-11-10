//MongoDB andyjan24_db_user IlN2A2EzlXppep0l

//mongodb+srv://andyjan24_db_user:VPrkJ9hQxAwZt6mk@migaz.ekuaaaf.mongodb.net/?appName=Migaz
const { MongoClient, ServerApiVersion } = require('mongodb');

const uri = "mongodb+srv://andyjan24_db_user:VPrkJ9hQxAwZt6mk@migaz.ekuaaaf.mongodb.net/?appName=Migaz";

const client = new MongoClient(uri, {
  serverApi: {
    version: ServerApiVersion.v1,
    strict: true,
    deprecationErrors: true,
  }
});

let db;

async function connect() {
  if (!db) {
    await client.connect();
    //db = client.db('sample_mflix'); // your DB name
    db = client.db('migaz'); // your DB name
  }
  return db;
}

module.exports = { connect };