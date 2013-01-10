Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1TtERz-00024M-8f
	for ltp-list@lists.sourceforge.net; Thu, 10 Jan 2013 09:29:27 +0000
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TtERx-0006r5-I9
	for ltp-list@lists.sourceforge.net; Thu, 10 Jan 2013 09:29:27 +0000
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <shubham@linux.vnet.ibm.com>; 
	Thu, 10 Jan 2013 14:58:17 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 20D69125804D
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Jan 2013 14:59:28 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r0A9TCUh47710444
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Jan 2013 14:59:12 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	r0A9TC0g001930
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Jan 2013 20:29:12 +1100
Message-ID: <50EE89E8.6030704@linux.vnet.ibm.com>
Date: Thu, 10 Jan 2013 14:59:12 +0530
From: shubham <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <50EB99FB.5020100@tsdv.com.vn>
	<50EBBB71.7060101@linux.vnet.ibm.com> <50EBD034.40400@tsdv.com.vn>
In-Reply-To: <50EBD034.40400@tsdv.com.vn>
Subject: Re: [LTP] Question mapping LTP testcases with Kernel setting?
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
To: duynv <duynv@tsdv.com.vn>
Cc: ltp-list@lists.sourceforge.net

On 01/08/2013 01:22 PM, duynv wrote:
> Dear Sir!
> Thanks for your reply.
> Because we want to test our kernel. So when we build kernel some 
> config options are disabled.
> I know what config options are disabled and i want to map between LTP 
> test case and kernel config to omit LTP test case when make install LTP
>
> I found in README file information below
> ...
> ---------------------------------
> Enabling Kernel Configuration to test Controllers
> ---------------------------------
> CONFIG_CGROUPS=y
> CONFIG_CGROUP_DEBUG=y
> CONFIG_CGROUP_NS=y
> CONFIG_GROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_RT_GROUP_SCHED=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_CGROUP_MEM_RES_CTLR=y
> CONFIG_LOCKDEP=y
> ....
>
> I think It mean, if those config options is not set when build kernel 
> all test case in Controllers no need to install and run. So when i 
> make LTP i dont want to make test cases in Controllers folder
>
> It's right? I can find out and map all test cases with kernel setting 
> in LTP project or in other document?
>
> Thanks.

Hi Duy,

The kernel options which are described in the "README" file are the 
kernel configurations we need to enable (before building the kernel) for 
testing that particular feature like controllers, power management or 
hotplugging. The facility of kernel config analysis and building the LTP 
based on that config options is not yet available. So you need to 
determine which tests you wish to run per your kernel configuration and 
than execute a customized LTP test run.

Thanks,
Shubham


>
> On 1/8/2013 13:23, shubham wrote:
>> On 01/08/2013 09:30 AM, duynv wrote:
>>> Dear Sir!
>>> I'm Duy.
>>>
>>> I am working with LTP to test our linux kernel.
>>> we want to collect LTP test cases to test our kernel base on the 
>>> kernel setting(configuration file create by "make menuconfig").
>>> (we want to omit unnecessary test case)
>>>
>>> But LTP has so many test cases. I can't mapping LTP test case with 
>>> appropriate kernel setting
>>> Could you please tell me the way to make a mapping list between LTP 
>>> test case with kernel setting
>>>
>>> Thank you
>>>
>>
>> Hi Duy,
>>
>> I believe its not possible to direct map LTP test cases with the 
>> current kernel settings. What you can do is select the subsystems or 
>> components you wish to test and than run only those tests by 
>> customizing the LTP test runs. For your information you can select 
>> the tests you wish to run from 'runtest' directory of the extracted 
>> LTP tarball.
>>
>> Thanks,
>> Shubham
>>
>


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
