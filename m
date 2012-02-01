Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RsbxB-0006jK-Ua
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 15:18:33 +0000
Date: Wed, 1 Feb 2012 16:31:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120201153152.GA32485@saboteur.suse.cz>
References: <1328097104-25615-1-git-send-email-salvatore.cro@st.com>
	<1328107114-14472-1-git-send-email-salvatore.cro@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1328107114-14472-1-git-send-email-salvatore.cro@st.com>
Subject: Re: [LTP] [PATCH V2] syscalls: fix creat07 setup and arg to execve
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
To: Salvatore CRO' <salvatore.cro@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Fix typo in setup function as app[0] should be
> checked instead of test_app[0].
> Fix test_path concatenating the absolute
> path to test_app when required (app[0] == '/').
> Finally fix execve (returning Bad address - EFAULT)
> argument av[1] as it requires argument
> array to be terminated by a null pointer.

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
