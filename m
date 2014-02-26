Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIc9R-0006py-Sh
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 10:55:45 +0000
Date: Wed, 26 Feb 2014 11:55:32 +0100
From: chrubis@suse.cz
Message-ID: <20140226105531.GA23267@rei>
References: <1389853977.2282.9.camel@G08JYZSD130126>
	<1389854521.2282.10.camel@G08JYZSD130126>
	<1392710999.2036.16.camel@G08JYZSD130126>
	<1392711579.2036.18.camel@G08JYZSD130126>
	<20140225134636.GB14376@rei>
	<1393408265.2066.13.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393408265.2066.13.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] lstat/lstat02.c: add ELOOP errno test
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > > +	SAFE_MKDIR(cleanup, "test_eloop", MODE_RWX);
> > > +	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
> > > +	for (i = 0; i < 43; i++)
> > > +		strcat(elooppathname, "/test_eloop");
> > >  }
> > 
> > Hmm, where has the 43 came from?
> > 
> 
> I notice that the consecutive symlinks limits in kernel is hardwired to
> 40 in RHEL 5, 6, 7, but I'm not sure whether this value is the same in
> all linux kernels.

I've looked into the kernel sources and it's hardcoded to 40 in
fs/namei.c in follow_link() so I guess that we are fine with this value.

We should probably add a short comment about where the number came from.

> And the layer of the directory test_eloop/test_eloop is 2, if we want
> the test return ELOOP errno , the layer must more than 41. 43 = 2 + 41.
> 
> > Moreover the elloppathname size is PATH_MAX, you cannot be sure that the
> > whole string will fit (it likely will, but I would rather have value
> > based on the actual string length).
> > 
> 
> How about:
> static char elooppathname[(sizeof("/test_eloop") - 1) * 43 + 2] = ".";

I would simplify this to:

#define ELOPFILE "/test_eloop"

static char elooppathname[sizeof(ELOPFILE) * 43] = ".";

That way the buffer would be a few bytes longer than we need.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
