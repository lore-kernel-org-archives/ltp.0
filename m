Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PpBIa-0001uJ-A8
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 03:09:56 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PpBIZ-0000RV-1e
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 03:09:56 +0000
Date: Tue, 15 Feb 2011 11:13:34 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110215031334.GA2884@hpt.nay.redhat.com>
References: <20110214061409.GA7983@hpt.nay.redhat.com>
	<AANLkTimzLhCfwAgHuB4S3Fo=gHkHEKbjs6ObficnqKXU@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimzLhCfwAgHuB4S3Fo=gHkHEKbjs6ObficnqKXU@mail.gmail.com>
Subject: Re: [LTP] [PATCH] ksm: wait 3 increments of full_scans before
 checking the results
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, Feb 13, 2011 at 10:25:54PM -0800, Garrett Cooper wrote:
> On Sun, Feb 13, 2011 at 10:14 PM, Han Pingtian <phan@redhat.com> wrote:
> > The KSM developer tell us that we should wait 3~5 increments of the
> > /sys/kernel/mm/ksm/full_scans before checking ksm* testcases's results.
> > Otherwise, there may be some stuck pages that cause the testing failed.
> 
>     A common mistake is thinking that sleep(3) is non-interruptable.
> This proposed patch also has style-violations and is missing error
> checking around lseek, et all. Please fix these items according to the
> style guide.
> Thanks,
> -Garrett
Thanks reviewing. The patched function will be called by 
testcases/kernel/mem/ksm/ksm* , which all call tst_sig() in setup().
 So I think we have processed the interruptable problem of sleep(). 

I'll submit new patch.
> 
> ------------------------------------------------------------------------------
> The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
> Pinpoint memory and threading errors before they happen.
> Find and fix more than 250 security defects in the development cycle.
> Locate bottlenecks in serial and parallel code that limit performance.
> http://p.sf.net/sfu/intel-dev2devfeb
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
