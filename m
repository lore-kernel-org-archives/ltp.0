Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Tr1Om-0002Yw-Ke
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 07:09:00 +0000
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Tr1Ol-0007gi-Ux
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 07:09:00 +0000
Received: by mail-ie0-f178.google.com with SMTP id c12so19172894ieb.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 03 Jan 2013 23:08:54 -0800 (PST)
Message-ID: <50E67F91.106@casparzhang.com>
Date: Fri, 04 Jan 2013 15:06:57 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <cover.1357277005.git.zliu@redhat.com>
In-Reply-To: <cover.1357277005.git.zliu@redhat.com>
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

On 01/04/2013 02:12 PM, Zhouping Liu wrote:
> changed in v2:
>   - modified '_function_name' as 'function_name'
>   - added 'static' key word for internal function
>   - updated a little commit log
>
> Zhouping Liu (2):
>    mm/lib: rewrote create_same_memory()
>    mm/include: removed the global var 'memory'
>
>   testcases/kernel/mem/include/_private.h |   2 +-
>   testcases/kernel/mem/include/mem.h      |   5 -
>   testcases/kernel/mem/lib/mem.c          | 425 +++++++++++++-------------------
>   3 files changed, 170 insertions(+), 262 deletions(-)
>

Since there is no function updated in the patch, I'm OK to apply it if a 
unit-test is executed (better testing in a wide range of systems) and 
get ACKs from other reviewers. Zhouping, would you mind pasting some 
test details against your patch before we apply it?

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
