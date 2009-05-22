Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M7aRv-0002Jf-BU
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 19:30:35 +0000
Date: Fri, 22 May 2009 21:30:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090522193021.GA2885@schrodinger.suse.cz>
References: <20090518135848.GA1060@schrodinger.suse.cz>
	<1242729123.5961.46.camel@subratamodak.linux.ibm.com>
	<20090521122545.GA7848@schrodinger.suse.cz>
	<1242975165.8760.16.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1242975165.8760.16.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] fix missing return in several files.
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

> > Well it breaks building suse rpm package as buildservice system treats these
> > kind of warning as errors and it's IMHO harmless to add these returns in the code.
> 
> Strange. But, in LTP convention, tst_exit() is used which in turn does a
> return $EXIT_CODE on it?? own. We do not interfere. return 0/1 exists in
> LTP code only when we have not detected that, or, it has been lying
> there old. Else, for new tests and when submitting patches we convert
> all returns to tst_exit().

Yes tst_exit calls exit() call which does some magick that terminates running
process and returns value passed to that function. So the code iself is
correct. But compiler is not smart enough to see that. And as indirect call to
exit() is only situation I'm aware of where missing return is not a bug, it's
not so dumb to treat this kind of warning as error. And some buildsystems does
so.


There are several possibilities that can avoid this kind of problem.

a) Add return 0, to those main() functions to make buildsystem happy. That's
   perfectly harmless as the code never gets makes it to this return 0; But it's
   not clean solution anyway.

b) Add tst_exitval() function that do the same as tst_exit but instead of exiting
   returns value passed to exit() call. So the code would look like: 
   
   return tst_exitval();

c) Leave it this way and force people who are doing packages to patch all these
   files on their own.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
