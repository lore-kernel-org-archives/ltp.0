Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxic7-00073e-FE
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:44:35 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxic1-0005RQ-99
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:44:35 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DEde87026780
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:39:40 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DEiA6S023172
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:44:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DEhwRd027500
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:44:05 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A0780153CC19@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A0780142442B@svexch01.mvista.com>
	<200910050018.12711.jpalecek@web.de>
	<8368651DACC1964480F951191B94A0780153CC19@svexch01.mvista.com>
Date: Tue, 13 Oct 2009 20:13:37 +0530
Message-Id: <1255445017.8438.66.camel@subratamodak.linux.ibm.com>
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

On Mon, 2009-10-05 at 14:33 -0700, Henry Yei wrote: 
> On Wednesday 04, October 2009 04:06:46 Jiri Palecek wrote:
> 
> Hello,
> 
> On Wednesday 30 September 2009 04:06:46 Henry Yei wrote:
> > This patch for openfile contains the following changes:
> > - test output to use tst_resm functions
> > - sets ups and cleans up tmp dir properly
> > - closes all opened file descriptors before thread exit(fixes nfs issues on removing tmp dir)
> > 
> > Signed-off-by: Henry Yei <hyei@mvista.com>
> > 
> > 
> > This test opens multiple file descriptors to the same file. Perhaps the author meant to open file handles for separate files?
> 
> This is suspicious, for me too. But maybe there is some logic behind opening the same file many times.
> 
> I just have a small remark about your patch: Shouldn't you call close_files() here, too? (With a partially full fd_list array handled, of course)
> 
> +void * threads(void* thread_id_) {
> +	int thread_id = (uintptr_t) thread_id_;
> +	char errmsg[80];
> +	FILE *fd_list[MAXFILES];
> +	int i;
> +
> +	/* Open files */
> +	for (i = 0; i < numfiles; i++) {
> +		if (debug)
> +			printf("Thread  %d : Opening file number %d \n", thread_id, i);
> +		if ((fd_list[i] = fopen(filename, "rw")) == NULL) {
> +			sprintf(errmsg, "FAIL - Couldn't open file #%d", i);
> +			perror(errmsg);
> 
> 
> 
> Jiri, 
> 
> Thanks for reviewing the patch. Yes, that was an omission on my part. I have attached an updated patch. Let me know if there are any more comments.
> 

Henry,

This patch is ineffective on the present Makefile(s). Please rebase them
over latest CVS and resend:

patching file testcases/kernel/fs/openfile/Makefile
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file
testcases/kernel/fs/openfile/Makefile.rej
patching file testcases/kernel/fs/openfile/openfile.c

Regards--
Subrata

> 
> 
> Henry Yei
> 
> 
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> http://p.sf.net/sfu/devconf
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


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
