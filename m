Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZAxDJ-0000JM-AZ
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 09:24:53 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZAxDC-0003eK-5n
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2015 09:24:53 +0000
Message-ID: <559654BB.5050300@huawei.com>
Date: Fri, 3 Jul 2015 17:24:11 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1435724565-19631-1-git-send-email-sunyuan3@huawei.com>
	<1715707849.11822659.1435846199391.JavaMail.zimbra@redhat.com>
	<5595FC03.10602@huawei.com>
	<1526251635.12159899.1435909417100.JavaMail.zimbra@redhat.com>
	<55965241.5020206@huawei.com>
	<20150703091815.GA2855@dustball.brq.redhat.com>
In-Reply-To: <20150703091815.GA2855@dustball.brq.redhat.com>
Subject: Re: [LTP] [PATCH V2] userns01: add capability verification
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


Interesting. Log is as follow. I will have a research.

log:
root@ubuntu:/tmp/tt# gcc test.c -lcap
root@ubuntu:/tmp/tt# ls
a.out  test.c
root@ubuntu:/tmp/tt# ./a.out
ffffffff ffffffff
ffffffff ffffffff
cap_compare: 0


On 2015/7/3 17:18, Jan Stancek wrote:
> On Fri, Jul 03, 2015 at 05:13:37PM +0800, Yuan Sun wrote:
>> Hi Jan,
>>      The following link is unaccessible because HuaWei's network
>> security strategy.
>>      Could you please attach the test.c file for me?
>> http://fpaste.org/239445/35909330/
> Was afraid my web email client would mangle it. Attached.
>
> Regards,
> Jan
>


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
