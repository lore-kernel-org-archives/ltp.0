From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Sep 2021 15:08:16 +0200
Subject: [LTP] [PATCH v2 3/7] ci/alpine: Enable process.c
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
Message-ID: <20210910130820.21141-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

Fixed in 2 previous commits.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 ci/alpine.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index deb9cfdcf..d93a57616 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -33,7 +33,6 @@ cat /etc/os-release
 echo "WARNING: remove unsupported tests (until they're fixed)"
 cd $(dirname $0)/..
 rm -rfv \
-	testcases/kernel/sched/process_stress/process.c \
 	testcases/kernel/syscalls/confstr/confstr01.c \
 	testcases/kernel/syscalls/fmtmsg/fmtmsg01.c \
 	testcases/kernel/syscalls/getcontext/getcontext01.c \
-- 
2.33.0

