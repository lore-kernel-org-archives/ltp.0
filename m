From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 26 May 2021 19:25:02 +0200
Subject: [LTP] [LTP PATCH v2 2/3] nfs_lib.sh: Require nfsd kernel module
In-Reply-To: <20210526172503.18621-1-pvorel@suse.cz>
References: <20210526172503.18621-1-pvorel@suse.cz>
Message-ID: <20210526172503.18621-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
new in v2

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index b80ee0e18..26b670c35 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -30,6 +30,7 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
 TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
+TST_NEEDS_DRIVERS="nfsd"
 
 # When set and test is using netns ($TST_USE_NETNS set) NFS traffic will go
 # through lo interface instead of ltp_ns_veth* netns interfaces (useful for
-- 
2.31.1

