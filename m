Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NGDNb-0005QR-IP
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:14:03 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGDNW-0005u6-Rl
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:14:03 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB3F9C7K028628
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:09:12 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB3FDqFY063372
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:13:52 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB3FDVFr017958
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:13:31 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200912012304.nB1N4Q0m004817@e1.ny.us.ibm.com>
References: <200912012304.nB1N4Q0m004817@e1.ny.us.ibm.com>
Date: Thu, 03 Dec 2009 20:42:48 +0530
Message-Id: <1259853173.5085.44.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Refer to checkforlibcap.sh by its real name
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

On Wed, 2009-12-02 at 00:01 +0100, Jiri Palecek wrote: 
> Hello,
> 
> checkforlibcap doesn't exist, the script's proper name is checkforlibcap.sh.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/security/filecaps/filecapstest.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testcases/kernel/security/filecaps/filecapstest.sh
> index c95291a..149cbc1 100755
> --- a/testcases/kernel/security/filecaps/filecapstest.sh
> +++ b/testcases/kernel/security/filecaps/filecapstest.sh
> @@ -19,7 +19,7 @@
>  ##                                                                            ##
>  ################################################################################
> 
> -checkforlibcap
> +checkforlibcap.sh
>  ret=$?
>  if [ $ret -ne 0 ]; then
>  	echo "Filecaps 0 CONF : System doesn't support execution of the test"


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
