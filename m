Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UepT8-0007Um-0a
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 16:31:22 +0000
Date: Tue, 21 May 2013 18:32:30 +0200
From: chrubis@suse.cz
Message-ID: <20130521163230.GA32292@rei.suse.cz>
References: <1369066734-17683-1-git-send-email-alexey.kodanev@oracle.com>
	<20130521124905.GC28186@rei> <519B8E4E.1010105@oracle.com>
	<20130521154615.GA31574@rei.suse.cz> <519B9B8D.6050004@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <519B9B8D.6050004@oracle.com>
Subject: Re: [LTP] [PATCH] Create a function tst_resm_hexd to print a buffer
 in hex
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > Okay what about priting the content of the buffer on several lines
> > unsing several tst_res() calls if the size of the message overflows some
> > size (possibly 80 chars)?
> >
> > test_name   0 TINFO: 'message passed to the tst res'
> > test_name   0 TINFO: 57 41 52 4e 49 4e 47 20 2a 20 57 41 52 4e 49 4e
> > test_name   0 TINFO: 57 41 52 4e 49 4e 47 20 2a 20 57 41 52 4e 49 4e
> > ...
> > (till the end of the buffer)
> >
> I agree, moreover, can we do it by default? At least bytes will be 
> aligned correctly.

Ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
