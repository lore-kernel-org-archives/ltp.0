Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XqOsR-0001q4-20
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:10:07 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XqOsP-0005OR-Br
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:10:07 +0000
Message-ID: <546A103C.3050509@oracle.com>
Date: Mon, 17 Nov 2014 19:11:56 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1416189838.26092.1.camel@G08JYZSD130126.localdomain>
In-Reply-To: <1416189838.26092.1.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH] ltp_acpi_cpufreq.c: Fix compilation.
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>, ltp-list <ltp-list@lists.sourceforge.net>

Hi!
On 11/17/2014 06:03 AM, Zeng Linggang wrote:
> Fix compilation on missing 'CLOCK_MONOTONIC_RAW'.
>
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>   testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
> index 5b9c2a9..423188e 100644
> --- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
> +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
> @@ -33,6 +33,7 @@
>   
>   #include "test.h"
>   #include "usctest.h"
> +#include "lapi/posix_clocks.h"
>   #include "safe_macros.h"
>   #include "safe_stdio.h"
>   

Patch pushed, thank you!

Best regards,
Alexey


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
