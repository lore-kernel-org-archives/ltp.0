Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lxiang@redhat.com>) id 1So3eT-0004x1-3Q
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:24:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1So3eR-0001nG-Oj
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:24:41 +0000
Message-ID: <4FFA40DD.3030408@redhat.com>
Date: Mon, 09 Jul 2012 10:24:29 +0800
From: Lingzhu Xiang <lxiang@redhat.com>
MIME-Version: 1.0
References: <1e99528971ce08cfebd0bd9c2b3333295dc9efe4.1341705843.git.lxiang@redhat.com>
	<4FF8D306.5090401@redhat.com> <4FF6B720.3040705@casparzhang.com>
In-Reply-To: <4FF6B720.3040705@casparzhang.com>
Subject: Re: [LTP] [PATCH] timers: add a new test case leapsec_timer
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

On 07/06/2012 06:00 PM, Caspar Zhang wrote:
> On 07/08/2012 08:23 AM, Lingzhu Xiang wrote:
>> Note that this test case might cause kernel freeze. Running with -c 5 will
>> highly increase the likelihood of that.
>
> IIRC, -c is broken, is `-i 5` able to freeze the kernel? If yes, it
> would be better to add a new entry to $LTPROOT/runtest/timers or update
> the original entry w/ `-i 5` option.

Nope. It seems the hard hang caused by concurrent leap second is unresolved
in upstream "NOTE: Some reports have been of a hard hang right at or before
the leapsecond. I've not been able to reproduce or diagnose this..." [1]

[1]: https://lkml.org/lkml/2012/7/4/78

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
