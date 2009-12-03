Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NGDNG-0006fH-MB
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:42 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGDNA-00056R-MT
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:42 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB3F7UkA026923
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:07:30 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB3FDTjV107988
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:13:29 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB3FDSb0027100
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:13:28 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200912012353.nB1NrDT9015407@e6.ny.us.ibm.com>
References: <200912012353.nB1NrDT9015407@e6.ny.us.ibm.com>
Date: Thu, 03 Dec 2009 20:42:57 +0530
Message-Id: <1259853182.5085.45.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH][resend] Fix a wrong (reversed) success
	condition	in echo01
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

On Wed, 2009-12-02 at 00:43 +0100, Jiri Palecek wrote: 
> Hello,
> 
> This patch reverses the success check in echo01, obviously the checksums being equal is the right outcome.
> 
> This is the version with the changes Mike Frysinger requested.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/network/tcp_cmds/echo/echo01 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/echo/echo01 b/testcases/network/tcp_cmds/echo/echo01
> index eb798ae..2bc4621 100755
> --- a/testcases/network/tcp_cmds/echo/echo01
> +++ b/testcases/network/tcp_cmds/echo/echo01
> @@ -95,7 +95,7 @@ do_test()
>          while [ $NUM -lt $NUMPROCESSES ]
>          do
>              csum2=$(sum "$TCtmp/${ECHOFILE}${NUM}" | awk '{print $1}')
> -            if [ "$csum1" = "$csum2" ]; then
> +            if [ "$csum1" != "$csum2" ]; then
>                  end_testcase "Checksums differ in loop $TST_COUNT"
>              fi
>              NUM=$(( $NUM + 1 ))


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
