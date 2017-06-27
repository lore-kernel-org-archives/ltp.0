From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Jun 2017 15:30:59 +0200
Subject: [LTP] [COMMITTED] [PATCH] mmapstress10: Fix buffer overflow.
Message-ID: <20170627133059.2177-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is the same as:

commit 33ecf6f20c356face97cd934db55cd21afcd6dbb
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Tue Jun 27 15:07:15 2017 +0200

    mmapstress01: Fix buffer overflow

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/mmapstress/mmapstress10.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress10.c b/testcases/kernel/mem/mmapstress/mmapstress10.c
index d3ee8650b..482933bce 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress10.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress10.c
@@ -148,7 +148,7 @@ unsigned randloops = 0;
 unsigned dosync = 0;
 unsigned do_offset = 0;
 unsigned pattern = 0;
-char filename[64];
+static const char *filename = "mmapstress10.out";
 
 void clean_mapper(int sig);
 void clean_writer(int sig);
@@ -270,9 +270,7 @@ int main(int argc, char *argv[])
 		anyfail();
 	}
 	(void)time(&t);
-	//(void)printf("%s: Started %s", argv[0], ctime(&t)); LTP Port
 
-	(void)sprintf(filename, "%sout.%d", progname, getpid());
 	seed = initrand();
 	pattern = seed & 0xff;
 
-- 
2.13.0

