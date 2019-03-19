From: Matthias Maennich <maennich@google.com>
Date: Tue, 19 Mar 2019 18:41:37 +0000
Subject: [LTP] [PATCH v4 3/3] sigpending: improve portability by using
	tst_get_bad_addr()
In-Reply-To: <20190319184137.8357-1-maennich@google.com>
References: <20190308163832.212631-1-maennich@google.com>
 <20190319184137.8357-1-maennich@google.com>
Message-ID: <20190319184137.8357-4-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 testcases/kernel/syscalls/sigpending/sigpending02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index 0419fbedb8be..94e51bb1638f 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -117,7 +117,7 @@ static void test_sigpending(void)
 static void test_efault_on_invalid_sigset(void)
 {
 	/* set sigset to point to an invalid location */
-	sigset_t *sigset = (sigset_t *)-1;
+	sigset_t *sigset = tst_get_bad_addr(NULL);
 
 	tested_sigpending(sigset);
 
-- 
2.21.0.225.g810b269d1ac-goog

