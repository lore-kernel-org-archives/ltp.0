Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z5xKW-0007gg-4O
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 14:31:40 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z5xKV-0005iH-6J
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 14:31:40 +0000
Message-ID: <55842886.4090202@oracle.com>
Date: Fri, 19 Jun 2015 17:34:46 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <5572ED1E.1020203@oracle.com>
	<1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/7] SAFE_MACROS: Add socket(), bind(), listen(),
 connect() and getsockname()
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
On 06/16/2015 03:24 PM, Zeng Linggang wrote:
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>   include/safe_macros.h | 29 ++++++++++++++++++
>   lib/safe_macros.c     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 112 insertions(+)

Good idea.

Please use separate file for socket safe macros, look at how 
safe_stdin.h made.
The name could be safe_sock.h, safe_net.h, etc.


> +
> +int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
> +	      int socket, const struct sockaddr *address,
> +	      socklen_t address_len)
> +{
> +	int rval;
> +
> +	rval = bind(socket, address, address_len);
> +
> +	if (rval < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +		         "%s:%d: bind(%d, %p, %d) failed", file, lineno, socket,
> +			 address, address_len);
> +	}
> +
> +	return rval;
> +}

bind() can return -1 if address is in use, e.g. it's in time_wait state.

Usually, you should wait (~30 sec or more, it depends on rtt) on it 
until socket address will be available. If timeout exceeded, only then I 
would exit with TBROK. Please check for errno 'EADDRINUSE'.

Thanks,
Alexey


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
