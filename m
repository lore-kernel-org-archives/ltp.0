From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Mar 2020 14:47:06 +0100
Subject: [LTP] [PATCH 1/2] tst_test: Add support for needs_devices
In-Reply-To: <20200327134707.4532-1-chrubis@suse.cz>
References: <20200327134707.4532-1-chrubis@suse.cz>
Message-ID: <20200327134707.4532-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Which is a list of environment variables needed for a test.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h |  3 +++
 lib/tst_test.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 84b6a940f..75d6632a2 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -213,6 +213,9 @@ struct tst_test {
 	/* NULL terminated array of needed kernel drivers */
 	const char * const *needs_drivers;
 
+	/* NULL terminated array of devices */
+	const char *const *needs_devices;
+
 	/*
 	 * NULL terminated array of (/proc, /sys) files to save
 	 * before setup and restore after cleanup
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 9479264b2..da7324b78 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -464,6 +464,22 @@ static void print_test_tags(void)
 	printf("\n");
 }
 
+static void print_test_devices(void)
+{
+	const char *const *devices = tst_test->needs_devices;
+	int i;
+
+	if (!devices)
+		return;
+
+	printf("\nNeeded devices\n--------------\n");
+
+	for (i = 0; devices[i]; i++)
+		printf("%s\n", devices[i]);
+
+	printf("\n");
+}
+
 static void check_option_collision(void)
 {
 	unsigned int i, j;
@@ -543,6 +559,7 @@ static void parse_opts(int argc, char *argv[])
 		case 'h':
 			print_help();
 			print_test_tags();
+			print_test_devices();
 			exit(0);
 		case 'i':
 			iterations = atoi(optarg);
@@ -890,6 +907,21 @@ static void do_setup(int argc, char *argv[])
 				tst_brk(TCONF, "%s driver not available", name);
 	}
 
+	if (tst_test->needs_devices) {
+		int i;
+		const char *name;
+		int exit = 0;
+
+		for (i = 0; (name = tst_test->needs_devices[i]); i++) {
+			if (!getenv(name)) {
+				tst_res(TINFO, "%s device env variable mising", name);
+				exit = 1;
+			}
+		}
+		if (exit)
+			tst_brk(TCONF, "Device(s) not passed to the test");
+	}
+
 	if (tst_test->format_device)
 		tst_test->needs_device = 1;
 
-- 
2.24.1

