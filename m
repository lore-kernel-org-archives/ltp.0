From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Jun 2016 17:28:56 +0300
Subject: [LTP] [PATCH 8/8] network/nfs: remove README
In-Reply-To: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
References: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1466432936-3099-9-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The more detailed description can be found in network/README.md.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/README |   28 ----------------------------
 1 files changed, 0 insertions(+), 28 deletions(-)
 delete mode 100644 testcases/network/nfs/README

diff --git a/testcases/network/nfs/README b/testcases/network/nfs/README
deleted file mode 100644
index ee58415..0000000
--- a/testcases/network/nfs/README
+++ /dev/null
@@ -1,28 +0,0 @@
-
-NOTE:
-
-  These tests ALL assume that the "RHOST" variable is set to the hostname
-of the remote machine, i.e.
-
-    # export RHOST=<hostname here>.
-
-
-These tests also assume an identical path tree for their location on the remote
-machine.  So if pan's root path is "/home/ltptests" on the test machine, then
-it must also be located in "/home/ltptests" on the remote machine (RHOST). You
-also need to do a make and make install on both the local and remote machines
-before you run the test.
-
- You will also need to setup a ".rhosts" file in root's home directory on the
-remote machine, with the name of the local machine listed.  For example, if
-machineA is running the tests, with machineB set as RHOST, then machineB's
-root home directory will need an ".rhosts" file with machineA's hostname
-listed. After you create the .rhost file you must also set the proper
-permissions on the .rhost file.  chmod 600 .rhosts
-
-I apologize for the lengthy setup, but I tried to make it as minimal as
-possible.
-
-
--Robbie Williamson
-(robbiew@us.ibm.com)
-- 
1.7.1

