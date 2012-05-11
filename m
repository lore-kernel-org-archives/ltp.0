Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SSiRt-0004Li-FA
	for ltp-list@lists.sourceforge.net; Fri, 11 May 2012 05:31:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SSiRr-0002Jl-45
	for ltp-list@lists.sourceforge.net; Fri, 11 May 2012 05:31:29 +0000
Message-ID: <4FACA3DF.5000900@cn.fujitsu.com>
Date: Fri, 11 May 2012 13:30:07 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1336703855-15408-1-git-send-email-penght@cn.fujitsu.com>
	<4FAC91DE.70203@casparzhang.com>
In-Reply-To: <4FAC91DE.70203@casparzhang.com>
Subject: Re: [LTP] [PATCH] logrotate01: fix a bug of config file's
 permission is wrong
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

On 05/11/2012 12:13 PM, Caspar Zhang wrote:

> On 05/11/2012 10:37 AM, Peng Haitao wrote:
>> config file's permission should be 644, please refer to:
>> https://fedorahosted.org/logrotate/changeset/302
>>
>> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> 
> Reviewed-by: Caspar Zhang <caspar@casparzhang.com>


pushed, thanks,

Wanlong Gao

> 
>> ---
>>  testcases/commands/logrotate/logrotate_tests.sh |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
>> index 827dd5f..55ef0b3 100755
>> --- a/testcases/commands/logrotate/logrotate_tests.sh
>> +++ b/testcases/commands/logrotate/logrotate_tests.sh
>> @@ -192,6 +192,7 @@ test01()
>>  		rm -f $files > /dev/null 2>&1
>>  	done
>>  
>> +	chmod 644 $LTPTMP/tst_logrotate.conf
>>  	logrotate -fv $LTPTMP/tst_logrotate.conf > $LTPTMP/tst_logrotate.out 2>&1 \
>>  		|| RC=$?
>>  	if [ $RC -eq 0 ]
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
