From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  7 Nov 2017 19:38:01 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/1] network/nfs_stress/nfs03: add -w to
	the grep when calculate ORIG_NFSD
Message-ID: <20171107183801.32005-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Yongcheng Yang <yoyang@redhat.com>

e.g. proccess nfsd4_callbacks

Signed-off-by: Yongcheng Yang <yoyang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs03 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs03 b/testcases/network/nfs/nfs_stress/nfs03
index f8ee49ad7..e0d0d6e1a 100755
--- a/testcases/network/nfs/nfs_stress/nfs03
+++ b/testcases/network/nfs/nfs_stress/nfs03
@@ -102,7 +102,7 @@ nfs03_setup()
 	nfs_setup
 
 	tst_resm TINFO "Setting server side nfsd count to $THREAD_NUM"
-	ORIG_NFSD=$(tst_rhost_run -s -c 'ps -ef | grep nfsd | grep -v grep | wc -l')
+	ORIG_NFSD=$(tst_rhost_run -s -c 'ps -ef | grep -w nfsd | grep -v grep | wc -l')
 	tst_rhost_run -s -c "rpc.nfsd $THREAD_NUM"
 }
 
-- 
2.14.2

