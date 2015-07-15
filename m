Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZFOsi-00009N-7h
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2015 15:46:00 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZFOsh-0004KW-AR
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2015 15:46:00 +0000
Message-ID: <55A680FC.2010807@oracle.com>
Date: Wed, 15 Jul 2015 18:49:16 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <55842886.4090202@oracle.com>
	<1436411125-8012-1-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1436411125-8012-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4 01/11] SAFE_MACROS: Add socket(), bind(),
 listen(), connect() and getsockname()
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

Hi,
On 07/09/2015 06:05 AM, Zeng Linggang wrote:
> +int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
> +	      int socket, const struct sockaddr *address,
> +	      socklen_t address_len)
> +{
> +	int err, ret, i;
> +
> +	for (i = 0; i < 30; i++) {
> +		ret = bind(socket, address, address_len);
> +		err = errno;
> +
> +		if (!ret)
> +			return 0;
> +
> +		tst_resm(TINFO, "bind('%p') failed with %s, try %2i...",
> +			 address, tst_strerrno(err), i+1);
> +

I'd wait only if errno is EADDRINUSE; otherwise exit with TBROK 
immediately. And waiting for 3 seconds in the loop is too small, please 
increase the time.

The rest looks good.

Thanks,
Alexey

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
