Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SoEkb-0005OE-35
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 14:15:45 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SoEkV-0001Zd-KV
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 14:15:45 +0000
Received: by pbbrq2 with SMTP id rq2so18241679pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jul 2012 07:15:33 -0700 (PDT)
Message-ID: <4FFAE775.1020809@casparzhang.com>
Date: Mon, 09 Jul 2012 22:15:17 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1341827513-21908-1-git-send-email-caspar@casparzhang.com>
	<1341827513-21908-2-git-send-email-caspar@casparzhang.com>
	<4FFAC130.2090707@cn.fujitsu.com>
	<4FFAD07D.6010703@casparzhang.com>
	<4FFAD846.8060702@cn.fujitsu.com>
In-Reply-To: <4FFAD846.8060702@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] mm/lib: increase sleep time in ksm scanning
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

On 07/09/2012 09:10 PM, Wanlong Gao wrote:
> On 07/09/2012 08:37 PM, Caspar Zhang wrote:
>> On 07/09/2012 07:32 PM, Wanlong Gao wrote:
>>> On 07/09/2012 05:51 PM, Caspar Zhang wrote:
>>>>
>>>> for some systems under pressure, we've observed that sleeping 5
>>>> seconds is not sufficient for completing ksm scanning, to fix
>>>> this, we should give ksmd more time to scan the mergable pages
>>>> by increasing sleeping time to 10s.
>>>
>>> If 5s is not enough, isn't we waiting here already?
>>
>> Sorry, I'm not catching you... :-( the problem currently we
>> encounter is that if 5s given, all ksm values (pages_sharing,
>> pages_shared, etc) might remain the same between before and after
>> sleeping, so the wait_ksmd function could exit. But in fact the
>> kernel could be busy under pressure and it just needs more than 5s
>> to merge the same page. Using 10s as polling interval can make sure
>> if ksm values remains the same between each loop, it should
>> indicates that ksmd has done scanning correctly.
>>
>
> Oops, it's a serious problem, so can we first wait for changing and
> then wait for not changing? I'm afraid that hard coded sleep time
> can't do the right thing on some systems.

IMO the current implementation does the same thing as you suggested. We 
wait for certain interval (5s for now, 10s proposed), and check if ksm 
values increased, if still changing, continue next sleep interval. 
Adding a "wait-for-not-changing" in fact has the same effect as 
increasing the original sleep time.

theoretically, sleeping interval should be as larger as possible, but it 
will cost unnecessary running time if the interval is set too big in the 
this case. I'd say 10s is a "for-now-best-practice" during my several 
running (both w/ and w/o pressure). Besides, I'm not sure how ksm 
developers think of current ksm performance, but I think if ksmd takes 
more than 10s to merge two same pages, it will be a big performance issue.

I'd suggest everyone interested in this case try 10s on your systems to 
see if it works. Also if you have idea of design a flexible waiting 
time, it will be perfect.

Thanks,
Caspar

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
