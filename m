Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1MHDep-0005yL-VH
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 09:11:43 +0000
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121])
	by 3b2kzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHDeo-0006k3-16
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 09:11:43 +0000
Message-ID: <4A3A049B.2000002@st.com>
Date: Thu, 18 Jun 2009 11:10:51 +0200
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
References: <f5a7b3810906171317j40473a95y5dfc1b89d9e25950@mail.gmail.com>
In-Reply-To: <f5a7b3810906171317j40473a95y5dfc1b89d9e25950@mail.gmail.com>
Subject: Re: [LTP] [FIX HTML PATCH] ltp-genhtml
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

Hi,

I'm not sure about your patch.

I've introduced the usage of such env variables to support cross-build 
of LTP.

In fact, in case the results of LTP session was related to 
cross-execution, the infiormation about KERNEL_VERSION and 
MACHINE_ARCHITECTURE have to be referred to the target and not to the 
host. Do you agree ?

With your fix, by using "uname -r" and "uname -m", to avoid to report 
wrong information, you have to run the "genhtml.pl" script over the 
target system because if you run the genhtml.pl on the host, you will 
get wrong information about the kernel version and machine architecture.

Moreover, the assumption to run genhtml.pl over the target is not safe 
as often the target systems are embedded systems which do not support PERL.

With the fix I've proposed and accepted, the LTP-user by means of the 
simple env variables, can define the right information to be reported on 
the LTP results table about kernel version and machine architecture.

Now, by taking into account what above mentioned, I've to suggest  to do 
not apply your proposal patch.

Best Regards,
Francesco

naresh kamboju wrote:

>Hi,
>
>I have noticed following issue and fixed.
>1.   Kernel Version
>2.   Machine Architecture.
>
>Please find the patch below and as attachment.
>
>Best regards
>Naresh Kamboju
>
>Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>
>diff -Naurb a/tools/genhtml.pl b/tools/genhtml.pl
>--- a/tools/genhtml.pl	2009-04-02 12:07:28.000000000 +0530
>+++ b/tools/genhtml.pl	2009-06-18 00:33:46.000000000 +0530
>@@ -246,8 +246,12 @@
> print "<tr><td><strong>Total Test TWARN</strong></td><td><strong>
>$warn_test_counter </strong></td></tr>\n";
> print "<tr><td><strong>Total Test TRETR</strong></td><td><strong>
>$retr_test_counter </strong></td></tr>\n";
> print "<tr><td><strong>Total Test TCONF</strong></td><td><strong>
>$conf_test_counter </strong></td></tr>\n";
>-print "<tr><td><strong>Kernel Version</strong></td><td><strong>
>$ENV{KERNEL_VERSION}  </strong></td></tr>\n";
>-print "<tr><td><strong>Machine Architecture</strong></td><td><strong>
>$ENV{MACHINE_ARCH} </strong></td></tr>\n";
>+print "<tr><td><strong>Kernel_Version</strong>  </td> <td><strong>";
>+$kernel_version=system("uname -r");             chop($kernel_version);
>+print " $kernel_version </strong></td></tr>\n";
>+print "<tr><td><strong>Machine_Arch</strong>  </td> <td><strong>";
>+$machine_arch=system("uname -m");             chop($machine_arch);
>+print " $machine_arch </strong></td></tr>\n";
> print "<tr><td><strong>Hostname</strong>  </td> <td><strong>";
> $hostname=system("uname -n");             chop($hostname);
> print " $hostname </strong></td></tr></tbody></table></div></body></html>\n";
>  
>


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
