Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VdFMS-0005D1-4d
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 08:18:12 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdFMP-00029I-Ns
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 08:18:11 +0000
Date: Mon, 4 Nov 2013 03:18:03 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1568770588.18698492.1383553083237.JavaMail.root@redhat.com>
In-Reply-To: <1383542895-14069-1-git-send-email-xu.simon@oracle.com>
References: <1383542895-14069-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] sctp: enlarge SO_RCVBUF option value
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



----- Original Message -----
> From: "Simon Xu" <xu.simon@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 4 November, 2013 6:28:15 AM
> Subject: [LTP] [PATCH] sctp: enlarge SO_RCVBUF option value
> 
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

You are missing 'Signed-off-by', but patch looks good to me.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Regards,
Jan

>  testcases/network/sctp/func_tests/test_1_to_1_sockopt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/sctp/func_tests/test_1_to_1_sockopt.c
> b/testcases/network/sctp/func_tests/test_1_to_1_sockopt.c
> index b12313b..c36f502 100644
> --- a/testcases/network/sctp/func_tests/test_1_to_1_sockopt.c
> +++ b/testcases/network/sctp/func_tests/test_1_to_1_sockopt.c
> @@ -299,9 +299,9 @@ int main(void)
>  	tst_resm(TPASS, "getsockopt() SCTP_STATUS - SUCCESS");
>  
>  	/* Reducing the SO_RCVBUF value using setsockopt() */
> -	/*Minimum value is 128 and hence I am using it */
>  	len = sizeof(int);
> -	rcvbuf_val_set = 128;
> +	/* (rcvbuf len)*2 should be no less than SOCK_MIN_RCVBUF in kernel */
> +	rcvbuf_val_set = 1500;
>  	/* TEST16: Test case for setsockopt SO_RCVBUF */
>  	error = setsockopt(sk2, SOL_SOCKET, SO_RCVBUF, &rcvbuf_val_set, len);
>  	if (error < 0)
> --
> 1.8.1.2
> 
> 
> ------------------------------------------------------------------------------
> Android is increasing in popularity, but the open development platform that
> developers love is also attractive to malware creators. Download this white
> paper to learn more about secure code signing practices that can help keep
> Android apps secure.
> http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

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
