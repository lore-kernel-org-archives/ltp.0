Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NzNqy-00042W-33
	for ltp-list@lists.sourceforge.net; Wed, 07 Apr 2010 05:31:04 +0000
Received: from out07.sjc.mx.trendmicro.com ([216.99.131.23])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NzNqw-0005mi-8P
	for ltp-list@lists.sourceforge.net; Wed, 07 Apr 2010 05:31:04 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000401cad217$b1382d10$13a88730$@co.jp>
	<20100405132140.GB32049@us.ibm.com>
In-Reply-To: <20100405132140.GB32049@us.ibm.com>
Date: Wed, 7 Apr 2010 14:30:53 +0900
Message-ID: <000901cad613$7d894030$789bc090$@co.jp>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "'Serge E. Hallyn'" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

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

Yes. - In my system, this source is not problem. Your indication is 
right. :-)
But, I manually had updated "libcap2" once. And after "./configure", 
HAVE_LIBCAP is defined. Therefore, I noticed this error.

The system which updated to "libcap2" will need solution of this 
problem, I think.


Thank you--

-Tomonori Mitani


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



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
