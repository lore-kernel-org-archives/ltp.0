Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Szk58-0000mv-0t
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 07:56:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Szk56-0005Hc-En
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 07:56:29 +0000
Message-ID: <5024BE51.6040202@cn.fujitsu.com>
Date: Fri, 10 Aug 2012 15:54:57 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1344492473.git.caspar@casparzhang.com>
	<c34d8829b21a0e2cd2d5b1241ea751e61b993348.1344492473.git.caspar@casparzhang.com>
	<5024BC6F.7010408@redhat.com>
In-Reply-To: <5024BC6F.7010408@redhat.com>
Subject: Re: [LTP] [PATCH resend 3/6] syscalls/numa: check syscall
	availability
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 08/10/2012 03:46 PM, Zhouping Liu wrote:
> On 08/09/2012 02:15 PM, Caspar Zhang wrote:
>> some NUMA related syscalls: mbind, get_mempolicy are not supported on
>> some arches (e.g. i386), this patch checks the syscalls' availability in
>> setup() function, if the syscall is not implemented on the system, a
>> TCONF message will be given like this:
>>
>> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch
>>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> 
> Reviewed-by: Zhouping Liu <zliu@redhat.com>

Zhouping, 3/6 already has a V2 version.

Thanks,
Wanlong Gao

> 
> Thanks,
> Zhouping
> 
>> ---
>>  .../syscalls/get_mempolicy/get_mempolicy01.c       |   10 ++++++++++
>>  testcases/kernel/syscalls/mbind/mbind01.c          |    9 +++++++++
>>  2 files changed, 19 insertions(+), 0 deletions(-)
>>
>>
>>
>> ------------------------------------------------------------------------------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and 
>> threat landscape has changed and how IT managers can respond. Discussions 
>> will include endpoint security, mobile security and the latest in malware 
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>>
>>
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> 
> 
> 
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
