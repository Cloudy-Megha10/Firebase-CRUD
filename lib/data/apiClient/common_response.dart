class CommonResponse<T> {
  late bool status;
  late T? data;  // Marked as nullable since it might not always have data
  late String message;

  // Constructor for response without data
  CommonResponse.withoutData(
    this.status,
    this.message,
  );

  // Constructor for response with data
  CommonResponse(
    this.status,
    this.data,
    this.message,
  );
}
