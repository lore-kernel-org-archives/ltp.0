Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SMt0O-0008Cy-9P
	for ltp-list@lists.sourceforge.net; Wed, 25 Apr 2012 03:35:00 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SMt0L-0007F0-HG
	for ltp-list@lists.sourceforge.net; Wed, 25 Apr 2012 03:35:00 +0000
Received: by dadz9 with SMTP id z9so2140939dad.33
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 Apr 2012 20:34:47 -0700 (PDT)
Message-ID: <4F9770BF.5050609@casparzhang.com>
Date: Wed, 25 Apr 2012 11:34:23 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1335253407-17318-1-git-send-email-penght@cn.fujitsu.com>
	<4F976A4E.6070006@cn.fujitsu.com>
	<4F977041.9070607@casparzhang.com>
In-Reply-To: <4F977041.9070607@casparzhang.com>
Subject: Re: [LTP] [PATCH] memcg_move_charge_at_immigrate_test: fix a bug of
 usage_in_bytes is not 'exact'
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 04/25/2012 11:32 AM, Caspar Zhang wrote:
> On 04/25/2012 11:06 AM, Wanlong Gao wrote:
>> On 04/24/2012 03:43 PM, Peng Haitao wrote:
>>
>>> In memory.txt says:
>>>  usage_in_bytes is affected by the method and doesn't show 'exact' value of memory(and swap) usage, it's an fuzz value for efficient access. (Of course, when necessary, it's synchronized.) If you want to know more exact memory usage, you should use RSS+CACHE(+SWAP) value in memory.stat(see 5.2).
>>>
>>> So memory.usage_in_bytes should be replaced with memory.stat in the case of
>>> memcg_move_charge_at_immigrate_test.
> 
> Hi, Please break your commit message into <= 73 words per line (except

sorry, s/words/characters...

> some running output) next time.
> 
> Thanks,
> Caspar

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
