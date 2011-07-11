Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QgHVL-0001s1-0z
	for ltp-list@lists.sourceforge.net; Mon, 11 Jul 2011 14:30:35 +0000
Date: Mon, 11 Jul 2011 16:31:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110711143155.GD26246@saboteur.suse.cz>
References: <1308657537-17594-1-git-send-email-biessmann@corscience.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1308657537-17594-1-git-send-email-biessmann@corscience.de>
Subject: Re: [LTP] [PATCH] t/k/s/writev: fix UCLINUX build
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
To: Andreas =?iso-8859-1?Q?Bie=DFmann?= <biessmann@corscience.de>
Cc: ltp-list@lists.sourceforge.net

Hi!
> writev02 and writev03 can not build for UCLINUX defined but the choosen
> mechanism is error-prone cause in that case linking libltp.a complained about
> missing TCID symbol.
> 
> Remove the old way to skip this test for UCLINUX and choose an makefile based
> method instead.

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
