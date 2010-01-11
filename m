Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ljhc@br.ibm.com>) id 1NUPhr-0003Bz-IL
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 19:13:39 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NUPhq-0003XW-G7
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 19:13:39 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0BIYJTv020098
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 11:34:19 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0BIg44C063034
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 11:42:07 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0BIg32C008179
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 11:42:03 -0700
From: Lucio Correia <ljhc@br.ibm.com>
In-Reply-To: <135282C4-83A6-43D5-9D26-D711482A88A1@gmail.com>
References: <000001ca79f4$7869a110$693ce330$@co.jp>
	<135282C4-83A6-43D5-9D26-D711482A88A1@gmail.com>
Date: Mon, 11 Jan 2010 16:41:44 -0200
Message-Id: <1263235304.18451.3.camel@lucio-t400>
Mime-Version: 1.0
Subject: Re: [LTP] "libevent01" test failure with ltp-2009-12-10 cvs
Reply-To: ljhc@br.ibm.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

I'm still running into this issue with LTP-20091231

Regards,
-  
Lucio Correia
Software Engineer
IBM LTC Brazil


On Fri, 2009-12-11 at 01:56 -0800, Garrett Cooper wrote:
> On Dec 10, 2009, at 3:57 PM, Mitani wrote:
> 
> > Hi,
> > 
> > I got following message when I ran test of "libevent01" with 
> > ltp-2009-12-10 cvs.
> > 
> > ------------
> > sh: run_libevent.sh: command not found
> > ------------
> > 
> > This occured because "run_libevent.sh" was not installed under the 
> > "/opt/ltp" directory, I think.
> > 
> > Certainly, this test successed when I copied 
> > "${LTPROOT}/testcases/kernel/syscalls/libevent/run_libevent.sh" file 
> > to the "/opt/ltp/testcases/bin" directory.
> > 
> > So, I want to suggest the following revision:
> > 
> > 1. Install "run_libevent.sh" to under the "/opt/ltp/testcases/bin" 
> >   directory by default.
> >  (I don't know how to revise Makefile etc.)
> > 
> > 2. Apply the following patch to "run_libevent.sh".
> > 
> > ============
> > --- run_libevent.sh	2009-11-20 04:08:36.000000000 +0900
> > +++ run_libevent.sh.new	2009-12-10 16:44:02.000000000 +0900
> > @@ -31,7 +31,7 @@
> > 	tst_resm TCONF "You need to be root to run these tests"
> > 	TST_EXIT=0
> > else
> > -	"$LTPROOT/testcases/bin/tests/test-libevent.sh"
> > +	"$LTPROOT/testcases/bin/libevent/test/test-libevent.sh"
> > 	TST_EXIT=$?
> > fi
> > tst_cleanup
> > ============
> 
> Done -- thanks!
> -Garrett
> 
> ------------------------------------------------------------------------------
> Return on Information:
> Google Enterprise Search pays you back
> Get the facts.
> http://p.sf.net/sfu/google-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
