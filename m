Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XSMjp-0001CP-21
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 09:01:53 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XSMjm-00075S-4A
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 09:01:52 +0000
Date: Fri, 12 Sep 2014 05:01:43 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <833716875.22098201.1410512503300.JavaMail.zimbra@redhat.com>
In-Reply-To: <1410445092-6922-1-git-send-email-avagin@parallels.com>
References: <1302257752.21284267.1410435513928.JavaMail.zimbra@redhat.com>
	<1410445092-6922-1-git-send-email-avagin@parallels.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] inotify: print event->name accoding with
 event->len (v2)
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
To: Andrey Vagin <avagin@parallels.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Andrey Vagin" <avagin@parallels.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "Jan Stancek" <jstancek@redhat.com>, "Andrey Vagin" <avagin@parallels.com>
> Sent: Thursday, 11 September, 2014 4:18:12 PM
> Subject: [PATCH 2/2] inotify: print event->name accoding with event->len (v2)
> 
> v2: event_set[test_num].name is a null terminated string
> Signed-off-by: Andrey Vagin <avagin@parallels.com>
> ---
>  testcases/kernel/syscalls/inotify/inotify02.c |  8 ++++----
>  testcases/kernel/syscalls/inotify/inotify04.c | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)

Both pushed, with small change to drop "len" also from inotify02.

Regards,
Jan

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
> index 7c3fdef..9eb3b3c 100644
> --- a/testcases/kernel/syscalls/inotify/inotify04.c
> +++ b/testcases/kernel/syscalls/inotify/inotify04.c
> @@ -67,7 +67,6 @@ int TST_TOTAL = 4;
>  struct event_t {
>  	char name[BUF_SIZE];
>  	unsigned int mask;
> -	unsigned int len;
>  };
>  
>  #define	TEST_DIR	"test_dir"
> @@ -223,8 +222,8 @@ int main(int argc, char **argv)
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
> @@ -233,19 +232,20 @@ int main(int argc, char **argv)
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
> +				 "name=\"%.*s\" (expected \"%s\") %d",
>  				 event->wd, event->mask,
>  				 event_set[test_num].mask,
> -				 event->cookie, event->len, event->name,
> +				 event->cookie, event->len,
> +				 event->len, event->name,
>  				 event_set[test_num].name,
> -				 strcmp(event_set[test_num].name, event->name));
> +				 strncmp(event_set[test_num].name, event->name, event->len));
>  		}
>  		test_num++;
>  		i += EVENT_SIZE + event->len;
> --
> 1.9.3
> 
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
