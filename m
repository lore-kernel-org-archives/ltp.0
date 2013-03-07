Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UDWFf-000525-Sg
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:32:35 +0000
Received: from mail-pa0-f46.google.com ([209.85.220.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UDWFf-0004UG-4k
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:32:35 +0000
Received: by mail-pa0-f46.google.com with SMTP id kp14so292181pab.33
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Mar 2013 00:32:29 -0800 (PST)
Message-ID: <513850A9.2070807@casparzhang.com>
Date: Thu, 07 Mar 2013 16:32:41 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
	<513850C8.9080905@cn.fujitsu.com>
In-Reply-To: <513850C8.9080905@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/3] s/Tst_count/tst_count/ to avoid CamelCase
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

On 03/07/2013 04:33 PM, Wanlong Gao wrote:
> On 03/07/2013 03:38 PM, Caspar Zhang wrote:
>> when using latest checkpatch.pl, CamelCase variables are not encouraged,
>> this patch does a batch update to replace all var `Tst_count` with
>> `tst_count`.
>>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
>
> Hope this won't break anything.
>
> Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>

Tested by compiling all the patched cases, everything seems still working.

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
