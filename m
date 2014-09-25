Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XX5qn-0001HR-8D
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 10:00:37 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XX5ql-00054d-Ip
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 10:00:37 +0000
Message-ID: <1411639209.24531.6.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 25 Sep 2014 18:00:09 +0800
In-Reply-To: <179118855.6420138.1407923193096.JavaMail.zimbra@redhat.com>
References: <1407402404.1347.29.camel@G08JYZSD130126>
	<179118855.6420138.1407923193096.JavaMail.zimbra@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi,
On Wed, 2014-08-13 at 05:46 -0400, Jan Stancek wrote:
> 
> ----- Original Message -----
> > From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> > To: "ltp-list" <ltp-list@lists.sourceforge.net>
> > Sent: Thursday, 7 August, 2014 11:06:44 AM
> > Subject: [LTP] [PATCH] securebits: some cleanup
> > 
> > * Add Copyright for run_securebits.sh
> > 
> > * Use test.sh for run_securebits.sh
> > 
> > * Somecleanup for Makefile
> > 
> > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> > ---
> >  testcases/kernel/security/securebits/Makefile      |  7 +--
> >  .../kernel/security/securebits/run_securebits.sh   | 51
> >  +++++++++++++++-------
> >  2 files changed, 39 insertions(+), 19 deletions(-)
> 
> Hi,
> 
> Can we list these testcases directly in runtest/securebits
> and remove the .sh script which bundles all together?
> 

I am very sorry to reply you so later.
I almost missed this email until I repeat browse tagged mails.
OK, I will do that.
And, thank you very much.

Best regards,
Zeng

> Regards,
> Jan
> 
> > 
> > diff --git a/testcases/kernel/security/securebits/Makefile
> > b/testcases/kernel/security/securebits/Makefile
> > index 51018d9..47271c9 100644
> > --- a/testcases/kernel/security/securebits/Makefile
> > +++ b/testcases/kernel/security/securebits/Makefile
> > @@ -4,7 +4,8 @@
> >  ##
> >  ##
> >  ## This program is free software;  you can redistribute it and#or modify
> >  ##
> >  ## it under the terms of the GNU General Public License as published by
> >  ##
> > -## the Free Software Foundation; either version 2 of the License, or
> > ## ## (at your option) any later version.
> > ##
> > +## the Free Software Foundation; either version 2 of the License, or
> > ##
> > +## (at your option) any later version.
> > ##
> >  ##
> >  ##
> >  ## This program is distributed in the hope that it will be useful, but
> >  ##
> >  ## WITHOUT ANY WARRANTY; without even the implied warranty of
> >  MERCHANTABILITY ##
> > @@ -12,8 +13,8 @@
> >  ## for more details.
> >  ##
> >  ##
> >  ##
> >  ## You should have received a copy of the GNU General Public License
> >  ##
> > -## along with this program;  if not, write to the Free Software
> > ##
> > -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
> > USA    ##
> > +## along with this program;  if not, write to the Free Software Foundation,
> > ##
> > +## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> > ##
> >  ##
> >  ##
> >  ################################################################################
> >  
> > diff --git a/testcases/kernel/security/securebits/run_securebits.sh
> > b/testcases/kernel/security/securebits/run_securebits.sh
> > index 4d9e272..c3a301c 100644
> > --- a/testcases/kernel/security/securebits/run_securebits.sh
> > +++ b/testcases/kernel/security/securebits/run_securebits.sh
> > @@ -1,20 +1,39 @@
> >  #!/bin/sh
> > +################################################################################
> > +##
> > ##
> > +##  Copyright (c) Linux Test Project, 2014
> > ##
> > +##
> > ##
> > +##  This program is free software; you can redistribute it and/or modify
> > ##
> > +##  it under the terms of the GNU General Public License as published by
> > ##
> > +##  the Free Software Foundation; either version 2 of the License, or
> > ##
> > +##  (at your option) any later version.
> > ##
> > +##
> > ##
> > +##  This program is distributed in the hope that it will be useful,
> > ##
> > +##  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > ##
> > +##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > ##
> > +##  GNU Library General Public License for more details.
> > ##
> > +##
> > ##
> > +################################################################################
> >  
> > -echo "testing keepcaps"
> > -check_keepcaps 1
> > -tmp=$?
> > -if [ $tmp -ne 0 ]; then
> > -	exit_code=$tmp
> > -fi
> > -check_keepcaps 2
> > -tmp=$?
> > -if [ $tmp -ne 0 ]; then
> > -	exit_code=$tmp
> > -fi
> > -check_keepcaps 3
> > -tmp=$?
> > -if [ $tmp -ne 0 ]; then
> > -	exit_code=$tmp
> > +TCID="keepcaps"
> > +TST_TOTAL=1
> > +
> > +. test.sh
> > +
> > +exit_code=0
> > +for i in 1 2 3
> > +do
> > +	check_keepcaps $i
> > +	ret=$?
> > +	if [ $ret -ne 0 ]; then
> > +		exit_code=$ret
> > +	fi
> > +done
> > +
> > +if [ $exit_code -ne 0 ]; then
> > +	tst_resm TFAIL "Test $TCID FAIL"
> > +else
> > +	tst_resm TPASS "Test $TCID PASS"
> >  fi
> >  
> > -exit $exit_code
> > +tst_exit
> > --
> > 1.9.3
> > 
> > 
> > 
> > 
> > ------------------------------------------------------------------------------
> > Infragistics Professional
> > Build stunning WinForms apps today!
> > Reboot your WinForms applications with our WinForms controls.
> > Build a bridge from your legacy apps to the future.
> > http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 



------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
