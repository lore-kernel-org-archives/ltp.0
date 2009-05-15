Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M4rqg-00033F-CS
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 07:28:54 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M4rqS-0000sJ-4s
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 07:28:49 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4F7Pvfg002739
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 01:25:57 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4F7Scjn213884
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 01:28:38 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4F7ScxR032711
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 01:28:38 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0905132102y8a8e57dpeb6b73a24b693ea7@mail.gmail.com>
References: <d51f89b0905070410v468978ecjf6d8ee31bb4ede3c@mail.gmail.com>
	<20090508.232031.104047613.caiqian@cclom.cn>
	<d51f89b0905120440y8d3eacbh6874458946af6ea3@mail.gmail.com>
	<20090513.223538.71106642.caiqian@cclom.cn>
	<d51f89b0905132102y8a8e57dpeb6b73a24b693ea7@mail.gmail.com>
Date: Fri, 15 May 2009 12:58:35 +0530
Message-Id: <1242372515.7224.18.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Fwd: Patch for  :Unzip01 Test Not Working Correctly
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
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Thanks.

I have started to do some holy job, might be in annoyance to everybody,
to check all patches with checkpatch.pl before they are merged with
LTP. 

So, i would inform you what needs to be changed in the patch before they
can be merged. This exercise will help us in preventing any code mess as
we keep growing, and help maintaining LTP better. Hope, you will agree
too.

Your patch contains the following errors/warning. Please rectify and
resend :-)

========================================================================
WARNING: line over 80 characters
#40: FILE: testcases/commands/unzip/unzip_tests.sh:152:
+               diff -iwB "$PWD/tst_unzip.out" "$PWD/tst_unzip.out.exp"
> "$PWD/tst_unzip.out.err" || RC=$?

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 1 warnings, 49 lines checked
========================================================================

Regards--
Subrata

On Thu, 2009-05-14 at 09:32 +0530, rohit verma wrote:
> 
> 
> ---------- Forwarded message ----------
> From: CAI Qian <caiqian@cclom.cn>
> Date: Wed, May 13, 2009 at 8:05 PM
> Subject: Re: Patch for [LTP] :Unzip01 Test Not Working Correctly
> To: rohit.170309@gmail.com
> 
> 
> From: rohit verma <rohit.170309@gmail.com>
> Subject: Re: Patch for [LTP] :Unzip01 Test Not Working Correctly
> 
> Date: Tue, 12 May 2009 17:10:36 +0530
> 
> > Hi Qian,
> >
> > Yes you are correct. We cannot predict the output order of unzip. So
> I
> > have sorted the
> > actual and expected output and attached the updated patch with this
> mail.
> >
> > I request you to apply this patch and let me know if any issues.
> >
> > Regards,
> > Rohit
> >
> 
> 
> Works fine. Please submit to the mailing list.
> 
> Acked-by: CAI Qian <caiqian@cclom.cn>
> 
> Thanks,
> CAI Qian
> 
> 
> 
> ------------------------------------------------------------------------------
> The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
> production scanning environment may not be a perfect world - but thanks to
> Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
> Series Scanner you'll get full speed at 300 dpi even with all image 
> processing features enabled. http://p.sf.net/sfu/kodak-com
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
