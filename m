Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1ZAdHG-0001zu-OA
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 12:07:38 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZAdHB-00035X-TH
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 12:07:38 +0000
Message-ID: <55952961.30906@huawei.com>
Date: Thu, 2 Jul 2015 20:06:57 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1430827933-219682-1-git-send-email-cuibixuan@huawei.com>
	<5593E172.1050800@huawei.com> <5593F4E2.1040804@oracle.com>
In-Reply-To: <5593F4E2.1040804@oracle.com>
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

On 2015/7/1 22:10, Alexey Kodanev wrote:
> Hi,
> On 07/01/2015 03:47 PM, Cui Bixuan wrote:
>> ping ~~  :-)
>>
>> On 2015/5/5 20:12, Cui Bixuan wrote:
>>> For the first time,case do 'logrotate -fv tst_logrotate.conf' that will
>>> create the 'half-rotated' file(messages-20150416.gz). When run case again,
>>> the case will fail:
>>> 'error: destination /var/log/messages-20150416.gz already exists,skipping
>>> rotation'
>>>
>>> 'Logrotate' does't expect to find an already existing "half-rotated" file
>>> (http://centos.1050465.n5.nabble.com/CentOS-Logrotate-errors-td5725868.html).
>>> Clean the "half-rotated" file,and the case will pass all the time.
>>>
>>> Signed-off-by: Cui Bixuan<cuibixuan@huawei.com>
>>> ---
>>>   testcases/commands/logrotate/logrotate_tests.sh |    1 +
>>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
>>> index 2a793cc..5b14ca0 100755
>>> --- a/testcases/commands/logrotate/logrotate_tests.sh
>>> +++ b/testcases/commands/logrotate/logrotate_tests.sh
>>> @@ -191,6 +191,7 @@ test01()
>>>       do
>>>           rm -f $files > /dev/null 2>&1
>>>       done
>>> +    rm -f /var/log/*`date '+%Y%m%d'`* > /dev/null 2>&1
>>>   
> 
> The test creates only tst_logfile, why it should remove 'messages-*' and other system logs?
> 
> I see that its configuration file includes logrotate.d/, is it really needed by the test?
> 

The tst_logfile of test created is 'messages-*' and the 'messages-*' will cause the case failed,
so we should delete it if we want to the case run succeed at the second time.

And the test creates tst_logfile base on day time. For example, the system time is '2015 Jul 3',
then the case will create 'messages-20150703.gz'. So 'rm -r /var/log/*`date '+%Y%m%d'`*' in patch
only delete the message file of case created (after running it) and not other system logs.

I think, if the logrotate testcase fail when run it the second time,it's a problem of
testcase and we should fix it.

Thanks,
Cui Bixuan

> Thanks,
> Alexey
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
