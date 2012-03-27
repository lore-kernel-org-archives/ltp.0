Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SCMpA-0004Vg-Hf
	for ltp-list@lists.sourceforge.net; Tue, 27 Mar 2012 03:11:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SCMp9-00040r-Jt
	for ltp-list@lists.sourceforge.net; Tue, 27 Mar 2012 03:11:56 +0000
Message-ID: <4F712FB7.4040403@cn.fujitsu.com>
Date: Tue, 27 Mar 2012 11:10:47 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F707B51.4090306@redhat.com> <4F71276B.4090302@casparzhang.com>
In-Reply-To: <4F71276B.4090302@casparzhang.com>
Subject: Re: [LTP] [PATCH] mremap: fix dependency on ipc subdir
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
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 03/27/2012 10:35 AM, Caspar Zhang wrote:

> On 03/26/2012 10:21 PM, Jan Stancek wrote:
>>
>> We need to use MAKE_DEPS to declare the ipc subdir depend otherwise
>> attempting to do `make mremap01` without building in the ipc subdir
>> will fail, and we can hit race conditions in the overall `make`.
>>
>> This is same change as in commit:
>> commit 7103d3e8e0f9dc1804ba06ee66ee02753e8ce50e
>> Author: Mike Frysinger <vapier@gentoo.org>
>> Date:   Fri Mar 23 12:27:13 2012 -0400
>>      kill: fix dependency on ipc subdir
>>
>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> Reviewed-by: Caspar Zhang <caspar@casparzhang.com>


Thanks Jan, Caspar pushed,

Wanlong Gao

> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here 
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
