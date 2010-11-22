Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PKWt0-00088O-QE
	for ltp-list@lists.sourceforge.net; Mon, 22 Nov 2010 13:56:50 +0000
Date: Mon, 22 Nov 2010 15:08:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101122140857.GB2853@saboteur.suse.cz>
References: <4CE4CD9D.4040406@cn.fujitsu.com>
	<20101118174923.GB19296@saboteur.suse.cz>
	<AANLkTi=eDrR3hZwjbuHSVxTuswYAPdBQgOvRAoVNxUVB@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=eDrR3hZwjbuHSVxTuswYAPdBQgOvRAoVNxUVB@mail.gmail.com>
Subject: Re: [LTP] [POSIX][PATCH]Destroy mutex an mutex_attr object at end
 of test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> Destroy mutex an mutex_attr object at end of test.
> >>
> >> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> >>
> >> ---
> >> =A0.../interfaces/pthread_mutex_getprioceiling/3-1.c =A0| =A0 =A02 ++
> >> =A0.../interfaces/pthread_mutex_getprioceiling/3-2.c =A0| =A0 =A03 +++
> >> =A0.../interfaces/pthread_mutex_getprioceiling/3-3.c =A0| =A0 =A03 +++
> >> =A03 files changed, 8 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pth=
read_mutex_getprioceiling/3-1.c b/testcases/open_posix_testsuite/conformanc=
e/interfaces/pthread_mutex_getprioceiling/3-1.c
> >> index d96ae43..5267b63 100644
> >> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mu=
tex_getprioceiling/3-1.c
> >> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mu=
tex_getprioceiling/3-1.c
> >> @@ -62,6 +62,8 @@ main(void)
> >> =A0 =A0 =A0 } else
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("pthread_mutex_getprioceiling passe=
d unexpectedly\n");
> >>
> >> + =A0 =A0 (void) pthread_mutex_destroy(&mutex);
> >> +
> >
> > Please never use useless cast like this.
> =

> Bian was following my example. I've gotten into the habit of doing
> this on calls like this because later versions of glibc start whining
> about blind calls to libcalls / syscalls (take open, write, etc for
> instance) where the developer doesn't check the return code. I did
> this to shut up that whining (because the return code isn't important
> for the overall intent of this testcase), and because I wanted to be
> explicit about the fact that the return code is ignored for human
> readers.
> =


Okay.

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
