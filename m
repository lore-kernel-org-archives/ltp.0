Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O2Izs-0003aQ-5e
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 06:56:20 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2Izq-00037R-Ua
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 06:56:20 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3F6n9d8018343
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Apr 2010 00:49:09 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3F6u6YJ084642
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Apr 2010 00:56:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3F6u5Ao017037
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Apr 2010 00:56:05 -0600
Date: Thu, 15 Apr 2010 12:26:03 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100415065603.GB6261@linux.vnet.ibm.com>
References: <000401cad217$b1382d10$13a88730$@co.jp>
	<20100405132140.GB32049@us.ibm.com>
	<002201cadc47$24c528d0$6e4f7a70$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <002201cadc47$24c528d0$6e4f7a70$@co.jp>
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
Cc: kamimura@ryobi.co.jp, ltp-list@lists.sourceforge.net

On Thu, Apr 15, 2010 at 11:55:44AM +0900, Mitani wrote:
> Sorry.
> My patch was destroyed by e-mail.
> I attach patch for "cap_bset_inh_bounds.c" file.

Will test and update to master by this weekend. It seems it has been already
acked by serge.


Applied to next. Thanks for your patch.
-Rishi

> 
> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> 
> 
> Regards--
> 
> -Tomonori Mitani
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
> > Acked-by: Serge Hallyn <serue@us.ibm.com>
> > 
> > 
> > >
> > Index: ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
> > > ============
> > > --- ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
> > 2010-04-01
> > > 16:15:00.000000000 +0900
> > >
> > +++ ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c.ne
> > w
> > > 2010-04-01 17:27:23.000000000 +0900
> > > @@ -39,11 +39,11 @@
> > >
> > >  int errno;
> > >
> > > +int main(int argc, char *argv[])
> > > +{
> > >  #if HAVE_SYS_CAPABILITY_H
> > >  #if HAVE_DECL_PR_CAPBSET_READ && HAVE_DECL_PR_CAPBSET_DROP
> > >  #ifdef HAVE_LIBCAP
> > > -int main(int argc, char *argv[])
> > > -{
> > >         int ret = 1;
> > >         cap_value_t v[1];
> > >         cap_flag_value_t f;
> > > ============
> > >
> > >
> > > Thank you--
> > >
> > > -Tomonori Mitani
> > >
> > >
> > >
> > >
> > ------------------------------------------------------------------
> > ------------
> > > Download Intel&#174; Parallel Studio Eval
> > > Try the new software tools for yourself. Speed compiling, find bugs
> > > proactively, and fine-tune applications for parallel performance.
> > > See why Intel Parallel Studio got high marks during beta.
> > > http://p.sf.net/sfu/intel-sw-dev
> > > _______________________________________________
> > > Ltp-list mailing list
> > > Ltp-list@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/ltp-list


> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

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
