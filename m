Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Pzpj1-0006ig-Q8
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 12:21:15 +0000
Date: Wed, 16 Mar 2011 13:43:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110316124309.GB2096@saboteur.suse.cz>
References: <4D7B45F3.90703@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D7B45F3.90703@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] ftest06.c: fix a bug of using option -i
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> When using option -i, the case will print the following error message:
> # ./ftest06 -i 2
> ftest06     1  TPASS  :  Test passed.
> ftest06     2  TFAIL  :         Can't chdir(/tmp/fteBX4U5O/ftest06.7461/tmp/fteBX4U5O/ftest06.7461): errno=ENOENT(2): No such file or directory
> 

I've commited a little different patch that replaces the the strcat()'s
and strcpy()'s with single snprintf().

Thanks!
-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
