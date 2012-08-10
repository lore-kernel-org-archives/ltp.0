Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SzlS4-0000d9-Cp
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 09:24:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzlS1-0001Qh-UI
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 09:24:16 +0000
Message-ID: <5024D2E5.9050805@cn.fujitsu.com>
Date: Fri, 10 Aug 2012 17:22:45 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH resend 0/6] NUMA and follow-up fix
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 08/09/2012 02:15 PM, Caspar Zhang wrote:
> 
> Resending the whole patch series (including Jan's 2 patches) for easier 
> reviewing.
> 
> updates:
>    syscalls/numa: check syscall availability
>      remove TEST() macro and use syscall() directly.
>    numa_helper: move to libkerntest
>      merged the library cleaning fix to this one.
>    mm: use new numa_helper
>      the same as previous V3 version, which already has Jan's reivew.
> 
> Caspar Zhang (4):
>   syscalls/numa: check syscall availability
>   numa_helper: move to libkerntest
>   mm: use new numa_helper
>   mm: add common Makefile include: libmem.mk
> 
> Jan Stancek (2):
>   numa_helper: add flag to get_allowed_nodes()
>   update testcases to use flag for get_allowed_nodes()

As you guys all reviewed and tested this series, and this already flies for weeks,
I just pushed this series. Then will run on our test system next week. ;)
Thank you guys.

Wanlong Gao

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
