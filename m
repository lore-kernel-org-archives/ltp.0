From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 12 Nov 2019 18:11:31 +0300
Subject: [LTP] [PATCH 2/2] network/netstress: set default options value
 after arg parsing
In-Reply-To: <20191112151131.5740-1-alexey.kodanev@oracle.com>
References: <20191112151131.5740-1-alexey.kodanev@oracle.com>
Message-ID: <20191112151131.5740-2-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It fixes misleading warnings about multiple options being set:

$ netstress -H 127.0.0.1
tst_test.c:500: WARN: Option -H passed multiple times
tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
...

But for the result path 'rpath', don't create a file if the option
is not set.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index a5cc9a532..76d2fdb04 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -70,7 +70,7 @@ static int server_max_requests	= 3;
 static int client_max_requests	= 10;
 static int clients_num;
 static char *tcp_port;
-static char *server_addr	= "localhost";
+static char *server_addr;
 static char *source_addr;
 static char *server_bg;
 static int busy_poll		= -1;
@@ -101,7 +101,7 @@ static int sfd;
 static int wait_timeout = 60000;
 
 /* in the end test will save time result in this file */
-static char *rpath = "tfo_result";
+static char *rpath;
 static char *port_path = "netstress_port";
 static char *log_path = "netstress.log";
 
@@ -517,7 +517,8 @@ static void client_run(void)
 		SAFE_CLOSE(cfd);
 	}
 	/* the script tcp_fastopen_run.sh will remove it */
-	SAFE_FILE_PRINTF(rpath, "%ld", clnt_time);
+	if (rpath)
+		SAFE_FILE_PRINTF(rpath, "%ld", clnt_time);
 
 	tst_res(TPASS, "test completed");
 }
@@ -867,6 +868,9 @@ static void setup(void)
 	if (tst_parse_int(Aarg, &max_rand_msg_len, 10, max_msg_len))
 		tst_brk(TBROK, "Invalid max random payload size '%s'", Aarg);
 
+	if (!server_addr)
+		server_addr = "localhost";
+
 	if (max_rand_msg_len) {
 		max_rand_msg_len -= min_msg_len;
 		unsigned int seed = max_rand_msg_len ^ client_max_requests;
-- 
2.20.1

