Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UDW4K-0004FW-Fz
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:20:52 +0000
Received: from mail-pa0-f46.google.com ([209.85.220.46])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UDW4J-0003zk-Ky
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:20:52 +0000
Received: by mail-pa0-f46.google.com with SMTP id kp14so286357pab.5
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Mar 2013 00:20:43 -0800 (PST)
Message-ID: <51384DE7.8000400@casparzhang.com>
Date: Thu, 07 Mar 2013 16:20:55 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
	<0da7f15cb693ea31f3f5cb1512713ae0562b4f17.1362641893.git.caspar@casparzhang.com>
	<51384D30.1040003@cn.fujitsu.com>
In-Reply-To: <51384D30.1040003@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/3] syscalls/madvise02: fix madvise case due to
 kernel change
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/07/2013 04:17 PM, Wanlong Gao wrote:
> Please s/suuport/support/ when you push this patch.
>
> Reviewed-by: Wanlong Gao<gaowanlong@cn.fujitsu.com>

Do-oh!

Thanks for reviewing, I'll fix it :-)

Caspar

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
