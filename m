Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UsP7M-0005dX-JP
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 03:13:00 +0000
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UsP7K-0004F4-9G
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 03:13:00 +0000
Received: by mail-pb0-f46.google.com with SMTP id rq2so1729815pbb.33
	for <ltp-list@lists.sourceforge.net>;
	Thu, 27 Jun 2013 20:12:50 -0700 (PDT)
Message-ID: <51CCFF42.6060703@casparzhang.com>
Date: Fri, 28 Jun 2013 11:13:06 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1372142262-4654-1-git-send-email-liuhangbin@gmail.com>
In-Reply-To: <1372142262-4654-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] testscripts/networkstress.sh: update for two
 interfaces support
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 06/25/2013 02:37 PM, Hangbin Liu wrote:
> As some networking tests need two interfaces at the same time. Use grep -P to
> get two interfaces' mac addresses.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   testscripts/networkstress.sh | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh
> index b40af72..499b40c 100755
> --- a/testscripts/networkstress.sh
> +++ b/testscripts/networkstress.sh
> @@ -15,6 +15,8 @@ fi
>   export TMPDIR=/tmp/netst-$$
>   mkdir $TMPDIR
>   VERBOSE="no"
> +# Default interface is "eth0".
> +# For some test cases that need two interfaces, give parameter like "eth0|eth1"
>   INTERFACE="eth0"
>
>   #===========================================================================
> @@ -71,6 +73,7 @@ usage () {
>       echo " -W|w: Run whole network stress tests"
>       echo " -D|d: Test duration (default ${NS_DURATION} sec)"
>       echo " -N|n: Select the network interface (default: $INTERFACE)"
> +    echo "       Two interfaces' format: \"eth0|eth1\""
>       echo " -V|v: Enable verbose"
>       echo " -H|h: This Usage"
>       echo ""
> @@ -102,7 +105,7 @@ if [ -z ${TEST_CASE} ]; then
>   	usage
>   fi
>
> -export LHOST_HWADDRS=`ifconfig | grep ${INTERFACE} | grep HWaddr |awk '{print $5}'`
> +export LHOST_HWADDRS=`ifconfig | grep -P ${INTERFACE} | grep HWaddr |awk '{print $5}'`


As my understanding, the INTERFACE & LHOST_HWADDRS variables only used 
for verbose printing, right?

If yes, I'll give my ack here.

BTW, I'd to add quotations around ${INTERFACE}, to make sure 100% safety.

Caspar.

>
>   if [ -z ${RHOST} ]; then
>   	## Just a silly check
>


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
