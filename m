Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <madanvs@linux.vnet.ibm.com>) id 1WYY4t-0003P7-Kc
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 09:48:55 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WYY4r-0003kh-Db
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 09:48:55 +0000
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <madanvs@linux.vnet.ibm.com>; 
	Fri, 11 Apr 2014 15:18:45 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 542A3394005C
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Apr 2014 15:18:42 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	s3B9mmCD10289644
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 15:18:48 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s3B9mfQo030382
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 15:18:41 +0530
Received: from openstack.linuxxx (dhcp-9-193-66-181.in.ibm.com [9.193.66.181])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s3B9mfhS030348
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 15:18:41 +0530
Message-ID: <5347BA79.8030100@linux.vnet.ibm.com>
Date: Fri, 11 Apr 2014 15:18:41 +0530
From: Madan <madanvs@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] Cgroup_fj_stress tests are failing due to low memory
Reply-To: madanvs@linux.vnet.ibm.com
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

cgroup_fj stress.sh is failing for the following call
stress    6 1 2 2 2 is failing due to low memory !!
-bash-4.2# uname -a
Linux mcptestp72.austin.ibm.com 3.10.23-1100.pkvm2_1.1.ppc64 #1 SMP Wed 
Mar 5 21:23:43 CST 2014 ppc64 ppc64 ppc64 GNU/Linux


-bash-4.2# free -m
              total       used       free     shared    buffers cached
Mem:          8143       1158       6985          0 96        130
-/+ buffers/cache:        931       7212
Swap:         1999          0       199

I have a power machine with 8GB RAM,, strees tests is failing due to low 
memory..
if i reduce the mount times, subgroups, subgroup hierarchy to 50 test is 
passing,,

If anyone has the better fix  for this issue would be a great help.


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
