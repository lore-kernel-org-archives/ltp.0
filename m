Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XxwtC-0007W9-IC
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 11:54:06 +0000
Date: Mon, 8 Dec 2014 12:53:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208115349.GC11071@rei.suse.de>
References: <1417776470-12961-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1417776470-12961-1-git-send-email-zlang@redhat.com>
Subject: Re: [LTP] [PATCH] diotest: set errno with zero before test with zero
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
To: Zorro Lang <zlang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>     ret = read(fd, buf, count);
>     if (ret >= 0 || errno != errnum) {
>         tst_resm(TFAIL, "read allows %s. returns %d: %s", msg, ret, strerror(errno));
>         l_fail = TRUE;

As far as I can see this code tests that read() has returned negative
value and in this case errno must be set.

I.e.

if ret >= 0 -> read hasn't failed -> FAILURE

The errno != errnum is not evaluated unless the first condition has
failed (that means ret < 0) and in this case errno must be set.

The condition is equivalent to !(ret < 0 && errno == errnum)

Or am I missing something?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
