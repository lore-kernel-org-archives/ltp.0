Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TvTcJ-0006JF-AT
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 14:05:23 +0000
Date: Wed, 16 Jan 2013 15:05:29 +0100
From: chrubis@suse.cz
Message-ID: <20130116140529.GA6699@rei>
References: <CA+icZUUsDzP+uLWD0i=JpMSiK1Qu3Pdux19rE7wTeJJu+-FaZw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUUsDzP+uLWD0i=JpMSiK1Qu3Pdux19rE7wTeJJu+-FaZw@mail.gmail.com>
Subject: Re: [LTP] Spelling "succeded" VS. "succeeded"
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
> While looking trough the results especially searching for some
> pattern, I noticed the different spelling of the word "succeeded" VS.
> "succeded".
> The spell-checker integrated in Firefox v18.0 tells me "succeeded"
> with double-e is correct.
> 
> [ SUCCEDED - one "E" ]
> 
> $ egrep -i 'error|fail'
> runltplite-results_3.8.0-rc3-next20130116-2-iniza-generic.txt | egrep
> -i succeded
> flock01     1  TPASS  :  flock() succeded with Shared Lock, returned
> error number=0
> flock01     2  TPASS  :  flock() succeded with Unlock, returned error number=0
> flock01     3  TPASS  :  flock() succeded with Exclusive Lock,
> returned error number=0
> 
> [ SUCCEEDED - double "E" ]
> 
> $ egrep -i 'error|fail'
> runltplite-results_3.8.0-rc3-next20130116-2-iniza-generic.txt | egrep
> -i succeeded
> madvise02    5  TFAIL  :  madvise succeeded unexpectedly
> open call succeededopen failed with EACCES as expectedopen call
> succeeded<<<execution_status>>>
> 
> AFAICS flock01.c needs to be corrected:
> 
> --- ltp-full-20120903.orig/testcases/kernel/syscalls/flock/flock01.c
>  2012-09-03 06:39:27.000000000 +0200
> +++ ltp-full-20120903/testcases/kernel/syscalls/flock/flock01.c
> 2013-01-16 14:12:36.597859952 +0100
> @@ -128,7 +128,7 @@ int main(int argc, char **argv)
>                                 continue;       /*next loop for MTKERNEL  */
>                         } else {
>                                 tst_resm(TPASS,
> -                                        "flock() succeded with %s,
> returned error number=%d",
> +                                        "flock() succeeded with %s,
> returned error number=%d",
>                                          test_cases[i].opt, TEST_ERRNO);
>                         }
> 
> Not sure if you like that patch sent via git-email as a separate patch?

There is no need for such elaborate explanation for a patch fixing a typo ;).

The ideal way of sending a patches here is unified diff with
signed-of-by line (you can generate these by git format-patch or use git
send-email to mail them directly).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
