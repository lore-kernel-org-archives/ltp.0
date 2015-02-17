Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YNilv-0000cG-CX
	for ltp-list@lists.sourceforge.net; Tue, 17 Feb 2015 14:05:07 +0000
Date: Tue, 17 Feb 2015 15:04:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150217140458.GA25756@rei>
References: <789026778.7588485.1423581396876.JavaMail.zimbra@redhat.com>
	<1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
	<20150212110310.GA14329@rei>
	<980241572.9316983.1423749665613.JavaMail.zimbra@redhat.com>
	<54E33EE9.9000302@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54E33EE9.9000302@redhat.com>
Subject: Re: [LTP] network namespaces tests cleanup
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Alternatively, you could approach it a bit differently - test the
> actual kernel namespacing functionality using unshare/setns in
> *kernel*/containers/ and verify that iproute2 uses it in
> network/iproute/ (or perhaps commands/ip/ ?).

Right what needs to be tested is the kernel functionality and that the
tools call correct syscall with correct paramters, these are two
different things. But still as far as I can see the easiest way is to
run the whole test and switch between the tool it uses which is just a
few lines of code.

How do you plan to test that ip does what it should? Run it under strace
and grep for the syscall and check the parameters? That sound fragile to
me. Or is there a better way?

> The idea being that you don't exactly need to "brute force" test
> everything everytime - the kernel functionality doesn't change
> based on what utility uses the unshare() syscall.
> I (in ltp-unrelated activities) found out that this approach gives
> the best coverage / time / maintenance ratio.

Agree that the kernel functionality is the same. But how does having two
different testcases one for kernel functionality and one for ip decrease
maintenance ratio? This soulution would IMHO be more complicated. The
coverate should be same. The only aspect in which this solution is
likely better is test runtime, but that shouldn't be a problem because
these testcases does not take long time. Or am I mistaken?

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
