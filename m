From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  9 Aug 2021 12:58:26 +0200
Subject: [LTP] [PATCH] connectors/pec_listener: Make exit_flag volatile
Message-ID: <20210809105826.19674-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are two ways in which the main loop of pec_listener can stop:
- syscall gets interrupted by signal and its error handler code breaks the loop
- or exit_flag get set to 1

The exit flag is only changed in signal handler so it needs to be volatile,
otherwise the compiler will optimize it out of the main program loop. If
an incoming signal doesn't interrupt a syscall, pec_listener will get stuck
in the loop forever. It's a rare situation but it does happen once in a while.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/connectors/pec/pec_listener.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/connectors/pec/pec_listener.c b/testcases/kernel/connectors/pec/pec_listener.c
index 7844dc905..2707ea8fb 100644
--- a/testcases/kernel/connectors/pec/pec_listener.c
+++ b/testcases/kernel/connectors/pec/pec_listener.c
@@ -50,7 +50,7 @@ int main(void)
 
 static __u32 seq;
 
-static int exit_flag;
+static volatile int exit_flag;
 static struct sigaction sigint_action;
 
 struct nlmsghdr *nlhdr;
-- 
2.32.0

