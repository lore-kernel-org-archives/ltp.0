Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SXX53-0006Gu-KA
	for ltp-list@lists.sourceforge.net; Thu, 24 May 2012 12:23:49 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SXX4y-0003hg-2o
	for ltp-list@lists.sourceforge.net; Thu, 24 May 2012 12:23:49 +0000
Received: by pbbrq2 with SMTP id rq2so168654pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 May 2012 05:23:38 -0700 (PDT)
Message-ID: <4FBE2804.6020204@casparzhang.com>
Date: Thu, 24 May 2012 20:22:28 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4FBCC3E1.70302@redhat.com>
In-Reply-To: <4FBCC3E1.70302@redhat.com>
Subject: Re: [LTP] [PATCH] mbind01,
 get_mempolicy01: dont use hardcoded node 0
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
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 05/23/2012 07:02 PM, Jan Stancek wrote:
> 
> These tests are failing on following setup:
>   # numactl -H
>   available: 2 nodes (0-1)
>   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
>   23 24 25 26 27 28 29 30 31
>   node 0 size: 0 MB
>   node 0 free: 0 MB
>   node 1 cpus:
>   node 1 size: 12288 MB
>   node 1 free: 9998 MB
>   node distances:
>   node   0   1
>     0:  10  40
>     1:  40  10
> 
> Avoid hardcoded node 0 by using numa_get_mems_allowed().
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
Reviewed-by: Caspar Zhang <caspar@casparzhang.com>


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
