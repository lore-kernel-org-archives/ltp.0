From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:33 +0100
Subject: [LTP] [COMMITTED] [PATCH 11/23] syscalls/mallopt01: Make use of
	tst_parse_opts()
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-11-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/mallopt/mallopt01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
index 5df959e..416fc48 100644
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
@@ -70,6 +70,8 @@ int main(int argc, char *argv[])
 {
 	char *buf;
 
+	tst_parse_opts(argc, argv, NULL, NULL);
+
 	tst_tmpdir();
 
 	buf = SAFE_MALLOC(NULL, 20480);
-- 
2.10.2

