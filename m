Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UDW8n-0000dC-72
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:25:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UDW8l-0004hm-8k
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:25:29 +0000
Message-ID: <51384F5F.4030403@cn.fujitsu.com>
Date: Thu, 07 Mar 2013 16:27:11 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
	<b1f36450d2c5fd46eabdcee4f268cf7a0a69017b.1362641893.git.caspar@casparzhang.com>
In-Reply-To: <b1f36450d2c5fd46eabdcee4f268cf7a0a69017b.1362641893.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 2/3] syscalls/madvise: code cleanup
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

On 03/07/2013 03:38 PM, Caspar Zhang wrote:
> Just a code cleanup for syscalls/madvise01-04 cases.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

Reviewed-by: Wanlong Gao<gaowanlong@cn.fujitsu.com> 

> ---
>  testcases/kernel/syscalls/madvise/madvise01.c |  77 +++--------------
>  testcases/kernel/syscalls/madvise/madvise02.c | 117 ++++++++------------------
>  testcases/kernel/syscalls/madvise/madvise03.c |  17 ++--
>  testcases/kernel/syscalls/madvise/madvise04.c |   5 +-
>  4 files changed, 58 insertions(+), 158 deletions(-)


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
