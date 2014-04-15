Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wa1Gj-00063Q-CO
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 11:11:13 +0000
Date: Tue, 15 Apr 2014 13:10:26 +0200
From: chrubis@suse.cz
Message-ID: <20140415111025.GA13702@rei>
References: <20140414174105.GA26543@rei>
	<1397550675-25420-1-git-send-email-mats.liljegren@enea.com>
	<1397550675-25420-2-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397550675-25420-2-git-send-email-mats.liljegren@enea.com>
Subject: Re: [LTP] [PATCH] utils/Makefile: Move ffsb configure to
	configure.ac
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net, Fathi Boudra <fathi.boudra@linaro.org>

Hi!
> The configure call was done from make file without appropriate parameters,
> which breaks cross-compiling. Include ffsb into configure.ac so that it is
> included in the main configure call.
> 
> This fix is based on a patch by Fathi Boudra <fathi.boudra@linaro.org> for an
> earlier version of LTP.

Tested with out-of-tree build and pushed.

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
