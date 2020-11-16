const aws = require("aws-sdk");
const s3 = new aws.S3();

const parseFormEvent = (event) => {
  const formEntries = new URLSearchParams(event.body).entries();
  return Object.fromEntries(formEntries);
};

const uploadToS3Bucket = async (key, bodyObject) => {
  const params = {
    Bucket: process.env.CONTACTS_S3_BUCKET,
    Key: `${key}.json`,
    Body: JSON.stringify(bodyObject, null, 4),
  };
  return s3.upload(params).promise();
};

const htmlHeaderResponse = (error, statusCode) => ({
  statusCode,
  headers: { "Content-Type": "text/html" },
  body: `<html><body><h1>${error}</h1></body></html>`,
});

const redirectResponse = (location) => ({
  statusCode: 301,
  headers: { Location: location },
});

exports.lambdaHandler = async (event, context) => {
  const submissionKey = context.awsRequestId;
  console.log(`handling contact submission ${submissionKey}`);

  try {
    const formObject = parseFormEvent(event);
    await uploadToS3Bucket(submissionKey, formObject);
    console.log(`successfully processed form submission`);
  } catch (error) {
    console.error({ error });
    return htmlHeaderResponse(`Error occured during ${submissionKey}`, 500);
  }

  return redirectResponse("/");
};
