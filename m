Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQbeo-0002A3-0j
	for ltp-list@lists.sourceforge.net; Wed, 25 Feb 2015 13:05:42 +0000
Date: Wed, 25 Feb 2015 14:05:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150225130502.GB20275@rei.suse.de>
References: <1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
	<54E4C3C3.6080407@redhat.com> <20150219150413.GA23831@rei>
	<54EC5053.4060005@redhat.com> <20150225123508.GA20275@rei.suse.de>
	<54EDC5B4.9050806@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54EDC5B4.9050806@redhat.com>
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
> > What I got:
> > 
> > mount("/proc/15413/ns/net", "netnstest", 0x410848, MS_MGC_VAL|MS_BIND, NULL) = -1 ENOTDIR (Not a directory)
> 
> Right, "netnstest" already needs to exist as a *file*, not a directory
> and the second argument needs to be without a trailing '/' (which it
> is). Then it works for me. The posted C snippets are meant to fit in
> the example setup I posted earlier (just acting in place of unshare or
> nsenter).

My bad I wasn't reading the instruction carefully enough and did mkdir
instead of touch. Now it works fine for me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
