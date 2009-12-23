Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NNFXW-0006v1-F2
	for ltp-list@lists.sourceforge.net; Wed, 23 Dec 2009 00:57:22 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NNFXU-00068p-7k
	for ltp-list@lists.sourceforge.net; Wed, 23 Dec 2009 00:57:22 +0000
Received: by pxi27 with SMTP id 27so2966451pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Dec 2009 16:57:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20091222171103.GA9810@us.ibm.com>
References: <20091222171103.GA9810@us.ibm.com>
Date: Tue, 22 Dec 2009 16:57:14 -0800
Message-ID: <364299f40912221657q3e94e322h4936e57b4298c054@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] containers: mqns: use libc's mq_open,
	not 	syscall(__NR_mq_open
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Dec 22, 2009 at 9:11 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> The glibc version removes the leading '/' from the message queue name.
> Not doing so makes the system call fail. =A0We could just remove the
> '/' from SLASH_MQ1, if for some reason that were preferred, but using
> glibc functions when possible seems cleaner to me.
>
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> ---
> =A0testcases/kernel/containers/mqns/mqns_01.c | =A0 =A09 ++++-----
> =A0testcases/kernel/containers/mqns/mqns_02.c | =A0 =A08 +++-----
> =A0testcases/kernel/containers/mqns/mqns_03.c | =A0 =A03 +--
> =A0testcases/kernel/containers/mqns/mqns_04.c | =A0 =A02 +-
> =A04 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kerne=
l/containers/mqns/mqns_01.c
> index 7f41b2d..2f3bf8e 100644
> --- a/testcases/kernel/containers/mqns/mqns_01.c
> +++ b/testcases/kernel/containers/mqns/mqns_01.c
> @@ -55,7 +55,7 @@ int check_mqueue(void *vtest)
>
> =A0 =A0 =A0 =A0if (read(p1[0], buf, strlen("go") + 1) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO, "read(p1[0], ...)=
 failed");
> - =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDONLY);
> + =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDONLY);
> =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (write(p2[1], "notfnd", strlen("notfnd"=
) + 1) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO, "=
write(p2[1], ...) failed");
> @@ -86,8 +86,7 @@ main(int argc, char *argv[])
> =A0 =A0 =A0 =A0if (pipe(p1) =3D=3D -1) { perror("pipe"); exit(EXIT_FAILUR=
E); }
> =A0 =A0 =A0 =A0if (pipe(p2) =3D=3D -1) { perror("pipe"); exit(EXIT_FAILUR=
E); }
>
> - =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_E=
XCL, 0777,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL);
> + =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777, NUL=
L);
> =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("mq_open");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "mq_open failed\n");
> @@ -100,7 +99,7 @@ main(int argc, char *argv[])
> =A0 =A0 =A0 =A0if (r < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "failed clone/unshare\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq_close(mqd);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 syscall(__NR_mq_unlink, SLASH_MQ1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_unlink(SLASH_MQ1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0}
>
> @@ -122,7 +121,7 @@ main(int argc, char *argv[])
>
> =A0 =A0 =A0 =A0/* destroy the mqueue */
> =A0 =A0 =A0 =A0mq_close(mqd);
> - =A0 =A0 =A0 syscall(__NR_mq_unlink, SLASH_MQ1);
> + =A0 =A0 =A0 mq_unlink(SLASH_MQ1);
>
> =A0 =A0 =A0 =A0tst_exit();
> =A0}
> diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kerne=
l/containers/mqns/mqns_02.c
> index aa78f65..5343d5b 100644
> --- a/testcases/kernel/containers/mqns/mqns_02.c
> +++ b/testcases/kernel/containers/mqns/mqns_02.c
> @@ -60,8 +60,7 @@ int check_mqueue(void *vtest)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO, "read(p1[0], ..) =
failed");
> =A0 =A0 =A0 =A0else {
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_=
RDWR|O_CREAT|O_EXCL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0777, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O=
_EXCL, 0777, NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (write(p2[1], "mqfail",=
 strlen("mqfail") + 1) < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
BROK | TERRNO,
> @@ -85,8 +84,7 @@ int check_mqueue(void *vtest)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0if (mq_close(mqd) < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mq_close(mqd) failed");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 } else if (syscall(__NR_mq_unlink,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SLASH_MQ1) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 } else if (mq_unlink(SLASH_MQ1) < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mq_unlink(" SLASH_MQ1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0") failed");
> @@ -153,7 +151,7 @@ int main(int argc, char *argv[])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0} else {
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_=
RDONLY);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDONLY);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "Parent pr=
ocess can't see the mqueue\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kerne=
l/containers/mqns/mqns_03.c
> index 3c9e83e..6a841b8 100644
> --- a/testcases/kernel/containers/mqns/mqns_03.c
> +++ b/testcases/kernel/containers/mqns/mqns_03.c
> @@ -63,8 +63,7 @@ int check_mqueue(void *vtest)
>
> =A0 =A0 =A0 =A0read(p1[0], buf, 3); /* go */
>
> - =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_E=
XCL, 0755,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL);
> + =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755, NUL=
L);
> =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write(p2[1], "mqfail", 7);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kerne=
l/containers/mqns/mqns_04.c
> index 8a4a9c2..6ce9e34 100644
> --- a/testcases/kernel/containers/mqns/mqns_04.c
> +++ b/testcases/kernel/containers/mqns/mqns_04.c
> @@ -59,7 +59,7 @@ int check_mqueue(void *vtest)
>
> =A0 =A0 =A0 =A0read(p1[0], buf, 3); /* go */
>
> - =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_E=
XCL, 0755,
> + =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL);
> =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write(p2[1], "mqfail", 7);

    The problem with this is that we're instead testing indirectly via
libc instead of directly via syscall(2). Why not just have two
constants -- one that has a slash and one that doesn't? Seems like
it'd be simple to implement...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
