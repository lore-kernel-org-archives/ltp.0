Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v1Y-0004Lq-D2
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:57:32 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v1X-0000AQ-2y
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:57:32 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466q7A2030278
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:52:07 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466vP4b144696
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:57:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o466vOcE030354
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:57:25 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:27:15 +0530
Message-Id: <20100506065713.23879.94813.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [05/12 FAILURE] LTPX proc01 test fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1510745727651458867=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============1510745727651458867==

Subject: LTP�� proc01 test fail

Issues Description below:
====================================
# ./runltp -s proc01

<<<test_output>>>
proc01      0  TINFO  :  /proc/sysrq-trigger: is write-only.
proc01      0  TINFO  :  /proc/kmsg: known issue: errno=EAGAIN(11): Resource
temporarily unavailable
proc01      0  TINFO  :  /proc/powerpc/ofdt: is write-only.
proc01      1  TFAIL  :  read failed: /proc/powerpc/rtas/error_log:
errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/sys/fs/binfmt_misc/register: is write-only.
proc01      0  TINFO  :  /proc/self/task/7928/mem: known issue: errno=EIO(5):
Input/output error
proc01      0  TINFO  :  /proc/self/task/7928/clear_refs: is write-only.
proc01      0  TINFO  :  /proc/self/mem: known issue: errno=EIO(5):
Input/output error
proc01      0  TINFO  :  /proc/self/clear_refs: is write-only.
proc01      2  TFAIL  :  readproc() failed with 1 errors.
<<<execution_status>>>
initiation_status="ok"
duration=2 termination_type=exited termination_id=1 corefile=no
cutime=4 cstime=130
<<<test_end>>>

Regards--
Subrata



--===============1510745727651458867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============1510745727651458867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1510745727651458867==--
