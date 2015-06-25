Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z81Uv-0005QS-Cr
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 07:22:57 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z81Us-0002vW-MJ
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 07:22:57 +0000
Message-ID: <558BAC25.2020205@huawei.com>
Date: Thu, 25 Jun 2015 15:22:13 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <558B6C8C.5000202@huawei.com> <558B9D33.1090305@cn.fujitsu.com>
In-Reply-To: <558B9D33.1090305@cn.fujitsu.com>
Subject: Re: [LTP] Cedric
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi Wanlong,
     It works well after install the lib.
     Many thanks.
     Yuan

On 2015/6/25 14:18, Wanlong Gao wrote:
> On 06/25/2015 10:50 AM, Yuan Sun wrote:
>> Hi Cedric,
>>       I encounter the following error in ubuntu14.04. Your patch
>> "syscall/getrandom: Add tests for getrandom" leads to the error.
>>       Do I need to install new libraries?
> Try
>
> apt-get install linux-libc-dev
>
> Thanks,
> Wanlong Gao
>
>
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
