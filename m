Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WPXQv-0007ko-1N
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 13:18:25 +0000
Date: Mon, 17 Mar 2014 14:18:03 +0100
From: chrubis@suse.cz
Message-ID: <20140317131803.GA3532@rei>
References: <1392809376-13063-1-git-send-email-alexey.kodanev@oracle.com>
	<20140313144804.GB2503@rei.suse.cz> <5326CE7C.5070603@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5326CE7C.5070603@oracle.com>
Subject: Re: [LTP] [PATCH v5] network: tcp_fastopen: add TCP Fast Open test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > This version looks good. I would be happier if the shell part was ported
> > to the new test.sh but I can live with it as it is now.
> >
> > And this patch is blocked by the thread safety patch for the tst_res.c.
> > I guess I will commit it next week, it has been on the ML long enough.
> >
> OK, thanks. I can do porting later along with the fix which I would like 
> to add to the test: there is recently added tst_get_unused_port() 
> function, but how can I use it in the script, should I add it to 
> tools/apicmds?

Yes please.

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
