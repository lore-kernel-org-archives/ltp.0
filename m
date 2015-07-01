Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZAIfo-0000mM-EZ
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 14:07:36 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAIfn-0002DN-37
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 14:07:36 +0000
Message-ID: <5593F4E2.1040804@oracle.com>
Date: Wed, 01 Jul 2015 17:10:42 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1430827933-219682-1-git-send-email-cuibixuan@huawei.com>
	<5593E172.1050800@huawei.com>
In-Reply-To: <5593E172.1050800@huawei.com>
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
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

Hi,
On 07/01/2015 03:47 PM, Cui Bixuan wrote:
> ping ~~  :-)
>
> On 2015/5/5 20:12, Cui Bixuan wrote:
>> For the first time,case do 'logrotate -fv tst_logrotate.conf' that will
>> create the 'half-rotated' file(messages-20150416.gz). When run case again,
>> the case will fail:
>> 'error: destination /var/log/messages-20150416.gz already exists,skipping
>> rotation'
>>
>> 'Logrotate' does't expect to find an already existing "half-rotated" file
>> (http://centos.1050465.n5.nabble.com/CentOS-Logrotate-errors-td5725868.html).
>> Clean the "half-rotated" file,and the case will pass all the time.
>>
>> Signed-off-by: Cui Bixuan<cuibixuan@huawei.com>
>> ---
>>   testcases/commands/logrotate/logrotate_tests.sh |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
>> index 2a793cc..5b14ca0 100755
>> --- a/testcases/commands/logrotate/logrotate_tests.sh
>> +++ b/testcases/commands/logrotate/logrotate_tests.sh
>> @@ -191,6 +191,7 @@ test01()
>>   	do
>>   		rm -f $files > /dev/null 2>&1
>>   	done
>> +	rm -f /var/log/*`date '+%Y%m%d'`* > /dev/null 2>&1
>>   

The test creates only tst_logfile, why it should remove 'messages-*' and 
other system logs?

I see that its configuration file includes logrotate.d/, is it really 
needed by the test?

Thanks,
Alexey


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
