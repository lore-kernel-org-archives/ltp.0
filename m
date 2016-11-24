From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 24 Nov 2016 09:11:22 +0800
Subject: [LTP]  [PATCH v2] fs_racer: cleanup
In-Reply-To: <20161123122138.GD3346@rei.lan>
References: <1479902450-53501-1-git-send-email-cuibixuan@huawei.com>
 <20161123122138.GD3346@rei.lan>
Message-ID: <58363E3A.5080403@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove the DIR at the end of test

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/fs/racer/fs_racer.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/racer/fs_racer.sh b/testcases/kernel/fs/racer/fs_racer.sh
index 5c4dc69..aa38e86 100755
--- a/testcases/kernel/fs/racer/fs_racer.sh
+++ b/testcases/kernel/fs/racer/fs_racer.sh
@@ -86,6 +86,7 @@ call_exit()
     killall fs_racer_file_symlink.sh
     killall fs_racer_file_list.sh
     killall fs_racer_file_concat.sh
+    rm -rf $DIR
     exit 0
 }

-- 
1.8.3.4
