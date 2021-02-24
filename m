From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Feb 2021 17:50:43 +0100
Subject: [LTP] [PATCH v2 3/5] lib: Add hardware discovery code
In-Reply-To: <20210224165045.17738-1-chrubis@suse.cz>
References: <20210224165045.17738-1-chrubis@suse.cz>
Message-ID: <20210224165045.17738-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

See lib/tst_hardware.h for details.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_hwconf.h |  13 +++
 include/tst_test.h   |   3 +
 lib/tst_hardware.c   | 218 +++++++++++++++++++++++++++++++++++++++++++
 lib/tst_hardware.h   |  83 ++++++++++++++++
 lib/tst_test.c       |  30 ++++++
 5 files changed, 347 insertions(+)
 create mode 100644 include/tst_hwconf.h
 create mode 100644 lib/tst_hardware.c
 create mode 100644 lib/tst_hardware.h

diff --git a/include/tst_hwconf.h b/include/tst_hwconf.h
new file mode 100644
index 000000000..5b0b95441
--- /dev/null
+++ b/include/tst_hwconf.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020-2021 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_HWCONF_H__
+#define TST_HWCONF_H__
+
+#include "tst_json.h"
+
+struct tst_json_buf *tst_hwconf_get(void);
+
+#endif	/* TST_HWCONF_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 1fbebe752..bd6de601e 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -230,6 +230,9 @@ struct tst_test {
 	/* NULL terminated array of needed kernel drivers */
 	const char * const *needs_drivers;
 
+	/* Unique hardware identifier */
+	const char *needs_hardware;
+
 	/*
 	 * NULL terminated array of (/proc, /sys) files to save
 	 * before setup and restore after cleanup
diff --git a/lib/tst_hardware.c b/lib/tst_hardware.c
new file mode 100644
index 000000000..c67c9b5c6
--- /dev/null
+++ b/lib/tst_hardware.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020-2021 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "tst_hardware.h"
+#include "tst_hwconf.h"
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+static struct tst_hwconf *cur_conf;
+static char *reconfigure_path;
+static struct tst_hwconf *conf_root;
+static unsigned int conf_cnt;
+
+static int new_hwconf(char *buf, size_t start_off, size_t end_off)
+{
+	struct tst_hwconf *conf = malloc(sizeof(struct tst_hwconf));
+
+	if (!conf) {
+		tst_res(TWARN, "malloc() failed!");
+		return 0;
+	}
+
+	memset(conf, 0, sizeof(*conf));
+
+	conf->json.json = buf + start_off;
+	conf->json.len = end_off - start_off;
+
+	struct tst_json_val val = {
+		.buf = conf->uid,
+		.buf_size = sizeof(conf->uid)
+	};
+
+	TST_JSON_OBJ_FOREACH(&conf->json, &val) {
+		switch (val.type) {
+		case TST_JSON_STR:
+			if (!strcmp(val.id, "uid"))
+				goto done;
+		break;
+		case TST_JSON_ARR:
+			tst_json_arr_skip(&conf->json);
+		break;
+		case TST_JSON_OBJ:
+			tst_json_obj_skip(&conf->json);
+		break;
+		default:
+		break;
+		}
+	}
+
+	free(conf);
+
+	return 1;
+done:
+	tst_json_reset(&conf->json);
+
+	if (!cur_conf)
+		conf_root = conf;
+	else
+		cur_conf->next = conf;
+
+	cur_conf = conf;
+	conf_cnt++;
+
+	tst_res(TINFO, "Added hardware configuration UID='%s'", conf->uid);
+
+	return 0;
+}
+
+static void parse_devices(struct tst_json_buf *json)
+{
+	struct tst_json_val val = {};
+	size_t start_off;
+
+	TST_JSON_ARR_FOREACH(json, &val) {
+		switch (val.type) {
+		case TST_JSON_OBJ:
+			start_off = json->sub_off;
+			tst_json_obj_skip(json);
+			if (new_hwconf(json->buf, start_off, json->off))
+				tst_json_err(json, "Missing 'uid' in hwconf entry!");
+		break;
+		case TST_JSON_ARR:
+		case TST_JSON_INT:
+		case TST_JSON_STR:
+			tst_json_err(json, "Invalid record in hwconf list!");
+		break;
+		case TST_JSON_VOID:
+		break;
+		}
+	}
+}
+
+static void save_reconfigure(const char *reconfigure, const char *ltproot)
+{
+	if (reconfigure[0] == '/') {
+		reconfigure_path = strdup(reconfigure);
+		if (!reconfigure_path)
+			tst_brk(TBROK, "strdup() failed");
+	} else {
+		if (asprintf(&reconfigure_path, "%s/%s", ltproot, reconfigure) < 0)
+			tst_brk(TBROK, "asprintf() failed");
+	}
+}
+
+unsigned int tst_hwlist_cnt(void)
+{
+	return conf_cnt;
+}
+
+static void reconfigure(void)
+{
+	if (!reconfigure_path)
+		return;
+
+	if (!cur_conf)
+		return;
+
+	const char *const argv[] = {reconfigure_path, cur_conf->uid, NULL};
+
+	tst_res(TINFO, "Running reconfigure '%s %s'", reconfigure_path, cur_conf->uid);
+
+	tst_cmd(argv, NULL, NULL, TST_CMD_TCONF_ON_MISSING);
+}
+
+void tst_hwlist_reset(void)
+{
+	cur_conf = conf_root;
+
+	reconfigure();
+}
+
+void tst_hwlist_next(void)
+{
+	cur_conf = cur_conf->next;
+
+	reconfigure();
+}
+
+struct tst_json_buf *tst_hwconf_get(void)
+{
+	if (!cur_conf)
+		return NULL;
+
+	return &cur_conf->json;
+}
+
+unsigned int tst_hwlist_discover(const char *hardware_uid)
+{
+	const char *ltproot = getenv("LTPROOT");
+	const char *hardware_discovery = getenv("HARDWARE_DISCOVERY");
+	char buf[2048];
+
+	if (!hardware_discovery) {
+		if (!ltproot) {
+			tst_res(TCONF, "No LTPROOT nor HARDWARE_DISCOVERY set!");
+			return 0;
+		}
+
+		snprintf(buf, sizeof(buf), "%s/hardware-discovery.sh", ltproot);
+
+		hardware_discovery = buf;
+	}
+
+	const char *const argv[] = {hardware_discovery, hardware_uid, NULL};
+
+	tst_res(TINFO, "Executing '%s %s'", hardware_discovery, hardware_uid);
+
+	//TODO: read the data from a pipe instead
+	unlink("/tmp/hwlist.json");
+	tst_cmd(argv, "/tmp/hwlist.json", NULL, TST_CMD_TCONF_ON_MISSING);
+
+	struct tst_json_buf *json = tst_json_load("/tmp/hwlist.json");
+
+	if (!json)
+		tst_brk(TBROK, "Failed to load JSON hardware description");
+
+	if (tst_json_start(json) != TST_JSON_OBJ)
+		tst_brk(TBROK, "JSON hardware description must start with object!");
+
+	struct tst_json_val val = {.buf = buf, .buf_size = sizeof(buf)};
+
+	TST_JSON_OBJ_FOREACH(json, &val) {
+		switch (val.type) {
+		case TST_JSON_STR:
+			if (!strcmp(val.id, "reconfigure"))
+				save_reconfigure(val.val_str, ltproot);
+			else
+				tst_json_err(json, "Invalid object attr id='%s'", val.id);
+		break;
+		case TST_JSON_INT:
+		case TST_JSON_OBJ:
+			tst_json_err(json, "Invalid object attr id='%s'", val.id);
+		break;
+		case TST_JSON_ARR:
+			if (!strcmp(val.id, "hwconfs"))
+				parse_devices(json);
+			else
+				tst_json_err(json, "Invalid array attr id='%s'", val.id);
+		break;
+		case TST_JSON_VOID:
+		break;
+		}
+	}
+
+	if (tst_json_is_err(json)) {
+		tst_json_err_print(stderr, json);
+		tst_brk(TBROK, "Failed to parse JSON hardware description");
+	}
+
+	return conf_cnt;
+}
diff --git a/lib/tst_hardware.h b/lib/tst_hardware.h
new file mode 100644
index 000000000..9abf5d648
--- /dev/null
+++ b/lib/tst_hardware.h
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020-2021 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Hardware discovery code.
+ *
+ * Each hardware type is uniquely identified by an hardware unique id. Test
+ * that needs a particular hardware sets the .needs_hardware field in the
+ * tst_test structure which is then passed to the discovery code.
+ *
+ * The discovery launches a script/binary that returns a JSON in a format:
+ *
+ * {
+ *  "reconfigure": "/path/to/reconfigure/script",
+ *  "hwconfs": [
+ *   {
+ *     "uid": "device_unique_id01",
+ *     ...
+ *   },
+ *   {
+ *    "uid": "device_unique_id02",
+ *    ...
+ *   }
+ *  ]
+ * }
+ *
+ * The optional reconfigure script could be used to set up the hardware, e.g.
+ * connect different serial ports together with relays, the only parameter
+ * it takes is the device uid. E.g. to set up the testing environment for the
+ * first device in the list above LTP will execute command:
+ * '/path/to/reconfigure/script "device_unique_id01"' etc.
+ *
+ * The second parameter in the JSON is "hwconfs" array that describes all
+ * available hardware configurations. These objects, apart from "uid" are not
+ * interpreted by the test libary but rather passed down to the test one object
+ * per test iteration.
+ */
+
+#ifndef TST_HARDWARE_H__
+#define TST_HARDWARE_H__
+
+#include "tst_json.h"
+
+struct tst_hwconf {
+	struct tst_hwconf *next;
+	/* unique id for the hardware configuration */
+	char uid[128];
+	/* buffer with the JSON description */
+	struct tst_json_buf json;
+};
+
+/*
+ * Discovers a hardware based on hardware_uid.
+ *
+ * Exits the test with TBROK on error and with TCONF if no hardware was discovered.
+ */
+unsigned int tst_hwlist_discover(const char *hardware_uid);
+
+/*
+ * Returns number of parsed entries.
+ */
+unsigned int tst_hwlist_cnt(void);
+
+/*
+ * Resets current tst_hwconf to point to the first hardware entry.
+ */
+void tst_hwlist_reset(void);
+
+/*
+ * Allows to loop over all entries in the hareware list.
+ *
+ * If needed calls the reconfigure script.
+ */
+void tst_hwlist_next(void);
+
+/*
+ * Free the hwlist.
+ */
+void tst_hwlist_free(void);
+
+#endif /* TST_HARDWARE_H__ */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 6bbee030b..3883ce227 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -27,6 +27,7 @@
 #include "tst_wallclock.h"
 #include "tst_sys_conf.h"
 #include "tst_kconfig.h"
+#include "tst_hardware.h"
 
 #include "old_resource.h"
 #include "old_device.h"
@@ -499,6 +500,14 @@ static void print_test_tags(void)
 	printf("\n");
 }
 
+static void print_test_hardware(void)
+{
+	if (!tst_test->needs_hardware)
+		return;
+
+	printf("\nNeeded hardware\n--------------\n%s\n\n", tst_test->needs_hardware);
+}
+
 static void check_option_collision(void)
 {
 	unsigned int i, j;
@@ -578,6 +587,7 @@ static void parse_opts(int argc, char *argv[])
 		case 'h':
 			print_help();
 			print_test_tags();
+			print_test_hardware();
 			exit(0);
 		case 'i':
 			iterations = atoi(optarg);
@@ -942,6 +952,18 @@ static void do_setup(int argc, char *argv[])
 				tst_brk(TCONF, "%s driver not available", name);
 	}
 
+	if (tst_test->needs_hardware) {
+		unsigned int cnt = tst_hwlist_discover(tst_test->needs_hardware);
+
+		if (!cnt) {
+			tst_brk(TCONF, "No hardware '%s' discovered",
+				tst_test->needs_hardware);
+		}
+
+		tst_res(TINFO, "Found %u hardware configurations for '%s'",
+			cnt, tst_test->needs_hardware);
+	}
+
 	if (tst_test->format_device)
 		tst_test->needs_device = 1;
 
@@ -1395,6 +1417,11 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	if (tst_test->test_variants)
 		test_variants = tst_test->test_variants;
 
+	if (tst_test->needs_hardware) {
+		test_variants = tst_hwlist_cnt();
+		tst_hwlist_reset();
+	}
+
 	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
 		if (tst_test->all_filesystems)
 			ret |= run_tcases_per_fs();
@@ -1403,6 +1430,9 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 		if (ret & ~(TCONF))
 			goto exit;
+
+		if (tst_test->needs_hardware)
+			tst_hwlist_next();
 	}
 
 exit:
-- 
2.26.2

