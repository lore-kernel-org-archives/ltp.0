Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O46iU-00059F-Nf
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:13:50 +0000
Received: from out07.sjc.mx.trendmicro.com ([216.99.131.23])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O46iT-0007tI-6g
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:13:50 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.9])
	by out07.sjc.mx.trendmicro.com (Postfix) with ESMTP id 1E63D95245B
	for <ltp-list@lists.sourceforge.net>;
	Tue, 20 Apr 2010 06:13:43 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 4C255114B837
	for <ltp-list@lists.sourceforge.net>;
	Tue, 20 Apr 2010 06:13:41 +0000 (UTC)
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 20 Apr 2010 15:13:40 +0900
Message-ID: <000601cae050$9f25f1b0$dd71d510$@co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01CAE09C.0F0D99B0"
Content-Language: ja
Subject: [LTP]  [PATCH] fix "su01" test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: kamimura@ryobi.co.jp

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01CAE09C.0F0D99B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I ran "su01" test.
This test failed:
------------<log>
userdel: user su_usr1 does not exist
Creating mailbox file: File exists
userdel: user su_usr2 does not exist
Creating mailbox file: File exists
YOU NEED TO SET ENVIROMENT VARIABLE PASSWD.
------------

This failure was caused by "PASSWD" environment variable not being set:
------------<su01_s1>
#Grab input from enviroment
if [info exists env(PASSWD)] {
        set PASSWD $env(PASSWD)
} else {
        send_user "YOU NEED TO SET ENVIROMENT VARIABLE PASSWD. \n"
        exit 1
}
------------

According to "su01_s1", this "PASSWD" is the password of "root" user:
------------<su01_s1>
spawn /bin/su -c whoami
set i_am_root 0
expect {
  "Password:" {
        send "$PASSWD\r"
    expect {
      "root" { set i_am_root 1
                set i_can_root 1
         }
    }
  }
}
------------

I think whether this test program is unfinished.
Probably the author of this program thought that there was a problem 
to set a password in the shell, I think.
Because, the password of root is various by each users who run the test,
and it cannot be gotten from environment variable or file etc.

So, I suggest that "su01" shell demands root password when it is run.
But, when user forgot to input, it should return and finish with error.


I attach the patch for "su01" file.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>


Regards--

-Tomonori Mitani

------=_NextPart_000_0007_01CAE09C.0F0D99B0
Content-Type: application/octet-stream;
	name="su01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="su01.patch"

--- a/testcases/commands/su/su01	2010-04-01 16:15:00.000000000 +0900
+++ b/testcases/commands/su/su01	2010-04-20 13:26:53.000000000 +0900
@@ -81,6 +81,17 @@
 rm -f $TEST_ENV_FILE > /dev/null 2>&1
 
 
+#Set password of root-user
+	echo "Please input password of root-user within 30 seconds."
+	read -t 30 PASSWD
+	if [ $? != 0 ]
+	then {
+		echo "Time over. Password was not input."
+                exit 1
+	}
+	fi
+	export PASSWD
+
 #Create 1st test user
     #erase user if he may exist , so we can have a clean en
         rm -rf /home/$TEST_USER1

------=_NextPart_000_0007_01CAE09C.0F0D99B0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
------=_NextPart_000_0007_01CAE09C.0F0D99B0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_NextPart_000_0007_01CAE09C.0F0D99B0--



