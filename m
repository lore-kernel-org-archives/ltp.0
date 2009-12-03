Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NGDMx-0008O3-9S
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:23 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGDMp-0002oT-EY
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:23 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB3F797w026628
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:07:09 -0500
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB3FD9rY041304
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:13:09 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB3FD1Us003454
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 08:13:01 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200912012241.nB1MfUOA010285@e6.ny.us.ibm.com>
References: <200912012241.nB1MfUOA010285@e6.ny.us.ibm.com>
Date: Thu, 03 Dec 2009 20:42:24 +0530
Message-Id: <1259853149.5085.41.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix a bug in awk code in rsh01
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

On Tue, 2009-12-01 at 23:32 +0100, Jiri Palecek wrote: 
> Hello,
> 
> this patch fixes the following problem with awk code in rsh01. It caused the test to fail.
> 
>  The END label is executed always, even in the event of
>  exit. Therefore, the "exit 1" statement was executed even when the
>  line matched (as a consequence of "exit 0") and awk always returned
>  1 (ie. failure).
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/network/tcp_cmds/rsh/rsh01 |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/rsh/rsh01 b/testcases/network/tcp_cmds/rsh/rsh01
> index e87a6a0..0a2b58f 100755
> --- a/testcases/network/tcp_cmds/rsh/rsh01
> +++ b/testcases/network/tcp_cmds/rsh/rsh01
> @@ -72,9 +72,9 @@ do_test()
>              # gcooper@orangebox ~ $ ls -l /etc/hosts         
>              # -rw-r--r-- 1 root root 463 Jul  5 09:26 /etc/hosts
>              #
> -            echo "$OUT" | \
> -                awk 'NF == 9 && $NF == "/etc/hosts" { exit 0 } END { exit 1 }' \
> -                >& /dev/null
> +            echo "$OUT" |
> +                awk 'BEGIN { RET=1 } NF == 9 && $NF == "/etc/hosts" { RET=0 } END { exit RET }' \
> +                > /dev/null 2>&1
> 
>              if [ $? -eq 0 ] ; then
>                  tst_resm TPASS "rsh to $RHOST test succeeded"


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
