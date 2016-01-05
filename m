From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2016 16:27:03 +0100
Subject: [LTP] [PATCH v3] commands/which: Added new testcase to test
	which(1).
In-Reply-To: <1450249273-7498-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20151215134733.GC26217@rei.lan>
 <1450249273-7498-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160105152703.GD8939@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with this change:

@@ -47,9 +47,6 @@ cleanup()
 
 which_verify()
 {
-       local which_op=$1
-
-       shift
        until [ -z "$1" ]
        do
                grep -q "$1" temp
@@ -90,7 +87,7 @@ which_test()
 
        if [ $# -gt 2 ]; then
                shift 2
-               which_verify "$which_op" "$@"
+               which_verify "$@"
                if [ $? -ne 0 ]; then
                        tst_resm TFAIL "'${which_cmd}' failed, not expected."
                        return

Since the $which_op was unused in the fucntion.

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
