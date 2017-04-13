From: Steve Ellcey <sellcey@cavium.com>
Date: Thu, 13 Apr 2017 10:46:00 -0700
Subject: [LTP] [PATCH] mtest01.c: Increase max_pids and check for array
	overflow.
Message-ID: <1492105560-10287-1-git-send-email-sellcey@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test was writing past the end of the pid_list array which
corrupted other data such as the stdout file structure and that
resulted in incorrect output including non-ascii text.  This
patch increases the size of pid_list and adds checks so we don't
overflow the array.

Signed-off-by: Steve Ellcey <sellcey@caviumnetworks.com>
---
 testcases/kernel/mem/mtest01/mtest01.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index d3b55b6..f3fba04 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -152,7 +152,7 @@ int main(int argc, char *argv[])
 	total_free = sstats.freeram + sstats.freeswap;
 	/* Total Free Pre-Test RAM */
 	pre_mem = sstats.mem_unit * total_free;
-	max_pids = total_ram / (unsigned long)FIVE_HUNDRED_MB + 1;
+	max_pids = total_ram / (unsigned long)FIVE_HUNDRED_MB + 10;
 
 	if ((pid_list = malloc(max_pids * sizeof(pid_t))) == NULL)
 		tst_brkm(TBROK | TERRNO, NULL, "malloc failed.");
@@ -200,6 +200,8 @@ int main(int argc, char *argv[])
 #if defined (_s390_)		/* s390's 31bit addressing requires smaller chunks */
 	while (pid != 0 && maxbytes > FIVE_HUNDRED_MB) {
 		i++;
+		if (i >= max_pids)
+			tst_brkm(TBROK, cleanup, "max_pids needs to be increased");
 		maxbytes -= FIVE_HUNDRED_MB;
 		pid = fork();
 		if (pid < 0)
@@ -217,6 +219,8 @@ int main(int argc, char *argv[])
 #elif __WORDSIZE == 32
 	while (pid != 0 && maxbytes > ONE_GB) {
 		i++;
+		if (i >= max_pids)
+			tst_brkm(TBROK, cleanup, "max_pids needs to be increased");
 		maxbytes -= ONE_GB;
 		pid = fork();
 		if (pid < 0)
@@ -234,6 +238,8 @@ int main(int argc, char *argv[])
 #elif __WORDSIZE == 64
 	while (pid != 0 && maxbytes > THREE_GB) {
 		i++;
+		if (i >= max_pids)
+			tst_brkm(TBROK, cleanup, "max_pids needs to be increased");
 		maxbytes -= THREE_GB;
 		pid = fork();
 		if (pid < 0)
-- 
2.7.4

