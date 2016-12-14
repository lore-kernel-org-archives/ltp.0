From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 14 Dec 2016 20:03:50 +0300
Subject: [LTP] [PATCH] network/netstress.c: change default setup of sysctl
	parameters
Message-ID: <1481735030-3629-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* By default 'netstress' using whatever is set in tcp_fastopen sysctl
  parameter. There are several advantages to do this:

  a. It allows to test default configuration in kernel;
  b. We can control this parameter externally and avoid races
     when server/client runs on the same machine;
  c. Simplifies code.

* Introduce new parameter '-t x' where x is the new value for
  tcp_fastopen sysctl parameter.

* Allow to set tcp_tw_reuse value with '-w' parameter. If not set,
  'netstress' won't change it in kernel.

* Remove 'run_force' parameter '-F'. It didn't do anything useful,
  instead, invoke tst_require_root() only if we're going to update
  sysctl parameter.

* update tcp_fastopen test with new options.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c            |  117 ++++++++++++--------
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |    4 +-
 2 files changed, 71 insertions(+), 50 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 26fd217..6cc5f4b 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -62,14 +62,13 @@ enum {
 	TFO_ENABLED = 0,
 	TFO_DISABLED,
 };
-static int tfo_support;
+static int tfo_value = -1;
 static int fastopen_api;
 
 static const char tfo_cfg[]		= "/proc/sys/net/ipv4/tcp_fastopen";
 static const char tcp_tw_reuse[]	= "/proc/sys/net/ipv4/tcp_tw_reuse";
 static int tw_reuse_changed;
 static int tfo_cfg_value;
-static int tfo_bit_num;
 static int tfo_cfg_changed;
 static int tfo_queue_size	= 100;
 static int max_queue_len	= 100;
@@ -93,6 +92,7 @@ static int clients_num		= 2;
 static char *tcp_port		= "61000";
 static char *server_addr	= "localhost";
 static int busy_poll		= -1;
+static int set_tcp_tw_reuse	= -1;
 static int use_udp;
 /* server socket */
 static int sfd;
@@ -103,10 +103,9 @@ static long wait_timeout = 60000000;
 /* in the end test will save time result in this file */
 static char *rpath		= "./tfo_result";
 
-static int force_run;
 static int verbose;
 
-static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg;
+static char *narg, *Narg, *qarg, *rarg, *Rarg, *aarg, *Targ, *barg, *targ;
 
 static const option_t options[] = {
 	/* server params */
@@ -125,25 +124,25 @@ static const option_t options[] = {
 	/* common */
 	{"g:", NULL, &tcp_port},
 	{"b:", NULL, &barg},
+	{"w", &set_tcp_tw_reuse, NULL},
 	{"U", &use_udp, NULL},
-	{"F", &force_run, NULL},
 	{"l", &net_mode, NULL},
 	{"o", &fastopen_api, NULL},
-	{"O", &tfo_support, NULL},
+	{"t:", NULL, &targ},
 	{"v", &verbose, NULL},
 	{NULL, NULL, NULL}
 };
 
 static void help(void)
 {
-	printf("\n  -F      Force to run\n");
-	printf("  -v      Verbose\n");
+	printf("\n  -v      Verbose\n");
 	printf("  -o      Use old TCP API, default is new TCP API\n");
-	printf("  -O      TFO support is off, default is on\n");
+	printf("  -t x    Set tcp_fastopen value\n");
 	printf("  -l      Become TCP Client, default is TCP server\n");
 	printf("  -g x    x - server port, default is %s\n", tcp_port);
 	printf("  -b x    x - low latency busy poll timeout\n");
 	printf("  -U      use UDP\n");
+	printf("  -w      set tcp_tw_reuse sysctl knob\n");
 
 	printf("\n          Client:\n");
 	printf("  -H x    x - server name or ip address, default is '%s'\n",
@@ -191,9 +190,6 @@ static void do_cleanup(void)
 		net.cleanup();
 
 	if (tfo_cfg_changed) {
-		SAFE_FILE_SCANF(NULL, tfo_cfg, "%d", &tfo_cfg_value);
-		tfo_cfg_value &= ~tfo_bit_num;
-		tfo_cfg_value |= !tfo_support << (tfo_bit_num - 1);
 		tst_resm(TINFO, "unset '%s' back to '%d'",
 			tfo_cfg, tfo_cfg_value);
 		SAFE_FILE_PRINTF(NULL, tfo_cfg, "%d", tfo_cfg_value);
@@ -729,6 +725,62 @@ static void check_opt_l(const char *name, char *arg, long *val, long lim)
 	}
 }
 
+static void check_tfo_value(void)
+{
+	/* Check if we can write to tcp_fastopen knob. We might be
+	 * inside netns and either have read-only permission or
+	 * doesn't have the knob@all.
+	 */
+	if (access(tfo_cfg, W_OK) < 0) {
+		/* TODO check /proc/self/ns/ or TST_USE_NETNS env var */
+		tst_resm(TINFO, "can't read %s, assume server runs in netns",
+			tfo_cfg);
+		return;
+	}
+
+	SAFE_FILE_SCANF(NULL, tfo_cfg, "%d", &tfo_cfg_value);
+	tst_resm(TINFO, "'%s' is %d", tfo_cfg, tfo_cfg_value);
+
+	/* The check can be the first in this function but set here
+	 * to allow to print information about the currently set config
+	 */
+	if (tfo_value < 0)
+		return;
+
+	if (tfo_cfg_value == tfo_value)
+		return;
+
+	tst_require_root();
+
+	tst_resm(TINFO, "set '%s' to '%d'", tfo_cfg, tfo_value);
+
+	SAFE_FILE_PRINTF(cleanup, tfo_cfg, "%d", tfo_value);
+	tfo_cfg_changed = 1;
+}
+
+static void check_tw_reuse(void)
+{
+	if (set_tcp_tw_reuse < 0)
+		return;
+
+	if (access(tcp_tw_reuse, W_OK) < 0)
+		return;
+
+	int reuse_value = 0;
+
+	SAFE_FILE_SCANF(cleanup, tcp_tw_reuse, "%d", &reuse_value);
+	if (reuse_value) {
+		tst_resm(TINFO, "tcp_tw_reuse is already set");
+		return;
+	}
+
+	tst_require_root();
+
+	SAFE_FILE_PRINTF(cleanup, tcp_tw_reuse, "1");
+	tw_reuse_changed = 1;
+	tst_resm(TINFO, "set '%s' to '1'", tcp_tw_reuse);
+}
+
 static void setup(int argc, char *argv[])
 {
 	tst_parse_opts(argc, argv, options, help);
@@ -744,29 +796,18 @@ static void setup(int argc, char *argv[])
 	check_opt("q", qarg, &tfo_queue_size, 1);
 	check_opt_l("T", Targ, &wait_timeout, 0L);
 	check_opt("b", barg, &busy_poll, 0);
+	check_opt("t", targ, &tfo_value, 0);
 
-	if (!force_run)
-		tst_require_root();
-
-	if (!force_run && tst_kvercmp(3, 7, 0) < 0) {
+	if (tfo_value > 0 && tst_kvercmp(3, 7, 0) < 0) {
 		tst_brkm(TCONF, NULL,
 			"Test must be run with kernel 3.7 or newer");
 	}
 
-	if (!force_run && busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0) {
+	if (busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0) {
 		tst_brkm(TCONF, NULL,
 			"Test must be run with kernel 3.11 or newer");
 	}
 
-	/* check tcp fast open knob */
-	if (!force_run && access(tfo_cfg, F_OK) == -1)
-		tst_brkm(TCONF, NULL, "Failed to find '%s'", tfo_cfg);
-
-	if (!force_run) {
-		SAFE_FILE_SCANF(NULL, tfo_cfg, "%d", &tfo_cfg_value);
-		tst_resm(TINFO, "'%s' is %d", tfo_cfg, tfo_cfg_value);
-	}
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	switch (net_mode) {
@@ -776,7 +817,6 @@ static void setup(int argc, char *argv[])
 		net.init	= server_init;
 		net.run		= (use_udp) ? server_run_udp : server_run;
 		net.cleanup	= (use_udp) ? NULL : server_cleanup;
-		tfo_bit_num = 2;
 	break;
 	case CLIENT_HOST:
 		tst_resm(TINFO, "connection: addr '%s', port '%s'",
@@ -789,7 +829,6 @@ static void setup(int argc, char *argv[])
 		net.init	= client_init;
 		net.run		= client_run;
 		net.cleanup	= client_cleanup;
-		tfo_bit_num = 1;
 	break;
 	}
 
@@ -803,26 +842,8 @@ static void setup(int argc, char *argv[])
 			(net_mode == SERVER_HOST) ? "server" : "client",
 			(fastopen_api == TFO_ENABLED) ? "Fastopen" : "old");
 
-		tfo_support = TFO_ENABLED == tfo_support;
-		if (((tfo_cfg_value & tfo_bit_num) == tfo_bit_num)
-		      != tfo_support) {
-			int value = (tfo_cfg_value & ~tfo_bit_num)
-				| (tfo_support << (tfo_bit_num - 1));
-			tst_resm(TINFO, "set '%s' to '%d'", tfo_cfg, value);
-			SAFE_FILE_PRINTF(cleanup, tfo_cfg, "%d", value);
-			tfo_cfg_changed = 1;
-		}
-
-		int reuse_value = 0;
-		SAFE_FILE_SCANF(cleanup, tcp_tw_reuse, "%d", &reuse_value);
-		if (!reuse_value) {
-			SAFE_FILE_PRINTF(cleanup, tcp_tw_reuse, "1");
-			tw_reuse_changed = 1;
-			tst_resm(TINFO, "set '%s' to '1'", tcp_tw_reuse);
-		}
-
-		tst_resm(TINFO, "TFO support %s",
-			(tfo_support) ? "enabled" : "disabled");
+		check_tfo_value();
+		check_tw_reuse();
 	}
 
 	net.init();
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index e506b87..6b9a9ba 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -91,11 +91,11 @@ TST_CLEANUP="cleanup"
 tst_tmpdir
 
 tst_resm TINFO "using old TCP API"
-tst_netload $(tst_ipaddr rhost) $tfo_result TFO -o -O
+tst_netload $(tst_ipaddr rhost) $tfo_result TFO -o
 time_tfo_off=$(read_result_file)
 
 tst_resm TINFO "using new TCP API"
-tst_netload $(tst_ipaddr rhost) $tfo_result TFO
+tst_netload $(tst_ipaddr rhost) $tfo_result TFO -t 3
 time_tfo_on=$(read_result_file)
 
 tfo_cmp=$(( 100 - ($time_tfo_on * 100) / $time_tfo_off ))
-- 
1.7.1

