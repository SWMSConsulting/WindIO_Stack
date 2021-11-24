load("logging.star", "log")
load("json.star", "json")
load("time.star", "time")


def apply(metric):
    j = json.decode(metric.fields.get("value"))
    #log.debug("This is j: {}".format(j))
    out_metrics = []

    for k in j["measurements"]:
        meas = k["series"]
         
    # Iterate through each entry in the JSON and convert to the line protocol. Regardless of the number of measurements, all data points should be recognised.
        for i in range(len(meas["time"])):
            ts = j["measurements"][0]["ts"]
            log.debug(ts)
            for key in meas:
                if key == "time":
                    continue
                new_metric = Metric(j["device"]["id"])
                new_metric.fields[key] = float(meas[key][i])
                new_metric.tags["testkey"] = "testval1"
                new_metric.time = time.parse_time(ts, format="2006-01-02T15:04:05.999Z", location="CET").unix_nano + meas["time"][i]*1000000
                out_metrics.append(new_metric)
                log.debug("key: {}".format(key))
                log.debug("value: {}".format(meas[key][i]))
                log.debug(str(new_metric))
    return out_metrics