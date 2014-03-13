Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WO6vn-0006HB-Sb
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 14:48:24 +0000
Date: Thu, 13 Mar 2014 15:48:04 +0100
From: chrubis@suse.cz
Message-ID: <20140313144804.GB2503@rei.suse.cz>
References: <1392809376-13063-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392809376-13063-1-git-send-email-alexey.kodanev@oracle.com>
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
> This is a perfomance test for TCP Fast Open (TFO) which is an extension to
> speed up the opening of TCP connections between two endpoints. It reduces
> the number of round time trips (RTT) required in TCP conversations. TFO could
> result in speed improvements of between 4% and 41% in the page load times on
> popular web sites.
> 
> The default test scenario simulates an average conversation between a
> web-browser and an application server, so the test results with TFO enabled
> must be at least 3 percent faster.
> 
> The test must be run on Linux versions higher then 3.7. (TFO client side
> implemented in Linux 3.6, server side in Linux 3.7).

This version looks good. I would be happier if the shell part was ported
to the new test.sh but I can live with it as it is now.

And this patch is blocked by the thread safety patch for the tst_res.c.
I guess I will commit it next week, it has been on the ML long enough.

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
