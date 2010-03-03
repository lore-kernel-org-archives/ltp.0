Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nmnvy-0003aY-OB
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 12:44:14 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nmnvx-0003H6-JC
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 12:44:14 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o23CaGwS004522
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 07:36:16 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o23Ci75X1867800
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 07:44:07 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o23Ci6f0008259
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 07:44:07 -0500
Date: Wed, 3 Mar 2010 18:13:52 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100303124352.GD23601@linux.vnet.ibm.com>
References: <4B8E3B7F.8050301@calsoftinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B8E3B7F.8050301@calsoftinc.com>
Subject: Re: [LTP] Missing test tools in recent ltp builds
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
To: Shwetabh <shwetabh.goel@calsoftinc.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Mar 03, 2010 at 04:05:43PM +0530, Shwetabh wrote:
> Hi,
> 
Hi Shwetabh,

Few queries:
    - Tell us the complete steps of execution/compiling
    - OS version ?
    - automake & autoconf version ?
    - Arch ?

Thanks
-Rishi

> In recent ltp releases, I see quite a few test cases breaking since 
> their required tools
> are not being copied over to /opt/ltp/testcases/. I believe this 
> behaviour started since
> ltp started compiling and copying the files to /opt/ltp. Here is an example:
> 
> ----<<snip>>-----------
> remove test cases which require the block device.
> You can specify it with option -b
> COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 27204     -n 27204  -p  -f 
> /tmp/ltp-gcfmm27210/alltests -l 
> /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.log  -C 
> /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.failed
> LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.log
> FAILED COMMAND File: 
> /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.failed
> Running tests.......
> <<<test_start>>>
> tag=CPUHOTPLUG stime=1267586681
> cmdline="(cd $LTPROOT/testcases/kernel/hotplug/cpu_hotplug/; ./runtests.sh)"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> sh: line 0: cd: /opt/ltp/testcases/kernel/hotplug/cpu_hotplug/: No such 
> file or directory
> sh: ./runtests.sh: No such file or directory
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=127 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20100228
> 
>         ###############################################################"
> 
>              Done executing testcases."
>              LTP Version:  LTP-20100228
>         ###############################################################"
> 
> [root@localhost runtest]# cd /opt/ltp/testcases/
> [root@localhost testcases]# ls
> bin  data
> [root@localhost testcases]# pwd
> /opt/ltp/testcases
> [root@localhost testcases]# ls -l
> total 76
> drwxr-xr-x 7 root root 69632 Mar  2 22:24 bin
> drwxr-xr-x 2 root root  4096 Mar  2 22:19 data
> 
> --------------------
> 
> Please advice if I am doing something wrong here. Do I manually have to 
> copy the tools from tarballs' testcases/kernel directory?
> If so, shouldn't this be done by make install?
> 
> -- 
> Regards,
> Shwetabh
> 
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

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
