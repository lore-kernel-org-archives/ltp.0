Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SB5IG-00017Z-Vm
	for ltp-list@lists.sourceforge.net; Fri, 23 Mar 2012 14:16:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SB5IB-0006O5-AF
	for ltp-list@lists.sourceforge.net; Fri, 23 Mar 2012 14:16:40 +0000
Message-ID: <4F6C85B7.4040604@redhat.com>
Date: Fri, 23 Mar 2012 22:16:23 +0800
From: ZhoupingLiu <zliu@redhat.com>
MIME-Version: 1.0
References: <87ae50f292bc2e82ecdd1fefe2db0dd41d6026a4.1332395878.git.zliu@redhat.com>
	<4F6B2A08.5070709@cn.fujitsu.com>
In-Reply-To: <4F6B2A08.5070709@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mm/tunable: add a new testcase min_free_kbytes
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 03/22/2012 09:32 PM, Wanlong Gao wrote:
> On 03/22/2012 02:35 PM, Zhouping Liu wrote:
>
>> The case is designed to test min_free_kbytes tunable file.
>>
>> The tune is used to control free memory, and system always
>> reserve min_free_kbytes memory at least.
>>
>> Since the tune is not too large or too little, which will
>> lead to the system hang, so I choose two cases, and test them
>> on all overcommit_memory policy, at the same time, compare
>> the current free memory with the tunable value repeatedly.
>>
>> a) default min_free_kbytes with all overcommit memory policy
>> b) half of mem_free with all overcommit memory policy
>
> Looks good and test OK to me. thanks,
>
> Reviewed-by: Wanlong Gao<gaowanlong@cn.fujitsu.com>
>

hi, Wanlong
Thanks for your reviewing :)
I sent a new version, please review it again.

Thanks,
Zhouping

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
