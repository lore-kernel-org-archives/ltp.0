Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1P7msc-0006IH-LN
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 10:23:46 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P7msb-000298-8H
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 10:23:46 +0000
Message-ID: <4CBC2044.3040202@cn.fujitsu.com>
Date: Mon, 18 Oct 2010 18:24:04 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CBC1431.1080808@cn.fujitsu.com>
	<AANLkTinQjHvu=F1rnB19Bzv4g27anHt4QM9JJJAh_bBA@mail.gmail.com>
In-Reply-To: <AANLkTinQjHvu=F1rnB19Bzv4g27anHt4QM9JJJAh_bBA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Fix variable type error
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Garrett Cooper wrote:
> On Mon, Oct 18, 2010 at 2:32 AM, Gui Jianfeng
> <guijianfeng@cn.fujitsu.com> wrote:
>> Hi
>>
>> Currently, the variable "timeout" type is int, We should make it to be "unsigned long".
>> Otherwise, we'll get an unexpected value in thread function, consequently, test fails.
>>
>> Signed-off-by: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
>> ---
>>  .../functional/threads/pi_test/pitest-1.c          |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/testcases/ /functional/threads/pi_test/pitest-1.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
>> index b8969a8..9fac992 100644
>> --- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
>> +++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
>> @@ -296,7 +296,7 @@ int main(int argc, char **argv)
>>
>>        /* Start TB thread (boosting thread) */
>>        DPRINTF(stderr,"Main Thread: start TB thread\n");
>> -       int timeout = multiplier * 20;
>> +       unsigned long timeout = multiplier * 20;
>>        rc = pthread_create(&threadtb, &threadattr, thread_tb,
>>                            &timeout);
>>         if (rc != 0) {
> 
>     Please try this patch out instead and let me know how it goes.

Works good for me.

Gui

> Thanks,
> -Garrett


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
