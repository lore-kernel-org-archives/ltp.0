Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NzVTa-0005ld-Tp
	for ltp-list@lists.sourceforge.net; Wed, 07 Apr 2010 13:39:26 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NzVTa-0004kv-11
	for ltp-list@lists.sourceforge.net; Wed, 07 Apr 2010 13:39:26 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o37DRfxL018372
	for <ltp-list@lists.sourceforge.net>; Wed, 7 Apr 2010 09:27:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o37DdKnw181884
	for <ltp-list@lists.sourceforge.net>; Wed, 7 Apr 2010 09:39:20 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o37DdJEr006242
	for <ltp-list@lists.sourceforge.net>; Wed, 7 Apr 2010 10:39:20 -0300
Date: Wed, 7 Apr 2010 08:39:18 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100407133918.GA20569@us.ibm.com>
References: <000401cad217$b1382d10$13a88730$@co.jp>
	<20100405132140.GB32049@us.ibm.com>
	<000901cad613$7d894030$789bc090$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000901cad613$7d894030$789bc090$@co.jp>
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

Quoting Mitani (mitani@ryobi.co.jp):
> Hi,
> 
> > -----Original Message-----
> > From: Serge E. Hallyn [mailto:serue@us.ibm.com]
> > Sent: Monday, April 05, 2010 10:22 PM
> > To: Mitani
> > Cc: ltp-list@lists.sourceforge.net
> > Subject: Re: [LTP] cap_bset_inh_bounds.c build failure
> > 
> > Quoting Mitani (mitani@ryobi.co.jp):
> > > Hi,
> > >
> > > I tried to build by using yesterday's git in my system (RHEL4.8 x86).
> > >  (ltp-dev-4837fee8a7c2de6a83c8927a574c792ca6dabe4e.tar.gz)
> > > But build failed in "cap_bset_inh_bounds.c" with following message.
> > > This is different from "cap_bounds_r.c"'s problem (another thread),
> > I think
> > >
> > > ------------
> > > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> > > -I/home/LTP/ltp-dev-20100401-3/testcases/kernel/include
> > > -I../../../../include -I../../../../include   -L../../../../lib
> > > cap_bset_inh_bounds.c   -lltp -lcap -o cap_bset_inh_bounds
> > > cap_bset_inh_bounds.c:124: error: syntax error before numeric
> > constant
> > > cap_bset_inh_bounds.c:124: warning: type defaults to `int' in
> > declaration of
> > > `tst_resm'
> > > cap_bset_inh_bounds.c:124: error: conflicting types for 'tst_resm'
> > > ../../../../include/test.h:192: error: previous declaration of
> > 'tst_resm'
> > > was here
> > > cap_bset_inh_bounds.c:124: error: conflicting types for 'tst_resm'
> > > ../../../../include/test.h:192: error: previous declaration of
> > 'tst_resm'
> > > was here
> > > cap_bset_inh_bounds.c:124: warning: data definition has no type or
> > storage
> > > class
> > > cap_bset_inh_bounds.c:129: warning: type defaults to `int' in
> > declaration of
> > > `tst_exit'
> > > cap_bset_inh_bounds.c:129: error: conflicting types for 'tst_exit'
> > > ../../../../include/test.h:203: error: previous declaration of
> > 'tst_exit'
> > > was here
> > > cap_bset_inh_bounds.c:129: error: conflicting types for 'tst_exit'
> > > ../../../../include/test.h:203: error: previous declaration of
> > 'tst_exit'
> > > was here
> > > cap_bset_inh_bounds.c:129: warning: data definition has no type or
> > storage
> > > class
> > > cap_bset_inh_bounds.c:130: error: syntax error before '}' token
> > > ------------
> > >
> > > In this source, the pair of "ifdef" start/end and the pair of
> > > main() function's "parenthesis" are alternate, I think.
> > >
> > >
> > > How about following patch?
> > >
> > > Signed-off-by : Tomonori Mitani <mitani@ryobi.co.jp>
> > 
> > Yup - although really the #ifdef HAVE_LIBCAP should be redundant as
> > the testcases/kernel/security/cap_bound/Makefile shouldn't compile
> > cap_bounds at all if HAVE_LIBCAP is not defined.
> > 
> 
> Yes. - In my system, this source is not problem. Your indication is 
> right. :-)
> But, I manually had updated "libcap2" once. And after "./configure", 
> HAVE_LIBCAP is defined. Therefore, I noticed this error.
> 
> The system which updated to "libcap2" will need solution of this 
> problem, I think.

Agreed, since this is LTP it's not right to expect "sane"
userspace-kernel combos.  So we need to check both.  Unfortunately
I won't have time to work with that this week.

Even if I did, I'd have a guidance question for Garrett:  Do we
want to assume that people will change kernels, but not libraries,
between compile/install and run of ltp?  If so, then we can stick
with the autoconf checks for libraries+includes, and add a check
at runtime (as I believe was there originally) for the requisite
kernel support - file capabilities, bounding sets, and 64-bit
capabilities.

OTOH if you're ok with assuming kernel is same at ltp configure
and run, then we can do a test in autoconf which makes for a cleaner
run.

thanks,
-serge

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
