From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Nov 2016 11:09:23 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/5] testscripts/syscalls.sh: Remove.
In-Reply-To: <1478772565-12167-1-git-send-email-chrubis@suse.cz>
References: <1478772565-12167-1-git-send-email-chrubis@suse.cz>
Message-ID: <1478772565-12167-3-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The script just calls runltp -f syscalls and does not seem to be called
from any other script inside LTP.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testscripts/syscalls.sh | 4 ----
 1 file changed, 4 deletions(-)
 delete mode 100755 testscripts/syscalls.sh

diff --git a/testscripts/syscalls.sh b/testscripts/syscalls.sh
deleted file mode 100755
index 24455b7..0000000
--- a/testscripts/syscalls.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-cd `dirname $0`
-cd ..
-./runltp -f ${PWD}/runtest/syscalls -q "$@"
-- 
2.7.3

