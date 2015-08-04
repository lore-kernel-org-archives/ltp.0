Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMbeu-0000ik-Fo
	for Ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 12:49:32 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMbes-0005KG-MD
	for Ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 12:49:32 +0000
Date: Tue, 4 Aug 2015 14:49:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150804124909.GB31594@rei.suse.de>
References: <OF65A761E0.9AA157C2-ON65257E93.002B0BBB-65257E93.002CB911@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OF65A761E0.9AA157C2-ON65257E93.002B0BBB-65257E93.002CB911@in.ibm.com>
Subject: Re: [LTP] : Test Cases for libnuma
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
To: Vijay K Puliyala <vpuliyal@in.ibm.com>
Cc: Ltp-list@lists.sourceforge.net, subrata@linux.vnet.ibm.com

Hi!
> Hi Subrata,

As far as I know Subrata is not active in LTP development for quite some
time.

> I have installed LTP on SUSE.  I want to run numa testcases.  I have done 
> below steps to run numa.
> 
> _______________________________________________________________________
> 
> perf2877:/vijay/NUMA/ltp-full-20150420 # ./runltp -f numa
> FATAL: LTP not installed correctly
> INFO:  Follow directions in INSTALL!

This is wrong, you cannot run LTP without installation.

> ______________________________________________________________________
> 
> perf2877:/vijay/NUMA/ltp-full-20150420 # /opt/ltp/runltp -f numa
> 
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=32 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> <<<test_start>>>
> tag=move_pages11 stime=1438256071
> cmdline="cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 
> 04755 move_pages11 && move_pages.sh 11"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> move_pages11    1  TCONF  :  move_pages_support.c:412: NUMA support not 
> provided
> move_pages11    2  TCONF  :  move_pages_support.c:412: Remaining cases not 


This looks like numa devel headers are missing or too old. Check output
from the LTP configure.

> But if I run only  "/opt/ltp/runltp" with out any options or with out " -f 
> numa " option  it is giving results.

That is quite unlikely, if testcases are compiled without NUMA support
they cannot do anything unless recompiled.

> ____________________________________________________________________________
> If I run numa01.sh I am getting below errors.
> perf2877:/vijay/NUMA/ltp-full-20150420/testcases/kernel/numa # ./numa01.sh
> ./numa01.sh: line 66: tst_brkm: command not found
> ./numa01.sh: line 784: tst_resm: command not found
> ./numa01.sh: line 215: tst_resm: command not found
> ___________________________________________________________________

This is also wrong. You cannot run LTP testcases without setting right
PATH and few more env variables (which is done by runltp script).

> 
> I have installed  below packages 
> 
> perf2877:/opt/ltp # rpm -q libnuma-devel
> libnuma-devel-2.0.9-5.1.1
> perf2877:/opt/ltp # rpm -q libnuma1
> libnuma1-2.0.9-5.1.1
> perf2877:/opt/ltp # rpm -q libnuma-devel
> libnuma-devel-2.0.9-5.1.1
> perf2877:/opt/ltp # rpm -q autoconf
> autoconf-2.69-9.3
> perf2877:/opt/ltp # rpm -q automake
> automake-1.10.1-4.131.9.1
> perf2877:/opt/ltp #

Check the output from the configure script if it can find usable numa.h
and numaif.h.

> Also please add me in mailing list.

Do that yourself on LTP sf.net mailing list page.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
