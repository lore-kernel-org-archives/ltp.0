From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Nov 2016 17:02:59 +0100
Subject: [LTP] [PATCH 1/1] network/echoes: fix endless loop on error
Message-ID: <20161129160259.31058-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/tcp_cmds/echo/echoes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/network/tcp_cmds/echo/echoes.c b/testcases/network/tcp_cmds/echo/echoes.c
index 8138d28..d753d98 100644
--- a/testcases/network/tcp_cmds/echo/echoes.c
+++ b/testcases/network/tcp_cmds/echo/echoes.c
@@ -97,6 +97,7 @@ int main(int argc, char *argv[], char *env[])
 
 		if ((pid = wait(&wait_stat)) == -1)
 			tst_resm(TFAIL | TERRNO, "wait failed");
+
 		if (wait_stat == 0) {
 			for (j = 0; j < i; j++) {
 				if (echo_struc[j].pid == pid) {
@@ -105,7 +106,6 @@ int main(int argc, char *argv[], char *env[])
 				}
 			}
 		} else {
-
 			tst_resm(TFAIL, "wait(2) status was non-zero");
 
 			if (WIFEXITED(wait_stat)) {
@@ -120,6 +120,9 @@ int main(int argc, char *argv[], char *env[])
 				if (kill(echo_struc[k].pid, 0) == 0) {
 					kill(echo_struc[k].pid, 9);
 				}
+				if (echo_struc[k].pid == pid) {
+					finish--;
+				}
 			}
 
 		}
-- 
2.10.2

