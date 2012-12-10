Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ti51l-0007QW-P2
	for ltp-list@lists.sourceforge.net; Mon, 10 Dec 2012 15:12:17 +0000
Date: Mon, 10 Dec 2012 16:12:06 +0100
From: chrubis@suse.cz
Message-ID: <20121210151205.GA11482@rei>
References: <50C597BF.3000807@symbio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50C597BF.3000807@symbio.com>
Subject: Re: [LTP] Running from tmpfs
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
To: Olli Vertanen <olli.vertanen@symbio.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I'd like to know if LTP tests can be run entirely from tmpfs? My system 
> has rootfs mounted read-only, and I would like to avoid remounting it. 
> Do you have tests that require write access to rootfs?

Not for writing, there were some buggy tests that utilized / directly
but that should have been fixed (at least I hope so). If you find such
testcase it's considered a bug.

> I've succeeded in running the runltplite.sh set of tests from tmpfs, but 
> to accomplish this with runalltests.sh minor modifications to the script 
> is required.
> 
> So, I started wondering, is the limitation because of inherit properties 
> of the tests, or just poor paramerization of the script.

I would say poorly written script, and as usuall patches are welcome ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
