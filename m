Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TvrAQ-0008D2-HF
	for ltp-list@lists.sourceforge.net; Thu, 17 Jan 2013 15:14:10 +0000
Date: Thu, 17 Jan 2013 16:14:26 +0100
From: chrubis@suse.cz
Message-ID: <20130117151426.GA12851@rei>
References: <1358368488-5082-1-git-send-email-sedat.dilek@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1358368488-5082-1-git-send-email-sedat.dilek@gmail.com>
Subject: Re: [LTP] [PATCH] realtime/lib: Fix includes in Makefile
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> testcases/realtime/lib/Makefile:25: ../../../../config.mk: No such file or directory
> make[2]: *** No rule to make target `../../../../config.mk'.  Stop.
> 
> The patch fixes the issue by using env_pre.mk to include config.mk from
> the correct location.
> 
> Tested with ltp-full-20130109 and ltp-git (20130109-5-g385d792).
> 
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  testcases/realtime/lib/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/realtime/lib/Makefile b/testcases/realtime/lib/Makefile
> index 8860549..fbbb873 100644
> --- a/testcases/realtime/lib/Makefile
> +++ b/testcases/realtime/lib/Makefile
> @@ -22,7 +22,8 @@
>  
>  top_srcdir		?= ../../..
>  
> -include $(top_srcdir)/../config.mk
> +include $(top_srcdir)/include/mk/env_pre.mk
> +include $(abs_srcdir)/../config.mk
>  
>  CFLAGS			+= -D_GNU_SOURCE

I do have similar patch for this issue I've haven't commited yet (I've
asked for review and the issue faded away).

Thanks for reminding, I'll fix this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
