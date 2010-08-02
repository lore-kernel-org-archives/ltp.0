Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gurudas.pai@oracle.com>) id 1Ofolx-0007kp-4K
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 06:45:17 +0000
Received: from rcsinet10.oracle.com ([148.87.113.121])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ofolw-0004MP-8j
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 06:45:17 +0000
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by rcsinet10.oracle.com (Switch-3.4.2/Switch-3.4.2) with ESMTP id
	o726j92T001669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Aug 2010 06:45:10 GMT
Received: from acsmt354.oracle.com (acsmt354.oracle.com [141.146.40.154])
	by acsinet15.oracle.com (Switch-3.4.2/Switch-3.4.1) with ESMTP id
	o7242Krn013554
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Aug 2010 06:45:04 GMT
Message-ID: <4C5666AC.60308@oracle.com>
Date: Mon, 02 Aug 2010 12:03:16 +0530
From: Gurudas Pai <gurudas.pai@oracle.com>
MIME-Version: 1.0
Subject: [LTP]  LTP-20100630:quota_remount_test01.sh test fails.
Reply-To: gurudas.pai@oracle.com
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

Hi,

quota_remount_test01.sh test fails.

<<<test_start>>>
tag=quota_remount_test01 stime=1280709472
cmdline="quota_remount_test01.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
quota_remount_test01    0  TINFO  :  Successfully mounted the File System
quota_remount_test01    0  TINFO  :  Successfully Created Quota Files
quota_remount_test01    0  TINFO  :  Successfully Turned on Quota
quota_remount_test01    0  TINFO  :  Successfully wrote to the filesystem
quota: invalid option -- f
quota: Usage: quota [-guqxvs] [-l | -Q] [-i] [-F quotaformat]
         quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -u username ...
         quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -g groupname ...
Bugs to: mvw@planets.elm.net, jack@suse.cz
quota_remount_test01    0  TINFO  :  Successfully Remounted Read-Only FS
quota_remount_test01    0  TINFO  :  Successfully Remounted Read-Write FS
quota: invalid option -- f
quota: Usage: quota [-guqxvs] [-l | -Q] [-i] [-F quotaformat]
         quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -u username ...
         quota [-qxvs] [-l | -Q] [-i] [-F quotaformat] -g groupname ...
Bugs to: mvw@planets.elm.net, jack@suse.cz
Usage did not change after remount
quota_remount_test01    1  TFAIL  :  Quota on Remount Failed
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=20
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100630


Thanks,
-Guru

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
