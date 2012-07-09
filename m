Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SoCeX-0007lN-IO
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 12:01:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SoCeT-0004IE-68
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 12:01:21 +0000
Message-ID: <4FFAC7F1.3020504@cn.fujitsu.com>
Date: Mon, 09 Jul 2012 20:00:49 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <c16878af-92cd-4354-b3ef-8e442556877a@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <c16878af-92cd-4354-b3ef-8e442556877a@zmail13.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 1/2] mm/lib: ksm code style fixes.
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 07/09/2012 06:08 PM, Zhouping Liu wrote:
> 
> 
> ----- Original Message -----
>> From: "Caspar Zhang" <caspar@casparzhang.com>
>> To: "Zhouping Liu" <zliu@redhat.com>
>> Cc: "LTP list" <ltp-list@lists.sourceforge.net>
>> Sent: Monday, July 9, 2012 5:51:52 PM
>> Subject: [PATCH 1/2] mm/lib: ksm code style fixes.
>>
>>
>> This patch gives some minor fixes to the following two commits:
>>
>> f9ae09a lib/mem.c: using read_file to replace the redundant code
>> 60c41a5 lib/mem.c: add _wait_ksmd_done func to wait ksmd finish his
>> job
>>
>> to make the codes cleaner and easier to understand.
> 
> Looks good for me.
> 
> Reviewed-by: Zhouping Liu <zliu@redhat.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> 
> 
>>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
>> ---
>>  testcases/kernel/mem/lib/mem.c |   69
>>  +++++++++++++++------------------------
>>  1 files changed, 27 insertions(+), 42 deletions(-)
>>
>>
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
