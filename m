Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WO70H-0003zF-Fc
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 14:53:01 +0000
Date: Thu, 13 Mar 2014 15:52:42 +0100
From: chrubis@suse.cz
Message-ID: <20140313145241.GA3628@rei.suse.cz>
References: <1390882509-16312-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140305141502.GA24575@rei> <5318026D.4020306@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5318026D.4020306@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] pipeio/pipeio.c: cleanup
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This patch is a long cleanup, thanks for reviewing this.
> >
> > * The C option is removed
> >   (this one makes sense because it's not supported)
> Yes.
> >
> > * The B background option is removed
> 
> Here I think the "-B" option does not make much sense.
> And if "-B" option is specified, the parent process will always
> return 0, which won't reflect the correct test results.
> >
> > * The d dir option no longer copies the dir name, why?
> "-d" option is used to specify a directory, where named pipe is created, other
> than the current directory. Tst_tmpdir() will create a temporary directory, so I think
> "-d" option may be removed.

This is exactly what should be in the commit message. Because if you
don't write the motivation for the changes there, I need to figure it
out myself, which takes much more time.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
