Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1Ow6RE-0002bv-Vx
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 04:51:12 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ow6RB-0005G3-ML
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 04:51:12 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o8G4p3FT009961
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Sep 2010 21:51:03 -0700 (PDT)
Message-ID: <4C91A23E.6080506@windriver.com>
Date: Thu, 16 Sep 2010 12:51:10 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060702000101060505070702"
Subject: [LTP] [patch] change user password usable time
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

This is a multi-part message in MIME format.
--------------060702000101060505070702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Some board do not have a RTC, then when it boot up, the time is 1970.1.1.

if Linux finds 'last password change date' of an account = 1/1/1970 , it 
forces password change on next login.
if the systems' date is like that and you change (as required) the 
password, each time you login on the same day it will require you to 
change password.

So in the target whose boot up time is 1/1/1970 and use the 'su' 
command, there will be 'You are required to change your password 
immediately (root enforced)' informations and stop the testing.

chage -d 10 userName will let the userName is usable in the next 10 days.

Thanks,

Lina

--------------060702000101060505070702
Content-Type: text/x-diff; name="0001-change-user-password-expiry-time.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-change-user-password-expiry-time.patch"

From a76578071c5319f47420777fc349c470dcd198aa Mon Sep 17 00:00:00 2001
From: Lina Zhao <lina.zhao@windriver.com>
Date: Thu, 16 Sep 2010 11:17:33 +0800
Subject: [PATCH] change user password expiry time

Some board do not have a RTC, then when it boot up, the time is 1970.1.1.
if Linux finds 'last password change date' of an account = 1/1/1970 ,
it forces password change on next login.
So in the target whose boot up time is 1/1/1970 and use the 'su' command,
there will be 'You are required to change your password.
informations and stop the testing.

chage -d 10 userName will let the userName is usable in the next 10 days.

Signed-off-by: Lina Zhao < lina.zhao@windriver.com >
---
 testcases/commands/at/at_deny01      |    2 ++
 testcases/commands/cron/cron02       |    1 +
 testcases/commands/cron/cron_allow01 |    2 ++
 testcases/commands/cron/cron_deny01  |    2 ++
 testcases/commands/su/su01           |    2 ++
 5 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/testcases/commands/at/at_deny01 b/testcases/commands/at/at_deny01
index 9f9f433..3a0a711 100755
--- a/testcases/commands/at/at_deny01
+++ b/testcases/commands/at/at_deny01
@@ -64,12 +64,14 @@ do_setup()
 		echo "Could not add test user ${test_user1} to system."
 		exit 1
 	fi
+   chage -d 10 ${test_user1}
 
 	# Create the 2nd user.
 	if ! useradd -g users -d "${test_user2_home}" -m "${test_user2}"; then
 		echo "Could not add test user ${test_user2} to system."
 		exit 1
 	fi
+   chage -d 10 ${test_user2}
 
 	# This is the workaround for a potential bug.
 	# [Bug 468337] At Refuse to Work with Non-login Shell
diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cron02
index 0c05c95..2ca2d88 100755
--- a/testcases/commands/cron/cron02
+++ b/testcases/commands/cron/cron02
@@ -51,6 +51,7 @@ do_setup(){
                 exit 1
         }
         fi
+        chage -d 10 $TEST_USER
 
 	# restart cron daemon
 	# Red Hat uses crond, SuSE/Other uses cron.
diff --git a/testcases/commands/cron/cron_allow01 b/testcases/commands/cron/cron_allow01
index ffecf68..86c5296 100755
--- a/testcases/commands/cron/cron_allow01
+++ b/testcases/commands/cron/cron_allow01
@@ -68,6 +68,7 @@ do_setup() {
         exit 1
     }
     fi
+    chage -d 10 $TEST_USER1
 
 #create 2nd user	
 	useradd -m -g users $TEST_USER2
@@ -77,6 +78,7 @@ do_setup() {
         exit 1
     }
     fi
+    chage -d 10 $TEST_USER2
 }
 
 #-----------------------------------------------------------------------
diff --git a/testcases/commands/cron/cron_deny01 b/testcases/commands/cron/cron_deny01
index 957529b..b1f8263 100755
--- a/testcases/commands/cron/cron_deny01
+++ b/testcases/commands/cron/cron_deny01
@@ -72,6 +72,7 @@ do_setup() {
         exit 1
     }
     fi
+    chage -d 10 $TEST_USER1
 
 #create 2nd user	
 	useradd -m -g users $TEST_USER2
@@ -81,6 +82,7 @@ do_setup() {
         exit 1
     }
     fi
+    chage -d 10 $TEST_USER2
 }
 
 #-----------------------------------------------------------------------
diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
index 0a99514..d589365 100755
--- a/testcases/commands/su/su01
+++ b/testcases/commands/su/su01
@@ -115,6 +115,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
                 exit 1
         }
         fi
+        chage -d 10 $TEST_USER1
 
 #Create 2nd test user
 	#erase user if he may exist , so we can have a clean en
@@ -151,6 +152,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
                 exit 1
         }
         fi
+        chage -d 10 $TEST_USER2
 }
 
 
-- 
1.6.3.1


--------------060702000101060505070702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--------------060702000101060505070702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060702000101060505070702--

