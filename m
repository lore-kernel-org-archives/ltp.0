Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1ZEZF4-0007jW-M5
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 08:37:38 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZEZF1-0003KK-P9
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 08:37:38 +0000
Message-ID: <55A378AE.8060202@cn.fujitsu.com>
Date: Mon, 13 Jul 2015 16:37:02 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1436426857-7322-1-git-send-email-mawentao@inspur.com>,
	<55A3610F.5000703@cn.fujitsu.com>
	<2015071316333140061425@inspur.com>
In-Reply-To: <2015071316333140061425@inspur.com>
Subject: Re: [LTP] [PATCH] acls: Solve a problem from acl_test01
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
To: "mawentao@inspur.com" <mawentao@inspur.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "wunan@inspur.com" <wunan@inspur.com>

On 07/13/2015 04:33 PM, mawentao@inspur.com wrote:
> Thanks Wanlong Gao, we set the SELinux mode to permissive and the test passes. 
> the error is caused by the SELinux, finally we modify the patch.

Nope, SELinux setup should do before you running LTP. Since SELinux is not
supported by all of the distributions, we assume that it is disabled by yourself
before running LTP. 

Thanks,
Wanlong Gao



> 
> 
>> The failed infornamtion is as follow:
>> useradd: cannot set SELinux context for
>> home directory /tmp/tacl/mount-ext3/acltest1
>>
>> this is caused by SELinux, the SELinux mode is enforcing
>> set the mode to permissive before adding user acl_test1
>> then set it to the default mode enforcing.
>>
>> Signed-off-by: Wentao Ma <mawentao@inspur.com>
>> ---
>>   testcases/kernel/fs/acls/acl_test01 | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
>> index 328ff74..e38e39b 100755
>> --- a/testcases/kernel/fs/acls/acl_test01
>> +++ b/testcases/kernel/fs/acls/acl_test01
>> @@ -87,7 +87,9 @@ do_setup(){
>>   rm -rf $TEST_USER1_HOMEDIR
>>   userdel $TEST_USER1 > /dev/null 2>&1
>>   sleep 1
>> + setenforce 0
>>   useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
>> + setenforce 1
>>  
>>   if [ $? -ne 0 ]; then
>>   tst_brkm TBROK "Could not add test user $TEST_USER1."
> 
> ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> mawentao@inspur.com
> 
>      
>     *From:* Wanlong Gao <mailto:gaowanlong@cn.fujitsu.com>
>     *Date:* 2015-07-13 14:56
>     *To:* Wentao Ma <mailto:mawentao@inspur.com>; ltp-list@lists.sourceforge.net <mailto:ltp-list@lists.sourceforge.net>
>     *CC:* wunan@inspur.com <mailto:wunan@inspur.com>
>     *Subject:* Re: [LTP] [PATCH] acls: Solve a problem from acl_test01
>     On 07/09/2015 03:27 PM, Wentao Ma wrote:
>     > The failed infornamtion is as follow:
>     > useradd: cannot set SELinux context for
>     > home directory /tmp/tacl/mount-ext3/acltest1
>      
>     It seems that the error is caused by SELinux, please disable
>     your SELinux or set it to permissive and test again.
>      
>     Thanks,
>     Wanlong Gao
>      
>     >
>     > this is caused by comand "rm -rf $TEST_USER1_HOMEDIR".
>     > But this directory is needed by next step.
>     > So create this driectory again.
>     >
>     > Signed-off-by: Wentao Ma <mawentao@inspur.com>
>     > ---
>     >  testcases/kernel/fs/acls/acl_test01 | 1 +
>     >  1 file changed, 1 insertion(+)
>     >
>     > diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
>     > index 328ff74..d079abd 100755
>     > --- a/testcases/kernel/fs/acls/acl_test01
>     > +++ b/testcases/kernel/fs/acls/acl_test01
>     > @@ -87,6 +87,7 @@ do_setup(){
>     >  rm -rf $TEST_USER1_HOMEDIR
>     >  userdel $TEST_USER1 > /dev/null 2>&1
>     >  sleep 1
>     > +        mkdir -p $TEST_USER1_HOMEDIR
>     >  useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
>     > 
>     >  if [ $? -ne 0 ]; then
>     >
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
