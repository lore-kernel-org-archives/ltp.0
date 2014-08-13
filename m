Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XHV8l-0001tA-Ev
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 09:46:43 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHV8j-0006Sw-Mo
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 09:46:43 +0000
Date: Wed, 13 Aug 2014 05:46:33 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <179118855.6420138.1407923193096.JavaMail.zimbra@redhat.com>
In-Reply-To: <1407402404.1347.29.camel@G08JYZSD130126>
References: <1407402404.1347.29.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] securebits: some cleanup
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
> To: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Thursday, 7 August, 2014 11:06:44 AM
> Subject: [LTP] [PATCH] securebits: some cleanup
> 
> * Add Copyright for run_securebits.sh
> 
> * Use test.sh for run_securebits.sh
> 
> * Somecleanup for Makefile
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/security/securebits/Makefile      |  7 +--
>  .../kernel/security/securebits/run_securebits.sh   | 51
>  +++++++++++++++-------
>  2 files changed, 39 insertions(+), 19 deletions(-)

Hi,

Can we list these testcases directly in runtest/securebits
and remove the .sh script which bundles all together?

Regards,
Jan

> 
> diff --git a/testcases/kernel/security/securebits/Makefile
> b/testcases/kernel/security/securebits/Makefile
> index 51018d9..47271c9 100644
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
> diff --git a/testcases/kernel/security/securebits/run_securebits.sh
> b/testcases/kernel/security/securebits/run_securebits.sh
> index 4d9e272..c3a301c 100644
> --- a/testcases/kernel/security/securebits/run_securebits.sh
> +++ b/testcases/kernel/security/securebits/run_securebits.sh
> @@ -1,20 +1,39 @@
>  #!/bin/sh
> +################################################################################
> +##
> ##
> +##  Copyright (c) Linux Test Project, 2014
> ##
> +##
> ##
> +##  This program is free software; you can redistribute it and/or modify
> ##
> +##  it under the terms of the GNU General Public License as published by
> ##
> +##  the Free Software Foundation; either version 2 of the License, or
> ##
> +##  (at your option) any later version.
> ##
> +##
> ##
> +##  This program is distributed in the hope that it will be useful,
> ##
> +##  but WITHOUT ANY WARRANTY; without even the implied warranty of
> ##
> +##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> ##
> +##  GNU Library General Public License for more details.
> ##
> +##
> ##
> +################################################################################
>  
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
> +TCID="keepcaps"
> +TST_TOTAL=1
> +
> +. test.sh
> +
> +exit_code=0
> +for i in 1 2 3
> +do
> +	check_keepcaps $i
> +	ret=$?
> +	if [ $ret -ne 0 ]; then
> +		exit_code=$ret
> +	fi
> +done
> +
> +if [ $exit_code -ne 0 ]; then
> +	tst_resm TFAIL "Test $TCID FAIL"
> +else
> +	tst_resm TPASS "Test $TCID PASS"
>  fi
>  
> -exit $exit_code
> +tst_exit
> --
> 1.9.3
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Infragistics Professional
> Build stunning WinForms apps today!
> Reboot your WinForms applications with our WinForms controls.
> Build a bridge from your legacy apps to the future.
> http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
