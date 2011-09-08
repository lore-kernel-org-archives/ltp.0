Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R1dG4-0005d7-I3
	for ltp-list@lists.sourceforge.net; Thu, 08 Sep 2011 11:59:04 +0000
Date: Thu, 8 Sep 2011 13:59:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110908115939.GA9484@saboteur.suse.cz>
References: <4E377560.7060600@cn.fujitsu.com> <4E4A2359.2040602@cn.fujitsu.com>
	<20110902124352.GA14558@saboteur.suse.cz>
	<20110902124744.GA14944@saboteur.suse.cz>
	<4E66D3C5.80001@cn.fujitsu.com> <4E66D492.1030907@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E66D492.1030907@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/6] hugemmap01.c
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
>  	/* Parse standard options given to run the test. */
> -	msg = parse_opts(ac, av, options, &help);
> +	msg = parse_opts(ac, av, NULL, NULL);
>  	if (msg != (char *) NULL) {
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use -help", msg);
>  		tst_exit();

The cast to (char *) is useless, please remove it, and also the
tst_exit() don't need to be there as tst_brkm() calls the tst_exit()
itself now.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Doing More with Less: The Next Generation Virtual Desktop 
What are the key obstacles that have prevented many mid-market businesses
from deploying virtual desktops?   How do next-generation virtual desktops
provide companies an easier-to-deploy, easier-to-manage and more affordable
virtual desktop model.http://www.accelacomm.com/jaw/sfnl/114/51426474/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
