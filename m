Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDXEU-00005v-DC
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 11:44:30 +0000
Date: Tue, 20 Jan 2015 12:43:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150120114329.GA11013@rei>
References: <1421426599-17413-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20150119145200.GA30242@rei> <54BE2EF3.3010604@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54BE2EF3.3010604@oracle.com>
Subject: Re: [LTP] [RFC PATCH] Asynchronous module unloading and tst_run_cmd
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> There is one more issue with tbio. :(
> >>
> >> Sometimes it may fail with:
> >>
> >> ltp_tbio    0  TINFO  :  Device opened successfully
> >> ltp_tbio    1  TPASS  :  success on LTP_TBIO_ALLOC test
> >> ltp_tbio    2  TPASS  :  success on LTP_TBIO_CLONE test
> >> ltp_tbio    3  TPASS  :  success on LTP_TBIO_GET_NR_VECS test
> >> ltp_tbio    4  TPASS  :  success on LTP_TBIO_ADD_PAGE test
> >> ltp_tbio    5  TPASS  :  success on LTP_TBIO_SPLIT:write to dev
> >> ltp_tbio    6  TPASS  :  success on LTP_TBIO_DO_IO:write to dev
> >> ltp_tbio    7  TPASS  :  success on LTP_TBIO_DO_IO:read from dev
> >> ltp_tbio    8  TPASS  :  success on LTP_TBIO_PUT test
> >> ERROR: Module ltp_tbio is in use
> >> ltp_tbio    9  TBROK  :  tst_run_cmd.c:84: failed to exec cmd 'rmmod' at tst_run_cmd.c:84
> >> ltp_tbio   10  TBROK  :  tst_run_cmd.c:84: Remaining cases broken
> >
> > Hmm, would switch to modprobe -r fix that?
> >
> > I've been told several times that rrmod should not be used anymore
> > because modprobe handles things better...
> >
> > Or will modprobe -r fail the same way?
> 
> Yes, modprobe -r will fail the same way. And using modprobe complicates 
> the module loading/unloading wrappers, because we will need to place 
> modules in /lib/modules/`uname-r`.

Ok, then we need this patchset to fix that.

Just side note, for modprobe -r the path for loading modules should not
matter and for loading modules we pass right path with -d.

> >> This is a rfc patch which fixes this problem.
> >>
> >> The main idea is to execute rmmod up to a timeout, and check if the module
> >> has been unloaded after each execution of rmmod.
> >>
> >> Summary of changes:
> >>   * introduce tst_module_is_loaded() - checks if the module is in /proc/modules
> >>   * change a bit interfaces of tst_run_cmd and cmd_run_cmd_fds (to conditionally
> >>     check the program exit code to be able to continue the test if the program failed)
> >>   * introducing a loop into tst_module_unload
> >>
> >
> > That sounds reasonably.
> >
> >> I would like somebody to review the general idea. If it's ok, I'll split this patch
> >> into several logically coupled ones and resend them.
> >>
> >> I'm really unsure if the changes to tst_run_cmd and cmd_run_cmd_fds are acceptable.
> >
> > I'm OK with adding the flag, it would need a better name though.
> >
> 
> int check_exit_status ? check if it's set to a non-zero value

Maybe we can change the functions to pass the exit value (return int) in
case that it's not used internally and name the flag pass_exit_val.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
