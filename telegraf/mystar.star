load("logging.star", "log")
load("json.star", "json")

def apply(metric):
    j = json.decode(metric.fields.get("value"))
    #log.debug("This is j: {}".format(j))
    out_metrics = []
    meas = j["measurements"][0]["series"]
    #log.debug(str(j["measurements"][0]["series"]))
    #log.debug(str(len(meas["time"])))

    i = 0
    meas_count = len(meas["time"])

    # Iterate through each entry in the JSON and convert to the line protocol. Regardless of the number of measurements, all data points should be recognised.
    while i < meas_count:
        ts = j["measurements"][0]["ts"]  # + meas["time"][i]
        #log.debug(ts)
        for key in meas:
            if key == "time":
                continue
            new_metric = Metric(j["device"]["id"])
            new_metric.fields[key] = float(meas[key][i])
            new_metric.tags["testkey"] = "testval1"
            # new_metric.time = 1618578033261026200
            out_metrics.append(new_metric)
            #log.debug("key: {}".format(key))
            #log.debug("value: {}".format(meas[key][i]))
            #log.debug(str(new_metric))
        i = i + 1

    return out_metrics
