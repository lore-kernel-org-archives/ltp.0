Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MyATZ-0001Zs-TD
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 20:29:37 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MyATT-0007tS-R2
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 20:29:37 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9EKS67G006389
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 16:28:06 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9EKTPc92384100
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 16:29:25 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9EKTEtf001864
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 14:29:16 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A0780153D3FC@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A0780142442B@svexch01.mvista.com>
	<200910050018.12711.jpalecek@web.de>
	<8368651DACC1964480F951191B94A0780153CC19@svexch01.mvista.com>
	<1255445017.8438.66.camel@subratamodak.linux.ibm.com>
	<364299f40910131220x162b5e02u65bae87e349f7dda@mail.gmail.com>
	<364299f40910131221h7f9acf01te65be5b462281463@mail.gmail.com>
	<8368651DACC1964480F951191B94A0780153D3FC@svexch01.mvista.com>
Date: Thu, 15 Oct 2009 01:58:57 +0530
Message-Id: <1255552138.4892.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH][openfile] file descriptors not cleaned up
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
To: Henry Yei <hyei@mvista.com>
Cc: jpalecek@web.de, LTP Mailing List <ltp-list@lists.sourceforge.net>

Thanks Henry.

Regards--
Subrata

On Tue, 2009-10-13 at 19:25 -0700, Henry Yei wrote: 
> All,
> 
> Here is the openfile patch without the Makefile changes as they are not needed with the new Makefile changes.
> I regenerated and tested the patch with the latest version of the ltp from CVS.
> 
> I had trouble compiling LTP without autoconf 2.61 even after following instructions from the README.mk-users file to try to build without autoconf. Most of our test hosts are running autoconf 2.59. Does anyone have updated instructions?
> 
> 
> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com] 
> Sent: Tuesday, October 13, 2009 12:22 PM
> To: subrata@linux.vnet.ibm.com
> Cc: Henry Yei; jpalecek@web.de; LTP Mailing List
> Subject: Re: [LTP] [PATCH][openfile] file descriptors not cleaned up
> 
> On Tue, Oct 13, 2009 at 12:20 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> > On Tue, Oct 13, 2009 at 7:43 AM, Subrata Modak
> > <subrata@linux.vnet.ibm.com> wrote:
> >> On Mon, 2009-10-05 at 14:33 -0700, Henry Yei wrote:
> >>> On Wednesday 04, October 2009 04:06:46 Jiri Palecek wrote:
> >>>
> >>> Hello,
> >>>
> >>> On Wednesday 30 September 2009 04:06:46 Henry Yei wrote:
> >>> > This patch for openfile contains the following changes:
> >>> > - test output to use tst_resm functions
> >>> > - sets ups and cleans up tmp dir properly
> >>> > - closes all opened file descriptors before thread exit(fixes nfs issues on removing tmp dir)
> >>> >
> >>> > Signed-off-by: Henry Yei <hyei@mvista.com>
> >>> >
> >>> >
> >>> > This test opens multiple file descriptors to the same file. Perhaps the author meant to open file handles for separate files?
> >>>
> >>> This is suspicious, for me too. But maybe there is some logic behind opening the same file many times.
> >>>
> >>> I just have a small remark about your patch: Shouldn't you call close_files() here, too? (With a partially full fd_list array handled, of course)
> >>>
> >>> +void * threads(void* thread_id_) {
> >>> +     int thread_id = (uintptr_t) thread_id_;
> >>> +     char errmsg[80];
> >>> +     FILE *fd_list[MAXFILES];
> >>> +     int i;
> >>> +
> >>> +     /* Open files */
> >>> +     for (i = 0; i < numfiles; i++) {
> >>> +             if (debug)
> >>> +                     printf("Thread  %d : Opening file number %d \n", thread_id, i);
> >>> +             if ((fd_list[i] = fopen(filename, "rw")) == NULL) {
> >>> +                     sprintf(errmsg, "FAIL - Couldn't open file #%d", i);
> >>> +                     perror(errmsg);
> >>>
> >>>
> >>>
> >>> Jiri,
> >>>
> >>> Thanks for reviewing the patch. Yes, that was an omission on my part. I have attached an updated patch. Let me know if there are any more comments.
> >>>
> >>
> >> Henry,
> >>
> >> This patch is ineffective on the present Makefile(s). Please rebase them
> >> over latest CVS and resend:
> >>
> >> patching file testcases/kernel/fs/openfile/Makefile
> >> Hunk #1 FAILED at 1.
> >> 1 out of 1 hunk FAILED -- saving rejects to file
> >> testcases/kernel/fs/openfile/Makefile.rej
> >> patching file testcases/kernel/fs/openfile/openfile.c
> >
> >    I'll gladly help if help is needed. Feel free to ping me and we
> > can setup a rendezvous on IRC or something.
> 
>     I looked at the diff again and if you just omit the Makefile
> change then the rest should go through.
> HTH,
> -Garrett


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
