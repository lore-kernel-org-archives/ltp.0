Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NNUuI-0003Gk-DK
	for ltp-list@lists.sourceforge.net; Wed, 23 Dec 2009 17:21:54 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NNUuC-0004xx-TG
	for ltp-list@lists.sourceforge.net; Wed, 23 Dec 2009 17:21:54 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBNHEsTI001243
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Dec 2009 10:14:54 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBNHLP7r184410
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Dec 2009 10:21:25 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBNHLO1U002652
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Dec 2009 10:21:25 -0700
Date: Wed, 23 Dec 2009 11:21:22 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20091223172122.GA17627@us.ibm.com>
References: <20091222171103.GA9810@us.ibm.com>
	<364299f40912221657q3e94e322h4936e57b4298c054@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40912221657q3e94e322h4936e57b4298c054@mail.gmail.com>
Subject: Re: [LTP] [PATCH] containers: mqns: use libc's mq_open,
 not syscall(__NR_mq_open
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Tue, Dec 22, 2009 at 9:11 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > The glibc version removes the leading '/' from the message queue name.
> > Not doing so makes the system call fail. =A0We could just remove the
> > '/' from SLASH_MQ1, if for some reason that were preferred, but using
> > glibc functions when possible seems cleaner to me.
> >
> > Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> > ---
> > =A0testcases/kernel/containers/mqns/mqns_01.c | =A0 =A09 ++++-----
> > =A0testcases/kernel/containers/mqns/mqns_02.c | =A0 =A08 +++-----
> > =A0testcases/kernel/containers/mqns/mqns_03.c | =A0 =A03 +--
> > =A0testcases/kernel/containers/mqns/mqns_04.c | =A0 =A02 +-
> > =A04 files changed, 9 insertions(+), 13 deletions(-)
> >
> > diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/ker=
nel/containers/mqns/mqns_01.c
> > index 7f41b2d..2f3bf8e 100644
> > --- a/testcases/kernel/containers/mqns/mqns_01.c
> > +++ b/testcases/kernel/containers/mqns/mqns_01.c
> > @@ -55,7 +55,7 @@ int check_mqueue(void *vtest)
> >
> > =A0 =A0 =A0 =A0if (read(p1[0], buf, strlen("go") + 1) < 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO, "read(p1[0], ..=
.) failed");
> > - =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDONLY);
> > + =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDONLY);
> > =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (write(p2[1], "notfnd", strlen("notfn=
d") + 1) < 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO,=
 "write(p2[1], ...) failed");
> > @@ -86,8 +86,7 @@ main(int argc, char *argv[])
> > =A0 =A0 =A0 =A0if (pipe(p1) =3D=3D -1) { perror("pipe"); exit(EXIT_FAIL=
URE); }
> > =A0 =A0 =A0 =A0if (pipe(p2) =3D=3D -1) { perror("pipe"); exit(EXIT_FAIL=
URE); }
> >
> > - =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O=
_EXCL, 0777,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL);
> > + =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777, N=
ULL);
> > =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("mq_open");
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "mq_open failed\n");
> > @@ -100,7 +99,7 @@ main(int argc, char *argv[])
> > =A0 =A0 =A0 =A0if (r < 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "failed clone/unshare\n"=
);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq_close(mqd);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 syscall(__NR_mq_unlink, SLASH_MQ1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_unlink(SLASH_MQ1);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> > =A0 =A0 =A0 =A0}
> >
> > @@ -122,7 +121,7 @@ main(int argc, char *argv[])
> >
> > =A0 =A0 =A0 =A0/* destroy the mqueue */
> > =A0 =A0 =A0 =A0mq_close(mqd);
> > - =A0 =A0 =A0 syscall(__NR_mq_unlink, SLASH_MQ1);
> > + =A0 =A0 =A0 mq_unlink(SLASH_MQ1);
> >
> > =A0 =A0 =A0 =A0tst_exit();
> > =A0}
> > diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/ker=
nel/containers/mqns/mqns_02.c
> > index aa78f65..5343d5b 100644
> > --- a/testcases/kernel/containers/mqns/mqns_02.c
> > +++ b/testcases/kernel/containers/mqns/mqns_02.c
> > @@ -60,8 +60,7 @@ int check_mqueue(void *vtest)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO, "read(p1[0], ..=
) failed");
> > =A0 =A0 =A0 =A0else {
> >
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, =
O_RDWR|O_CREAT|O_EXCL,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0777, NUL=
L);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT=
|O_EXCL, 0777, NULL);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (write(p2[1], "mqfail=
", strlen("mqfail") + 1) < 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm=
(TBROK | TERRNO,
> > @@ -85,8 +84,7 @@ int check_mqueue(void *vtest)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0if (mq_close(mqd) < 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mq_close(mqd) failed");
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 } else if (syscall(__NR_mq_unlink,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SLASH_MQ1) < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 } else if (mq_unlink(SLASH_MQ1) < 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK | TERRNO,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mq_unlink(" SLASH_MQ1
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0") failed");
> > @@ -153,7 +151,7 @@ int main(int argc, char *argv[])
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> > =A0 =A0 =A0 =A0} else {
> >
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, =
O_RDONLY);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDONLY);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "Parent =
process can't see the mqueue\n");
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> > diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/ker=
nel/containers/mqns/mqns_03.c
> > index 3c9e83e..6a841b8 100644
> > --- a/testcases/kernel/containers/mqns/mqns_03.c
> > +++ b/testcases/kernel/containers/mqns/mqns_03.c
> > @@ -63,8 +63,7 @@ int check_mqueue(void *vtest)
> >
> > =A0 =A0 =A0 =A0read(p1[0], buf, 3); /* go */
> >
> > - =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O=
_EXCL, 0755,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL);
> > + =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755, N=
ULL);
> > =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write(p2[1], "mqfail", 7);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> > diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/ker=
nel/containers/mqns/mqns_04.c
> > index 8a4a9c2..6ce9e34 100644
> > --- a/testcases/kernel/containers/mqns/mqns_04.c
> > +++ b/testcases/kernel/containers/mqns/mqns_04.c
> > @@ -59,7 +59,7 @@ int check_mqueue(void *vtest)
> >
> > =A0 =A0 =A0 =A0read(p1[0], buf, 3); /* go */
> >
> > - =A0 =A0 =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O=
_EXCL, 0755,
> > + =A0 =A0 =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL);
> > =A0 =A0 =A0 =A0if (mqd =3D=3D -1) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write(p2[1], "mqfail", 7);
> =

>     The problem with this is that we're instead testing indirectly via
> libc instead of directly via syscall(2). Why not just have two

Yup - we're testing the namespaces here, not the mq_open syscall itself,
so I wasn't sure whether we minded inadvertently testing libc as well.
(The mq_open() also is cleaner to read)

> constants -- one that has a slash and one that doesn't? Seems like
> it'd be simple to implement...

<shrug>  yup, that's why I made sure to make that clear, that's the
other way, and will work just fine.

(I'm actually out for the rest of this week, back monday)

-serge

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
