Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZNFCK-0000IP-BG
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 07:02:40 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZNFCE-0005qP-PK
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 07:02:40 +0000
Message-ID: <55C30677.7060803@huawei.com>
Date: Thu, 6 Aug 2015 15:02:15 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1438334146-32590-1-git-send-email-sunyuan3@huawei.com>
	<584308599.4393130.1438780906980.JavaMail.zimbra@redhat.com>
In-Reply-To: <584308599.4393130.1438780906980.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH V2] containers: new testcase userns06
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


Many thanks, Jan.

On 2015/8/5 21:21, Jan Stancek wrote:
>
>
>
> ----- Original Message -----
>> From: "Yuan Sun" <sunyuan3@huawei.com>
>> To: jstancek@redhat.com
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Friday, 31 July, 2015 11:15:46 AM
>> Subject: [PATCH V2] containers: new testcase userns06
>>
>> When a process with non-zero user IDs performs an execve(), the
>> process's capability sets are cleared. When a process with zero
>> user IDs performs an execve(), the process's capability sets are
>> set.
>>
>> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> Pushed with these changes:
> - some ifdefs from userns06.c removed as they were around code,
>    that had nothing to do with LIB_CAP
> - added LTP_ATTRIBUTE_UNUSED to updatemap()
> - fixed TCID of userns06_capcheck to "userns06_capcheck"
>
> Regards,
> Jan
>
>


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
