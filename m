Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RsY9v-0000Mz-C6
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 11:15:27 +0000
Date: Wed, 1 Feb 2012 12:28:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120201112840.GA25391@saboteur.suse.cz>
References: <1328090070-15140-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1328090070-15140-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] sigaction/16-1.c: make build pass on mips arch
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../conformance/interfaces/sigaction/16-1.c        |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
> index 1eda711..213bda0 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
> @@ -67,7 +67,9 @@ static struct sig_info sigs[] = {
>  	{SIGPIPE, "SIGPIPE", 0},
>  	{SIGALRM, "SIGALRM", 0},
>  	{SIGTERM, "SIGTERM", 0},
> +#ifndef __mips__
>  	{SIGSTKFLT, "SIGSTKFLT", 0},
> +#endif
>  	{SIGCHLD, "SIGCHLD", 0},
>  	{SIGCONT, "SIGCONT", 0},
>  	{SIGTSTP, "SIGTSTP", 0},

What about?

#ifdef SIGSTKFLT
  	{SIGSTKFLT, "SIGSTKFLT", 0},
#endif

Which should fix all possible systems without this signal.

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
