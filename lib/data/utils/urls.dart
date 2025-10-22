class Urls{

  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";

  static const String signUpUrl = "$_baseUrl/Registration";
  static const String loginUrl = "$_baseUrl/Login";
  static const String createNewTaskUrl = "$_baseUrl/createTask";
  static const String taskStatusCountUrl = "$_baseUrl/taskStatusCount";
  static const String updateProfileUrl = "$_baseUrl/ProfileUpdate";
  static const String recoverResetPasswordUrl = "$_baseUrl/RecoverResetPassword";
  static String recoverVerifyEmailUrl(String email) => "$_baseUrl/RecoverVerifyEmail/$email";
  static String recoverVerifyOtpUrl(String email, String otp) => "$_baseUrl/RecoverVerifyOtp/$email/$otp";
  static  String taskListUrl(String status) => "$_baseUrl/listTaskByStatus/$status";
  static const String progressTaskListUrl = "$_baseUrl/listTaskByStatus/Progress";
  static String updateStatusUrl(String id, String newStatus) => "$_baseUrl/updateTaskStatus/$id/$newStatus";
  static String deleteTask(String id) => "$_baseUrl/deleteTask/$id";
}