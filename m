From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 19 Feb 2020 10:37:06 +0100
Subject: [LTP] [PATCH v4 4/4] Skip Btrfs in LVM stress tests
In-Reply-To: <20200219093706.9043-1-mdoucha@suse.cz>
References: <20200130144146.20846-1-mdoucha@suse.cz>
 <20200219093706.9043-1-mdoucha@suse.cz>
Message-ID: <20200219093706.9043-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Delayed file deletion makes stress testing Btrfs on small block devices
difficult. Each test case would require explicit FS cleanup synchronization.
Drop Btrfs tests from LVM runfile for now.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v3: New patch.

 testcases/misc/lvm/generate_lvm_runfile.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index b5e979e6b..5ca035f22 100755
--- a/testcases/misc/lvm/generate_lvm_runfile.sh
+++ b/testcases/misc/lvm/generate_lvm_runfile.sh
@@ -18,7 +18,10 @@ generate_runfile()
 	echo -n "" >"$OUTFILE"
 
 	for fsname in $FS_LIST; do
-		sed -e "s/{fsname}/$fsname/g" "$INFILE" >>"$OUTFILE"
+		# Btrfs needs too much space for reliable stress testing
+		if [ "x$fsname" != "xbtrfs" ]; then
+			sed -e "s/{fsname}/$fsname/g" "$INFILE" >>"$OUTFILE"
+		fi
 	done
 
 	tst_res TPASS "Runfile $OUTFILE successfully created"
-- 
2.25.0

