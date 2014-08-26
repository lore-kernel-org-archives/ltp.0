Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XMBBV-0001Z7-9K
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 07:28:53 +0000
Date: Tue, 26 Aug 2014 09:27:49 +0200
From: chrubis@suse.cz
Message-ID: <20140826072749.GA23377@rei.suse.cz>
References: <424e9b2f0320f58ad3b13852cb2093ef01ca90dd.1408717012.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <424e9b2f0320f58ad3b13852cb2093ef01ca90dd.1408717012.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] sbrk02: check for ret code in setup()
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/sbrk/sbrk02.c b/testcases/kernel/syscalls/sbrk/sbrk02.c
> index caa8537..5e9d4b8 100644
> --- a/testcases/kernel/syscalls/sbrk/sbrk02.c
> +++ b/testcases/kernel/syscalls/sbrk/sbrk02.c
> @@ -34,7 +34,7 @@ static void sbrk_verify(void);
>  static void cleanup(void);
>  static int exp_enos[] = { ENOMEM, 0 };
>  
> -static long increment;
> +static long increment = INC;
>  
>  int main(int argc, char *argv[])
>  {
> @@ -60,12 +60,19 @@ int main(int argc, char *argv[])
>  
>  static void setup(void)
>  {
> +	void *ret = NULL;
> +
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
>  
> -	for (increment = INC; errno == 0; increment+=INC)
> -		sbrk(increment);
> +	/* call sbrk until it fails or increment overflows */
> +	while (ret != (void *)-1 && increment > 0) {
> +		ret = sbrk(increment);
> +		increment += INC;
> +	}
> +	tst_resm(TINFO | TERRNO, "setup() bailing inc: %ld, ret: %p, sbrk: %p",
> +		increment, ret, sbrk(0));
>  
>  	errno = 0;

Ok, this fixes the inifinite loop, but doesn't the testcase still fail
afterwards? The sbrk_verify() expects it to fail with ENOMEM and when
the setup fails to prepare the condition it may not fail, or am I
mistaken?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
