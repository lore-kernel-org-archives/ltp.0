Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Xdc1x-000272-Tc
	for ltp-list@lists.sourceforge.net; Mon, 13 Oct 2014 09:35:05 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xdc1u-0005cI-Ef
	for ltp-list@lists.sourceforge.net; Mon, 13 Oct 2014 09:35:05 +0000
Date: Mon, 13 Oct 2014 05:34:50 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <694293359.7837436.1413192890959.JavaMail.zimbra@redhat.com>
In-Reply-To: <1412754540.28284.11.camel@G08JYZSD130126.localdomain>
References: <1407402404.1347.29.camel@G08JYZSD130126>
	<179118855.6420138.1407923193096.JavaMail.zimbra@redhat.com>
	<1411718817.9511.9.camel@G08JYZSD130126>
	<237697509.31082624.1411735385050.JavaMail.zimbra@redhat.com>
	<1412754540.28284.11.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3] securebits: some cleanup
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Wednesday, 8 October, 2014 9:49:00 AM
> Subject: [PATCH v3] securebits: some cleanup
> 
> * Remove .sh and divide into three seperate tests.
> 
> * Check the header <linux/securebits.h>.
> 
> * Use tst_brkm instead of tst_exit() that follows tst_resm.
> 
> * Some cleanup
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

This version is no longer crashing for me.

Tested-by: Jan Stancek <jstancek@redhat.com>

> ---
>  runtest/securebits                                 |  4 +-
>  testcases/kernel/security/securebits/Makefile      |  9 ++--
>  .../kernel/security/securebits/check_keepcaps.c    | 57
>  +++++++++-------------
>  .../kernel/security/securebits/run_securebits.sh   | 20 --------
>  4 files changed, 30 insertions(+), 60 deletions(-)
>  delete mode 100644 testcases/kernel/security/securebits/run_securebits.sh
> 
> diff --git a/runtest/securebits b/runtest/securebits
> index d78a66f..64e6e0a 100644
> --- a/runtest/securebits
> +++ b/runtest/securebits
> @@ -1,2 +1,4 @@
>  #DESCRIPTION:securebits tests
> -Securebits	run_securebits.sh
> +check_keepcaps01 check_keepcaps 1
> +check_keepcaps02 check_keepcaps 2
> +check_keepcaps03 check_keepcaps 3
> diff --git a/testcases/kernel/security/securebits/Makefile
> b/testcases/kernel/security/securebits/Makefile
> index 51018d9..e379b7c 100644
> --- a/testcases/kernel/security/securebits/Makefile
> +++ b/testcases/kernel/security/securebits/Makefile
> @@ -4,7 +4,8 @@
>  ##
>  ##
>  ## This program is free software;  you can redistribute it and#or modify
>  ##
>  ## it under the terms of the GNU General Public License as published by
>  ##
> -## the Free Software Foundation; either version 2 of the License, or
> ## ## (at your option) any later version.
> ##
> +## the Free Software Foundation; either version 2 of the License, or
> ##
> +## (at your option) any later version.
> ##
>  ##
>  ##
>  ## This program is distributed in the hope that it will be useful, but
>  ##
>  ## WITHOUT ANY WARRANTY; without even the implied warranty of
>  MERCHANTABILITY ##
> @@ -12,8 +13,8 @@
>  ## for more details.
>  ##
>  ##
>  ##
>  ## You should have received a copy of the GNU General Public License
>  ##
> -## along with this program;  if not, write to the Free Software
> ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
> USA    ##
> +## along with this program;  if not, write to the Free Software Foundation,
> ##
> +## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> ##
>  ##
>  ##
>  ################################################################################
>  
> @@ -23,6 +24,4 @@ include $(top_srcdir)/include/mk/testcases.mk
>  
>  LDLIBS			+= $(CAP_LIBS)
>  
> -INSTALL_TARGETS		:= *.sh
> -
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/security/securebits/check_keepcaps.c
> b/testcases/kernel/security/securebits/check_keepcaps.c
> index 6e195c6..ce74715 100644
> --- a/testcases/kernel/security/securebits/check_keepcaps.c
> +++ b/testcases/kernel/security/securebits/check_keepcaps.c
> @@ -5,7 +5,6 @@
>  #include <sys/capability.h>
>  #endif
>  #include <sys/prctl.h>
> -#include <linux/securebits.h>
>  #include "usctest.h"
>  #include "test.h"
>  
> @@ -30,7 +29,9 @@
>  char *TCID = "keepcaps";
>  int TST_TOTAL = 1;
>  
> -#ifdef HAVE_LIBCAP
> +#if (HAVE_LINUX_SECUREBITS_H && HAVE_LIBCAP)
> +#include <linux/securebits.h>
> +
>  static int eff_caps_empty(cap_t c)
>  {
>  	int i, ret, empty = 1;
> @@ -75,10 +76,8 @@ static void do_setuid(int expect_privs)
>  	int have_privs;
>  
>  	ret = setuid(1000);
> -	if (ret) {
> -		tst_resm(TERRNO | TFAIL, "setuid failed");
> -		tst_exit();
> -	}
> +	if (ret)
> +		tst_brkm(TERRNO | TFAIL, NULL, "setuid failed");
>  
>  	have_privs = am_privileged();
>  	if (have_privs && expect_privs == EXPECT_PRIVS) {
> @@ -95,8 +94,7 @@ static void do_setuid(int expect_privs)
>  	}
>  
>  	/* have_privs && EXPECT_NOPRIVS */
> -	tst_resm(TFAIL, "expected to drop privs but did not");
> -	tst_exit();
> +	tst_brkm(TFAIL, NULL, "expected to drop privs but did not");
>  }
>  
>  int main(int argc, char *argv[])
> @@ -106,64 +104,55 @@ int main(int argc, char *argv[])
>  	tst_require_root(NULL);
>  
>  	ret = prctl(PR_GET_KEEPCAPS);
> -	if (ret) {
> -		tst_resm(TBROK, "keepcaps was already set?\n");
> -		tst_exit();
> -	}
> +	if (ret)
> +		tst_brkm(TBROK, NULL, "keepcaps was already set?\n");
> +
> +	if (argc < 2)
> +		tst_brkm(TBROK, NULL, "Usage: %s <tescase_num>", argv[0]);
>  
> -	if (argc < 2) {
> -		tst_resm(TBROK, "Usage: %s <tescase_num>", argv[0]);
> -		tst_exit();
> -	}
>  	whichtest = atoi(argv[1]);
> -	if (whichtest < 1 || whichtest > 3) {
> -		tst_resm(TFAIL, "Valid tests are 1-3\n");
> -		tst_exit();
> -	}
> +	if (whichtest < 1 || whichtest > 3)
> +		tst_brkm(TFAIL, NULL, "Valid tests are 1-3\n");
> +
>  	switch (whichtest) {
>  	case 1:
>  		do_setuid(EXPECT_NOPRIVS);	/* does not return */
>  	case 2:
>  		ret = prctl(PR_SET_KEEPCAPS, 1);
>  		if (ret == -1) {
> -			tst_resm(TFAIL | TERRNO, "PR_SET_KEEPCAPS failed\n");
> -			tst_exit();
> +			tst_brkm(TFAIL | TERRNO, NULL,
> +				 "PR_SET_KEEPCAPS failed\n");
>  		}
>  		ret = prctl(PR_GET_KEEPCAPS);
>  		if (!ret) {
> -			tst_resm(TFAIL | TERRNO,
> +			tst_brkm(TFAIL | TERRNO, NULL,
>  				 "PR_SET_KEEPCAPS did not set keepcaps\n");
> -			tst_exit();
>  		}
>  		do_setuid(EXPECT_PRIVS);	/* does not return */
>  	case 3:
>  		ret = prctl(PR_GET_SECUREBITS);
>  		ret = prctl(PR_SET_SECUREBITS, ret | SECBIT_KEEP_CAPS);
>  		if (ret == -1) {
> -			tst_resm(TFAIL | TERRNO, "PR_SET_SECUREBITS failed\n");
> -			tst_exit();
> +			tst_brkm(TFAIL | TERRNO, NULL,
> +				 "PR_SET_SECUREBITS failed\n");
>  		}
>  		ret = prctl(PR_GET_KEEPCAPS);
>  		if (!ret) {
> -			tst_resm(TFAIL | TERRNO,
> +			tst_brkm(TFAIL | TERRNO, NULL,
>  				 "PR_SET_SECUREBITS did not set keepcaps\n");
> -			tst_exit();
>  		}
>  		do_setuid(EXPECT_PRIVS);	/* does not return */
>  	default:
> -		tst_resm(TFAIL, "should not reach here\n");
> -		tst_exit();
> +		tst_brkm(TFAIL, NULL, "Valid tests are 1-3\n");
>  	}
> -	tst_resm(TFAIL, "should not reach here\n");
> -	tst_exit();
> +	tst_brkm(TFAIL, NULL, "should not reach here\n");
>  }
>  
>  #else
>  
>  int main(void)
>  {
> -	tst_resm(TCONF, "Test was compiled without libcap.");
> -	tst_exit();
> +	tst_brkm(TCONF, NULL, "linux/securebits.h or libcap is not existence.");
>  }
>  
>  #endif /* HAVE_LIBCAP */
> diff --git a/testcases/kernel/security/securebits/run_securebits.sh
> b/testcases/kernel/security/securebits/run_securebits.sh
> deleted file mode 100644
> index 4d9e272..0000000
> --- a/testcases/kernel/security/securebits/run_securebits.sh
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -#!/bin/sh
> -
> -echo "testing keepcaps"
> -check_keepcaps 1
> -tmp=$?
> -if [ $tmp -ne 0 ]; then
> -	exit_code=$tmp
> -fi
> -check_keepcaps 2
> -tmp=$?
> -if [ $tmp -ne 0 ]; then
> -	exit_code=$tmp
> -fi
> -check_keepcaps 3
> -tmp=$?
> -if [ $tmp -ne 0 ]; then
> -	exit_code=$tmp
> -fi
> -
> -exit $exit_code
> --
> 1.9.3
> 
> 
> 
> 

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
