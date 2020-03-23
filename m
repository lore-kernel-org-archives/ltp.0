From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 23 Mar 2020 23:49:33 +0100
Subject: [LTP] [PATCH 3/3] travis: Update musl build
In-Reply-To: <20200323224933.2613658-1-petr.vorel@gmail.com>
References: <20200323224933.2613658-1-petr.vorel@gmail.com>
Message-ID: <20200323224933.2613658-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

accept4_01.c was fixed in previous build.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 travis/alpine.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/travis/alpine.sh b/travis/alpine.sh
index 233dae78e..b2c1fff9e 100755
--- a/travis/alpine.sh
+++ b/travis/alpine.sh
@@ -30,7 +30,6 @@ echo "WARNING: remove unsupported tests (until they're fixed)"
 cd ..
 rm -rfv \
 	testcases/kernel/sched/process_stress/process.c \
-	testcases/kernel/syscalls/accept4/accept4_01.c \
 	testcases/kernel/syscalls/confstr/confstr01.c \
 	testcases/kernel/syscalls/fmtmsg/fmtmsg01.c \
 	testcases/kernel/syscalls/getcontext/getcontext01.c \
-- 
2.25.1

