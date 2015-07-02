Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZAfKK-0004QW-HG
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 14:18:56 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAfKF-00083K-3B
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 14:18:56 +0000
Message-ID: <5595490E.1010509@oracle.com>
Date: Thu, 02 Jul 2015 17:22:06 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1430827933-219682-1-git-send-email-cuibixuan@huawei.com>
	<5593E172.1050800@huawei.com> <5593F4E2.1040804@oracle.com>
	<55952961.30906@huawei.com>
In-Reply-To: <55952961.30906@huawei.com>
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
On 07/02/2015 03:06 PM, Cui Bixuan wrote:
> On 2015/7/1 22:10, Alexey Kodanev wrote:
>> The test creates only tst_logfile, why it should remove 'messages-*' and other system logs?
>>
>> I see that its configuration file includes logrotate.d/, is it really needed by the test?
>>
> The tst_logfile of test created is 'messages-*' and the 'messages-*' will cause the case failed,
> so we should delete it if we want to the case run succeed at the second time.

OK, the test does the following basic steps:

a. create tst_logfile, fill it with messages;
b. ./logrotate
c. if [ -f tst_logfile.1.gz ] then test passed.

Therefore, why bother about 'messages-*' and other logs, the test 
doesn't check if they were rotated/compressed... so, may be, we should 
remove "include /etc/logrotate.d/" from the test configuration file so 
that logrotate rotated only "tst_logfile" and nothing else, what do you 
think?

Thanks,
Alexey


> And the test creates tst_logfile base on day time. For example, the system time is '2015 Jul 3',
> then the case will create 'messages-20150703.gz'. So 'rm -r /var/log/*`date '+%Y%m%d'`*' in patch
> only delete the message file of case created (after running it) and not other system logs.
>
> I think, if the logrotate testcase fail when run it the second time,it's a problem of
> testcase and we should fix it.


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
