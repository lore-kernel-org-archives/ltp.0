Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NymFQ-00065c-I9
	for ltp-list@lists.sourceforge.net; Mon, 05 Apr 2010 13:21:48 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NymFP-0002vN-2h
	for ltp-list@lists.sourceforge.net; Mon, 05 Apr 2010 13:21:48 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o35DCdAE016767
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Apr 2010 09:12:39 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o35DLfuT154042
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Apr 2010 09:21:41 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o35DLfEi014343
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Apr 2010 09:21:41 -0400
Date: Mon, 5 Apr 2010 08:21:40 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100405132140.GB32049@us.ibm.com>
References: <000401cad217$b1382d10$13a88730$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000401cad217$b1382d10$13a88730$@co.jp>
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
> I tried to build by using yesterday's git in my system (RHEL4.8 x86).
>  (ltp-dev-4837fee8a7c2de6a83c8927a574c792ca6dabe4e.tar.gz)
> But build failed in "cap_bset_inh_bounds.c" with following message.
> This is different from "cap_bounds_r.c"'s problem (another thread), I think
> 
> ------------
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/LTP/ltp-dev-20100401-3/testcases/kernel/include
> -I../../../../include -I../../../../include   -L../../../../lib
> cap_bset_inh_bounds.c   -lltp -lcap -o cap_bset_inh_bounds
> cap_bset_inh_bounds.c:124: error: syntax error before numeric constant
> cap_bset_inh_bounds.c:124: warning: type defaults to `int' in declaration of
> `tst_resm'
> cap_bset_inh_bounds.c:124: error: conflicting types for 'tst_resm'
> ../../../../include/test.h:192: error: previous declaration of 'tst_resm'
> was here
> cap_bset_inh_bounds.c:124: error: conflicting types for 'tst_resm'
> ../../../../include/test.h:192: error: previous declaration of 'tst_resm'
> was here
> cap_bset_inh_bounds.c:124: warning: data definition has no type or storage
> class
> cap_bset_inh_bounds.c:129: warning: type defaults to `int' in declaration of
> `tst_exit'
> cap_bset_inh_bounds.c:129: error: conflicting types for 'tst_exit'
> ../../../../include/test.h:203: error: previous declaration of 'tst_exit'
> was here
> cap_bset_inh_bounds.c:129: error: conflicting types for 'tst_exit'
> ../../../../include/test.h:203: error: previous declaration of 'tst_exit'
> was here
> cap_bset_inh_bounds.c:129: warning: data definition has no type or storage
> class
> cap_bset_inh_bounds.c:130: error: syntax error before '}' token
> ------------
> 
> In this source, the pair of "ifdef" start/end and the pair of 
> main() function's "parenthesis" are alternate, I think.
> 
> 
> How about following patch?
> 
> Signed-off-by : Tomonori Mitani <mitani@ryobi.co.jp>

Yup - although really the #ifdef HAVE_LIBCAP should be redundant as
the testcases/kernel/security/cap_bound/Makefile shouldn't compile
cap_bounds at all if HAVE_LIBCAP is not defined.

Acked-by: Serge Hallyn <serue@us.ibm.com>


> Index: ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
> ============
> --- ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c 2010-04-01
> 16:15:00.000000000 +0900
> +++ ./testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c.new
> 2010-04-01 17:27:23.000000000 +0900
> @@ -39,11 +39,11 @@
> 
>  int errno;
> 
> +int main(int argc, char *argv[])
> +{
>  #if HAVE_SYS_CAPABILITY_H
>  #if HAVE_DECL_PR_CAPBSET_READ && HAVE_DECL_PR_CAPBSET_DROP
>  #ifdef HAVE_LIBCAP
> -int main(int argc, char *argv[])
> -{
>         int ret = 1;
>         cap_value_t v[1];
>         cap_flag_value_t f;
> ============
> 
> 
> Thank you--
> 
> -Tomonori Mitani
> 
> 
> 
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
