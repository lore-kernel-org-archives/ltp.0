Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <a-fujita@rs.jp.nec.com>) id 1OJjoW-0001jb-E6
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 09:00:40 +0000
Received: from tyo200.gate.nec.co.jp ([202.32.8.215])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OJjoT-0000Vg-Ri
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 09:00:40 +0000
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o528X0PL008926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 2 Jun 2010 17:33:02 +0900 (JST)
Message-ID: <4C061631.3090407@rs.jp.nec.com>
Date: Wed, 02 Jun 2010 17:28:33 +0900
From: Akira Fujita <a-fujita@rs.jp.nec.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] Fix ext4_subdir_limit fix
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: risrajak@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com

LTP: Fix ext4_subdir_limit fix

From: Akira Fujita <a-fujita@rs.jp.nec.com>

We get the following error results since the if condition
in ext4_subdir_limit_tset.sh does not work fine.  The patch fixes this issue.

[root@bsd086 ltp]# ./runltp -f fs_ext4

<snip>

Ext4 subdir limit test
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name,
mkdir: No space left on device
ext4-subdir-limit    2  TFAIL  :  failed to create directories - 19118

<snip>

ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name,
mkdir: No space left on device
ext4-subdir-limit    4  TFAIL  :  failed to create directories - 19592

Signed-off-by: Akira Fujita <a-fujita@rs.jp.nec.com>
---
 ext4_subdir_limit_test.sh |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
index 5631fe5..f0a3b50 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
@@ -152,7 +152,8 @@ for ((i = 0; i < 3; i++))
 	{
 		for ((k = 0; k < 2; k++))
 		{
-			if [ $i -eq $LONG_DIR -a $k -eq 1024 ]; then
+			if [ ${DIR_LEN[$k]} -eq $LONG_DIR -a \
+				${BLOCK_SIZE[$i]} -eq 1024 ]; then
 				continue
 			fi
 			ext4_run_case 65537 ${DIR_LEN[$k]} ${PARENT_DIR[$j]} \


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
