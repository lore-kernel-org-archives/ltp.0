Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Ni3PU-0006TX-84
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 10:15:04 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ni3PR-0005Si-QB
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 10:15:04 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1IA7PGg005761
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Feb 2010 05:07:25 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1IAEk6J114078
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Feb 2010 05:14:46 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1IAEkQD010998
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Feb 2010 08:14:46 -0200
Date: Thu, 18 Feb 2010 15:44:40 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100218101440.GA21750@rishikesh.in.ibm.com>
References: <EB1A7C66AD0C92419BFFC785A947865A09EAE44689@BLRINMSMBX01.bglrodc.lntinfotech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <EB1A7C66AD0C92419BFFC785A947865A09EAE44689@BLRINMSMBX01.bglrodc.lntinfotech.com>
Subject: Re: [LTP] not able to generate HTML output
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
To: Pramendra Singh <Pramendra.Singh@lntinfotech.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Pramendra,
Can you let us know on which kernel/distro you are trying to take coverage ?

Thanks
Rishikesh

On Thu, Feb 18, 2010 at 12:30:03PM +0530, Pramendra Singh wrote:
> Hi everyone,
> 
> Good afternoon!
> 
> I am new to LTP and using it to test my code for PPC architecture.
> I have patched my kernel with GCOV and it seems working fine. But
> I  am not able to get the HTML of code coverage/
> 
> I am cross compiling the kernel on my server for PPC and putting the image
> to my PPC target board. After test I am able to get .gcda file for my .c file
> and I take it back to my server where my kernel  source is there.
> 
> I use ppc_85xx-gcov for generating coverage and after that I use
> "geninfo "  utiliy available in lcov-1.8 but I get error "not able to open
> Basic block .bb files."
> 
> Problem is that in my source code there is no .bb files but .gcno files are there
> and I think that is because my gcc compiler version is  3.4.1 but "geninfo" binary
> is compiled with some low version gcc.
> 
> So please let me know where to get source code for geninfo and genhtml so
> That I can compile them for  PPC architecture with my gcc version.
> 
> Or let me know if I am doing anything wrong is code coverage process.
> 
> Thanks in advance!
> 
> Thanks and Regards
> Pramendra Singh (Sr. Software Engg)
> L&T  InfoTech Ltd, Plot No # 25 ~31
> EPIP 2nd Phase, KIADB, Whitefield,
> Bangalore - 560066, Phone: 080-66242424, Extn: 2106,
> Mobile No:  9449718250
> 
> 
> 
> ________________________________
> This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
> 
> ______________________________________________________________________

> ------------------------------------------------------------------------------
> Download Intel&reg; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs 
> proactively, and fine-tune applications for parallel performance. 
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
