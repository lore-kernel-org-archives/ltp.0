Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T3gJv-0007Lq-DG
	for ltp-list@lists.sourceforge.net; Tue, 21 Aug 2012 04:44:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T3gJt-00025M-Pf
	for ltp-list@lists.sourceforge.net; Tue, 21 Aug 2012 04:44:03 +0000
Message-ID: <50330833.1080708@cn.fujitsu.com>
Date: Tue, 21 Aug 2012 12:01:55 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <446368613.3052914.1344590200420.JavaMail.root@redhat.com>
In-Reply-To: <446368613.3052914.1344590200420.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH 3/3] timer_settime/5-3: fix test hung
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng Zhao <Zhenfeng.Zhao@windriver.com>

On 08/10/2012 05:16 PM, Jan Stancek wrote:
> 
> ----- Original Message -----
>> > From: "Kang Kai" <kai.kang@windriver.com>
>> > To: ltp-list@lists.sourceforge.net
>> > Cc: "Zhenfeng Zhao" <Zhenfeng.Zhao@windriver.com>
>> > Sent: Thursday, 9 August, 2012 12:30:58 PM
>> > Subject: [LTP] [PATCH 3/3] timer_settime/5-3: fix test hung
>> > 
>> > This case hangs on sugarbay(intel x86_64) platform.
>> > 
>> > The root cause is that the case calls timer_settime with time which
>> > already took place and then calls sleep. When the timer expires and
>> > sends signal the sleep will be break.
>> > 
>> > But on sugarbay the timer always expires before the case enters
>> > sleep,
>> > then it always sleeps NUMTESTS * LONGSLEEPTIME seconds. So it exceeds
>> > the time limit set by auto-run test shell script, and reports that it
>> > hangs.
>> > 
>> > Decrease LONGSLEEPTIME value to avoid this issue.
>> > 
>> > Signed-off-by: Kang Kai <kai.kang@windriver.com>
> Looks good to me, 5 secs is still enough time.
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> 

Pushed, thank you.

Wanlong Gao


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
