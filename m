Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RiGGk-0004jo-If
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 02:07:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RiGGg-0005aq-U6
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 02:07:58 +0000
Message-ID: <4F03B406.8050808@cn.fujitsu.com>
Date: Wed, 04 Jan 2012 10:05:58 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4EFAF5BB.2030407@windriver.com> <4F03AD5E.4000003@jp.fujitsu.com>
In-Reply-To: <4F03AD5E.4000003@jp.fujitsu.com>
Subject: Re: [LTP] Posix test case mmap/31-1 fails on Linux/eglibc
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
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Kang Kai <Kai.Kang@windriver.com>

On 01/04/2012 09:37 AM, Yasuaki Ishimatsu wrote:

> Hi Kai,
> 
> 2011/12/28 19:55, Kang Kai wrote:
>> Hi all,
>>
>> I run mmap/31-1 failed with ENOMEM on linux, with error message:
>> off: fffffffffffff000, len: fffffffffffff000
>> Test FAIL: expect EOVERFLOW but get other error: Cannot allocate memory
>>
>> But compare to mmap/24-2, it mmap() the same length but pass. Its output:
>> available memory: 18446744073709551615
>> addr: 7f78c54fa000, len: ffffffffffffffff
>> addr: 7f78c54fa000, len: fffffffffffff000
>> Test Pass: mmap/24-2.c Get ENOMEM: Cannot allocate memory
>>
>> So I suppose that mmap/31-1 may need update, but I don't know how to
>> make mmap() overflow as expect.
>> Any suggestion is appreciated.
> 
> I don't think mmap/31-1 need update since it is Linux Kernel's problem,
> not the test's problem. The problem is being discussed on LKML.
> 
> https://lkml.org/lkml/2011/12/22/85


But it seems that the patch was not acceptable.

Thanks
-Wanlong Gao

> 
> Regards,
> Yasuaki Ishimatsu
> 
>>
>> Regards,
>> Kai



------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
