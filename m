Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Rb4Ge-0002w7-0p
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 05:54:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rb4Gb-0008Mk-Ro
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 05:54:07 +0000
Message-ID: <4EE98B34.2070709@cn.fujitsu.com>
Date: Thu, 15 Dec 2011 13:52:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4EE95F75.6030909@cn.fujitsu.com> <4EE963A9.7030100@cn.fujitsu.com>
	<CAGH67wQxgxm01PQVGyaMTDgThGU8pNUSMsrAkVMX2MBiAX48JQ@mail.gmail.com>
In-Reply-To: <CAGH67wQxgxm01PQVGyaMTDgThGU8pNUSMsrAkVMX2MBiAX48JQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] memcg_function:fix the wrong use of mlock
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi Garrett:

What do you think about the patch set below now?

	[PATCH 0/5] Automatically mount hugetlbfs for hugemmap tests.


Thanks a lot 
-Wanlong Gao

> On Wed, Dec 14, 2011 at 7:04 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>> On 12/15/2011 10:46 AM, Peng Haitao wrote:
>>
>>>
>>> mlock and munmap will return -1 when ERROR.
>>>
>>> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
>>
>> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> 
> Committed -- thanks!
> -Garrett
> 



------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
