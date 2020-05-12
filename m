From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 May 2020 17:17:29 +0200
Subject: [LTP] [PATCH 2/3] [COMMITTED] lib: Fix two sprintf() warnings.
In-Reply-To: <20200512151730.10201-1-chrubis@suse.cz>
References: <20200512151730.10201-1-chrubis@suse.cz>
Message-ID: <20200512151730.10201-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_test.c: In function 'do_setup':
tst_test.c:69:21: warning: '%s' directive writing up to 1023 bytes into a region of size 1011 [-Wformat-overflow=]

tst_kconfig.c: In function 'tst_kconfig_read':
tst_kconfig.c:67:37: warning: '%s' directive output may be truncated writing up to 1023 bytes into a region of size 1018 [-Wformat-truncation=]

The buffer that we print the path along with variable name has to be
bigger than the path obviously.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_kconfig.c | 2 +-
 lib/tst_test.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 4b51413e5..d49187b6f 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -52,7 +52,7 @@ static char is_gzip;
 static FILE *open_kconfig(void)
 {
 	FILE *fp;
-	char buf[1024];
+	char buf[1064];
 	char path_buf[1024];
 	const char *path = kconfig_path(path_buf, sizeof(path_buf));
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 64cd3ac33..0e58060e0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -68,7 +68,7 @@ extern unsigned int tst_max_futexes;
 
 #define IPC_ENV_VAR "LTP_IPC_PATH"
 
-static char ipc_path[1024];
+static char ipc_path[1064];
 const char *tst_ipc_path = ipc_path;
 
 static char shm_path[1024];
-- 
2.26.2

