# Flutter y Dialogflow

Esta aplicación hace uso de un agente creado en Dialogflow. Para la integración, se requieren los siguientes componentes dentro del `pubspec.yaml`:

```yaml
dependencies:
  ...
  hive: ^2.0.4
  path_provider: ^2.0.2
  provider: ^5.0.0
  cupertino_icons: ^1.0.2
  bubble: ^1.2.1
  intl: ^0.17.0
  flutter_dialogflow: ^0.1.3
```

Dentro de la carpeta `assets/dialogflow`, se encuentran las credenciales del chatbot en un archivo llamado `service.json`
