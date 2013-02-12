Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U5FYK-0002OZ-JD
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 13:05:40 +0000
Date: Tue, 12 Feb 2013 14:06:06 +0100
From: chrubis@suse.cz
Message-ID: <20130212130606.GC9378@rei>
References: <CAAZGUZdwKLu=b14tV5XiuArAcN1o9ENEpc=Vyw+jdP6_CUzeog@mail.gmail.com>
	<CAAZGUZfwzVLPd6HesN26c4uL=ZTug9f-axrkcxHGRveqsjnjyA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAZGUZfwzVLPd6HesN26c4uL=ZTug9f-axrkcxHGRveqsjnjyA@mail.gmail.com>
Subject: Re: [LTP] Running LTP on embedded Busybox platforms
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
To: Bogdan Purcareata <bogdan.purcareata@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I'm a new user of the LTP and I was wondering if it works on embedded
> platforms with custom Linux distros built with Yocto. I was interested
> in the "containers" set of tests, particularly the network namespace
> ones.

Most of the tests should work on embedded platforms and with Busybox but
I personaly can't guarante that. In other words We are trying not to
break things for anybody, but some tests may not worked from the start.

> I noticed the tests were not working properly on a Busybox
> system, and I've identified some differences between this and running
> LTP on my host Fedora 17 system (which works fine):
> - Busybox's diff outputs in the unified format by default - this
> causes parsing issues in LTP
> - there is no sshd server on my embedded platform - instead I have
> dropbear installed, and the scripts need minor changes to work
> - the networking utils - ping, ip, etc. - are from the inetutils
> package, instead if the expected iputils package

As usual patches are welcome.

> I was wondering if these requirements - diff, sshd, iputils package,
> and others - are somewhere listed as prerequisites in the
> documentation (I haven't searched it extensively). Where should I look
> for a complete list of host userspace applications needed by LTP to
> work?

Sorry the LTP documentation is not in a good shape. On the other hand I
would be happy to include what you have found into the containers README
file. Just send a signed patch.

> Also, are there any branches of the LTP project designed to work with
> e.g. Busybox by default? I noticed that the ltp-full-20130109.bz2
> arhive is universal and has no mentions of supported host distro
> configuration (or perhaps I didn't look in the right place?).

There are not. We have one archive to run on all flavors of Linux,
fragmentation would only make things worse.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
