Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSqft-0006Ay-Jw
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:37:09 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSqfs-0007y5-PI
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:37:09 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o07BRs52001050
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:27:54 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o07Bb2Ms1593442
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:37:02 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o07Bb15L013041
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 09:37:01 -0200
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <ECC1F2A4-FC8C-4626-904B-F29FB9CB209E@gmail.com>
References: <4B41E55D.2020801@st.com>
	<ECC1F2A4-FC8C-4626-904B-F29FB9CB209E@gmail.com>
Date: Thu, 07 Jan 2010 17:06:56 +0530
Message-Id: <1262864216.12213.37.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] mtest01: free memory allocated
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
Cc: LTP <ltp-list@lists.sourceforge.net>

Garrett,

On Mon, 2010-01-04 at 18:10 -0800, Garrett Cooper wrote: 
> On Jan 4, 2010, at 4:55 AM, Francesco RUNDO <francesco.rundo@st.com>  
> wrote:
> 
> > Hi All,
> >
> > I'm running LTP (I'm using ltp-full-20090731....but asap I will  
> > upgrade to latest)  on SH based platforms.
> > Now, during a test-session. I've noted that the test "mtest01"  
> > reduced drastically the system memory and after its execution this  
> > memory wasn't de-allocated.
> >
> > I've analysed the mtest01.c code and I've noted that no "free()"  
> > istruction was associated to the related malloc:
> >
> > ......
> > if((mem = (char*)malloc(chunksize)) == NULL) {
> > ......
> >
> > I've simply added a "free(mem)" of the allocated memory and the  
> > issue was addressed successfully.
> >
> > I've attached the trivial patch I've developed.
> >
> > Best Regards,
> > --
> > Francesco
> > Added missed "free" istruction to release memory previosuly allocated.
> > Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
> > --- ltp-full-20090731/testcases/kernel/mem/mtest01/ 
> > mtest01.c.origin    2009-02-26 13:02:27.000000000 +0100
> > +++ ltp-full-20090731/testcases/kernel/mem/mtest01/mtest01.c     
> > 2009-12-15 14:03:28.779240000 +0100
> > @@ -258,5 +258,8 @@
> >     else
> >       tst_resm(TPASS, "%llu kbytes allocated only.",  
> > original_maxbytes/1024);
> >   }
> > +
> > +  free(mem);
> > +
> >   exit(0);
> > }
> 
> 1. Does the version off cvs still have this issue?
> 2. Unless the test exits the code block immediately, I'd definitely do:
> 
> if (mem)
>      free (mem);
> 
> to avoid making a bad free call.

Have you made any changes to this ? I do not see any commits.

Regards--
Subrata

> 
> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
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
