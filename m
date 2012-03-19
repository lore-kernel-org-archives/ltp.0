Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S9VMe-0004gs-Vp
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 05:42:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S9VMd-00072a-B5
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 05:42:40 +0000
Message-ID: <4F66C70F.80503@cn.fujitsu.com>
Date: Mon, 19 Mar 2012 13:41:35 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <CABxY-SJqTBTDJQimvByQT3GEnk021YtHggPgw9F5NWk9ec8uXg@mail.gmail.com>
In-Reply-To: <CABxY-SJqTBTDJQimvByQT3GEnk021YtHggPgw9F5NWk9ec8uXg@mail.gmail.com>
Subject: Re: [LTP] Query regarding Open Posix fail Test Case
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jubi Taneja <jubitaneja@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 03/19/2012 01:25 PM, Jubi Taneja wrote:

> Hi
> 
> In LTP(Jan 2012 release) Open Posix Test Suite, the test case "aio-suspend/1-1.c" passes
> successfully for Linux Kernel 2.6.35 for Target ARM but the same test case fails for Kernel
> version: 3.0.18.
> 
> It throws error as :
> aio_suspend/1-1.c Error at write(): No such file or directory.


I haven't seen this error before, so weird.
Can you try to debug on your ARM target and submit a patch?

Thanks,
Wanlong Gao


> 
> Can any one please point out the reason for the failure in kernel 3.0.18 for target ARM?
> 
> The exact path of the test case is :
> LTP/testcases/open_posix_testsuite/conformance/
> interfaces/aio_suspend/1-1.c
> 
> Looking forward to your reply.
> 
> Thanks,
> Jubi
> 
> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here 
> http://p.sf.net/sfu/sfd2d-msazure
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
