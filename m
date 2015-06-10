Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Z2cpD-0002Fw-Mr
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:01:35 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2cpC-0003N7-Q9
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:01:35 +0000
Message-ID: <55780AF5.5050407@oracle.com>
Date: Wed, 10 Jun 2015 13:01:25 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <CAHNg1SruVvcH1TjAmACDW7+CTDOeaHP4j9zvZSQ61PHPgOJTEQ@mail.gmail.com>
In-Reply-To: <CAHNg1SruVvcH1TjAmACDW7+CTDOeaHP4j9zvZSQ61PHPgOJTEQ@mail.gmail.com>
Subject: Re: [LTP] How to add test case in LTP for my local use
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
To: Pratik Prajapati <pratik.prajapati12@gmail.com>, ltp-list@lists.sourceforge.net



On 06/10/2015 09:56 AM, Pratik Prajapati wrote:
> Hi,

Hi.

>
> I want to add a test case for my local use. From
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines I
> get to know how to write a test case but didb't get how to add it.
> Please help.

For example, you could create a directory somewhere inside your LTP 
sources with Makefile including testcases.mk and generic_leaf_target.mk 
like this:

top_srcdir              ?= ../

include $(top_srcdir)/include/mk/testcases.mk

include $(top_srcdir)/include/mk/generic_leaf_target.mk

And put your C files there. 'make' and 'make clean' will work inside 
this directory.


>
> Regards,
> Pratik
>
>
> ------------------------------------------------------------------------------
>
>
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
