From: Steve Muckle <smuckle@google.com>
Date: Wed, 24 Oct 2018 15:01:01 -0700
Subject: [LTP] [PATCH] syscalls/ptrace05: skip internally used signals
Message-ID: <20181024220101.140311-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some signals may be internally used by the C library. Do not attempt to
test these.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 testcases/kernel/syscalls/ptrace/ptrace05.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 22261f3df..420330029 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -71,6 +71,9 @@ int main(int argc, char **argv)
 
 	for (signum = start_signum; signum <= end_signum; signum++) {
 
+		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
+			continue;
+
 		switch (child = fork()) {
 		case -1:
 			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
-- 
2.19.1.568.g152ad8e336-goog

