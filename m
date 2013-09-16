Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VLVVl-0006ub-FV
	for ltp-list@lists.sourceforge.net; Mon, 16 Sep 2013 09:54:29 +0000
Date: Mon, 16 Sep 2013 11:54:42 +0200
From: chrubis@suse.cz
Message-ID: <20130916095442.GA17003@rei.suse.cz>
References: <1379066452-5943-1-git-send-email-zliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379066452-5943-1-git-send-email-zliu@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/setgid: fixed a compiling error
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> commit 7dc42c97 did some clean up, but brought some typos:
>  1. getpwnam() is defined in /usr/include/pwd.h,
>     it doesn't need 'static', or remove getpwnam() declaration.
>  2. added duplicated 'static' key word.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  testcases/kernel/syscalls/setgid/setgid03.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setgid/setgid03.c b/testcases/kernel/syscalls/setgid/setgid03.c
> index 8b71401..8c76556 100644
> --- a/testcases/kernel/syscalls/setgid/setgid03.c
> +++ b/testcases/kernel/syscalls/setgid/setgid03.c
> @@ -33,11 +33,11 @@ int TST_TOTAL = 1;
>  
>  static char ltpuser1[] = "nobody";
>  static char root[] = "root";
> -static struct passwd *getpwnam(), *ltpuser1pwent, *rootpwent;
> +static struct passwd *ltpuser1pwent, *rootpwent;
>  static gid_t mygid;
>  
> -static static void setup(void);
> -static static void cleanup(void);
> +static void setup(void);
> +static void cleanup(void);
>  
>  int main(int ac, char **av)
>  {

Missed that, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
