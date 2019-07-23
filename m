From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jul 2019 18:28:26 +0800
Subject: [LTP] [PATCH] setdomainname: use strlen() to get length of string
Message-ID: <20190723102826.9679-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The sizeof(new) is only to get the size of char *, and it's not corret to pass
it as 'len' in setdomainname(). Here replace by strlen() to get the correct number
of characters for string.

On x86_64, we get this failures if the LTP compilied in 32bit.

  -----Error Log-----
  setdomainname.h:24: INFO: Testing libc setdomainname()
  setdomainname01.c:24: FAIL: getdomainname() returned wrong domainname: 'test'
  setdomainname.h:27: INFO: Testing __NR_setdomainname syscall
  setdomainname01.c:24: FAIL: getdomainname() returned wrong domainname: 'test'
  -------------------

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/setdomainname/setdomainname01.c | 2 +-
 testcases/kernel/syscalls/setdomainname/setdomainname03.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname01.c b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
index 57d58ab42..1731af733 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname01.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
@@ -12,7 +12,7 @@ static void do_test(void)
 	char *new = TST_VALID_DOMAIN_NAME;
 	static char tmp[_UTSNAME_DOMAIN_LENGTH];
 
-	TEST(do_setdomainname(new, sizeof(new)));
+	TEST(do_setdomainname(new, strlen(new)));
 
 	if (TST_RET != 0)
 		tst_brk(TFAIL | TTERRNO, "setdomainname() failed: %d", TST_ERR);
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname03.c b/testcases/kernel/syscalls/setdomainname/setdomainname03.c
index e53ea8806..b8d17d8da 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname03.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname03.c
@@ -16,7 +16,7 @@ static void do_test(void)
 {
 	char *new = TST_VALID_DOMAIN_NAME;
 
-	TEST(do_setdomainname(new, sizeof(new)));
+	TEST(do_setdomainname(new, strlen(new)));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "unexpected exit code: %ld", TST_RET);
-- 
2.20.1

