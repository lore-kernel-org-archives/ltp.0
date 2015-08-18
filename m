Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZRVOS-0004ul-9U
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 01:08:48 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZRVOM-0002vx-KS
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 01:08:48 +0000
Message-ID: <55D2857D.6000909@huawei.com>
Date: Tue, 18 Aug 2015 09:08:13 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1439540244-15421-1-git-send-email-sunyuan3@huawei.com>
	<2105335239.10970039.1439818423738.JavaMail.zimbra@redhat.com>
In-Reply-To: <2105335239.10970039.1439818423738.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH V3] container: new testcase pidns32
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
Cc: ltp-list@lists.sourceforge.net


On 2015/8/17 21:33, Jan Stancek wrote:
>
>
>
> ----- Original Message -----
>> From: "Yuan Sun" <sunyuan3@huawei.com>
>> To: jstancek@redhat.com
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Friday, 14 August, 2015 10:17:24 AM
>> Subject: [PATCH V3] container: new testcase pidns32
>>
>> Kernel imposes a limit of 32 nested levels of pid namespaces.
>>
>> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> Hi,
>
> pushed with updated commit message and removed kernel version check.
> Since we expect that 32 levels will work on any kernel, there's
> no need for it now.
Yes, you are right. I agree with you. Thank you.
     Yuan
>
> Regards,
> Jan
>
>> ---
>>   runtest/containers                           |   1 +
>>   testcases/kernel/containers/pidns/.gitignore |   1 +
>>   testcases/kernel/containers/pidns/pidns32.c  | 103
>>   +++++++++++++++++++++++++++
>>   3 files changed, 105 insertions(+)
>>   create mode 100644 testcases/kernel/containers/pidns/pidns32.c
>>
>


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
