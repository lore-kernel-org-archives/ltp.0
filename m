Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannuxx@gmail.com>) id 1OvwbQ-000105-21
	for ltp-list@lists.sourceforge.net; Wed, 15 Sep 2010 18:21:04 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OvwbP-0004N4-1y
	for ltp-list@lists.sourceforge.net; Wed, 15 Sep 2010 18:21:04 +0000
Received: by bwz2 with SMTP id 2so1117215bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Sep 2010 11:20:57 -0700 (PDT)
Date: Wed, 15 Sep 2010 21:20:52 +0300
From: Hannu Heikkinen <hannuxx@iki.fi>
Message-ID: <20100915182052.GA2750@hannu-ubuntu>
References: <000401cb53c6$d7a16620$86e43260$@co.jp>
	<20100915134318.GD24784@hannu-debian.research.nokia.com>
	<AANLkTikYz9ppRN1FZBSnpyePoMV79GDWNA4umS7NLUn_@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikYz9ppRN1FZBSnpyePoMV79GDWNA4umS7NLUn_@mail.gmail.com>
Subject: Re: [LTP] POSIX "sched_yield/1-1.c" build failed
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
Cc: ext Mitani <mitani@ryobi.co.jp>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 15/09/10 09:18 -0700, Garrett Cooper wrote:
> That seems like a reasonable thing to do, but here's an alternative
> way to do this (less variables):
> 
> --- a/testcases/open_posix_testsuite/include/posixtest.h
> +++ b/testcases/open_posix_testsuite/include/posixtest.h
> @@ -10,10 +10,24 @@
>   * return codes
>   */
> 
> +/*
> + * Define PTS_DEVELOPER_MODE if you want to compile for developer scenarios,
> + * including reporting errors (as opposed to warnings), when compiling some
> + * test programs.
> + */
> +
>  #if defined(_GNU_SOURCE)
> +#if defined(PTS_DEVELOPER_MODE)
>  #error "Contains GNU-isms that need fixing."
> +#else
> +#warning "Contains GNU-isms that need fixing."
> +#endif
>  #elif defined(_BSD_SOURCE)
> +#if defined(PTS_DEVELOPER_MODE)
>  #error "Contains BSD-isms that need fixing."
> +#else
> +#warning "Contains BSD-isms that need fixing."
> +#endif
>  #endif
> 
>  #define PTS_PASS        0
> 
> Thanks for the idea Hannu :),
> -Garrett
> 

Ok, even better, less is always good! Developer mode sounds good. 

Should this posixtest.h be kind of a must include for all test cases?
Currently not all cases include this. 

br,
Hannu

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
