Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z1E3W-0000D8-8G
	for ltp-list@lists.sourceforge.net; Sat, 06 Jun 2015 13:22:34 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z1E3V-0003ok-C1
	for ltp-list@lists.sourceforge.net; Sat, 06 Jun 2015 13:22:34 +0000
Message-ID: <5572F400.4050504@oracle.com>
Date: Sat, 06 Jun 2015 16:22:08 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <20150428172442.GB25152@rei>	<1433247689-3984-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1433247689-3984-3-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1433247689-3984-3-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/6] lib6/asapi_04.c: Cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

On 02.06.2015 15:21, Zeng Linggang wrote:
> -		for (word = 0; word < 4; ++word)
> -			for (bit = 0; bit < 32; ++bit) {
> -				uint32_t newbit = 1 << bit;
> +	for (word = 0; word < 4; ++word)
> +		for (bit = 0; bit < 32; ++bit) {
> +			uint32_t newbit = 1 << bit;

1 is int here, please change it to unsigned int as follows:

uint32_t newbit = 1U << bit;


>   
> -void *ilistener(void *arg)
> +static void *ilistener(void *arg __attribute__ ((unused)))

LTP has a macro for it, a sort of LTP_ATTR_UNUSED

> -#define MAX(a, b) ((a) >= (b) ? (a) : (b))
> +# define MAX(a, b) ((a) >= (b) ? (a) : (b))

It seems it is not common for LTP coding style to use space there.

> -
>   int TST_TOTAL = PTCOUNT + CSCOUNT;

May be move it closer to CSCOUNT?

Best regards,
Alexey

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
