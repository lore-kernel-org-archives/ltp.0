Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YVduj-0000h6-VM
	for ltp-list@lists.sourceforge.net; Wed, 11 Mar 2015 10:30:57 +0000
Date: Wed, 11 Mar 2015 11:30:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150311103011.GA3713@rei>
References: <1425986309-12966-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1425986309-12966-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] sctp/test_1_to_1_sockopt.c: set SO_SNDBUF above
 the defined minimum
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> SO_SNDBUF have the following minimum value:
> TCP_SKB_MIN_TRUESIZE (2048 + sizeof(struct sk_buff))
> SOCK_MIN_SNDBUF (TCP_SKB_MIN_TRUESIZE * 2)
> 
> The test set 'SO_SNDBUF' to 2048, then it gets the value back
> with getsockopt(). But the value was defaulted in the kernel
> to the SOCK_MIN_SNDBUF.

I guess that the setsockopt() does that without failing and then
the comparsion of the value you get with getsockopt() fails, right?

I still do not get why the code does:

if ((2 * sndbuf_val_set) != sndbuf_val_get)

Shouldn't the sndbuf_val_set == sndbuf_val_get once the value is changed
to 5000?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
