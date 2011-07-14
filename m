Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QhKVC-0005nf-OA
	for ltp-list@lists.sourceforge.net; Thu, 14 Jul 2011 11:54:46 +0000
Date: Thu, 14 Jul 2011 13:56:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110714115618.GA3287@saboteur.suse.cz>
References: <1310567251-20343-1-git-send-email-no>
	<20110713153327.GA4772@saboteur.suse.cz>
	<000c01cc41f3$bf4c0370$3de40a50$@rundo@st.com>
	<20110714103204.GA2018@saboteur.suse.cz>
	<000d01cc421a$607dc5a0$217950e0$@rundo@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000d01cc421a$607dc5a0$217950e0$@rundo@st.com>
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
> Hmmm....I'm not sure about that....is not only a proper "print" issue as the
> testcase should return a "well defined" LTP error code i.e.
> TAPSS/TFAIL/TBROK etc...
>
> In the lib/tst_res.c, the error code used in the tst_resm()[internally by
> "tst_res()"] is used to setup the "T_exitval" variable which is used to
> define the LTP testcase exit code in the "tst_exit()".

Well test that just calls tst_exit() is successful and that would not
change, that would be called regression ;). Frankly there is quite lot
of things that has default behavior that must not change and not only in
LTP.

> Correctly, in the "kill05" test, each wrong scenario is properly managed
> with a tst_resm(TFAIL,"......") and so on.
> 
> Why it didn't the same(with tst_resm(TPASS,"...")) in case of no errors ?

I'm certainly not against that, I just don't like the wording for the
commit message, which made me think that the commit fixes very different
problem.

> Ok about your comment for the default LTP setup but I think the "kill05"
> test(or generally speaking, each LTP testcase) shouldn't make any assumption
> about LTP default settings as it could changes.... 
> Each test should set proper exit error code according to the obtained
> results/expected ones.

In short I will gladly pick your patch, just clarify the commit message
a little.

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
