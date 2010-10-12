Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P5lLf-0003wF-3w
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 20:21:23 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5lLe-0006hS-9t
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 20:21:23 +0000
Received: by gya1 with SMTP id 1so814525gya.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Oct 2010 13:21:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimb=F0NaS+Sipp8EzrbRUqPqRf+9-nBZQMPpD=w@mail.gmail.com>
References: <AANLkTimb=F0NaS+Sipp8EzrbRUqPqRf+9-nBZQMPpD=w@mail.gmail.com>
Date: Tue, 12 Oct 2010 13:21:16 -0700
Message-ID: <AANLkTimhAOpaWN7KDwg_PCQ=_j81A1fddRe5_KaB+RLY@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Patch to record kernel dump message to each testcases log
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
To: hake huang <hakehuang@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Oct 12, 2010 at 5:56 AM, hake huang <hakehuang@gmail.com> wrote:
> Hi,
>
> I wnat LTP to record the kernel dump message during each test case, and I
> make a patch for this. Any comments?

Low:
1. This will break existing functionality (IIRC) with runltp provided
by Subrata (CCed for comment).

Medium:
2. It will bloat logs output on embedded systems / systems with limited space.
3. It could have other potential unwanted side-effects with tests
and/or system services (in particular because some people on the list
have been executing LTP on production systems, not testbed machines...
even though I argue that's their mistake).

High:
4. The change would confuse end-users.
5. The change would break scripts which parse the output in different
ways from what you intend.
6. Using system(3) to execute a program could yield some unintended
side-effects with file descriptors, terminal handling, process
wait(2)ing, etc.

Thanks,
-Garrett

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
