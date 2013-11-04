Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VdFU7-0005Vk-DN
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 08:26:07 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdFU6-0004u9-3R
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 08:26:07 +0000
Message-ID: <527759F4.8040606@cn.fujitsu.com>
Date: Mon, 04 Nov 2013 16:25:24 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383542895-14069-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1383542895-14069-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] sctp: enlarge SO_RCVBUF option value
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

On 11/04/2013 01:28 PM, Simon Xu wrote:
> When using setsockopt() with recent Linux kernels, it doesn't make sense to
> use a value smaller than SOCK_MIN_RCVBUF/2 for SO_RCVBUF and expect getting
> a SO_RCVBUF value by getsockopt() which is doubled.  See the following code
> in linux/net/core/sock.c:
> 
> 	if ((val * 2) < SOCK_MIN_RCVBUF)
> 		sk->sk_rcvbuf = SOCK_MIN_RCVBUF;
> 	else
> 		sk->sk_rcvbuf = val * 2;
> 	break;
> 
> SOCK_MIN_RCVBUF is defined as (2048 + sizeof(struct sk_buff)) which is 2240.
> ---
>  testcases/network/sctp/func_tests/test_1_to_1_sockopt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thank you. Please add your Signed-off-by next time as Jan pointed out.

Wanlong Gao


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
