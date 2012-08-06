Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SyCQE-0008Dt-UG
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 01:47:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SyCQD-0002ib-7A
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 01:47:54 +0000
Message-ID: <501F21E8.6030302@cn.fujitsu.com>
Date: Mon, 06 Aug 2012 09:46:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <13ebcba495cd84de8ffb6db190d3cfc5490c7af2.1343994187.git.jstancek@redhat.com>
In-Reply-To: <13ebcba495cd84de8ffb6db190d3cfc5490c7af2.1343994187.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] sockioctl01: fix expected errno for pipe ioctl
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/03/2012 07:48 PM, Jan Stancek wrote:
> 
> commit 46ce341b2f176c2611f12ac390adf862e932eb02
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Fri May 25 11:39:13 2012 +0100
> 
>     pipe: return -ENOIOCTLCMD instead of -EINVAL on unknown ioctl
> command
> 
> This commit (v3.4-8603-g46ce341 in linux-stable) changed pipe_ioctl,
> so vfs_ioctl() now returns ENOTTY instead of EINVAL.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Pushed, thanks Jan.

Wanlong Gao

> ---
>  testcases/kernel/syscalls/sockioctl/sockioctl01.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
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
