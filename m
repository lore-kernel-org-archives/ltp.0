From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 25 Oct 2018 10:19:08 +0200
Subject: [LTP] [PATCH] keyctl05: use data that passes
	dns_resolver_preparse() check
Message-ID: <5693d852c76547d1b05f68c3ab9cb8728c5a9958.1540455393.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

commit bbb4c4323a4d ("dns: Allow the dns resolver to retrieve a server set")
introduced extra checks in dns_resolver_preparse(), which led to failure
when creating a key:
  keyctl05.c:119: BROK: unexpected error adding 'dns_resolver' key: EINVAL
  tst_test.c:884: BROK: Test 1 haven't reported results!

This patches replaces 2 zero-es with payload that passes checks introduced
by bbb4c4323a4d. Since these checks didn't exist before, this change
is backwards-compatible with earlier kernels without this patch.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/keyctl/keyctl05.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index 2384f7f67167..e2ed8ad4841b 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -194,8 +194,11 @@ static void test_update_setperm_race(void)
 
 static void do_test(unsigned int i)
 {
-	/* two 0 bytes is accepted as a dns_resolver key payload */
-	static char zeroes[2];
+	/*
+	 * We need to pass check in dns_resolver_preparse(),
+	 * give it dummy server list request.
+	 */
+	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00 };
 
 	switch (i) {
 	case 0:
@@ -203,8 +206,8 @@ static void do_test(unsigned int i)
 					 x509_cert, sizeof(x509_cert));
 		break;
 	case 1:
-		test_update_nonupdatable("dns_resolver",
-					 zeroes, sizeof(zeroes));
+		test_update_nonupdatable("dns_resolver", dns_res_payload,
+			sizeof(dns_res_payload));
 		break;
 	case 2:
 		test_update_setperm_race();
-- 
1.8.3.1

