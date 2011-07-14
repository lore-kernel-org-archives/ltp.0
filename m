Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QhJBg-0002D9-N7
	for ltp-list@lists.sourceforge.net; Thu, 14 Jul 2011 10:30:32 +0000
Date: Thu, 14 Jul 2011 12:32:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110714103204.GA2018@saboteur.suse.cz>
References: <1310567251-20343-1-git-send-email-no>
	<20110713153327.GA4772@saboteur.suse.cz>
	<000c01cc41f3$bf4c0370$3de40a50$@rundo@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000c01cc41f3$bf4c0370$3de40a50$@rundo@st.com>
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
> Thanks for your comment.
> 
> Anyway, I know LTP initalizes the return value to 0 (TPASS) but the problem
> is that this return code was "not reported" in the LTP log (in the same way
> used by other testcases) and, moreover, the "kill05" output message was
> misleading as it reported only the message " "kill failed with EPERM"
> without any further message which explained that EPERM was the expected test
> result and then the test worked fine.
> 
> Without above info, the result of the test was not very clear taking into
> account the output message ("kill failed with EPERM") which didn't include
> any further info about:
> 
> 1. LTP exit code (TPASS/TFAIL/TINFO/TBROK...); 
> 2. "obtained result" against "expected ones";

Okay, so the commit description was a bit misleading as return value is
integer nuber returned after process has ceased to exist. I would rather
change it to "kill05 didn't print ...".

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
