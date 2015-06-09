Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2FPm-0000Ip-3V
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:01:46 +0000
Date: Tue, 9 Jun 2015 11:00:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609090041.GA24041@rei.suse.de>
References: <481574461.737361433821252744.JavaMail.weblogic@epmlwas02a>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <481574461.737361433821252744.JavaMail.weblogic@epmlwas02a>
Subject: Re: [LTP] [PATCH]: Fix memory leak
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
To: Manjeet Pawar <manjeet.p@samsung.com>
Cc: AJEET YADAV <ajeet.y@samsung.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, AKHILESH KUMAR <akhilesh.k@samsung.com>

Hi!
> This patch make 'found' a static array to avoid memory leaks.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
> ---
>  utils/sctp/testlib/sctputil.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/sctp/testlib/sctputil.c b/utils/sctp/testlib/sctputil.c
> index c670af6..e7333e5 100644
> --- a/utils/sctp/testlib/sctputil.c
> +++ b/utils/sctp/testlib/sctputil.c
> @@ -370,8 +370,7 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
>  	struct sockaddr *sa_addr;
>  	socklen_t addrs_size = 0;
>  	void *addrbuf;
> -	char *found = (char *) malloc(count);
> -	memset(found, 0, count);
> +	char found[count];
>  
>  	error = sctp_getpaddrs(sk, asoc, &addrs);
>  	if (-1 == error) {

I've added initialization to 0 to the else branch down below, since we
removed the memset and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
