Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Tr99o-0007f9-Ve
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 15:26:05 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tr99l-0005yX-A7
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 15:26:04 +0000
Message-ID: <50E6F562.50609@redhat.com>
Date: Fri, 04 Jan 2013 23:29:38 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1357277005.git.zliu@redhat.com>
	<50E67F91.106@casparzhang.com> <50E682DF.3050901@redhat.com>
	<50E6853D.3050006@casparzhang.com>
In-Reply-To: <50E6853D.3050006@casparzhang.com>
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 01/04/2013 03:31 PM, Caspar Zhang wrote:
> On 01/04/2013 03:21 PM, Zhouping Liu wrote:
>> This is an example of output log with the patch on Fedora 17:
>
> Nice.
>
> Is there a higher coverage of test result (ksm01-05 and on NUMA system 
> / large system / small system, etc)?

yes, I tested it on i386/x86_64/ppc64 arch, also did it on NUMA system, 
ksm0[1-5] all PASSed.

Thanks,
Zhouping


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
