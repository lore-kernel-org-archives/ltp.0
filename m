Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Rb49i-0005o8-4R
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 05:46:58 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rb49f-0006sy-OZ
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 05:46:58 +0000
Received: by ggnh1 with SMTP id h1so2032094ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Dec 2011 21:46:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EE8830E.6050804@redhat.com>
References: <4EE8830E.6050804@redhat.com>
Date: Wed, 14 Dec 2011 21:46:50 -0800
Message-ID: <CAGH67wTyha76pFPVHxQ=WhTw-K7tDz7PmipQakdGYWhqtu_ndA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] pipeio: prevent race between SIGCHLD and open()
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Dec 14, 2011 at 3:05 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
> This test occasionally hangs on some machines. The hang has been
> observed on some single CPU ones.
>
> pipeio code is using signal(2), setting by default SA_RESTART
> flag, which is also the case for SIGCHLD.
>
> If last child manages to exit while parent is still at open(),
> parent gets SIGCHLD and open() is restarted. At this point test
> hangs.
>
> Here's strace output from parent point of view:
>
> =3D=3D=3D snip =3D=3D=3D
> brk(0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=3D 0x11bb000
> brk(0x11dd000) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x1=
1dd000
> getpid() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D 18826
> stat("tpipe.18826", 0x7fff89e1d410) =A0 =A0 =3D -1 ENOENT (No such file or
> directory)
> mknod("tpipe.18826", S_IFIFO|0777) =A0 =A0 =A0=3D 0
> rt_sigaction(SIGCHLD, {0x400a54, [CHLD], SA_RESTORER|SA_RESTART,
> =A00x354aa32a20}, {SIG_DFL, [], 0}, 8) =3D 0
> clone(child_stack=3D0, flags=3DCLONE_CHILD_CLEARTID|
> =A0CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=3D0x7f53b9ddd9d0) =3D 18827
> fstat(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 3), ...}) =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
> =A0=3D 0x7f53b9de5000
> open("tpipe.18826", O_RDONLY
> ) =A0 =A0 =A0 =A0 =A0 =3D ? ERESTARTSYS (To be restarted)
> --- SIGCHLD (Child exited) @ 0 (0) ---
> wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) =3D=3D 0}], 0, NULL) =3D 18827
> rt_sigreturn(0xffffffffffffffff) =A0 =A0 =A0 =A0=3D 2
> open("tpipe.18826", O_RDONLY
> =3D=3D=3D /snip =3D=3D=3D
>
> This patch is introducing semaphore, which prevents children from
> exiting until parent completes open(). It also adds timed wait,
> so parent waits for children to exit before it deletes pipe and
> semaphore.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> =A0testcases/kernel/ipc/pipeio/pipeio.c | =A0 37
> ++++++++++++++++++++++++++++++++-
> =A01 files changed, 35 insertions(+), 2 deletions(-)

Please use:

tst_brkm(TBROK|TERRNO,

instead of:

tst_brkm(TBROK, "... : %s", strerror(errno));

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  =

But none more important than the need to reduce IT complexity =

while improving strategic productivity.  Learn More! =

http://www.accelacomm.com/jaw/sdnl/114/51507609/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
