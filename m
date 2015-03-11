Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YVf8X-0007L5-R3
	for ltp-list@lists.sourceforge.net; Wed, 11 Mar 2015 11:49:17 +0000
Date: Wed, 11 Mar 2015 12:48:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150311114831.GB3713@rei>
References: <1425986309-12966-1-git-send-email-alexey.kodanev@oracle.com>
	<20150311103011.GA3713@rei> <55002A64.6040108@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55002A64.6040108@oracle.com>
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
> This is what is written in kernel source (net/core/sock.c):
> 
> sk->sk_sndbuf = max_t(u32, val * 2, SOCK_MIN_SNDBUF);
> ...
> /*
>   * We double it on the way in to account for
>   * "struct sk_buff" etc. overhead.   Applications
>   * assume that the SO_RCVBUF setting they make will
>   * allow that much actual data to be received on that
>   * socket.
>   *
>   * Applications are unaware that "struct sk_buff" and
>   * other overheads allocate from the receive buffer
>   * during socket buffer allocation.
>   *
>   * And after considering the possible alternatives,
>   * returning the value we actually used in getsockopt
>   * is the most desirable behavior.
>   */
> 
> sk->sk_rcvbuf = max_t(u32, val * 2, SOCK_MIN_RCVBUF);
> 
> I'm not sure why it is not just 'val', because it chooses the maximum 
> value in any case and we have defined minimum.

Ok.

The patch is fine then.

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
