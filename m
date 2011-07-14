Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QhMQX-0004nF-6B
	for ltp-list@lists.sourceforge.net; Thu, 14 Jul 2011 13:58:05 +0000
Date: Thu, 14 Jul 2011 15:59:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110714135937.GA7866@saboteur.suse.cz>
References: <1310649983-28262-1-git-send-email-n>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1310649983-28262-1-git-send-email-n>
Subject: Re: [LTP] [PATCH V2] kill05: Added tst_resm() to print the proper
 error code(TPASS) if test exits with EPERM
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
> Added "tst_resm()" call to print the proper LTP error code(TPASS)
> in case of the testcase exit with expected result.
> 
> The testcase didn't call "tst_resm()" in case of 
> exit without error i.e. after that EPERM is correctly raised.
> The proper LTP error code, in that case, is TPASS as EPERM
> is the expected result.

Commited, thanks.

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
