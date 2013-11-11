Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VfrKe-00081Y-Uj
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 13:15:09 +0000
Date: Mon, 11 Nov 2013 14:14:56 +0100
From: chrubis@suse.cz
Message-ID: <20131111131456.GA12164@rei>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
	<1383085243-5833-4-git-send-email-vincent.hsu@linaro.org>
	<20131107131234.GA28961@rei.suse.cz>
	<CAARHBVsQQEdYjY59Wa80ZO6TiVvb5gfWRA4vigMPmy-+tyH0jA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAARHBVsQQEdYjY59Wa80ZO6TiVvb5gfWRA4vigMPmy-+tyH0jA@mail.gmail.com>
Subject: Re: [LTP] [LNG][PATCH 3/9] ltp-networking/tcp_cmds/finger: finger
 an unknown host test will return 1 even if execution success on Ubuntu
 12.04
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
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, Linaro Networking <linaro-networking@linaro.org>

Hi!
> > > for example:
> > >     $ finger @xxxx || echo "test fail"
> > >     finger: unknown host: xxxx
> > >     getaddrinfo: No address associated with hostname
> > >     test fail
> >
> > Hmm, at my computers (SUSE, Gentoo) it works as:
> >
> > $ finger @xxxx || echo "test fail"
> > finger: unknown host: xxxx
> >
> > Are you sure that finger returns nonzero? From what package and what
> > version does your finger come from?
> >
> Yes, it returns nonzero in ubuntu. I have tested it in centos before, it
> returned zero same as your enviroment. I thinks it doen't relative to the
> package version, because it also happened in netstat test. I considerd that
> the default shell in ubuntu is dash not bash before, but it doesn't help
> even I forced to use bash. Maybe it cause by the bash version or something
> else, I could find the root cause yet. If you have time can you test it in
> debian based distribution?
> 
> However, I gave by finger and bash package version below, it seems applying
> some patch not pure packages.
> 
> apt-get source finger
> Reading package lists... Done
> Building dependency tree
> Reading state information... Done
> Picking 'bsd-finger' as source package instead of 'finger'
> Need to get 37.6 kB of source archives.
> Get:1 http://ubuntu.cs.nctu.edu.tw/ubuntu/ precise/main bsd-finger 0.17-14
> (dsc) [1,653 B]
> Get:2 http://ubuntu.cs.nctu.edu.tw/ubuntu/ precise/main bsd-finger 0.17-14
> (tar) [25.5 kB]
> Get:3 http://ubuntu.cs.nctu.edu.tw/ubuntu/ precise/main bsd-finger 0.17-14
> (diff) [10.4 kB]
> Fetched 37.6 kB in 0s (168 kB/s)
> gpgv: Signature made Fri 12 Feb 2010 02:03:58 PM CST using RSA key ID
> 947897D8
> gpgv: Can't check signature: public key not found
> dpkg-source: warning: failed to verify signature on ./bsd-finger_0.17-14.dsc
> dpkg-source: info: extracting bsd-finger in bsd-finger-0.17
> dpkg-source: info: unpacking bsd-finger_0.17.orig.tar.gz
> dpkg-source: info: unpacking bsd-finger_0.17-14.debian.tar.bz2
> dpkg-source: info: applying 01-legacy.patch
> dpkg-source: info: applying 02-518559-nsswitch-sources.patch
> dpkg-source: info: applying 03-468454-fingerd-ipv6.patch
> dpkg-source: info: applying 04-468454-finger-ipv6.patch
> dpkg-source: info: applying 05-547014-netgroup.patch

Looks like this is caused by the 01-legacy.patch that is part of the
debian package and gets picked up by ubuntu as well.

> > Btw what is wrong at the code bellow is the redirection, which does not
> > work, the >/dev/null should be before the 2>&1. Even if your finger
> > really returns nonzero the code bellow is quite cryptic as it looks like
> > it redirects all output from the finger into the /dev/null but it really
> > just redirects stderr into stdout which goes to the grep...
> >
> Yes, I thinks the redirection sequence is weird, I just don't want to do
> many modifications of the  original code. Can you help to improve it?

Just send fixes for the redirection in separate patch first and then
patch that fixes the finger return value.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
