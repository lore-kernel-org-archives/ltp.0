Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VRjlU-0006jU-LG
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 14:20:28 +0000
Date: Thu, 3 Oct 2013 16:20:50 +0200
From: chrubis@suse.cz
Message-ID: <20131003142050.GB3862@rei.Home>
References: <1380705212-7200-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380705212-7200-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2] device-drivers: acpi: update for Linux kernel
 2.6.37+
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
> User-space program determines block device major number using sysfs.
> User-space program loads/unloads kernel module.
> acpi_get_object_info external interface updated.
> ACPI bit register access function renamed.
> acpi_bus_get_power() changed to acpi_bus_update_power()
> Added block device queue to fix NULL dereference.
> Added acpi functions return status checks.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/kernel/device-drivers/acpi/.gitignore    |    8 +
>  testcases/kernel/device-drivers/acpi/LtpAcpi.h     |    6 +-
>  testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c |  439 +++++++++-----------
>  testcases/kernel/device-drivers/acpi/LtpAcpiMain.c |  169 +++++---
>  testcases/kernel/device-drivers/acpi/Makefile      |   43 +-
>  testcases/kernel/device-drivers/acpi/ltpacpi.sh    |   54 ---
>  6 files changed, 337 insertions(+), 382 deletions(-)
>  create mode 100644 testcases/kernel/device-drivers/acpi/.gitignore
>  delete mode 100755 testcases/kernel/device-drivers/acpi/ltpacpi.sh

I've looked at the code closely and the whole point of the device driver
is the ioclt() handler that is used to start the tests. I guess that we
can rewrite it to use sysfs interface too.

Otherwise the code looks like it tries to poke some of the ACPI
structures that are expected to be there by the ACPI specification and
try to register some handlers and LTP test device. The \_SB is root of
the system bus, then it tries to execute initialization on the system
bus which, if I'm reading the ACPI specification (free downloadable ~500
pages pdf) is noop if device is allready initialized.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
