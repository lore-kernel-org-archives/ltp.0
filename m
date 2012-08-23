Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T4TIy-0004Hi-Fn
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 09:02:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T4TIx-0005z6-Df
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 09:02:20 +0000
Message-ID: <5035F125.6000106@cn.fujitsu.com>
Date: Thu, 23 Aug 2012 17:00:21 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1281448625.57776160.1345712387252.JavaMail.root@redhat.com>
In-Reply-To: <1281448625.57776160.1345712387252.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/23/2012 04:59 PM, Zhouping Liu wrote:
> 
> ----- Original Message -----
>> > From: "shuang qiu" <shuang.qiu@oracle.com>
>> > To: ltp-list@lists.sourceforge.net
>> > Sent: Thursday, August 23, 2012 2:43:01 PM
>> > Subject: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
>> > 
>> > From: Shuang Qiu <shuang.qiu@oracle.com>
>> > 
>> > The value of min_free_kbytes is set too high(half of mem_free) during
>> > testing min_free_kbytes tunable.It often cause the system to become
>> > out-of-memory.Using 20% of mem_free to avoid oom and system hang.
> Thanks for the patch, I will test the patch, will provide feedback ASAP.
> 

Great! thank you Zhouping.

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
