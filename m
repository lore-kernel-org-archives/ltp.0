Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QNPYy-0000FK-Jh
	for ltp-list@lists.sourceforge.net; Fri, 20 May 2011 13:16:20 +0000
Date: Fri, 20 May 2011 15:12:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110520131211.GB16147@saboteur.suse.cz>
References: <1aca96688a199f0cc6559a3f64be2ca1d73e6842.1305106654.git.czhang@redhat.com>
	<BANLkTik82GxsSMDV0ifMxy4DvEBRRGJPww@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTik82GxsSMDV0ifMxy4DvEBRRGJPww@mail.gmail.com>
Subject: Re: [LTP] [PATCH] [syscalls] chown03: fix EPERM issue
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > in setup phase of chown03 testcase, it set effective gid/uid before
> > create tmpdir, this might cause EPERM error under some circumstance:
> >
> > chown03 =A0 =A0 1 =A0TBROK =A0: =A0chown(/tmp/ltp-1FYYTiULQl/chos2UBh3,=
 -1, 0) failed: errno=3DEPERM(1): Operation not permitted
> > chown03 =A0 =A0 2 =A0TBROK =A0: =A0Remaining cases broken
> > chown03 =A0 =A0 0 =A0TWARN =A0: =A0tst_brk: Invalid Type: 4. Using TBROK
> =

> That message is bizarre and looks like another bug in lib/... .

Hmm, looks like the tst_tmpdir() is trying to change group id to
getgid() which returns 0, but you are not allowed (at least in this
case) to do that with egid for nobody. (on my machine this works fine).

And yes, the tst_tmpdir() would need some cleanup...

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its =

next-generation tools to help Windows* and Linux* C/C++ and Fortran =

developers boost performance applications - including clusters. =

http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
