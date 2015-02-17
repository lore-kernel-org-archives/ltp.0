Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YNfD0-0008D8-1Y
	for ltp-list@lists.sourceforge.net; Tue, 17 Feb 2015 10:16:50 +0000
Date: Tue, 17 Feb 2015 11:16:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150217101625.GA21223@rei>
References: <CAHTgTXUOoT5adk98nj05B9Xq6K4i6tq7jGxQPtNPeiOU4oPbNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHTgTXUOoT5adk98nj05B9Xq6K4i6tq7jGxQPtNPeiOU4oPbNQ@mail.gmail.com>
Subject: Re: [LTP] mknodat01 build error
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
To: Vinson Lee <vlee@twopensource.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am hitting the following build error on Linux.

Thanks for the report, fixed in:

https://github.com/linux-test-project/ltp/commit/e25705238e7d5d24a3aa3bba9800afe36cbd5f5e

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
