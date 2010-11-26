Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PLz4N-0001bU-1J
	for ltp-list@lists.sourceforge.net; Fri, 26 Nov 2010 14:14:35 +0000
Date: Fri, 26 Nov 2010 15:27:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101126142704.GA3587@saboteur.suse.cz>
References: <20101125164008.GC2853@saboteur.suse.cz>
	<AANLkTimFfK-34NALnKWMmOUqRhVfF70KMnWup8TiEp1C@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimFfK-34NALnKWMmOUqRhVfF70KMnWup8TiEp1C@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix lchown tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Folowing patch fixes/cleanups lchown tests.
> >
> > lchown01 changes:
> >
> > * make a better use of ltp test interface
> > * make error messages consistent
> > * various coding style issues
> >
> > lchown02 changes:
> >
> > * all test setups are now done in setup functions
> > * eliminated need for external script for preparing tempfile
> > * make a better use of ltp test interface
> > * make error messages consistent
> > * various coding style issues
> > * fix lchown02 invocation in runtest files
> 
> ...
> 
> +CFLAGS+=-W -Wall
> +
> 
> gcooper> Please remove.

Okay.

> ...
> 
> +				if (user_id == (uid_t)-1)
> +					user_id = test_cases[i - 1].user_id;
> +				if (group_id == (gid_t)-1)
> +					group_id = test_cases[i - 1].group_id;
> 
> gcooper> These assume that i is >= 1. Could you please add that
> conditional to the overall block so someone doesn't delete the
> subtestcase, break the test and come back to us later and gripe about
> how it's accessing memory out of bounds?
 
Okay.

> +				if ((stat_buf.st_uid != user_id) ||
> +				    (stat_buf.st_gid != group_id)) {
>  					tst_resm(TFAIL,
>  						 "%s: Incorrect ownership set, "
>  						 "Expected %d %d", SFILE,
> 
> gcooper> Technically it's %u.

Okay.

> +	return 0;
> +}
> 
> gcooper> If it gets down here, it should be return 1;
> 

Well, the return 0; is there just to silent compiler as cleanup() calls
tst_exit(); The best solution is IMHO add noreturn attribute to
cleanup() and remove the return 0;

> ...
> 
> +	if (close(fd) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "close(2) %s", TESTFILE);
> 
> gcooper> Wouldn't worry about the close.
 
Checking it doesn't do any harm. ;)

> ...
> 
> -	/* fix permissions on the tmpdir */
> -	if (chmod(".", 0711) != 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "chmod() failed");
> 
> gcooper> The directory mode for tst_tmpdir is different:
> 
> #define DIR_MODE        0777  /* mode of tmp dir that will be created */

As far as I understand the tests, changing permissions on tmp directory
is not needed as the test is testing permissions on symlinks created
inside of it (so we only need that the content of the directory is
accesible). I susspect that this is some workaround that wasn't removed
when test was ported for LTP.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
