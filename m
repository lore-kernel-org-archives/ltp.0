Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1ZBDkd-0007mW-TM
	for ltp-list@lists.sourceforge.net; Sat, 04 Jul 2015 03:04:23 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZBDkb-0004Cz-3Z
	for ltp-list@lists.sourceforge.net; Sat, 04 Jul 2015 03:04:23 +0000
Message-ID: <55974D10.5050808@huawei.com>
Date: Sat, 4 Jul 2015 11:03:44 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1430827933-219682-1-git-send-email-cuibixuan@huawei.com>
	<5593E172.1050800@huawei.com> <5593F4E2.1040804@oracle.com>
	<55952961.30906@huawei.com> <5595490E.1010509@oracle.com>
In-Reply-To: <5595490E.1010509@oracle.com>
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

On 2015/7/2 22:22, Alexey Kodanev wrote:
> Hi,
> On 07/02/2015 03:06 PM, Cui Bixuan wrote:
>> On 2015/7/1 22:10, Alexey Kodanev wrote:
>>> The test creates only tst_logfile, why it should remove 'messages-*' and other system logs?
>>>
>>> I see that its configuration file includes logrotate.d/, is it really needed by the test?
>>>
>> The tst_logfile of test created is 'messages-*' and the 'messages-*' will cause the case failed,
>> so we should delete it if we want to the case run succeed at the second time.
> 
> OK, the test does the following basic steps:
> 
> a. create tst_logfile, fill it with messages;
> b. ./logrotate
> c. if [ -f tst_logfile.1.gz ] then test passed.
> 
> Therefore, why bother about 'messages-*' and other logs, the test doesn't check if they were rotated/compressed... so, may be, we should remove "include /etc/logrotate.d/" from the test configuration file so that logrotate rotated only "tst_logfile" and nothing else, what do you think?
> 
Hi,
Your method is better than mine (I learned that how to use logrotate command again yesterday and
found that remove messages-* is not a good idea).

We can remove 'include /etc/logrotate.d' and delete 'grep including /etc/logrotate.d $LTPTMP/tst_logrotate.out'
in case to fix it, what do you think?  If ok, I will send a new patch.


In addition, I have a question, Why including the rules in /etc/logrotate.d/ will cause the case failed
when run it at the second time?

Thanks,
Cui Bixuan

> Thanks,
> Alexey
> 
> 
>> And the test creates tst_logfile base on day time. For example, the system time is '2015 Jul 3',
>> then the case will create 'messages-20150703.gz'. So 'rm -r /var/log/*`date '+%Y%m%d'`*' in patch
>> only delete the message file of case created (after running it) and not other system logs.
>>
>> I think, if the logrotate testcase fail when run it the second time,it's a problem of
>> testcase and we should fix it.
> 
> 
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
