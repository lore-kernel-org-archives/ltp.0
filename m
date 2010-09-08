Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1OtGMU-0002t7-6D
	for ltp-list@lists.sourceforge.net; Wed, 08 Sep 2010 08:50:34 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OtGMS-0006d3-Co
	for ltp-list@lists.sourceforge.net; Wed, 08 Sep 2010 08:50:34 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id o888oMPo024162
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Sep 2010 18:50:22 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o888oOKb2216076
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Sep 2010 18:50:24 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o888oOWj028122
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Sep 2010 18:50:24 +1000
Received: from [9.124.158.52] ([9.124.158.52])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o888oNx0028104
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Sep 2010 18:50:24 +1000
Message-ID: <4C874E4F.7080506@linux.vnet.ibm.com>
Date: Wed, 08 Sep 2010 14:20:23 +0530
From: Shubham <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050604080402080902060906"
Subject: [LTP] Patch suggested inside LTP memcg stress test case
	'memcg_stress_test.sh'.
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
--------------050604080402080902060906
Content-Type: multipart/alternative;
	boundary="------------050108030507050807060404"


--------------050108030507050807060404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  Hi,
      We have found out a cgroup test case issue with 
'ltp-full-20100331/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh'. 
The sniff of test case function is as below:-

Note: - Below code sniff is taken from latest LTP August month release.

run_stress()
{
         do_mount;

         for i in $(seq 0 $(($1-1)))
         do
                 mkdir /dev/memcg/$i 2> /dev/null
                 ./memcg_process_stress $2 $3 &
                 eval pid$i=$!

                 eval echo \$pid$i > /dev/memcg/$i/tasks
         done

         for i in $(seq 0 $(($1-1)))
         do
                 eval /bin/kill -s SIGUSR1 \$pid$i 2> /dev/null
         done

         sleep $4

         for i in $(seq 0 $(($1-1)))
         do
eval /bin/kill -s SIGINT \$pid$i 2> /dev/null *<----send  SIGINT signal 
for a pid *
                 eval wait \$pid$i

                 rmdir /dev/memcg/$i 2> /dev/null
         done

         cleanup;
}


Basically, the test case is not doing a proper cleanup using SIGINT.It 
seems that the current test runs for much longer time than expected, 
thus affecting test performance. During this course of time, other 
dependent tests were also not proceeding further and system seemed to be 
in a process hang state. However we have found that SIGKILL does a 
better cleanup job compared to SIGINT, to overcome this situation.

So, I have created a patch to fix above test case issue. Kindly review 
this patch and acknowledge. I think this patch can be merged into latest 
LTP code to avoid this problem.

Please let me know if you need any clarifications.

Regards,
Shubham


--------------050108030507050807060404
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    Hi,<br>
    &nbsp;&nbsp;&nbsp;&nbsp; We have found out a cgroup test case issue with
    'ltp-full-20100331/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh'.


    The sniff of test case function is as below:-<br>
    <br>
    Note: - Below code sniff is taken from latest LTP August month
    release.<br>
    <br>
    run_stress()<br>
    {<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_mount;<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for i in $(seq 0 $(($1-1)))<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir /dev/memcg/$i 2&gt; /dev/null<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ./memcg_process_stress $2 $3 &amp;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eval pid$i=$!<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eval echo \$pid$i &gt; /dev/memcg/$i/tasks<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; done<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for i in $(seq 0 $(($1-1)))<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eval /bin/kill -s SIGUSR1 \$pid$i 2&gt; /dev/null<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; done<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sleep $4<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for i in $(seq 0 $(($1-1)))<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="#ff0000"><font color="#330033">eval
        /bin/kill -s SIGINT \$pid$i 2&gt; /dev/null&nbsp;</font>&nbsp;&nbsp; <b>&lt;----send&nbsp;


        SIGINT signal for a pid </b></font><br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eval wait \$pid$i<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmdir /dev/memcg/$i 2&gt; /dev/null<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; done<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cleanup;<br>
    }<br>
    <br>
    <br>
    Basically, the test case is not doing a proper cleanup using
    SIGINT.It seems that the current test runs for much longer time than
    expected, thus affecting test performance. During this course of
    time, other dependent tests were also not proceeding further and
    system seemed to be in a process hang state. However we have found
    that SIGKILL does a better cleanup job compared to SIGINT, to
    overcome this situation.<br>
    <br>
    So, I have created a patch to fix above test case issue. Kindly
    review this patch and acknowledge. I think this patch can be merged
    into latest LTP code to avoid this problem. <br>
    <br>
    Please let me know if you need any clarifications.<br>
    <br>
    Regards,<br>
    Shubham<br>
    <br>
  </body>
</html>

--------------050108030507050807060404--

--------------050604080402080902060906
Content-Type: text/plain;
 name="patch_memcg_stress_test"
Content-Disposition: attachment;
 filename="patch_memcg_stress_test"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e23smtp06.au.ibm.com id
	o888oMPo024162

--- memcg_stress_test.sh	2010-09-01 01:04:22.000000000 +0530
+++ memcg_stress_test_latest.sh	2010-09-01 01:10:47.000000000 +0530
@@ -1,4 +1,4 @@
-#! /bin/sh
+=EF=BB=BF#! /bin/sh
=20
 ########################################################################=
########
 ##                                                                      =
      ##
@@ -85,7 +85,7 @@
=20
 	for i in $(seq 0 $(($1-1)))
 	do
-		eval /bin/kill -s SIGINT \$pid$i 2> /dev/null
+		eval /bin/kill -s SIGKILL \$pid$i 2> /dev/null
 		eval wait \$pid$i
=20
 		rmdir /dev/memcg/$i 2> /dev/null



--------------050604080402080902060906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--------------050604080402080902060906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050604080402080902060906--

