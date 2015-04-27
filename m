Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ymj1V-0004Di-3F
	for ltp-list@lists.sourceforge.net; Mon, 27 Apr 2015 13:24:33 +0000
Date: Mon, 27 Apr 2015 15:24:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150427132404.GA10567@rei.suse.de>
References: <1555406842.5673672.1429863249724.JavaMail.zimbra@redhat.com>
	<782230467.5857849.1429883677704.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <782230467.5857849.1429883677704.JavaMail.zimbra@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
>       1 ARRAY_VS_SINGLETON
>       4 BAD_COMPARE
>      17 BAD_FREE
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

Thanks for doing this again. :)

BTW do you have a this table for previous releases? I looked at the
previous emails and these stats weren't there. It would be interesting
to compare how these numbers changed in time.

-- 
Cyril Hrubis
chrubis@suse.cz

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
