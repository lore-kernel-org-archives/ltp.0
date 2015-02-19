Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YOT8P-0004Z1-UY
	for ltp-list@lists.sourceforge.net; Thu, 19 Feb 2015 15:35:25 +0000
Date: Thu, 19 Feb 2015 16:35:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150219153514.GA25126@rei>
References: <20150212165921.GA27008@rei> <20150218111446.GA15861@rei.suse.de>
	<1801010187.15219396.1424359733914.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1801010187.15219396.1424359733914.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] prototyping new library synchronization
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > https://github.com/linux-test-project/ltp/commit/9f136a48c6205362cd8d35c726491ca93cb16514
> > 
> > Everybody please test that it compiles and works fine.
> 
> - one small compilation problem
>    https://github.com/linux-test-project/ltp/commit/1261dd6817bb320081fa0237361bbb491a028c65

Thanks for fixing it.

> - gitignore could be expanded for:
>     lib/tests/tst_checkpoint
>     lib/tests/tst_checkpoint_wait_timeout
>     lib/tests/tst_checkpoint_wake_timeout

Ah, sorry I've forgotten to update the top level .gitignore file. The
old test names should have been removed, new added. I've pushed fix for
that now.

> I compiled and ran subset of tests (syscalls mostly) on RHEL5.6/6.0/7.1. There were some failures,
> but those all appear to be actual bugs present in older kernels.

Sounds good, thanks for the testing.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
