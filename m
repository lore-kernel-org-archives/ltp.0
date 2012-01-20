Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RoEVh-0005dn-H0
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 13:28:05 +0000
Date: Fri, 20 Jan 2012 14:40:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120120134016.GG4024@saboteur.suse.cz>
References: <1326897408-26778-1-git-send-email-carmelo.amoroso@st.com>
	<1326901442-23483-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326901442-23483-1-git-send-email-carmelo.amoroso@st.com>
Subject: Re: [LTP] [PATCH 1/2 V2] getcontext01: fix build using uClibc C
 runtime
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sf.net

Hi!
> Fix a build error when __UCLIBC__ is defined (see log below)
> by moving all headers inclusion and TCID definition on top of file
> as they are required by 'tst_brkm' function too.
> 
> ---
> getcontext01.c: In function ???main???:
> getcontext01.c:103:2: warning: implicit declaration of function ???tst_brkm???
> getcontext01.c:103:11: error: ???TCONF??? undeclared (first use in this function)
> getcontext01.c:103:11: note: each undeclared identifier is reported only once for each function it appears in
> getcontext01.c:103:18: error: ???NULL??? undeclared (first use in this function)
> getcontext01.c:104:1: warning: control reaches end of non-void function
> ---
> 
> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
> Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>

These signed off lines are added to comment sectioin (after the ---)
that gets stripped when applying. Please resend these two patches with
signed off lines right after the patch description. 

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
