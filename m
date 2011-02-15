Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <serge.hallyn@canonical.com>) id 1PpN3l-00085W-9N
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 15:43:25 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PpN3k-0007lG-E6
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 15:43:25 +0000
Date: Tue, 15 Feb 2011 09:43:14 -0600
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20110215154314.GA8739@localhost>
References: <4D5A47E5.3060108@cn.fujitsu.com> <20110215132603.GA3092@localhost>
	<AANLkTikNC8VgJiK3fzxTBX_9PXF6rw_F3KLakF-1+c45@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikNC8VgJiK3fzxTBX_9PXF6rw_F3KLakF-1+c45@mail.gmail.com>
Subject: Re: [LTP] [PATCH] unshare01.c: TEST_RETURN is used wrong
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

Quoting Garrett Cooper (yanegomi@gmail.com):
> > Looking at the rest of that file, isn't the right fix to
> > wrap 'pid1 = fork();' in a TEST() macro?
> 
> Hi Serge!
>     I would agree with you, but in my firm opinion this testcase
> abuses TEST_ERRNO, etc way too much for no good reason.

Cool.

>     I just didn't remember to follow through finishing off this file
> for some odd reason.

thanks,
-serge

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
