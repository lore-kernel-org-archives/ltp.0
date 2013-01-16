Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1TvTZf-0005Bc-6b
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 14:02:39 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TvTZd-0007Lq-AT
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 14:02:39 +0000
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <shubham@linux.vnet.ibm.com>; 
	Wed, 16 Jan 2013 23:57:22 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3EE7F357804D
	for <ltp-list@lists.sourceforge.net>;
	Thu, 17 Jan 2013 01:02:28 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r0GE2RRG57606216
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jan 2013 01:02:27 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	r0GE2R5v001409
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jan 2013 01:02:27 +1100
Message-ID: <50F6B2EF.70007@linux.vnet.ibm.com>
Date: Wed, 16 Jan 2013 19:32:23 +0530
From: shubham <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <CA+icZUUsDzP+uLWD0i=JpMSiK1Qu3Pdux19rE7wTeJJu+-FaZw@mail.gmail.com>
In-Reply-To: <CA+icZUUsDzP+uLWD0i=JpMSiK1Qu3Pdux19rE7wTeJJu+-FaZw@mail.gmail.com>
Subject: Re: [LTP] Spelling "succeded" VS. "succeeded"
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
To: sedat.dilek@gmail.com
Cc: ltp-list@lists.sourceforge.net

On 01/16/2013 06:45 PM, Sedat Dilek wrote:
> Hi,
>
> this is my first email to the LTP ML, so I am new and anot not
> familiar with known or unknown conventions here.
>
> I am using LTP, to be honest the "lite" test to check my Linux
> (upstream) and Linux-Next kernels.
> So, having run "runltplite.sh" successfully gives me a 1st impression
> or orientation this kernel has no bigger issues.
>
> To be honest I have checked with a minimal kernel-setup (a
> localmodconfig-ed setup with some debugging enabled).
>
> While looking trough the results especially searching for some
> pattern, I noticed the different spelling of the word "succeeded" VS.
> "succeded".
> The spell-checker integrated in Firefox v18.0 tells me "succeeded"
> with double-e is correct.
>
> [ SUCCEDED - one "E" ]
>
> $ egrep -i 'error|fail'
> runltplite-results_3.8.0-rc3-next20130116-2-iniza-generic.txt | egrep
> -i succeded
> flock01     1  TPASS  :  flock() succeded with Shared Lock, returned
> error number=0
> flock01     2  TPASS  :  flock() succeded with Unlock, returned error number=0
> flock01     3  TPASS  :  flock() succeded with Exclusive Lock,
> returned error number=0
>
> [ SUCCEEDED - double "E" ]
>
> $ egrep -i 'error|fail'
> runltplite-results_3.8.0-rc3-next20130116-2-iniza-generic.txt | egrep
> -i succeeded
> madvise02    5  TFAIL  :  madvise succeeded unexpectedly
> open call succeededopen failed with EACCES as expectedopen call
> succeeded<<<execution_status>>>
>
> AFAICS flock01.c needs to be corrected:
>
> --- ltp-full-20120903.orig/testcases/kernel/syscalls/flock/flock01.c
>   2012-09-03 06:39:27.000000000 +0200
> +++ ltp-full-20120903/testcases/kernel/syscalls/flock/flock01.c
> 2013-01-16 14:12:36.597859952 +0100
> @@ -128,7 +128,7 @@ int main(int argc, char **argv)
>                                  continue;       /*next loop for MTKERNEL  */
>                          } else {
>                                  tst_resm(TPASS,
> -                                        "flock() succeded with %s,
> returned error number=%d",
> +                                        "flock() succeeded with %s,
> returned error number=%d",
>                                           test_cases[i].opt, TEST_ERRNO);
>                          }
>
> Not sure if you like that patch sent via git-email as a separate patch?
>

We are not very concerned about some typos in log messages. Please come 
up with a fix for a broken test case or something which will really add 
a value to the LTP. Your patches are welcome. Kindly refer the 
documentation provided with LTP for the format of patch.

Thanks


------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
