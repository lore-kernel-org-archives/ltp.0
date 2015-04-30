Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YnjjV-0004HF-NY
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:22:09 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YnjjU-00073N-1Z
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:22:09 +0000
Date: Thu, 30 Apr 2015 04:22:01 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <162165083.8714320.1430382121729.JavaMail.zimbra@redhat.com>
In-Reply-To: <782230467.5857849.1429883677704.JavaMail.zimbra@redhat.com>
References: <782230467.5857849.1429883677704.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] Coverity report for ltp-20150420
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
To: ltp-list <ltp-list@lists.sf.net>





----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "ltp-list" <ltp-list@lists.sf.net>
> Sent: Friday, 24 April, 2015 3:54:37 PM
> Subject: [LTP] Coverity report for ltp-20150420
> 
> Hi,
> 
> What is Coverity?
>   Coverity Prevent is commercial enterprise level tool for static analysis
>   (analysis based only on compiling of sources, not based on running of
>   binary)
>   of the C/C++ and Java code.
> analyzer-version-coverity = 7.6.1
> 
> This run includes latest LTP release 20150420 (including
> open_posix_testsuite):
>   http://jan.stancek.eu/coverity/ltp-20150420.err.xz
> 
>       1 ARRAY_VS_SINGLETON
>       4 BAD_COMPARE
>      17 BAD_FREE

I went through most of BAD_FREE reports yesterday and in many cases it was
mmap + munmap with some offset, which coverity doesn't like.

From what I have read, it should be possible to annotate code to make coverity
stop complaining. For example by adding following:
  /* coverity[EVENT_TAG_NAME] */

I'm not exactly clear where to get "event tag names" yet, as these seem to be
different from error names that appear in *.err logs.

Before I dig deeper into this, would anyone be opposed if we start adding
such annotation to LTP source?

Regards,
Jan


>       1 CHAR_IO
>     319 CHECKED_RETURN
>       6 CONSTANT_EXPRESSION_RESULT
>       3 COPY_PASTE_ERROR
>      29 DEADCODE
>       1 EVALUATION_ORDER
>      43 FORWARD_NULL
>       3 IDENTICAL_BRANCHES
>      21 MISSING_BREAK
>     497 NEGATIVE_RETURNS
>       7 NO_EFFECT
>       6 NULL_RETURNS
>       1 OVERFLOW_BEFORE_WIDEN
>      27 OVERRUN
>       1 PASS_BY_VALUE
>     343 RESOURCE_LEAK
>       1 RETURN_LOCAL
>       1 REVERSE_INULL
>       2 REVERSE_NEGATIVE
>      19 SIZEOF_MISMATCH
>       1 STRAY_SEMICOLON
>      91 UNINIT
>      14 UNREACHABLE
>       6 UNUSED_VALUE
>      48 USE_AFTER_FREE
>       1 VARARGS
> 
> Regards,
> Jan
> 
> ------------------------------------------------------------------------------
> One dashboard for servers and applications across Physical-Virtual-Cloud
> Widest out-of-the-box monitoring support with 50+ applications
> Performance metrics, stats and reports that give you Actionable Insights
> Deep dive visibility with transaction tracing using APM Insight.
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
