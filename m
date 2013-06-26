Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Urq3j-0007lc-Ek
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 13:46:55 +0000
Date: Wed, 26 Jun 2013 15:48:23 +0200
From: chrubis@suse.cz
Message-ID: <20130626134823.GD16146@rei.suse.cz>
References: <1372251457-25602-1-git-send-email-alexey.kodanev@oracle.com>
	<20130626132135.GA16146@rei.suse.cz> <51CAEFD8.8000107@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51CAEFD8.8000107@oracle.com>
Subject: Re: [LTP] [PATCH] lib: safe_macros: add SAFE_EXECVP()
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > Well it is not execvp as the code does vfork + execvp, which is
> > confusing as the rest of the functions in this header does only what the
> > original function does + error checks. We should rather name this as
> > tst_run_cmd() or so.
> So, leave it in safe_macros, but named it as tst_run_cmd, right?

I would start a separate source file under lib and add either separate
header or add it to the test.h (as rest of the tst_interface does).

> >> +void safe_execvp(const char *file, const int lineno, void (cleanup_fn)(void),
> >> +                 char *const argv[])
> >> +{
> >> +	if (argv == NULL || ARRAY_SIZE(argv) == 0) {
> >> +		tst_brkm(TBROK, cleanup_fn,
> >> +			"argument list is empty at %s:%d", file, lineno);
> >> +	}
> > I do not think that the ARRAY_SIZE() works here (there are actually two
> > reasons for that). You cannot create zero leght array in C as array is a
> > pointer to memory (this is why we have NULL in C) and the second is that
> > ARRAY_SIZE() macro works only for arrays for which sizeof() returns size
> > of the object, if you have allocated array or pass it as a fuction
> > argument the sizeof() has no chance of determining the object size.
> >
> I see, then replace it with argv[0] != NULL, right?

Yes, if you settle for NULL-terminated array.

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
