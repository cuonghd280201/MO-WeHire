const String apiServer = String.fromEnvironment(
  'SERVER',
  defaultValue: 'https://wehireapi.azurewebsites.net/api',
);

const jwtSecret = 'booking_mobile_app';

const JWT_STORAGE_KEY = 'jwt';
const IS_CONFIRM_STORAGE_KEY = 'isConfirm';

String IS_CONFIRM_VALUE = 'false';
String JWT_TOKEN_VALUE = '';
String devId = '';
String userId = '';
