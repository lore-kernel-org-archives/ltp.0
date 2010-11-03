Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PDghp-000526-EY
	for ltp-list@lists.sourceforge.net; Wed, 03 Nov 2010 17:01:01 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PDgho-0001Mw-Fo
	for ltp-list@lists.sourceforge.net; Wed, 03 Nov 2010 17:01:01 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oA3Gj3FD006334
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Nov 2010 12:45:04 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oA3H0sRj354466
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Nov 2010 13:00:54 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oA3H0r1c024937
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Nov 2010 13:00:54 -0400
Message-ID: <4CD1952A.2000604@linux.vnet.ibm.com>
Date: Wed, 03 Nov 2010 22:30:26 +0530
From: Subrata Modak <subrata@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [Fwd: Query regarding termination_id=4 in LTP.]
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3023116812602049770=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============3023116812602049770==
Content-Type: multipart/alternative;
	boundary="------------050500080609000509020700"

This is a multi-part message in MIME format.
--------------050500080609000509020700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

FYI...!!

-------- Original Message --------
Subject: 	Query regarding termination_id=4 in LTP.
Date: 	Wed, 3 Nov 2010 12:08:56 +0530
From: 	naren.mehra@gmail.com
To: 	manojo@austin.ibm.com
CC: 	subrata@linux.vnet.ibm.com



Hi,

I am not sure whom to ask this question so putting it here.
I am trying to run LTP on my arm based board and in some of the tests like
shm_test01 and mtest05
I am getting termination_id=4.

So, I am stuck as theres no other information as to why these 2 tests failed.
Could you help me out and tell me what does "termination_id=4" suggests ??

Log Snippet:
1) shm_test01 :
<<<test_start>>>
tag=stime=3934
cmdline="shm_test -l 10 -t 2"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=signaled termination_id=4 corefile=no
cutime=0 cstime=0
<<<test_end>>>

2) mtest05
<<<test_start>>>
tag=mtest05 stime=3930
cmdline="  mmstress"
contacts=""
analysis=exit
<<<test_output>>>
mmstress    0  TINFO  :  run mmstress -h for all options
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=signaled termination_id=4 corefile=no
cutime=0 cstime=0
<<<test_end>>


Regards,
Naren


--------------050500080609000509020700
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
FYI...!!<br>
<br>
-------- Original Message --------
<table class="moz-email-headers-table" border="0" cellpadding="0"
 cellspacing="0">
  <tbody>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Subject: </th>
      <td>Query regarding termination_id=4 in LTP.</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">Date: </th>
      <td>Wed, 3 Nov 2010 12:08:56 +0530</td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">From: </th>
      <td><a class="moz-txt-link-abbreviated" href="mailto:naren.mehra@gmail.com">naren.mehra@gmail.com</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">To: </th>
      <td><a class="moz-txt-link-abbreviated" href="mailto:manojo@austin.ibm.com">manojo@austin.ibm.com</a></td>
    </tr>
    <tr>
      <th align="right" nowrap="nowrap" valign="baseline">CC: </th>
      <td><a class="moz-txt-link-abbreviated" href="mailto:subrata@linux.vnet.ibm.com">subrata@linux.vnet.ibm.com</a></td>
    </tr>
  </tbody>
</table>
<br>
<br>
<pre>Hi,

I am not sure whom to ask this question so putting it here.
I am trying to run LTP on my arm based board and in some of the tests like
shm_test01 and mtest05
I am getting termination_id=4.

So, I am stuck as theres no other information as to why these 2 tests failed.
Could you help me out and tell me what does "termination_id=4" suggests ??

Log Snippet:
1) shm_test01 :
&lt;&lt;&lt;test_start&gt;&gt;&gt;
tag=stime=3934
cmdline="shm_test -l 10 -t 2"
contacts=""
analysis=exit
&lt;&lt;&lt;test_output&gt;&gt;&gt;
&lt;&lt;&lt;execution_status&gt;&gt;&gt;
initiation_status="ok"
duration=1 termination_type=signaled termination_id=4 corefile=no
cutime=0 cstime=0
&lt;&lt;&lt;test_end&gt;&gt;&gt;

2) mtest05
&lt;&lt;&lt;test_start&gt;&gt;&gt;
tag=mtest05 stime=3930
cmdline="  mmstress"
contacts=""
analysis=exit
&lt;&lt;&lt;test_output&gt;&gt;&gt;
mmstress    0  TINFO  :  run mmstress -h for all options
&lt;&lt;&lt;execution_status&gt;&gt;&gt;
initiation_status="ok"
duration=0 termination_type=signaled termination_id=4 corefile=no
cutime=0 cstime=0
&lt;&lt;&lt;test_end&gt;&gt;


Regards,
Naren
</pre>
</body>
</html>

--------------050500080609000509020700--



--===============3023116812602049770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Achieve Improved Network Security with IP and DNS Reputation.
Defend against bad network traffic, including botnets, malware, 
phishing sites, and compromised hosts - saving your company time, 
money, and embarrassment.   Learn More! 
http://p.sf.net/sfu/hpdev2dev-nov
--===============3023116812602049770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3023116812602049770==--


