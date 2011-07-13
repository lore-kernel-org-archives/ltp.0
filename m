Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qh1Pr-0002sf-Q0
	for ltp-list@lists.sourceforge.net; Wed, 13 Jul 2011 15:31:59 +0000
Date: Wed, 13 Jul 2011 17:33:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110713153327.GA4772@saboteur.suse.cz>
References: <1310567251-20343-1-git-send-email-no>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1310567251-20343-1-git-send-email-no>
Subject: Re: [LTP] [PATCH] kill05: Added proper return code (TPASS) if
 testcase exit without errors.
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 	Added kill05 TPASS exit code.
> 
> The testcase didn't return any retrun code in case of 
> exit without errors i.e. in case of EPERM is correctly 
> raised by the system.

That shouldn't be a problem. The source in lib/tst_res.c initalizes the
return value to 0 (which is equal to TPASS) so when you call tst_exit()
it returns TPASS unless the tests reports failure.

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
