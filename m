Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sn5Qt-0007Uy-7D
	for ltp-list@lists.sourceforge.net; Fri, 06 Jul 2012 10:06:39 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sn5Qn-0004Pk-Nn
	for ltp-list@lists.sourceforge.net; Fri, 06 Jul 2012 10:06:39 +0000
Received: by pbbrq2 with SMTP id rq2so13593147pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Jul 2012 03:06:27 -0700 (PDT)
Message-ID: <4FF6B720.3040705@casparzhang.com>
Date: Fri, 06 Jul 2012 18:00:00 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1e99528971ce08cfebd0bd9c2b3333295dc9efe4.1341705843.git.lxiang@redhat.com>
	<4FF8D306.5090401@redhat.com>
In-Reply-To: <4FF8D306.5090401@redhat.com>
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
To: Lingzhu Xiang <lxiang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 07/08/2012 08:23 AM, Lingzhu Xiang wrote:
> Note that this test case might cause kernel freeze. Running with -c 5 will
> highly increase the likelihood of that.

IIRC, -c is broken, is `-i 5` able to freeze the kernel? If yes, it
would be better to add a new entry to $LTPROOT/runtest/timers or update
the original entry w/ `-i 5` option.

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
