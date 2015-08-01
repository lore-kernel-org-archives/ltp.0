Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1ZLLRQ-0005yK-8i
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2015 01:18:24 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZLLRN-0005rD-Gv
	for ltp-list@lists.sourceforge.net; Sat, 01 Aug 2015 01:18:24 +0000
Message-ID: <55BC1E51.6090508@huawei.com>
Date: Sat, 1 Aug 2015 09:18:09 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1010625653.980528.1438323855616.JavaMail.zimbra@redhat.com>
In-Reply-To: <1010625653.980528.1438323855616.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] How to compie a ltp-case into 32-bit on the 64bit system
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
To: ltp-list@lists.sourceforge.net

On 2015/7/31 14:24, Li Wang wrote:

> Then, I came up with a idea that I don't include the ltp-lib file in 'msgrcv08.c', 
> and just add two lines in the .../ipc/msgrcv/Makefile:
> 
>   msgrcv08:
> 	gcc -g -O2 -Wall -m32 msgrcv08.c -o msgrcv08
> 
> It works for me, but I know it's not appropriate for LTP management.
> 
> What should I do? or, Is there any good way to solve this problem?
Hi,
    For LTP, we can run './configure CC=[SDK-32]; make;' to compile 32-bit testcases.
So, I think, if the case 'msgrcv08.c' will not work as 64-bit application, it can check the
SDK first. And do 'TCONF: not gcc32' if it's 64-bit application.

    It's not a good idea that ipc/msgrcv/Makefile to control it, I mean, LTP user to control
it in ./configure which will be better.

    What do you think?

Thanks,
Cui Bixuan

> 
> Thanks~
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
