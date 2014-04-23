Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WcuMs-0003cV-Al
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 10:25:30 +0000
Date: Wed, 23 Apr 2014 12:24:36 +0200
From: chrubis@suse.cz
Message-ID: <20140423102436.GB23958@rei>
References: <0247700D01F14443B9209F90AD938CC524366845@sestoex05.enea.se>
	<1397663294-60210-1-git-send-email-mats.liljegren@enea.com>
	<20140422140717.GF3951@rei> <20140423084101.536f03f0@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140423084101.536f03f0@mats-desktop>
Subject: Re: [LTP] [RFC][PATCH] partrt_nohz_full: Introducing a new test case
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net, Kevin Hilman <khilman@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>

Hi!
> I've thought about this. The problem is that these tools is only one way
> of doing it. Performing CPU isolation in Linux is still something of a
> black art, so my idea was to show one way that we have got it working
> for at least some boards. Since how to do this is also dependent on
> architecture, board, kernel version and kernel configuration I didn't
> want to tie these script too closely to the test case since the test
> case by itself is quite generic.
> 
> Having these tools as copies in LTP repository gives additional
> maintenance burden that I feel is unnecessary. The tools are needed for
> other purposes as well, so moving them to LTP is not an option.
> 
> But if you have a good idea how to solve this dilemma, I'd like to hear
> about it.

The best solution I can think of is to add the rt-tools as a git
submodule in utils directory and install the required scripts on
make install if submodules were initialized and pulled.

On the test side we need to check if these scripts are in $PATH and exit
with TCONF if not.

Does this sound reasonable?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
