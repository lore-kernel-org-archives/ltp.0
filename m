From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:08 +0100
Subject: [LTP] [PATCH 15/19] fix old style definitions in memctl_test01.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-16-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/controllers/memctl/memctl_test01.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memctl/memctl_test01.c b/testcases/kernel/controllers/memctl/memctl_test01.c
index 7b6d10047..236286637 100644
--- a/testcases/kernel/controllers/memctl/memctl_test01.c
+++ b/testcases/kernel/controllers/memctl/memctl_test01.c
@@ -63,7 +63,7 @@ void signal_handler_sigusr1(int signal);
 void signal_handler_sigusr2(int signal);
 int allocate_memory(void);
 
-int main(int argc, char *argv[])
+int main(void)
 {
 	int ret;
 	char mygroup[FILENAME_MAX], mytaskfile[FILENAME_MAX];
@@ -120,7 +120,7 @@ int main(int argc, char *argv[])
  * Function: cleanup()
  * signals for system cleanup in case test breaks
  */
-void cleanup()
+void cleanup(void)
 {
 	if (kill(scriptpid, SIGUSR1) == -1)
 		tst_resm(TWARN | TERRNO, "kill failed");
@@ -134,6 +134,7 @@ void cleanup()
 void signal_handler_sigusr1(int signal)
 {
 	int i;
+	(void) signal;
 	for (i = 0; i < num_of_chunks; ++i)
 		free(array_of_chunks[i]);
 	free(array_of_chunks);
@@ -148,6 +149,7 @@ void signal_handler_sigusr1(int signal)
 void signal_handler_sigusr2(int signal)
 {
 	int i;
+	(void) signal;
 	for (i = 0; i < num_of_chunks; ++i)
 		free(array_of_chunks[i]);
 	free(array_of_chunks);
@@ -159,7 +161,7 @@ void signal_handler_sigusr2(int signal)
 	allocate_memory();
 }
 
-int allocate_memory()
+int allocate_memory(void)
 {
 	int i, j;
 	/*
-- 
2.13.6

