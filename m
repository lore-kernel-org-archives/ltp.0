Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wrmbs-0007oB-0j
	for ltp-list@lists.sourceforge.net; Tue, 03 Jun 2014 11:10:28 +0000
Date: Tue, 3 Jun 2014 13:10:08 +0200
From: chrubis@suse.cz
Message-ID: <20140603111008.GB13502@rei.Home>
References: <CA+icZUWoiUudQ8yZ0SKOTQUh2brwoCJNL0-FHZdfaKfAR2t_CQ@mail.gmail.com>
	<20140603103729.GA13502@rei.Home>
	<CA+icZUVjTjsuNsnM7usCEe8ORzdme3D9awfNGUvOzPW4q5F7Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUVjTjsuNsnM7usCEe8ORzdme3D9awfNGUvOzPW4q5F7Sg@mail.gmail.com>
Subject: Re: [LTP] Testcases especially to test pipes
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > The obvious answer would be testcases/syscalls/pipe/ and
> > testcases/syscall/{splice,vmsplice,tee} (make sure to use latest git for
> > these because I've just commited fixes for them).
> >
> > There may be other relevant testcases but sorting them out would require
> > going over the testcases and figuring out what exactly they test.
> >
> 
> Do I need the latest Linux header files?

Did anything break?

(The code should not use the linux headers but rather the glibc
counterparts)

> P.S.: Output installed linux-headers packages on Ubuntu/precise AMD64.
> 
> # dpkg -l | grep linux-headers
> ii  linux-headers-3.2.0-64                              3.2.0-64.96
>                                      Header files related to Linux
> kernel version 3.2.0
> ii  linux-headers-3.2.0-64-generic                      3.2.0-64.96
>                                      Linux kernel headers for version
> 3.2.0 on 64 bit x86 SMP
> ii  linux-headers-generic                               3.2.0.64.76
>                                      Generic Linux kernel headers

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
