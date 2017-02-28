From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:27 +0100
Subject: [LTP] [COMMITTED] [PATCH 05/23] syscalls/accept4_01: Make use of
	tst_parse_opts()
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/accept4/accept4_01.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index 6072bfa..a49b23c 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -200,14 +200,30 @@ static int create_listening_socket(int port_num)
 	return lfd;
 }
 
+static char *opt_port;
+
+static option_t options[] = {
+	{"p:", NULL, &opt_port},
+	{NULL, NULL, NULL}
+};
+
+static void usage(void)
+{
+	printf("  -p      Port\n");
+}
+
 int main(int argc, char *argv[])
 {
 	struct sockaddr_in conn_addr;
 	int lfd;
-	int port_num;
+	int port_num = PORT_NUM;
+
+	tst_parse_opts(argc, argv, options, usage);
+
+	if (opt_port)
+		port_num = atoi(opt_port);
 
 	setup();
-	port_num = (argc > 1) ? atoi(argv[1]) : PORT_NUM;
 
 	memset(&conn_addr, 0, sizeof(struct sockaddr_in));
 	conn_addr.sin_family = AF_INET;
@@ -220,7 +236,7 @@ int main(int argc, char *argv[])
 	do_test(lfd, &conn_addr, SOCK_CLOEXEC, 0);
 	do_test(lfd, &conn_addr, 0, SOCK_NONBLOCK);
 	do_test(lfd, &conn_addr, SOCK_CLOEXEC, SOCK_NONBLOCK);
-	
+
 	close(lfd);
 	cleanup();
 	tst_exit();
-- 
2.10.2

