Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Z7xlI-0003lf-4j
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 03:23:36 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z7xlG-0004lt-0b
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 03:23:36 +0000
Message-ID: <558B71D4.9010205@cn.fujitsu.com>
Date: Thu, 25 Jun 2015 11:13:24 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <CANuOEEhmmS_E-O9umbGEHerBONT+bGAOFHH5O055ajH_V+Rgaw@mail.gmail.com>
	<558B62CB.8060401@cn.fujitsu.com>
	<E0CF1826-54DC-40DE-8281-FE4F57492332@umich.edu>
In-Reply-To: <E0CF1826-54DC-40DE-8281-FE4F57492332@umich.edu>
Subject: Re: [LTP] How to specify testcases by running runltp
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
To: Shuo Yang <yshuo@umich.edu>
Cc: ltp-list@lists.sourceforge.net

Hi,

On 06/25/2015 11:12 AM, Shuo Yang wrote:
> Thank you so much for the answer. The file system I want to test is not from a regular device. I implemented a virtual file system on top of FUSE, so I only have a mount point to test. Is there a way to do this? 
Sorry, I made a mistake here, script runltp's '-b DEVICE' and '-B LTP_DEV_FS_TYPE' can only provide
a block device for test cases which need a block device to have test. I think what you need is
runltp's '-d TMPDIR' option.
"-d TMPDIR       Directory where temporary files will be created."

Regards,
Xiaoguang Wang 

> 
> Thanks,
> Shuo Yang
> 
> 
> 
> 
>> On Jun 24, 2015, at 7:09 PM, Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com <mailto:wangxg.fnst@cn.fujitsu.com>> wrote:
>>
>> Hi,
>>
>> On 06/25/2015 09:29 AM, Shuo Yang wrote:
>>> Hi guys,
>>>
>>> I just started using ltp, so this question is kind of dumb. I want to use it to run some file system tests but I don't know what the command should be. Currently I can run runtlp command but I don't know how to control the testcases. Assuming the file system I want to test is under /tmp/foo/. Could someone tell me how can I run the testcases specifically for testing file system.
>>>
>> Script runltp's '-b DEVICE' and '-B LTP_DEV_FS_TYPE' can control the file
>> system you want to test. Assume /tmp/foo/ is a mount point, the corresponding
>> device is /dev/sda1 and file system type is xfs, then you can try './runltp -b /dev/sda1 -B xfs'.
>> Also if you want to test file system, xfstests is a good candidate.
>>
>> Regards,
>> Xiaoguang Wang
>>
>>> Thanks,
>>> Shuo
>>>
>>>
>>>
>>> ------------------------------------------------------------------------------
>>> Monitor 25 network devices or servers for free with OpManager!
>>> OpManager is web-based network management software that monitors
>>> network devices and physical & virtual servers, alerts via email & sms
>>> for fault. Monitor 25 devices for free with no restriction. Download now
>>> http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
>>>
>>>
>>>
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>
>>
> 


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
