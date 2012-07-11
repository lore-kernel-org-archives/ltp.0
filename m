Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Soyb0-0000ZF-2u
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 15:12:54 +0000
Date: Wed, 11 Jul 2012 16:28:15 +0200
From: chrubis@suse.cz
Message-ID: <20120711142815.GC13301@saboteur.suse.cz>
References: <1341990549-30278-1-git-send-email-vlee@twitter.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1341990549-30278-1-git-send-email-vlee@twitter.com>
Subject: Re: [LTP] [PATCH] tools/t0: Use version of setpgrp that takes no
 arguments.
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
To: Vinson Lee <vlee@twitter.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> IEEE Std 1003.1, 2004 Edition and IEEE Std 1003.1-2008 only have the
> version of setpgrp that takes no arguments.
> 
> http://pubs.opengroup.org/onlinepubs/009695299/functions/setpgrp.html
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/setpgrp.html
> 
> Also fixes build error on Mac OS X 10.7.
> 
> Signed-off-by: Vinson Lee <vlee@twitter.com>
> ---
>  testcases/open_posix_testsuite/tools/t0.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/tools/t0.c b/testcases/open_posix_testsuite/tools/t0.c
> index d8ac328..96bae9f 100644
> --- a/testcases/open_posix_testsuite/tools/t0.c
> +++ b/testcases/open_posix_testsuite/tools/t0.c
> @@ -101,7 +101,7 @@ int main (int argc, char * argv[])
>  		perror("fork failed");
>  		exit(1);
>  	case 0:
> -		setpgrp(0, 0);
> +		setpgrp();
>  		execvp(argv[2], &argv[2]);
>  		perror("execvp failed");
>  		exit(1);

Hmm, that is not enough to make it work in Linux, appereantly glibc
doesn't expose any of the setpgrp() definitions unless you specify which
one you want. And it's market as obsolete even in POSIX what about
replacing it with with more up to date interface?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
