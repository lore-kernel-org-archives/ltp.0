Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdMhv-000404-OZ
	for ltp-list@lists.sourceforge.net; Wed, 21 Dec 2011 13:59:47 +0000
Date: Wed, 21 Dec 2011 15:09:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111221140926.GA27921@saboteur.suse.cz>
References: <4EE95F75.6030909@cn.fujitsu.com>
	<6d5f6f84-cdfa-42d0-a3a5-f9d028419818@zmail16.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6d5f6f84-cdfa-42d0-a3a5-f9d028419818@zmail16.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] memcg_function:fix the wrong use of mlock
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> this should be commited already, but looking at git,
> I see changes only for memcg_process.c:
> 
> commit 17ecdc4e0f895f61067a65d6105f29d4f55680be
> Author: Garrett Cooper <yanegomi@gmail.com>
> Date:   Wed Dec 14 21:42:25 2011 -0800
> 
>     mlock and munmap will return -1 if they fail.
> 
>     Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
>     Reviewed-by: Caspar Zhang <caspar@casparzhang.com>
>     Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> 
>  .../controllers/memcg/functional/memcg_process.c   |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> Have I missed some message on mailing list or did it slip by accident?

Looks like the second part is somehow missing.

Sigh, like when people are helping, but sometimes Garrett is actually
making my life harder...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
