Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1U30yt-0004IX-8p
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 09:07:51 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U30yr-0004uA-BG
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 09:07:51 +0000
Message-ID: <51121D3D.7090707@cn.fujitsu.com>
Date: Wed, 06 Feb 2013 17:07:09 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1617294472.837757.1360141026616.JavaMail.root@redhat.com>
In-Reply-To: <1617294472.837757.1360141026616.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH 2/3] setns: add new syscall test setns01
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

On 02/06/2013 04:57 PM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 6 February, 2013 9:48:17 AM
>> Subject: Re: [LTP] [PATCH 2/3] setns: add new syscall test setns01
>>
>>
>> So, how about adding fd and ns_type setting in setup4:
>>
>> +	int i;
>> +	for (i = 0; i < NS_TOTAL; i++)
>> +		if (ns_fds[i] != -1) {
>> +			t->fd = ns_fds[i];
>> +			t->ns_type = ns_types[i];
>> +			return;
>> +		}
>> +	t->skip = 1;
>>
>>
>> Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>>
>> Thanks,
>> Wanlong Gao
> 
> Thanks for having a look. I was thinking the same, I'm just building
> latest kernel tree to double check it. I'll send v2 afterwards.

Yeah, thank you. namespace part is in heavy development
recently, your contribution is very useful. 8-)

Thanks,
Wanlong Gao

> 
> Regards,
> Jan
> 


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
