Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O2FJH-0002Bd-LV
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 03:00:07 +0000
Received: from out04.sjc.mx.trendmicro.com ([216.99.131.8])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2FJF-0003bh-Vj
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 03:00:07 +0000
Message-ID: <002201cadc47$24c528d0$6e4f7a70$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 15 Apr 2010 11:55:44 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_11_55_46_Thursday_April_15_2010_27384"
References: <000401cad217$b1382d10$13a88730$@co.jp>
	<20100405132140.GB32049@us.ibm.com>
In-Reply-To: <20100405132140.GB32049@us.ibm.com>
Content-Language: ja
Subject: Re: [LTP] cap_bset_inh_bounds.c build failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "'Serge E. Hallyn'" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

This is a multi-part message in MIME format.

----=_NextPart_ST_11_55_46_Thursday_April_15_2010_27384
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Sorry.
My patch was destroyed by e-mail.
I attach patch for "cap_bset_inh_bounds.c" file.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>


Regards--

-Tomonori Mitani

> -----Original Message-----
> From: Serge E. Hallyn [mailto:serue@us.ibm.com]
> Sent: Monday, April 05, 2010 10:22 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] cap_bset_inh_bounds.c build failure
> 
> Quoting Mitani (mitani@ryobi.co.jp):
> > Hi,
> >
> > I tried to build by using yesterday's git in my system (RHEL4.8 x86).
> >  (ltp-dev-4837fee8a7c2de6a83c8927a574c792ca6dabe4e.tar.gz)
> > But build failed in "cap_bset_inh_bounds.c" with following message.
> > This is different from "cap_bounds_r.c"'s problem (another thread),
> I think
> >
> > ------------
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> > -I/home/LTP/ltp-dev-20100401-3/testcases/kernel/include
> > -I../../../../include -I../../../../include   -L../../../../lib
> > cap_bset_inh_bounds.c   -lltp -lcap -o cap_bset_inh_bounds
> > cap_bset_inh_bounds.c:124: error: syntax error before numeric
> constant
> > cap_bset_inh_bounds.c:124: warning: type defaults to `int' in
> declaration of
> > `tst_resm'
> > cap_bset_inh_bounds.c:124: error: conflicting types for 'tst_resm'
> > ../../../../include/test.h:192: error: previous declaration of
> 'tst_resm'
> > was here
> > cap_bset_inh_bounds.c:124: error: conflicting types for 'tst_resm'
> > ../../../../include/test.h:192: error: previous declaration of
> 'tst_resm'
> > was here
> > cap_bset_inh_bounds.c:124: warning: data definition has no type or
> storage
> > class
> > cap_bset_inh_bounds.c:129: warning: type defaults to `int' in
> declaration of
> > `tst_exit'
> > cap_bset_inh_bounds.c:129: error: conflicting types for 'tst_exit'
> > ../../../../include/test.h:203: error: previous declaration of
> 'tst_exit'
> > was here
> > cap_bset_inh_bounds.c:129: error: conflicting types for 'tst_exit'
> > ../../../../include/test.h:203: error: previous declaration of
> 'tst_exit'
> > was here
> > cap_bset_inh_bounds.c:129: warning: data definition has no type or
> storage
> > class
> > cap_bset_inh_bounds.c:130: error: syntax error before '}' token
> > ------------
> >
> > In this source, the pair of "ifdef" start/end and the pair of
> > main() function's "parenthesis" are alternate, I think.
> >
> >
> > How about following patch?
> >
> > Signed-off-by : Tomonori Mitani <mitani@ryobi.co.jp>
> 
> Yup - although really the #ifdef HAVE_LIBCAP should be redundant as
> the testcases/kernel/security/cap_bound/Makefile shouldn't compile
> cap_bounds at all if HAVE_LIBCAP is not defined.
> 
> Acked-by: Serge Hallyn <serue@us.ibm.com>
> 
> 
> >
> Index: ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
> > ============
> > --- ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
> 2010-04-01
> > 16:15:00.000000000 +0900
> >
> +++ ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c.ne
> w
> > 2010-04-01 17:27:23.000000000 +0900
> > @@ -39,11 +39,11 @@
> >
> >  int errno;
> >
> > +int main(int argc, char *argv[])
> > +{
> >  #if HAVE_SYS_CAPABILITY_H
> >  #if HAVE_DECL_PR_CAPBSET_READ && HAVE_DECL_PR_CAPBSET_DROP
> >  #ifdef HAVE_LIBCAP
> > -int main(int argc, char *argv[])
> > -{
> >         int ret = 1;
> >         cap_value_t v[1];
> >         cap_flag_value_t f;
> > ============
> >
> >
> > Thank you--
> >
> > -Tomonori Mitani
> >
> >
> >
> >
> ------------------------------------------------------------------
> ------------
> > Download Intel&#174; Parallel Studio Eval
> > Try the new software tools for yourself. Speed compiling, find bugs
> > proactively, and fine-tune applications for parallel performance.
> > See why Intel Parallel Studio got high marks during beta.
> > http://p.sf.net/sfu/intel-sw-dev
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_11_55_46_Thursday_April_15_2010_27384
Content-Type: application/octet-stream;
	name="cap_bset_inh_bounds.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cap_bset_inh_bounds.patch"

--- a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c=092010-04-0=
1 16:15:00.000000000 +0900=0A+++ b/testcases/kernel/security/cap_bound/cap_=
bset_inh_bounds.c=092010-04-01 17:27:23.000000000 +0900=0A@@ -39,11 +39,11 =
@@=0A =0A int errno;=0A =0A+int main(int argc, char *argv[])=0A+{=0A #if HA=
VE_SYS_CAPABILITY_H=0A #if HAVE_DECL_PR_CAPBSET_READ && HAVE_DECL_PR_CAPBSE=
T_DROP=0A #ifdef HAVE_LIBCAP=0A-int main(int argc, char *argv[])=0A-{=0A =09=
int ret =3D 1;=0A =09cap_value_t v[1];=0A =09cap_flag_value_t f;=0A
----=_NextPart_ST_11_55_46_Thursday_April_15_2010_27384
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
----=_NextPart_ST_11_55_46_Thursday_April_15_2010_27384
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_11_55_46_Thursday_April_15_2010_27384--

