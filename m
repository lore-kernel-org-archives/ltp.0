Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Porsn-0008Tr-Cd
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 06:26:01 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Porsm-0004Nq-Hh
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 06:26:01 +0000
Received: by wwi18 with SMTP id 18so4256232wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Sun, 13 Feb 2011 22:25:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110214061409.GA7983@hpt.nay.redhat.com>
References: <20110214061409.GA7983@hpt.nay.redhat.com>
Date: Sun, 13 Feb 2011 22:25:54 -0800
Message-ID: <AANLkTimzLhCfwAgHuB4S3Fo=gHkHEKbjs6ObficnqKXU@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: ltp-list@lists.sourceforge.net, caiqian@redhat.com

On Sun, Feb 13, 2011 at 10:14 PM, Han Pingtian <phan@redhat.com> wrote:
> The KSM developer tell us that we should wait 3~5 increments of the
> /sys/kernel/mm/ksm/full_scans before checking ksm* testcases's results.
> Otherwise, there may be some stuck pages that cause the testing failed.

    A common mistake is thinking that sleep(3) is non-interruptable.
This proposed patch also has style-violations and is missing error
checking around lseek, et all. Please fix these items according to the
style guide.
Thanks,
-Garrett

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
