Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1OypTS-0008RM-0q
	for ltp-list@lists.sourceforge.net; Thu, 23 Sep 2010 17:20:46 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OypTN-00037I-K4
	for ltp-list@lists.sourceforge.net; Thu, 23 Sep 2010 17:20:45 +0000
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by mx02.colomx.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id
	o8NHKZTj028931
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Sep 2010 13:20:35 -0400
Date: Thu, 23 Sep 2010 13:20:35 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1320440485.401261285262435919.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <117605613.400901285262212547.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18327_282087822.1285262435917"
Subject: [LTP] [PATCH] Re: fix incorrect parsing of df command in
	ftruncate04.sh
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
To: LTP List <ltp-list@lists.sourceforge.net>

------=_Part_18327_282087822.1285262435917
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Sorry for missing [PATCH] tag, now added.

Thanks,
Caspar
----- "Caspar Zhang" <czhang@redhat.com> wrote:

> Hi all, an error in ftruncate04 test is found,
> The problem I see is due to incorrect parsing
> of `df` command output:
> 
> <<<test_start>>>
> tag=ftruncate04 stime=1284729392
> cmdline="ftruncate04.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> DEV:         /dev/mapper/vg_rhel6beta-lv_root
> MOUNT_POINT: /dev/mapper/vg_rhel6beta-lv_root
> FLAG:        rw,mand
> ftruncate04    1  TPASS  :  Test passed.
> mount: you must specify the filesystem type
> ftruncate04.sh : ERROR : mounting /dev/mapper/vg_rhel6beta-lv_root
> remount,rw,mand failed
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=1 cstime=7
> <<<test_end>>>
> 
> # mount | head -1
> /dev/mapper/vg_rhel6beta-lv_root on / type ext4 (rw,mand)
> 
> # df .
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/mapper/vg_rhel6beta-lv_root
>                        2523808   2436384         0 100% /
> 
> A patch is attached to fix this problem. After applied the patch,
> the failure gone:
> 
> <<<test_start>>>
> tag=ftruncate04 stime=1284729277
> cmdline="ftruncate04.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> DEV:         /dev/mapper/vg_rhel6beta-lv_root
> MOUNT_POINT: /
> FLAG:        rw,mand
> ftruncate04    1  TPASS  :  Test passed.
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=1 cstime=9
> <<<test_end>>>
> 
> # mount | head -1
> /dev/mapper/vg_rhel6beta-lv_root on / type ext4 (rw)
> # df -P .
> Filesystem         1024-blocks      Used Available Capacity Mounted on
> /dev/mapper/vg_rhel6beta-lv_root   2523808   2436380         0    
> 100% /
> 
> So the test without the patch leaves the system in inconsistent state
> (mand option is kept for the filesystem) which is bad.
> 
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> 
> ---
> ltp-full-20100331.old/testcases/kernel/syscalls/ftruncate/ftruncate04.sh
> 2010-09-17 15:06:44.292158981 +0200
> +++
> ltp-full-20100331/testcases/kernel/syscalls/ftruncate/ftruncate04.sh
> 2010-09-17 15:10:26.646160911 +0200
> @@ -18,7 +18,7 @@
>      export TST_TOTAL=1
>  fi
>  cd ${TMPDIR:=/tmp}
> -set -- $(df . | awk '/^\// { print $1, $NF }')
> +set -- $(df -P . | awk '/^\// { print $1, $NF }')
>  DEV=$1; MOUNT_POINT=$2
>  if [ "x$DEV" = x -o "x$MOUNT_POINT" = x ] ; then
>      tst_resm TCONF "backend mountpoint for $TMPDIR does not
> correspond to a real device:"
> 
> 
> Thanks,
> Caspar
> 
> --
> Quality Assurance Associate (Kernel) in
> Red Hat Inc. (Beijing R&D Branch)
> 
> TEL: +86-10-62608150
> Web: http://www.redhat.com/

-- 
Quality Assurance Associate (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch

TEL: +86-10-62608150
WEB: http://www.redhat.com/

------=_Part_18327_282087822.1285262435917
Content-Type: text/x-patch; name=syscalls-ftruncate04-fix-df-param.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=syscalls-ftruncate04-fix-df-param.patch

--- ltp-full-20100331.old/testcases/kernel/syscalls/ftruncate/ftruncate04.sh	2010-09-17 15:06:44.292158981 +0200
+++ ltp-full-20100331/testcases/kernel/syscalls/ftruncate/ftruncate04.sh	2010-09-17 15:10:26.646160911 +0200
@@ -18,7 +18,7 @@
     export TST_TOTAL=1
 fi
 cd ${TMPDIR:=/tmp}
-set -- $(df . | awk '/^\// { print $1, $NF }')
+set -- $(df -P . | awk '/^\// { print $1, $NF }')
 DEV=$1; MOUNT_POINT=$2
 if [ "x$DEV" = x -o "x$MOUNT_POINT" = x ] ; then
     tst_resm TCONF "backend mountpoint for $TMPDIR does not correspond to a real device:"

------=_Part_18327_282087822.1285262435917
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
------=_Part_18327_282087822.1285262435917
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_18327_282087822.1285262435917--

