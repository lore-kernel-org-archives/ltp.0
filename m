Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QmlSl-0001Xn-Nw
	for ltp-list@lists.sourceforge.net; Fri, 29 Jul 2011 11:42:43 +0000
Date: Fri, 29 Jul 2011 13:45:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110729114534.GA29831@saboteur.suse.cz>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
	<1309414787-2022-6-git-send-email-yanpai.chen@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1309414787-2022-6-git-send-email-yanpai.chen@gmail.com>
Subject: Re: [LTP] [PATCH 6/7] runtest/fs: change parameters of growfiles
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
To: Andrew Chen <yanpai.chen@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ypchen@faraday-tech.com

Hi!
> --- a/ltp-full-20101031/runtest/fs
> +++ b/ltp-full-20101031/runtest/fs
> @@ -14,9 +14,9 @@ gf12 mkfifo $TMPDIR/gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 30 $TMPDIR/gf
>  gf13 mkfifo $TMPDIR/gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 $TMPDIR/gffifo18
>  gf14 growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 -f glseek19 -S 2 -d $TMPDIR
>  gf15 growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 -f Lgfile1 -d $TMPDIR
> -gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_ -d $TMPDIR
> -gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_ -d $TMPDIR
>  gf18 growfiles -W gf18 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -l -S 2 -f Lgf04_ -d $TMPDIR
> +gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 101 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_ -d $TMPDIR
> +gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 101 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_ -d $TMPDIR
>  gf19 growfiles -W gf19 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_ -d $TMPDIR
>  gf20 growfiles -W gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 -f gfbigio-$$ -d $TMPDIR
>  gf21 growfiles -W gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 -f gf-bld-$$ -d $TMPDIR

Any reason why you have changed the order of the execution (the gf18 now preceeds gf16 and gf17)?

Also I'm not sure if 'shrinking on the same file' wasn't intentional
(most likely not but I'm not sure yet).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
