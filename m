Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shwetabh.goel@calsoftinc.com>) id 1Nn5OC-0007TG-4P
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 07:22:32 +0000
Received: from inbox235.nyi.net ([66.111.15.35])
	by sfi-mx-3.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Nn5OB-0000Db-A0
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 07:22:32 +0000
Received: from imss.calsofthq.com (imss.calsofthq.com [172.16.0.44])
	by mail.calsofthq.com (8.13.6/8.13.6) with ESMTP id o247MNSV013174
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 12:52:23 +0530
Received: from imss.calsofthq.com (localhost.localdomain [127.0.0.1])
	by localhost.calsofthq.com (Postfix) with ESMTP id 6A2811BE10AB
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Mar 2010 12:57:23 +0530 (IST)
Received: from mail.calsofthq.com (mail.calsofthq.com [172.16.0.7])
	by imss.calsofthq.com (Postfix) with ESMTP id 4D9391BE1092
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Mar 2010 12:57:23 +0530 (IST)
Message-ID: <4B8F5FB8.103@calsoftinc.com>
Date: Thu, 04 Mar 2010 12:52:32 +0530
From: Shwetabh <shwetabh.goel@calsoftinc.com>
MIME-Version: 1.0
References: <4B8E3B7F.8050301@calsoftinc.com>	
	<20100303124352.GD23601@linux.vnet.ibm.com>	
	<4B8E5DF3.7090502@calsoftinc.com>	
	<9debc4411003030900t971da33pfbe9ea4e994d74d4@mail.gmail.com>	
	<BD77C355-AF47-4A92-8231-145DDBC8F54D@gmail.com>	
	<20100304064544.GA11885@linux.vnet.ibm.com>
	<364299f41003032250i78c201fesc5ce55d6d2c2794f@mail.gmail.com>
In-Reply-To: <364299f41003032250i78c201fesc5ce55d6d2c2794f@mail.gmail.com>
Subject: Re: [LTP] Missing test tools in recent ltp builds
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Garett,

There is one possible problem with the current solution provided by 
Maxin. The patch takes care
only of cpuhotplug tests. However, judging by the number of files that 
are missing in /opt/ltp/testcases,
it is quite possible that many other tests might have been broken. So, 
perhaps a generic solution to this
problem would be to modify the Makefile to ensure that it copies all 
directories from ltp-full-20100228/testcases/
to /opt/ltp/testcases/.

Here is a listing of files in both directories after an installation has 
been performed:

----Installation Directory------
[root@localhost ~]# ls -l /root/ltp-full-20100228/testcases/
total 56
drwxrwxr-x  3 500 500 4096 Mar  1 09:58 ballista
drwxrwxr-x 15 500 500 4096 Mar  1 09:58 commands
drwxrwxr-x  6 500 500 4096 Mar  1 09:58 DOTS
drwxrwxr-x  5 500 500 4096 Mar  1 09:58 kdump
drwxrwxr-x 21 500 500 4096 Mar  1 09:58 kernel
drwxrwxr-x  2 500 500 4096 Mar  1 09:58 lib
-rw-rw-r--  1 500 500 1381 Mar  1 09:58 Makefile
drwxrwxr-x  9 500 500 4096 Mar  1 09:58 mce-test
drwxrwxr-x  6 500 500 4096 Mar  1 09:58 misc
drwxrwxr-x 18 500 500 4096 Mar  3 19:00 network
drwxrwxr-x 15 500 500 4096 Mar  1 09:58 open_hpi_testsuite
drwxrwxr-x  7 500 500 4096 Mar  1 09:58 open_posix_testsuite
drwxrwxr-x  5 500 500 4096 Mar  1 09:58 pounder21
drwxrwxr-x 13 500 500 4096 Mar  3 18:51 realtime
---------------------------------

------Target Directory-----------
[root@localhost ~]# ls -l /opt/ltp/testcases/
total 76
drwxr-xr-x 7 root root 69632 Mar  3 19:01 bin
drwxr-xr-x 2 root root  4096 Mar  3 19:01 data
---------------------------------

Regards,
Shwetabh


On 3/4/2010 12:20 PM, Garrett Cooper wrote:
> On Wed, Mar 3, 2010 at 10:45 PM, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com>  wrote:
>    
>> On Wed, Mar 03, 2010 at 03:16:47PM -0800, Garrett Cooper wrote:
>>      
>>> On Mar 3, 2010, at 9:00 AM, Maxin John<maxin.john@gmail.com>  wrote:
>>>
>>>        
>>>> Hi Shwetabh,
>>>>
>>>>          
>>>>> 3. Went to /opt/ltp directory and tried to execute cpuhotplug test:
>>>>> [root@localhost ~]# cd /opt/ltp/
>>>>> [root@localhost ltp]# ./runltp -f cpuhotplug
>>>>>
>>>>>            
>>>> Please find attached the quick 'n' dirty patch
>>>> (cpu_hotplugin_makefile.patch) to execute cpuhotplugin test.
>>>> I have observed that the 'hotplug' directory is not included in
>>>> "testcases/kernel/Makefile". I have also
>>>> created a Makefile in 'hotplug/cpu_hotplug' directory.
>>>>
>>>> After applying this patch, I have followed the usual ./configure;
>>>> make; sudo make install steps and executed
>>>> the cpuhotplug test and observed the below given output . It seems
>>>> like the test execution is "not so good" in
>>>> my machine. Your mileage may vary.
>>>>
>>>> Garret,Rishi, please review the patch and let me know your comments.
>>>>
>>>> Signed-off-by: Maxin B. John<maxin.john@gmail.com>
>>>>          
>>> It looks better but it's going to need a minor amount of fudging in
>>> the scripts to source the appropriate scripts to execute cpuhotplug's
>>> tests... I'll pick this up tomorrow if it's not done by then...
>>>        
>> Yes it looks better, i have tested it and true there are still some
>> problem with testcase, can you look very closely and try to find the
>> root cause for that ? Since this patch is important to run cpuhotplug
>> testcases, i have included this to master branch.
>>      
>      I'm not arguing that it's a good step towards getting the task
> solved; I'm arguing that the change wasn't complete. I'm cleaning it
> up right now...
> Thanks,
> -Garrett
>
>    

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
