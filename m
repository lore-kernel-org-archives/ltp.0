From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 3 Jul 2019 16:42:36 +0200
Subject: [LTP] [PATCH v3] sysctl/sysctl02: Add new regression test for
 overflow file-max
In-Reply-To: <5D0C323B.5020505@cn.fujitsu.com>
References: <20190606114134.GB13068@rei.lan>
 <1560156706-13617-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190620120122.GB31382@dell5510> <5D0C323B.5020505@cn.fujitsu.com>
Message-ID: <20190703144236.GA1495@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> Hi Petr

>  I use 2 strings because sysctl uses "fs.file-max" but cat uses "fs/file-max" file.
>  Your big changes look good to me.  Thanks for your changes.
I pushed tiny changes to sysctl02.sh as 8e2d73a88 ("sysctl/sysctl02: Improve log messages").
See the diff below.

Kind regards,
Petr

diff --git a/testcases/commands/sysctl/sysctl02.sh b/testcases/commands/sysctl/sysctl02.sh
index 8a434183e..3964a9829 100755
--- a/testcases/commands/sysctl/sysctl02.sh
+++ b/testcases/commands/sysctl/sysctl02.sh
@@ -44,14 +44,17 @@ do_test()
 
 sysctl_test_overflow()
 {
+	local test_value="$1"
 	local old_value="$(cat $sys_file)"
-	sysctl -w -q $sys_name=$1 2>/dev/null
-	local test_value="$(cat $sys_file)"
 
-	if echo $test_value | grep -q $old_value; then
-		tst_res TPASS "$sys_file overflows, reject it and keep old value"
+	tst_res TINFO "trying to set $sys_name=$test_value"
+	sysctl -w -q $sys_name=$test_value 2>/dev/null
+	local new_value="$(cat $sys_file)"
+
+	if [ "$new_value" = "$old_value" ]; then
+		tst_res TPASS "$sys_file keeps old value ($old_value)"
 	else
-		tst_res TFAIL "$sys_file overflows and set to $test_value"
+		tst_res TFAIL "$sys_file overflows and is set to $new_value"
 	fi
 	cleanup
 }
