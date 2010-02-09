Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NemJz-00089O-DD
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 09:23:51 +0000
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NemJx-0000gW-Hr
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 09:23:51 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o199K79W024700
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Feb 2010 20:20:07 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o199IJeV1474802
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Feb 2010 20:18:21 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o199NSp4013903
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Feb 2010 20:23:29 +1100
Message-ID: <4B71298E.6090600@linux.vnet.ibm.com>
Date: Tue, 09 Feb 2010 14:53:26 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] proc01 testcase fails on SLES11
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
To: LTP <ltp-list@lists.sourceforge.net>
Cc: Mike Frysinger <vapier@gentoo.org>

Hi All,

Tested with latest cvs ( 9th Feb ). And found proc01 test is failing on 
SLES11-GA.

Let me know if someone is tracking this problem.

rishi:/opt/ltp/testcases/bin # ./proc01
proc01      0  TINFO  :  /proc/sys/fs/binfmt_misc/register: is write-only.
proc01      1  TFAIL  :  read failed: /proc/bus/pnp/12: errno=EIO(5): 
Input/output error
proc01      2  TFAIL  :  read failed: /proc/bus/pnp/11: errno=EIO(5): 
Input/output error
proc01      3  TFAIL  :  read failed: /proc/bus/pnp/10: errno=EIO(5): 
Input/output error
proc01      4  TFAIL  :  read failed: /proc/bus/pnp/0f: errno=EIO(5): 
Input/output error
proc01      5  TFAIL  :  read failed: /proc/bus/pnp/0e: errno=EIO(5): 
Input/output error
proc01      6  TFAIL  :  read failed: /proc/bus/pnp/0d: errno=EIO(5): 
Input/output error
proc01      7  TFAIL  :  read failed: /proc/bus/pnp/0c: errno=EIO(5): 
Input/output error
proc01      8  TFAIL  :  read failed: /proc/bus/pnp/0b: errno=EIO(5): 
Input/output error
proc01      9  TFAIL  :  read failed: /proc/bus/pnp/0a: errno=EIO(5): 
Input/output error
proc01     10  TFAIL  :  read failed: /proc/bus/pnp/09: errno=EIO(5): 
Input/output error
proc01     11  TFAIL  :  read failed: /proc/bus/pnp/08: errno=EIO(5): 
Input/output error
proc01     12  TFAIL  :  read failed: /proc/bus/pnp/07: errno=EIO(5): 
Input/output error
proc01     13  TFAIL  :  read failed: /proc/bus/pnp/06: errno=EIO(5): 
Input/output error
proc01     14  TFAIL  :  read failed: /proc/bus/pnp/05: errno=EIO(5): 
Input/output error
proc01     15  TFAIL  :  read failed: /proc/bus/pnp/04: errno=EIO(5): 
Input/output error
proc01     16  TFAIL  :  read failed: /proc/bus/pnp/03: errno=EIO(5): 
Input/output error
proc01     17  TFAIL  :  read failed: /proc/bus/pnp/02: errno=EIO(5): 
Input/output error
proc01     18  TFAIL  :  read failed: /proc/bus/pnp/01: errno=EIO(5): 
Input/output error
proc01     19  TFAIL  :  read failed: 
/proc/bus/pnp/legacy_device_resources: errno=EIO(5): Input/output error
proc01     20  TFAIL  :  read failed: /proc/bus/pnp/escd: errno=EIO(5): 
Input/output error
proc01     21  TFAIL  :  read failed: /proc/bus/pnp/escd_info: 
errno=EIO(5): Input/output error
proc01     22  TFAIL  :  read failed: /proc/bus/pnp/configuration_info: 
errno=EIO(5): Input/output error
proc01     23  TFAIL  :  read failed: /proc/bus/pnp/boot/12: 
errno=EIO(5): Input/output error
proc01     24  TFAIL  :  read failed: /proc/bus/pnp/boot/11: 
errno=EIO(5): Input/output error
proc01     25  TFAIL  :  read failed: /proc/bus/pnp/boot/10: 
errno=EIO(5): Input/output error
proc01     26  TFAIL  :  read failed: /proc/bus/pnp/boot/0f: 
errno=EIO(5): Input/output error
proc01     27  TFAIL  :  read failed: /proc/bus/pnp/boot/0e: 
errno=EIO(5): Input/output error
proc01     28  TFAIL  :  read failed: /proc/bus/pnp/boot/0d: 
errno=EIO(5): Input/output error
proc01     29  TFAIL  :  read failed: /proc/bus/pnp/boot/0c: 
errno=EIO(5): Input/output error
proc01     30  TFAIL  :  read failed: /proc/bus/pnp/boot/0b: 
errno=EIO(5): Input/output error
proc01     31  TFAIL  :  read failed: /proc/bus/pnp/boot/0a: 
errno=EIO(5): Input/output error
proc01     32  TFAIL  :  read failed: /proc/bus/pnp/boot/09: 
errno=EIO(5): Input/output error
proc01     33  TFAIL  :  read failed: /proc/bus/pnp/boot/08: 
errno=EIO(5): Input/output error
proc01     34  TFAIL  :  read failed: /proc/bus/pnp/boot/07: 
errno=EIO(5): Input/output error
proc01     35  TFAIL  :  read failed: /proc/bus/pnp/boot/06: 
errno=EIO(5): Input/output error
proc01     36  TFAIL  :  read failed: /proc/bus/pnp/boot/05: 
errno=EIO(5): Input/output error
proc01     37  TFAIL  :  read failed: /proc/bus/pnp/boot/04: 
errno=EIO(5): Input/output error
proc01     38  TFAIL  :  read failed: /proc/bus/pnp/boot/03: 
errno=EIO(5): Input/output error
proc01     39  TFAIL  :  read failed: /proc/bus/pnp/boot/02: 
errno=EIO(5): Input/output error
proc01     40  TFAIL  :  read failed: /proc/bus/pnp/boot/01: 
errno=EIO(5): Input/output error
proc01      0  TINFO  :  /proc/sysrq-trigger: is write-only.
proc01      0  TINFO  :  /proc/kmsg: known issue: errno=EAGAIN(11): 
Resource temporarily unavailable
proc01      0  TINFO  :  /proc/self/task/13799/mem: known issue: 
errno=EIO(5): Input/output error
proc01      0  TINFO  :  /proc/self/task/13799/clear_refs: is write-only.
proc01      0  TINFO  :  /proc/self/task/13799/attr/prev: known issue: 
errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/self/task/13799/attr/exec: known issue: 
errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/self/task/13799/attr/fscreate: known 
issue: errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/self/task/13799/attr/keycreate: known 
issue: errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/self/task/13799/attr/sockcreate: known 
issue: errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/self/mem: known issue: errno=EIO(5): 
Input/output error
proc01      0  TINFO  :  /proc/self/clear_refs: is write-only.
proc01      0  TINFO  :  /proc/self/attr/prev: known issue: 
errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/self/attr/exec: known issue: 
errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/self/attr/fscreate: known issue: 
errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/self/attr/keycreate: known issue: 
errno=EINVAL(22): Invalid argument
proc01      0  TINFO  :  /proc/self/attr/sockcreate: known issue: 
errno=EINVAL(22): Invalid argument
proc01     41  TFAIL  :  readproc() failed with 40 errors.
rishi:/opt/ltp/testcases/bin # uname -a
Linux rishi.in.ibm.com 2.6.27.19-5-pae #1 SMP 2009-02-28 04:40:21 +0100 
i686 i686 i386 GNU/Linux
rishi:/opt/ltp/testcases/bin # cat /etc/issue

Welcome to SUSE Linux Enterprise Server 11 (i586) - Kernel \r (\l).


rishi:/opt/ltp/testcases/bin #

-- 
Thanks&  Regards
Rishi Kesh K Rajak
IBM LTC, Bangalore
LTP Maintainer
Please join IRC: #ltp @ freenode.net


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
