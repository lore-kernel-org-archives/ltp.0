Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SzLjM-0004Of-QH
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 05:56:24 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SzLjM-00005b-14
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 05:56:24 +0000
Received: by pbcwy7 with SMTP id wy7so312721pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 22:56:18 -0700 (PDT)
Message-ID: <502350F5.9030005@casparzhang.com>
Date: Thu, 09 Aug 2012 13:56:05 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1344490274-19671-1-git-send-email-penght@cn.fujitsu.com>
In-Reply-To: <1344490274-19671-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] syslog07: fix a bug of -o
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 08/09/2012 01:31 PM, Peng Haitao wrote:
> Add missing -o.
>
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>   testcases/kernel/syscalls/syslog/syslog07 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/syslog/syslog07 b/testcases/kernel/syscalls/syslog/syslog07
> index a477cce..0212efb 100755
> --- a/testcases/kernel/syscalls/syslog/syslog07
> +++ b/testcases/kernel/syscalls/syslog/syslog07
> @@ -116,7 +116,7 @@ syslog_case7()
>   	notice=$(( $notice_new - $notice_old ))
>   	info=$(( $info_new - $info_old ))
>
> -	if [ $emerg -ne 1 -o $alert -ne 1 -o $crit -ne 1 -o $err -ne 1 \
> +	if [ $emerg -ne 1 -o $alert -ne 1 -o $crit -ne 1 -o $err -ne 1 -o \
>   	     $warning -ne 1 -o $notice -ne 1 -o $info -ne 1 -o \
>   	     $info -ne 1 ]; then
>   		status_flag=1
>
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
