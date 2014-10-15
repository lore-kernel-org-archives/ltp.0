Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XeMhq-0000R1-RU
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 11:25:26 +0000
Date: Wed, 15 Oct 2014 13:25:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141015112504.GA5006@rei.suse.cz>
References: <1407402404.1347.29.camel@G08JYZSD130126>
	<179118855.6420138.1407923193096.JavaMail.zimbra@redhat.com>
	<1411718817.9511.9.camel@G08JYZSD130126>
	<237697509.31082624.1411735385050.JavaMail.zimbra@redhat.com>
	<1412754540.28284.11.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412754540.28284.11.camel@G08JYZSD130126.localdomain>
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

Hi!
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
> diff --git a/testcases/kernel/security/securebits/Makefile b/testcases/kernel/security/securebits/Makefile
> index 51018d9..e379b7c 100644
> --- a/testcases/kernel/security/securebits/Makefile
> +++ b/testcases/kernel/security/securebits/Makefile
> @@ -4,7 +4,8 @@
>  ##                                                                            ##
>  ## This program is free software;  you can redistribute it and#or modify      ##
>  ## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ## ## (at your option) any later version.                                        ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
>  ##                                                                            ##
>  ## This program is distributed in the hope that it will be useful, but        ##
>  ## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> @@ -12,8 +13,8 @@
>  ## for more details.                                                          ##
>  ##                                                                            ##
>  ## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> +## along with this program;  if not, write to the Free Software Foundation,   ##
> +## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
>  ##                                                                            ##
>  ################################################################################
>  
> @@ -23,6 +24,4 @@ include $(top_srcdir)/include/mk/testcases.mk
>  
>  LDLIBS			+= $(CAP_LIBS)
>  
> -INSTALL_TARGETS		:= *.sh
> -
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/security/securebits/check_keepcaps.c b/testcases/kernel/security/securebits/check_keepcaps.c
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

I've removed this tst_brkm(TFAIL, NULL, "should not reach here\n")
entirely as well as the newlines from the strings passed to the tst_foo()
interfaces and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
