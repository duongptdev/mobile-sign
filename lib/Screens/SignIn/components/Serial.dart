class Serial {
  String _serialNo, _status;

  Serial(this._serialNo, this._status);

  factory Serial.fromJSON(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    } else {
      return Serial(json["serialNo"], json["status"]);
    }
  }

  get serialNo => this._serialNo;
  get status => this._status;
}
