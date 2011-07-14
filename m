Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QhKvA-0007UP-0C
	for ltp-list@lists.sourceforge.net; Thu, 14 Jul 2011 12:21:36 +0000
Date: Thu, 14 Jul 2011 14:23:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110714122308.GA5300@saboteur.suse.cz>
References: <1310542250-1294-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1310542250-1294-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] opsix-test:sigaltstack:9-1.c:fix the wrong file
	path
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -	if (execl("conformance/interfaces/sigaltstack/9-buildonly.test", "9-buildonly.test", NULL) == -1) {
> +	if (execl("./9.run-test", "9.run-test", NULL) == -1) {
>  		perror("Unexpected error while attempting to setup test pre-conditions");

This one is more tricky too (mind the situation when the test is
installed). I need to figure out how how correctly propagate the path to
the test helper binary.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AppSumo Presents a FREE Video for the SourceForge Community by Eric 
Ries, the creator of the Lean Startup Methodology on "Lean Startup 
Secrets Revealed." This video shows you how to validate your ideas, 
optimize your ideas and identify your business strategy.
http://p.sf.net/sfu/appsumosfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
