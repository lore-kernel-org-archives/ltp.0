Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TgcNS-0002MC-Lh
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 14:24:38 +0000
Date: Thu, 6 Dec 2012 15:24:26 +0100
From: chrubis@suse.cz
Message-ID: <20121206142426.GB2317@rei.nue.novell.com>
References: <1354605716-4747-1-git-send-email-penght@cn.fujitsu.com>
	<1354605716-4747-3-git-send-email-penght@cn.fujitsu.com>
	<50BDA8C3.4070802@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50BDA8C3.4070802@casparzhang.com>
Subject: Re: [LTP] [PATCH 3/4] at_allow01: Use lib to restart atd service
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > + 84?? .??cmdlib.sh
> 
> Patch series looks good to me except this.

The patch series looks really good.

> sourcing a lib inside a function seems not so good. Yet I don't see any 
> code style rules telling which is the correct place to put a shell lib 
> source (commonly I think it would be the top in the file)

It's always better to include the bash library first so that your
variables are not rewritten by these used in the library. I've seen
cases where this was a issue (one test included a file from init scripts
which is different in diferent version of distribution and in one case
the name clashed) and the test was broken because the file wasn't
included at the top.

So actually this is not hard requirement but rather a good practice.

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
