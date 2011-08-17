Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czyzak2@linux.vnet.ibm.com>) id 1QtnpC-0007cu-HO
	for ltp-list@lists.sourceforge.net; Wed, 17 Aug 2011 21:38:58 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QtnpB-00017t-Py
	for ltp-list@lists.sourceforge.net; Wed, 17 Aug 2011 21:38:58 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7HKScC8002083
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Aug 2011 14:28:38 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p7HLcjkD143708
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Aug 2011 15:38:47 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p7HFciDO013703
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Aug 2011 09:38:44 -0600
Message-ID: <4E4C34E5.1090702@linux.vnet.ibm.com>
Date: Wed, 17 Aug 2011 16:38:45 -0500
From: James Czyzak <czyzak2@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/1] fix ssh03 on system running mls policy
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7588916032312725775=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Shubham <shubham@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net
Cc: debora@linux.vnet.ibm.com

This is a multi-part message in MIME format.
--===============7588916032312725775==
Content-Type: multipart/alternative;
	boundary="------------010706010309040708030407"

This is a multi-part message in MIME format.
--------------010706010309040708030407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Modified ssh03 to unset TCtmp. On a system running the latest selinux 
mls policy the call to tst_setup in the cmdlib.sh script with the TCtmp 
variable still set with the TEST_USER directory will result in the 
directory being created with the context of the logged in user (i.e. 
administrator running the test 
...staff_u:object_r:home_root_t:SystemLow) when the useradd is run 
afterwords the directory will already exist but the context of directory 
/home/ssh_user3 should be 
user_u:object_r:user_home_dir_t:SystemLow-SystemHigh. Now when the test 
is run to ssh login with the valid password the test will fail due to 
not being able to change to the user directory which is caused by a 
mismatched context. The unset of TCtmp will prevent this. This does not 
appear to be detrimental to systems running with a targeted policy and 
should have no ill affect systems not running selinux, although a test 
could be placed around the unset to determine if selinux is running and 
the mls policy is in use.

Signed-off-by James Czyzak <czyzak2@linux.vnet.ibm.com> 
<mailto:czyzak2@linux.vnet.ibm.com>

diff --git a/testcases/network/tcp_cmds/ssh/ssh03 
b/testcases/network/tcp_cmds/s
index 8fbca34..a75032c 100755
--- a/testcases/network/tcp_cmds/ssh/ssh03
+++ b/testcases/network/tcp_cmds/ssh/ssh03
@@ -42,7 +42,7 @@ do_setup()
      TCtmp=/home/$TEST_USER

      rm -Rf $TCtmp
-
+    unset TCtmp
      tst_setup

      exists expect ssh ssh03_s1 useradd userdel


--------------010706010309040708030407
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    Modified ssh03 to unset TCtmp. On a system running the latest
    selinux mls policy the call to tst_setup in the cmdlib.sh script
    with the TCtmp variable still set with the TEST_USER directory will
    result in the directory being created with the context of the logged
    in user (i.e. administrator running the test
    ...staff_u:object_r:home_root_t:SystemLow) when the useradd is run
    afterwords the directory will already exist but the context of
    directory /home/ssh_user3 should be
    user_u:object_r:user_home_dir_t:SystemLow-SystemHigh. Now when the
    test is run to ssh login with the valid password the test will fail
    due to not being able to change to the user directory which is
    caused by a mismatched context. The unset of TCtmp will prevent
    this. This does not appear to be detrimental to systems running with
    a targeted policy and should have no ill affect systems not running
    selinux, although a test could be placed around the unset to
    determine if selinux is running and the mls policy is in use.<br>
    <br>
    Signed-off-by James Czyzak <font color="#000000"> </font><font
      color="#3366ff"><font color="#000000"><a
          href="mailto:czyzak2@linux.vnet.ibm.com">&lt;czyzak2@linux.vnet.ibm.com&gt;</a><br>
        <br>
      </font></font>diff --git a/testcases/network/tcp_cmds/ssh/ssh03
    b/testcases/network/tcp_cmds/s<br>
    index 8fbca34..a75032c 100755<br>
    --- a/testcases/network/tcp_cmds/ssh/ssh03<br>
    +++ b/testcases/network/tcp_cmds/ssh/ssh03<br>
    @@ -42,7 +42,7 @@ do_setup()<br>
    &nbsp;&nbsp;&nbsp;&nbsp; TCtmp=/home/$TEST_USER<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp; rm -Rf $TCtmp<br>
    -<br>
    +&nbsp;&nbsp;&nbsp; unset TCtmp<br>
    &nbsp;&nbsp;&nbsp;&nbsp; tst_setup<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp; exists expect ssh ssh03_s1 useradd userdel<br>
    <br>
  </body>
</html>

--------------010706010309040708030407--



--===============7588916032312725775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
--===============7588916032312725775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7588916032312725775==--


