From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:45 +0100
Subject: [LTP] [COMMITTED] [PATCH 23/23] syscalls/semctl07: Make use of
	tst_parse_opts()
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-23-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/semctl/semctl07.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
index 6e1bbf6..5d7fad3 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
@@ -61,9 +61,10 @@ int main(int argc, char *argv[])
 {
 	int status;
 	struct semid_ds buf_ds;
-
 	union semun arg;
 
+	tst_parse_opts(argc, argv, NULL, NULL);
+
 	setup();
 
 	arg.buf = &buf_ds;
-- 
2.10.2

