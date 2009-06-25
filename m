Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJl0G-0000yb-W2
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:12:20 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJl07-0002VM-HN
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:12:15 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5P9BRvu008171
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 03:11:27 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5P9CAuF225238
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 03:12:10 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5P9CAAg028346
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 03:12:10 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906240117.n5O1H5O0007047@e2.ny.us.ibm.com>
References: <200906240117.n5O1H5O0007047@e2.ny.us.ibm.com>
Date: Thu, 25 Jun 2009 14:39:53 +0530
Message-Id: <1245920993.5542.35.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Use custom prompt in the telnet test,
	to avoid	timeouts in case the user's prompt doesn't contain hostname
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-06-10 at 13:05 +0200, Jiri Palecek > wrote: 
> Hello,
> 
> this patch makes the telnet test avoid timeouts when the remote users prompt doesn't contain hostname, or is somehow irregular. It works by explicitly setting the prompt in the remote shell (see the PROMPT variable). Note that setting literal value as a prompt works even when the remote shell is not bash (the classic bash placeholders do not).
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/network/tcp_cmds/telnet/telnet01 |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/telnet/telnet01 b/testcases/network/tcp_cmds/telnet/telnet01
> index a4b37d3..24cfd11 100755
> --- a/testcases/network/tcp_cmds/telnet/telnet01
> +++ b/testcases/network/tcp_cmds/telnet/telnet01
> @@ -41,6 +41,7 @@ set TC telnet
>  set TCtmp "/tmp"
>  set SLEEPTIME 3
>  set TESTLOG "$TCtmp"
> +set PROMPT "Alpha Bravo"
> 
>  if [info exists env(RUSER)] {
>     set RUSER $env(RUSER)
> @@ -83,20 +84,21 @@ while {$count < $LOOPCOUNT} {
>        # telnet to the host
>        spawn telnet $HOST
>        expect -re "login:"
> -      sleep 1
> +
>        send "$RUSER\r"
>        expect -re "Password:"
> -      sleep 1
> +
>        send "$PASSWD\r"
> 
> +      send "PS1=\"$PROMPT\"\r"
>        # Wait for shell prompt
> -      expect -re "$RUSER@" 
> +      expect "$PROMPT" 
> 
>        # Run passwd command - and respond to its prompts
>        send "LC_ALL=C ls -l /etc/hosts | wc -w > $TESTLOG/$RUSER.$HOST \r" 
>        # When shell prompt comes back, logout
> 
> -      expect -re "$RUSER@"
> +      expect "$PROMPT"
>        exp_send "logout\r"
> 
>        send_user "CHECKING TELNET STATUS\n"


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
