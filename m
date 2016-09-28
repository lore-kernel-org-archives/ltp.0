From: Yongcheng Yang <yoyang@redhat.com>
Date: Wed, 28 Sep 2016 14:51:31 +0800
Subject: [LTP] [PATCH] network/nfs_stress/nfs03: add -w to the grep when
	calculate ORIG_NFSD
Message-ID: <1475045491-21918-1-git-send-email-yoyang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yongcheng Yang <yoyang@redhat.com>
---

Without the "--word-regexp", ORIG_NFSD may get a wrong value, i.e.

# ps -ef | grep nfsd | grep -v grep
root     15067     2  0 02:05 ?        00:00:00 [nfsd4]
root     15068     2  0 02:05 ?        00:00:00 [nfsd4_callbacks]
root     15069     2  0 02:05 ?        00:00:00 [nfsd]
# ps -ef | grep -w nfsd | grep -v grep
root     15069     2  0 02:05 ?        00:00:00 [nfsd]

Then wrongly recovers by "rpc.nfsd $ORIG_NFSD" in cleanup. 

Thanks,
Yongcheng

 testcases/network/nfs/nfs_stress/nfs03 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs03 b/testcases/network/nfs/nfs_stress/nfs03
index 03ad056..960d9c4 100755
--- a/testcases/network/nfs/nfs_stress/nfs03
+++ b/testcases/network/nfs/nfs_stress/nfs03
@@ -104,7 +104,7 @@ nfs03_setup()
 	nfs_setup
 
 	tst_resm TINFO "Setting server side nfsd count to $THREAD_NUM"
-	ORIG_NFSD=$(tst_rhost_run -s -c 'ps -ef | grep nfsd | grep -v grep | wc -l')
+	ORIG_NFSD=$(tst_rhost_run -s -c 'ps -ef | grep -w nfsd | grep -v grep | wc -l')
 	tst_rhost_run -s -c "rpc.nfsd $THREAD_NUM"
 }
 
-- 
2.4.3

