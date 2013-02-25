Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1U9rX6-0007dB-PZ
	for ltp-list@lists.sourceforge.net; Mon, 25 Feb 2013 06:27:28 +0000
Received: from mail-da0-f43.google.com ([209.85.210.43])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1U9rX3-000348-2e
	for ltp-list@lists.sourceforge.net; Mon, 25 Feb 2013 06:27:28 +0000
Received: by mail-da0-f43.google.com with SMTP id u36so201027dak.30
	for <ltp-list@lists.sourceforge.net>;
	Sun, 24 Feb 2013 22:26:57 -0800 (PST)
Message-ID: <512AFE56.2020006@casparzhang.com>
Date: Mon, 25 Feb 2013 14:01:58 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1349794116-5016-1-git-send-email-liuhangbin@gmail.com>
In-Reply-To: <1349794116-5016-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] testscripts: add appl test in networkstress.sh
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

On 10/09/2012 10:48 PM, Hangbin Liu wrote:
> We have network_stress.appl in runtest dir. But we didn't include this test in
> networkstress.sh. Add a new parameter to support appl test.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Comitted, thanks. Sorry for late respond.

Caspar

> ---
>   testscripts/networkstress.sh |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh
> index e04a143..68673f4 100755
> --- a/testscripts/networkstress.sh
> +++ b/testscripts/networkstress.sh
> @@ -59,6 +59,7 @@ usage () {
>       echo "---------------------------------------------------------"
>       echo -e "\033[31m $0 [options] \033[0m "
>       echo "---------------------------------------------------------"
> +    echo " -A|a: Stress test for appl"
>       echo " -E|e: Stress test for interface"
>       echo " -I|i: Stress test for ICMP protocol"
>       echo " -T|t: Stress test for TCP/IP"
> @@ -76,9 +77,10 @@ usage () {
>       exit 1
>   }
>
> -while getopts EeTtIiUuRrMmSsWwBbVvN:n:D:d: OPTION
> +while getopts AaEeTtIiUuRrMmSsWwBbVvN:n:D:d: OPTION
>   do
>       case $OPTION in
> +	A|a) TEST_CASE="network_stress.appl";;
>   	E|e) TEST_CASE="network_stress.interface";;
>   	B|b) TEST_CASE="network_stress.broken_ip";;
>   	I|i) TEST_CASE="network_stress.icmp";;
>


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
