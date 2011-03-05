Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <cristian@regolo.cc>) id 1Pvf0L-0007AG-0v
	for ltp-list@lists.sourceforge.net; Sat, 05 Mar 2011 00:05:53 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pvf0J-00083q-VW
	for ltp-list@lists.sourceforge.net; Sat, 05 Mar 2011 00:05:52 +0000
Date: Sat, 5 Mar 2011 01:06:00 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110305010600.0c7cd017@regolo>
In-Reply-To: <AANLkTik6nKzqp2tuyhsuk6FvMd540xZVGGddr=B13D-R@mail.gmail.com>
References: <20110304170932.19819907@regolo>
	<AANLkTin_4rBGj5O-ZgTdu2C8nV6Lc9-pa9ig8NsAowAd@mail.gmail.com>
	<AANLkTik6nKzqp2tuyhsuk6FvMd540xZVGGddr=B13D-R@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] kill05: fix regression
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1430322743587462391=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

--===============1430322743587462391==
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/b1._4StPw/NlU.ZG6P/z3Ok";
	protocol="application/pgp-signature"

--Sig_/b1._4StPw/NlU.ZG6P/z3Ok
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Mar 2011 08:30:14 -0800
Garrett Cooper <yanegomi@gmail.com> wrote:

> On Fri, Mar 4, 2011 at 8:29 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> > On Fri, Mar 4, 2011 at 8:09 AM, Cristian Greco <cristian@regolo.cc> wro=
te:
> >> Hi,
> >>
> >> this should fix a regression in kill05.
> >>
> >> Why did tst_resm/tst_exit get replaced by perror/exit in 84f181fd?
> >
> > =A0 =A0Because it's a child process and child processes should _not_ use
> > libltp for sanity and to avoid introducing determinism, test bugs, and
>=20
> s/determinism/non-determinism/
>=20
> > for cluttering up output (remember: you have to communicate to the
> > user which process is actually doing the work, they're sharing file
> > descriptors potentially, etc).
> > =A0 =A0The proposed fix doesn't make sense though because do_master_chi=
ld
> > always exits when the flow is executed correctly (i.e. there aren't
> > any early return statements from do_master_child, etc. Is it not
> > resuming the stack appropriately after it gets signaled? What's the
> > call flow exactly for the failure?
> > Thanks,
> > -Garrett
> >

Hi Garrett,

you're right. In fact, the problem is in safe_getpwnam(), which does not
correctly reproduce the behavior of the deprecated my_getpwnam().
Moreover, I'm not noticing the problem on my laptop due to a race
condition in kill05, while it shows an inconsistent behavior on the box
I'm running tests on (mipsel with glibc, for the sake).

Could you please fix safe_getpwnam() with either one of the following
patches?

--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -98,13 +98,18 @@ struct passwd*
 safe_getpwnam(const char *file, const int lineno, void (*cleanup_fn)(void),
     const char *name)
 {
+       struct passwd *pwd;
        struct passwd *rval;
=20
-       rval =3D getpwnam(name);
-       if (rval =3D=3D NULL)
+       pwd =3D getpwnam(name);
+       if (pwd =3D=3D NULL)
                tst_brkm(TBROK|TERRNO, cleanup_fn, "getpwnam failed at %s:%=
d",
                    file, lineno);
=20
+       rval =3D (struct passwd *) malloc(sizeof(struct passwd));
+       memset(rval, 0, sizeof(struct passwd));
+       memcpy(rval, pwd, sizeof(struct passwd));
+
        return (rval);
 }

This second patch is a bit more invasive, using getpwnam_r() to
correctly retrieve the strings which getpwnam() will store in static
buffers (e.g. pw_name in kill05 is 'bin' for both the parent and the
child, while their UID is still different).

--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -98,9 +98,26 @@ struct passwd*
 safe_getpwnam(const char *file, const int lineno, void (*cleanup_fn)(void),
     const char *name)
 {
+       struct passwd *pwd;
        struct passwd *rval;
+       char *buf;
+       size_t bufsize;
=20
-       rval =3D getpwnam(name);
+       bufsize =3D sysconf(_SC_GETPW_R_SIZE_MAX);
+       if (bufsize =3D=3D -1)
+               bufsize =3D 16384;
+
+       buf =3D malloc(bufsize);
+       if (buf =3D=3D NULL)
+               tst_brkm(TBROK|TERRNO, cleanup_fn, "malloc failed at %s:%d",
+                   file, lineno);
+
+       pwd =3D malloc(sizeof(struct passwd));
+       if (buf =3D=3D NULL)
+               tst_brkm(TBROK|TERRNO, cleanup_fn, "malloc failed at %s:%d",
+                   file, lineno);
+
+       getpwnam_r(name, pwd, buf, bufsize, &rval);
        if (rval =3D=3D NULL)
                tst_brkm(TBROK|TERRNO, cleanup_fn, "getpwnam failed at %s:%=
d",
                    file, lineno);


On the other hand, the race condition in kill05 should be fixed with
something like this (sorry, please double-check, I have not so much
experience with pthreads):

--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -77,6 +77,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <pthread.h>
=20
 #include "test.h"
 #include "usctest.h"
@@ -101,6 +102,9 @@ extern int getipckey();
=20
 #define TEST_SIG SIGKILL
=20
+pthread_mutex_t mutex =3D PTHREAD_MUTEX_INITIALIZER;
+pthread_cond_t cond =3D PTHREAD_COND_INITIALIZER;
+
 int main(int ac, char **av)
 {
        char *msg;              /* message returned from parse_opts */
@@ -169,6 +173,11 @@ void do_master_child(char **av)
                        exit(1);
                }
 #else
+               pthread_mutex_lock(&mutex);
+               *flag =3D 1;
+               pthread_cond_signal(&cond);
+               pthread_mutex_unlock(&mutex);
+
                do_child();
 #endif
        }
@@ -177,10 +186,19 @@ void do_master_child(char **av)
                exit(1);
        }
=20
+       pthread_mutex_lock(&mutex);
+       while (*flag =3D=3D 0)
+               pthread_cond_wait(&cond, &mutex);
+       pthread_mutex_unlock(&mutex);
+
        TEST(kill(pid1, TEST_SIG));
=20
        /* signal the child that we're done */
+       pthread_mutex_lock(&mutex);
        *flag =3D 1;
+       pthread_cond_signal(&cond);
+       pthread_mutex_unlock(&mutex);
+
=20
        if (waitpid(pid1, &status, 0) =3D=3D -1) {
                perror("waitpid failed");
@@ -206,15 +224,12 @@ void do_master_child(char **av)
=20
 void do_child()
 {
-       pid_t my_pid;
-
-       my_pid =3D getpid();
-       while (1) {
-               if (*flag =3D=3D 1)
-                       exit(0);
-               else
-                       sleep(1);
-       }
+       pthread_mutex_lock(&mutex);
+       while (*flag =3D=3D 0)
+               pthread_cond_wait(&cond, &mutex);
+       pthread_mutex_unlock(&mutex);
+
+       exit(0);
 }
=20
 void setup(void)


Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

--Sig_/b1._4StPw/NlU.ZG6P/z3Ok
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNcX5qAAoJEID329zPTTLkWAsP+gPTrP5ZDxgKOfahVKYFQpuf
eW+cjLJBGcWpA9ttvw+7GwHgm57eaGiN+TtMC21IkdD+zgs5HrSqVa4rQJHG92oN
aBy+GTDPcG50uvAor+1SxqZ0WU0bTEHoJo4V8WmulpXTqRIH+5Kvqmw2bQjxOjbi
qZvHdspTw91WWmQmFRpKc4E08MWg7klYeux75u5Wn+eeIwdct0rgMPlGZKmFFAzD
+uKQUMiCDqVl//aaEopApTNQJLXP8iTlwraZ+WDVWjCR8qYcHwXZG8H0iOEU/0YG
Ylxn/pgeYLB4iWD/HQDaH/HsTiBPXH5KCqiz9QqVEYWqDHptEatCcdJvgqBU6Ul+
/TjwkJLCXEjmxAGVhEZkWCdRBNuOeMUF0WoZoWEdkoKrJCl8ONzCZkOAt/h/s/o1
Zjpy1bnewfgrCP2ZPt+lkyMk/cG647JH/xNW9DnoaTcmUIyvvKMa3F8K1Cot3O1q
tNtgqyIygF2kPioqX1lX9ILnLHVhyCoCP2JDr1kr9EPN7T7Gj3Pdg0KquooffKrQ
W0pq9yFnvk2Qp5YiDHXEBmLfRhYQ1cOB8G1HZkeBnG/2SnrD42k367m1tiED+Thb
esGKfVOVs3XfW1ElHUbmq3FrLMhtv+/gqtimrSLb+WV3C7YSrM7rYpN0dMlxbuuD
NnCyWOxY4XDLDPMQGZvx
=sx4a
-----END PGP SIGNATURE-----

--Sig_/b1._4StPw/NlU.ZG6P/z3Ok--


--===============1430322743587462391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
--===============1430322743587462391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1430322743587462391==--

