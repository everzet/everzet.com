const jsonResponse = (object, statusCode = 200) => ({
  statusCode,
  body: JSON.stringify(object),
});

exports.lambdaHandler = async (event, context) => {
  console.log({ event, context });
  return jsonResponse({ token: "SOME_RANDOM_TOKEN" });
};
