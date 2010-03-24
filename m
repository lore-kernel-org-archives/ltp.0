Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <schamart@linux.vnet.ibm.com>) id 1NuJf6-0007Sf-3Y
	for ltp-list@lists.sourceforge.net; Wed, 24 Mar 2010 06:01:52 +0000
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NuJf4-00021x-9J
	for ltp-list@lists.sourceforge.net; Wed, 24 Mar 2010 06:01:52 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp01.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2O5xX4q020275
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Mar 2010 16:59:33 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2O61fEc1724644
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Mar 2010 17:01:41 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2O61fDv020271
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Mar 2010 17:01:41 +1100
Received: from localhost ([9.77.201.93])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o2O61eZp020225
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Mar 2010 17:01:40 +1100
Date: Wed, 24 Mar 2010 11:31:39 +0530
From: Srinivasa R Chamarthy <schamart@linux.vnet.ibm.com>
Message-ID: <20100324060139.GA2565@chamarthy>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [BUG?] cgroup_fg_release_agent not present in the /opt/ltp
 after compilation
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
To: ltp-list@lists.sourceforge.net

Hi All,

There seems to be another issues with the cgroup_fj tests. The
cgroups_fj_release_agent script is not present in /opt/ltp testcases after
compilation. This is resulting in failure of all the cgroup_fj testcases.

cgroup_fj_release_agent is referenced by cgroup_fj_utility.sh.

cgroup_fj_release_agent is present in the LTP source.
Plese let me know if this is fixed in the head.

-- 
Srinivasa R Chamarthy (schamart@linux.vnet.ibm.com)
Linux on System z (RedHat & Novell SuSE) CSVT,
IBM India Systems & Technology Group/LTC - ISL,
Bangalore - 560071, KA, INDIA. Off: +91-80-41776451 
[ http://www.ibm.com/in/isl | http://www.ibm.com/linux/ltc ]

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
