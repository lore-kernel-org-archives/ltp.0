Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Yyamh-0004JG-Bc
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2015 07:02:19 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yyamb-0001mp-Tm
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2015 07:02:19 +0000
Message-ID: <55696062.5010705@huawei.com>
Date: Sat, 30 May 2015 15:01:54 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1430827933-219682-1-git-send-email-cuibixuan@huawei.com>
	<555D8E94.20605@huawei.com> <555DA53C.10008@huawei.com>
	<5567BFF1.7000503@huawei.com>
In-Reply-To: <5567BFF1.7000503@huawei.com>
Subject: Re: [LTP] [PATCH] commands/logrotate:run the case once again will
 failed
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net, peifeiyue@huawei.com


Hi Bixuan,
If the current time is 23:59:59 May 30 23:59:59 2015, we start to run
the case and /var/log/*20150530* file is created.
It has a delay before the program runs the following command added by you.
rm -f /var/log/*`date '+%Y%m%d'`* > /dev/null 2>&1

If it is 2 seconds delay, the command will be "rm -f /var/log/*20150531*".
The issue leads to the fact the previous log file can't removed.
Thanks.
     Yuan

On 2015/5/29 9:25, Cui Bixuan wrote:
> On 2015/5/21 17:28, s00318865 wrote:
>
>> If the current time is 23:59:59, a problem would occur. It is good to use the following command.
>> rm [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]
>> Of course, it is better if you can find a way to use regular expressions to match it.
> "If the current time is 23:59:59, a problem would occur." why?
> The error occur when there are messages-20150406 file in /var/log/ and do "logrotate" in 20150406(same day).
>
> Thanks,
> Cui Bixuan
>
>
>
>
> .
>


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
