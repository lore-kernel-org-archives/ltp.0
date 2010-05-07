Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OAJQP-0003am-Mb
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 09:00:49 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OAJQO-0001vF-M3
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 09:00:49 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o478vX1K026885
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 02:57:33 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o4790Vif106244
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 03:00:31 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4790Ud7016053
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 03:00:31 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <o2y364299f41005061043yf5044aa0u136c168855622abd@mail.gmail.com>
References: <20100506144556.GA11460@us.ibm.com>
	<o2y364299f41005061043yf5044aa0u136c168855622abd@mail.gmail.com>
Date: Fri, 07 May 2010 14:30:27 +0530
Message-Id: <1273222827.6042.4.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v2] make filecaps tests succeed
Reply-To: subrata@linux.vnet.ibm.com
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
Cc: Subrata Modak1 <subrata.modak@in.ibm.com>, LTP list <ltp-list@lists.sourceforge.net>

On Thu, 2010-05-06 at 10:43 -0700, Garrett Cooper wrote:
> On Thu, May 6, 2010 at 7:45 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > (Garrett I was going to add your ack, but wasn't absolutely sure
> > whether you meant it should apply to the whole thing or not)
> >
> > Most of these are belated cleanup after the move to using /opt/ltp.
> > But come on, replacing 'return' with tst_exit(), are you just trying
> > to mess with my head?
> >
> > Changelog:
> >  may 4: address Garrett's feedback
> >  1. single return 0 in print_caps.c
> >  2. use $TMP if defined for location of caps_fifo
> >  3. use tst_brkm in place of tst_resm.
> >  may 5: address Garrett's comment:
> >  don't add 1 to null pointer and then check for 1
> >
> > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> 
> Acked-by: Garrett Cooper <yanegomi@gmail.com>

Thanks. Checked in just now.

Regards--
Subrata

> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
