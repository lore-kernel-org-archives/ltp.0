Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Zvlwx-0004fh-Gh
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2015 12:53:31 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zvlwu-0003XO-Fp
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2015 12:53:31 +0000
Date: Mon, 9 Nov 2015 13:50:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20151109125022.GA20990@rei>
References: <CAOVJa8FYtVzST_sEkeWxaEVFCC1FBo_ASgDjncAy50AaYiFGhA@mail.gmail.com>
	<20151022105504.GA7192@rei.suse.cz>
	<CAOVJa8E1YNg5a2ZeTHY_vpDPJkntpXsys9usaHQNYvBAxDWYcg@mail.gmail.com>
	<20151022121307.GB7192@rei.suse.cz>
	<CAOVJa8EfpYnYXriEa9XeDxH=6vwrprqT2FE+qNugyzw4oY6skg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOVJa8EfpYnYXriEa9XeDxH=6vwrprqT2FE+qNugyzw4oY6skg@mail.gmail.com>
Subject: Re: [LTP] how to cross compile linux test project?
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
To: vichy <vichy.kuo@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ltp@lists.linux.it

Hi!
> I can successfully configure the LTP for arm cross-compiling.
> But I found even if I enable posix-testsuites with below configs:
> ./configure AR=arm-buildroot-linux-gnueabi-ar
> CC=arm-buildroot-linux-gnueabi-gcc
> RANLIB=arm-buildroot-linux-gnueabi-ranlib
> STRIP=arm-buildroot-linux-gnueabi-strip --host=arm-linux
> --target=arm-buildroot-linux LDFLAGS=-pthread
> --with-open-posix-testsuite
> 
> the test binary located in testcases/open_posix_testsuite/conformance/
> are sill for X86, Not for the host, arm, I configure.
> 
> Is there anything I need to take care for cross compiling
> --with-open-posix-testsuite?
> or --with-open-posix-testsuite so far not support cross compile ?
> 
> appreciate your kind help in advance,

The build system for Open Posix Testsuite is not integrated with the
rest of the build system. But it shouldn't need anything more than
setting up right compiler:

$ export CC=arm-buildroot-linux-gnueabi-gcc
$ make

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Presto, an open source distributed SQL query engine for big data, initially
developed by Facebook, enables you to easily query your data on Hadoop in a 
more interactive manner. Teradata is also now providing full enterprise
support for Presto. Download a free open source copy now.
http://pubads.g.doubleclick.net/gampad/clk?id=250295911&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
