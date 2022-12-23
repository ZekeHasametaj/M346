exports.handler = async (event, context) => {
  const file = event.Records[0].s3.object;

  // Return a success response
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: String(file),
    }),
  };
};
