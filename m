Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaOY-0006R6-Bm
	for Ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:26 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaOR-0007QY-2C
	for Ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:26 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UIOrwX008536
	for <Ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 14:24:53 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UIUDQZ177594
	for <Ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 14:30:13 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UIUDAo007071
	for <Ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 14:30:13 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <6213bc560907290608i1ad6aea1gf327f523957f8a5c@mail.gmail.com>
References: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
	<2A0DDADE-5C3C-43F2-9487-98A8A735DC8D@kernel.crashing.org>
	<6213bc560907220838h49e5c273qa543e538bb37923a@mail.gmail.com>
	<578FBC09-589D-4691-82FF-985FCFE8ADC9@kernel.crashing.org>
	<6213bc560907220932u3b771af2q743ae55dda5a2198@mail.gmail.com>
	<13B0CDE8-B974-4CFA-A4B9-8AC4374B4694@kernel.crashing.org>
	<6213bc560907231331p188a7b32q7287e9fe777eaf18@mail.gmail.com>
	<6213bc560907290608i1ad6aea1gf327f523957f8a5c@mail.gmail.com>
Date: Thu, 30 Jul 2009 23:59:53 +0530
Message-Id: <1248978594.5788.69.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] msgctl10 fails on Powerpc Linux-2.6.29.6
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
To: srikanth krishnakar <skrishnakar@gmail.com>
Cc: Ltp-list@lists.sourceforge.net

Has this Patch been tested on the concerned Power Box ? I would need
some info before applying this.

Regards--
Subrata

On Wed, 2009-07-29 at 18:38 +0530, srikanth krishnakar wrote:
> Hi all,
> 
> 
> I always found the remap_file_pages failing in PowerPC target
> (ppc44x) , the patch to fix the test cases of remap_file_pages passes
> the test cases on PowerPC targets ( ppc44x virtex target does not use
> bootloader ), any better suggestions are welcome.
> 
> -Srikanth
> 
> On Fri, Jul 24, 2009 at 2:01 AM, srikanth krishnakar
> <skrishnakar@gmail.com> wrote:
>         
>         
>         
>         On Thu, Jul 23, 2009 at 6:33 AM, Kumar Gala
>         <galak@kernel.crashing.org> wrote: 
>                 
>                 On Jul 22, 2009, at 11:32 AM, srikanth krishnakar
>                 wrote:
>                 
>                         
>                         
>                         On Wed, Jul 22, 2009 at 9:14 PM, Kumar Gala
>                         <galak@kernel.crashing.org> wrote:
>                         
>                         On Jul 22, 2009, at 10:38 AM, srikanth
>                         krishnakar wrote:
>                         
>                         
>                         
>                         On Wed, Jul 22, 2009 at 8:52 PM, Kumar Gala
>                         <galak@kernel.crashing.org> wrote:
>                         I'm not seeing any BUG* in traps.c @ line 904.
>                         
>                         
>                         On Jul 21, 2009, at 4:33 AM, srikanth
>                         krishnakar wrote:
>                         
>                         The LTP test case msgctl10.c fails on
>                         linux-2.6.29.6 for PowerPC architecture
>                         (ppc440)
>                         
>                         
>                         msgctl10    1  B------------[ cut
>                         here ]------------
>                         kernel BUG at arch/powerpc/kernel/traps.c:904!
>                         Oops: Exception in kernel mode, sig: 5 [#9]
>                         
>                         I'm not seeing any BUG* in traps.c @ line
>                         904.  Do you have some other patches on top of
>                         2.6.29.6?
>                         
>                         - k
>                         
>                         
>                         I have LTTng patches on top of linux-2.6.29.6.
>                         
>                         Does it modify traps.c?  Can you see what the
>                         code around line 904 looks like and post that.
>                         
>                         - k
>                          896
>                          897 #if defined(CONFIG_XILINX_VIRTEX_5_FXT)
>                         && defined(CONFIG_PPC_FPU)
>                          898         if (reason & REASON_ILLEGAL) {
>                          899                 if (excep_state < 1) {
>                          900                         excep_state++;
>                          901                         return;
>                          902                 }
>                          903                 /* should never get here
>                         */
>                          904                 BUG();
>                          905         }
>                          906 #endif
>                          907
>                          908         /* Try to emulate it if we
>                         should. */
>                         
>                 
>                 
>                 Are you sure this is coming from the LTTng patches?
>                  Which actual patch makes this change?
>                 
>                 - k 
>         Thanks kumar,
>         
>         
>         
>         I've got the patch out which fixes the issues. But now.. seems
>         there is some generic issue in PPC440 targets, I am observing
>         that  
>         remap_file_pages01 and remap_file_pages02  test cases from LTP
>         are failing since Linux-2.6.24 kernel to Linux-2.6.30. If you
>         can give some pointers that would be greatly appreciated ! Or
>         if you have results for this on any PPC44x would be helpful. 
>         
>         
>         Arch : PowerPC
>         
>         Target : Xilinx PowerPC440 virtex5
>         
>         
>         
>         I've tried to test the cause for this but found that kernel
>         throws error message of "segmentation fault".
>         
>         
>         
>         Thanks in Advance.
>         
>         
>         
>         -Srikant
>         
>         
>         
>         
> 
> 
> 
> -- 
> "The Good You Do, The Best You GET"
> 
> Regards
> Srikanth Krishnakar
> ********************** 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
