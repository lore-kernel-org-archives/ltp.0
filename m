Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwDvW-0006iQ-ET
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 16:04:34 +0000
Date: Mon, 8 Jul 2013 18:06:09 +0200
From: chrubis@suse.cz
Message-ID: <20130708160609.GB24528@rei.suse.cz>
References: <1372658141-4384-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372658141-4384-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] clock_settime03: do not set outside address space
	tp
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  .../kernel/timers/clock_settime/clock_settime03.c    | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/testcases/kernel/timers/clock_settime/clock_settime03.c b/testcases/kernel/timers/clock_settime/clock_settime03.c
> index a949303..0b24e6d 100644
> --- a/testcases/kernel/timers/clock_settime/clock_settime03.c
> +++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
> @@ -49,8 +49,8 @@ int testcases[] = {
>  	EINVAL,			/* Invalid timespec     */
>  	EINVAL,			/* NSEC_PER_SEC + 1     */
>  	EPERM,			/* non-root user        */
> -	0,
> -	0,
> +	EINVAL,			/* PROCESS_CPUTIME_ID	*/
> +	EINVAL,			/* THREAD_CPUTIME_ID	*/
>  };
>  
>  char *TCID = "clock_settime03";
> @@ -70,17 +70,6 @@ int main(int ac, char **av)
>  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
> -	/* PROCESS_CPUTIME_ID & THREAD_CPUTIME_ID are not supported on
> -	 * kernel versions lower than 2.6.12 and changed back in 2.6.38
> -	 */
> -	if ((tst_kvercmp(2, 6, 12)) < 0 || (tst_kvercmp(2, 6, 38)) >= 0) {
> -		testcases[7] = EINVAL;
> -		testcases[8] = EINVAL;
> -	} else {
> -		testcases[7] = EFAULT;
> -		testcases[8] = EFAULT;
> -	}
> -
>  	setup();
>  
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> @@ -168,11 +157,6 @@ static int setup_test(int option)
>  			return -1;
>  		}
>  		break;
> -	case 7:
> -	case 8:
> -		/* Make tp argument bad pointer */
> -		if (tst_kvercmp(2, 6, 12) >= 0)
> -			temp = (struct timespec *)-1;
>  	}
>  	return 0;
>  }

If I'm getting this right the order of checks in kernel was probably
changed (userspace address validation vs timer id validation) and
because of that the errno values were not stable. And as the test passes
invalid pointer in first testcase (with correct timer id) the invalid
pointer codepath in kernel is covered by the test allready.

Acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
