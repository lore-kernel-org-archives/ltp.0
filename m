Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XS2i7-0000Nx-3C
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 11:38:47 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XS2i0-0000Dc-Mh
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 11:38:47 +0000
Date: Thu, 11 Sep 2014 07:38:33 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1302257752.21284267.1410435513928.JavaMail.zimbra@redhat.com>
In-Reply-To: <1410343254-2349-2-git-send-email-avagin@openvz.org>
References: <1410343254-2349-1-git-send-email-avagin@openvz.org>
	<1410343254-2349-2-git-send-email-avagin@openvz.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] inotify: print event->name accoding
	with	event->len
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
To: Andrey Vagin <avagin@openvz.org>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Andrey Vagin" <avagin@openvz.org>
> To: ltp-list@lists.sourceforge.net
> Cc: "Andrey Vagin" <avagin@openvz.org>
> Sent: Wednesday, 10 September, 2014 12:00:54 PM
> Subject: [LTP] [PATCH 2/2] inotify: print event->name accoding with	event->len
> 
> Signed-off-by: Andrey Vagin <avagin@openvz.org>
> ---
>  testcases/kernel/syscalls/inotify/inotify02.c |  8 ++++----
>  testcases/kernel/syscalls/inotify/inotify04.c | 15 ++++++++-------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/inotify/inotify02.c
> b/testcases/kernel/syscalls/inotify/inotify02.c
> index f4f93fc..69bc0ff 100644
> --- a/testcases/kernel/syscalls/inotify/inotify02.c
> +++ b/testcases/kernel/syscalls/inotify/inotify02.c
> @@ -216,8 +216,8 @@ int main(int ac, char **av)
>  				tst_resm(TFAIL,
>  					 "get unnecessary event: "
>  					 "wd=%d mask=%x cookie=%u len=%u"
> -					 "name=\"%s\"", event->wd, event->mask,
> -					 event->cookie, event->len,
> +					 "name=\"%.*s\"", event->wd, event->mask,
> +					 event->cookie, event->len, event->len,
>  					 event->name);
>  
>  			} else if ((event_set[test_num].mask == event->mask)
> @@ -244,10 +244,10 @@ int main(int ac, char **av)
>  				if (!fail) {
>  					tst_resm(TPASS,
>  						 "get event: wd=%d mask=%x "
> -						 "cookie=%u len=%u name=\"%s\"",
> +						 "cookie=%u len=%u name=\"%.*s\"",
>  						 event->wd, event->mask,
>  						 event->cookie, event->len,
> -						 event->name);
> +						 event->len, event->name);
>  				} else {
>  					tst_resm(TFAIL,
>  						 "get event: wd=%d mask=%x "
> diff --git a/testcases/kernel/syscalls/inotify/inotify04.c
> b/testcases/kernel/syscalls/inotify/inotify04.c
> index 7c3fdef..e8cdbab 100644
> --- a/testcases/kernel/syscalls/inotify/inotify04.c
> +++ b/testcases/kernel/syscalls/inotify/inotify04.c
> @@ -223,8 +223,8 @@ int main(int argc, char **argv)
>  			tst_resm(TFAIL,
>  				 "got unnecessary event: "
>  				 "wd=%d mask=%x cookie=%u len=%u "
> -				 "name=\"%s\"", event->wd, event->mask,
> -				 event->cookie, event->len, event->name);
> +				 "name=\"%.*s\"", event->wd, event->mask,
> +				 event->cookie, event->len, event->len, event->name);
>  
>  		} else if ((event_set[test_num].mask == event->mask)
>  			   &&
> @@ -233,18 +233,19 @@ int main(int argc, char **argv)
>  			     event->len))) {
>  			tst_resm(TPASS,
>  				 "got event: wd=%d mask=%x "
> -				 "cookie=%u len=%u name=\"%s\"",
> +				 "cookie=%u len=%u name=\"%.*s\"",
>  				 event->wd, event->mask, event->cookie,
> -				 event->len, event->name);
> +				 event->len, event->len, event->name);
>  
>  		} else {
>  			tst_resm(TFAIL, "got event: wd=%d mask=%x "
>  				 "(expected %x) cookie=%u len=%u "
> -				 "name=\"%s\" (expected \"%s\") %d",
> +				 "name=\"%.*s\" (expected \"%.*s\") %d",
>  				 event->wd, event->mask,
>  				 event_set[test_num].mask,
> -				 event->cookie, event->len, event->name,
> -				 event_set[test_num].name,
> +				 event->cookie, event->len,
> +				 event->len, event->name,
> +				 event_set[test_num].len, event_set[test_num].name,

Hi,

event_set[test_num].len doesn't seem to be initialized anywhere, so in unlikely
case this fails (and len is 0) you get:
  TFAIL got event: wd=2 mask=400 (expected 400) cookie=0 len=0 name="" (expected "") 114
instead of:
  TFAIL got event: wd=2 mask=400 (expected 400) cookie=0 len=0 name="" (expected "test_file") 114

I'd suggest to keep last "%s" as it is now. It's used for "event_set[test_num].name",
which is always initialized. Then event_set's "len" field wouldn't be used for anything,
and could be removed from both inotify02.c and inotify04.c.

Regards,
Jan

>  				 strcmp(event_set[test_num].name, event->name));
>  		}
>  		test_num++;
> --
> 1.9.3
> 
> 
> ------------------------------------------------------------------------------
> Want excitement?
> Manually upgrade your production database.
> When you want reliability, choose Perforce
> Perforce version control. Predictably reliable.
> http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
