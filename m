Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Tr1mE-0004kX-6e
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 07:33:14 +0000
Received: from mail-pa0-f51.google.com ([209.85.220.51])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Tr1mD-000107-7E
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 07:33:14 +0000
Received: by mail-pa0-f51.google.com with SMTP id fb11so9120074pad.24
	for <ltp-list@lists.sourceforge.net>;
	Thu, 03 Jan 2013 23:33:07 -0800 (PST)
Message-ID: <50E6853D.3050006@casparzhang.com>
Date: Fri, 04 Jan 2013 15:31:09 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <cover.1357277005.git.zliu@redhat.com>
	<50E67F91.106@casparzhang.com> <50E682DF.3050901@redhat.com>
In-Reply-To: <50E682DF.3050901@redhat.com>
Subject: Re: [LTP] [PATCH v2 0/2] updated create_same_memory() inside
	lib/mem.c
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 01/04/2013 03:21 PM, Zhouping Liu wrote:
> This is an example of output log with the patch on Fedora 17:

Nice.

Is there a higher coverage of test result (ksm01-05 and on NUMA system / 
large system / small system, etc)?

Caspar

------------------------------------------------------------------------------
Master HTML5, CSS3, ASP.NET, MVC, AJAX, Knockout.js, Web API and
much more. Get web development skills now with LearnDevNow -
350+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122812
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
