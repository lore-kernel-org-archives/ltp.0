Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WO5IP-0002xe-Tt
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 13:03:37 +0000
Date: Thu, 13 Mar 2014 14:03:19 +0100
From: chrubis@suse.cz
Message-ID: <20140313130319.GB31515@rei.suse.cz>
References: <1394707260-20121-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394707260-20121-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2] device-drivers/rcu: add wrapper script for
 rcutorture test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> One of the possible ways to test RCU is to use rcutorture kernel module.
> The test requires that kernel configured with CONFIG_RCU_TORTURE_TEST.
> It runs rcutorture module using particular options and then inspects
> dmesg output for module's test results.
> For more information, please read Linux Documentation: RCU/torture.txt
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> v2: Make use of new LTP shell library
>     Parse dmesg output with sed
> 
>  runtest/kernel_misc                                |    1 +
>  testcases/kernel/device-drivers/rcu/Makefile       |   22 ++++
>  testcases/kernel/device-drivers/rcu/rcu_torture.sh |  105 ++++++++++++++++++++
>  3 files changed, 128 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/device-drivers/rcu/Makefile
>  create mode 100755 testcases/kernel/device-drivers/rcu/rcu_torture.sh
> 
> diff --git a/runtest/kernel_misc b/runtest/kernel_misc
> index c1826fb..8f37cc6 100644
> --- a/runtest/kernel_misc
> +++ b/runtest/kernel_misc
> @@ -7,3 +7,4 @@ tbio tbio
>  ltp_acpi ltp_acpi
>  ltp_acpi_cpufreq ltp_acpi_cpufreq
>  uaccess uaccess
> +rcu_torture.sh rcu_torture.sh

I've changed this label from rcu_torture.sh to just rcu_torture and
pushed the patch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
