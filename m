Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Ol1A5-0002ZP-IX
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 14:59:41 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ol1A4-0001V8-4x
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 14:59:41 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7GEg1nD024051
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 10:42:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7GExHjt1720322
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 10:59:17 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7GExHgD015972
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 10:59:17 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4C5666AC.60308@oracle.com>
References: <4C5666AC.60308@oracle.com>
Date: Mon, 16 Aug 2010 20:29:12 +0530
Message-Id: <1281970752.5120.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP-20100630:quota_remount_test01.sh test fails.
Reply-To: subrata@linux.vnet.ibm.com
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
To: gurudas.pai@oracle.com
Cc: ltp-list@lists.sourceforge.net

See this:

<<<test_start>>>
tag=quota_remount_test01.sh stime=1281970608
cmdline="quota_remount_test01.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
quota_remount_test01    0  TINFO  :  Successfully mounted the File
System
quota_remount_test01    0  TINFO  :  Successfully Created Quota Files
quota_remount_test01    0  TINFO  :  Successfully Turned on Quota
quota_remount_test01    0  TINFO  :  Successfully wrote to the
filesystem
quota_remount_test01    0  TINFO  :  Successfully Remounted Read-Only FS
quota_remount_test01    0  TINFO  :  Successfully Remounted Read-Write
FS
quota_remount_test01    0  TINFO  :  Usage successfully Changed after
Remount
quota_remount_test01    1  TPASS  :  Quota on Remount Successfull
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=15
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20100630
        
       ###############################################################"
        
            Done executing testcases."
            LTP Version:  LTP-20100630
       ###############################################################"
       
[root@mustang-lp4 ltp]# uname -a
Linux mustang-lp4.ltc.austin.ibm.com 2.6.33.4-106.fc13.ppc64 #1 SMP Mon
May 24 14:08:08 EDT 2010 ppc64 ppc64 ppc64 GNU/Linux
[root@mustang-lp4 ltp]# cat /etc/issue
Fedora release 13 (Goddard)
Kernel \r on an \m (\l)

Regards--
Subrata

On Mon, 2010-08-02 at 12:03 +0530, Gurudas Pai wrote:
> Hi,
> 
> quota_remount_test01.sh test fails.
> 
> <<<test_start>>>
> tag=quota_remount_test01 stime=1280709472
> cmdline="quota_remount_test01.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> quota_remount_test01    0  TINFO  :  Successfully mounted the File System
> quota_remount_test01    0  TINFO  :  Successfully Created Quota Files
> quota_remount_test01    0  TINFO  :  Successfully Turned on Quota
> quota_remount_test01    0  TINFO  :  Successfully wrote to the filesystem
> quota: invalid option -- f
> quota: Usage: quota [-guqxvs] [-l | -Q] [-i] [-F quotaformat]
>          quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -u username ...
>          quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -g groupname ...
> Bugs to: mvw@planets.elm.net, jack@suse.cz
> quota_remount_test01    0  TINFO  :  Successfully Remounted Read-Only FS
> quota_remount_test01    0  TINFO  :  Successfully Remounted Read-Write FS
> quota: invalid option -- f
> quota: Usage: quota [-guqxvs] [-l | -Q] [-i] [-F quotaformat]
>          quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -u username ...
>          quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -g groupname ...
> Bugs to: mvw@planets.elm.net, jack@suse.cz
> Usage did not change after remount
> quota_remount_test01    1  TFAIL  :  Quota on Remount Failed
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=1 corefile=no
> cutime=1 cstime=20
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20100630
> 
> 
> Thanks,
> -Guru
> 
> ------------------------------------------------------------------------------
> The Palm PDK Hot Apps Program offers developers who use the
> Plug-In Development Kit to bring their C/C++ apps to Palm for a share
> of $1 Million in cash or HP Products. Visit us here for more details:
> http://p.sf.net/sfu/dev2dev-palm
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
