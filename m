Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7WJ-0003Zd-Rv
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:02:47 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7WA-00008b-Rs
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:02:42 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEpl6k017337
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:51:48 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NF2VfV229926
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:02:31 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF2V1Q016710
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:02:31 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220118.n5M1I1Hp029590@e33.co.us.ibm.com>
References: <200906220118.n5M1I1Hp029590@e33.co.us.ibm.com>
Date: Tue, 23 Jun 2009 20:19:31 +0530
Message-Id: <1245768571.4860.71.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add test environment variables (TCID et al.)
	to	tpm_version_tests.sh
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

On Tue, 2009-06-09 at 00:14 +0200, Jiri Palecek > wrote: 
> Hello,
> 
> this patch adds variables needed for tst_* routines into the tpm_version_tests.sh
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  .../tpm-tools/tpm/tpm_version/tpm_version_tests.sh |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh b/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh
> index 0fb54cd..dd2e5b9 100755
> --- a/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh
> +++ b/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh
> @@ -17,6 +17,10 @@
>  # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>  #
> 
> +export TCID=tpm_version
> +export TST_TOTAL=1
> +export TST_COUNT=1
> +
>  setup()
>  {
>  	RC=0				# Return code from commands.


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
