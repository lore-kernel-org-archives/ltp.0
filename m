Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1ZHpMa-0006qG-GT
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 08:26:52 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZHpMS-0003FU-1G
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 08:26:45 +0000
Message-ID: <55AF50DB.5020305@cn.fujitsu.com>
Date: Wed, 22 Jul 2015 16:14:19 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <371268015.770228.1437399185640.JavaMail.zimbra@redhat.com>
	<1437532823-19315-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<825821983.1905967.1437553011524.JavaMail.zimbra@redhat.com>
In-Reply-To: <825821983.1905967.1437553011524.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/getrandom: add configure check for
	linux/random.h
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

hi,

On 07/22/2015 04:16 PM, Jan Stancek wrote:
> 
> 
> 
> 
> ----- Original Message -----
>> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 22 July, 2015 4:40:23 AM
>> Subject: [LTP] [PATCH] syscalls/getrandom: add configure check for	linux/random.h
>>
>> For simplicity, I think we should just verify whether 'linux/random.h'
>> is valid, here if it's valid, that means such codes will be compiled
>> correctly.
>>
>>   #include <linux/random.h>
>>   int main(void)
>>   {
>>   	getrandom(NULL, 100, 0);
>>   	return 0;
>>   }
>> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> 
> I added paragraph about autoconf behaviour before 2.64, removed
> getrandom() call from commit message and pushed.
OK, that would be better, thanks!

Regards,
Xiaoguang Wang

> 
> Thank you,
> Jan
> .
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
