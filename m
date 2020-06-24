From: Michal Simek <michal.simek@xilinx.com>
Date: Wed, 24 Jun 2020 10:41:11 +0200
Subject: [LTP] [Automated-testing] [PATCH 1/2] tst_test: Add support for
 device discovery
In-Reply-To: <20200623112827.10744-2-chrubis@suse.cz>
References: <20200623112827.10744-1-chrubis@suse.cz>
 <20200623112827.10744-2-chrubis@suse.cz>
Message-ID: <574e52f4-8988-a562-57c5-274a86e6e8cb@xilinx.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 23. 06. 20 13:28, Cyril Hrubis via lists.yoctoproject.org wrote:
> Device discovery
> ----------------
> 
> The problem
> -----------
> 
> Each lab has a different hardware capabilities and configuration. A test
> that heavily depends on a hardware needs to get this information in
> order to be able to run correctly.
> 
> The solution
> ------------
> 
> The test declares which devices it needs for a testing. In the uart test
> these are UART_RX and UART_TX which are two UART endpoints which are
> connected together.
> 
> This information is then passed as a parameter to a device-discovery.sh
> script that prints, possibly several lines, of device listrs, which is
> then parsed by the test library and the test is executed accordingly.
> 
> The data are passed to the test as a environment variables, if these are
> set prior to the test start, we do not even attempt to do a device
> discovery. If these are unset, we run the device discovery and loop the
> test around the lists we got.
> 
> Why this solution?
> ------------------
> 
> The device discovery is lab specific and does not belong to the test
> itself. This is an attempt to abstract the interface between the test
> and the hardware so that we can finally add device drivers tests into
> LTP.
> 
> Missing pieces
> --------------
> 
> There are stil a few missing pieces, but these are probably easy to fix

still

> as well.
> 
> Device reconfiguration
> ~~~~~~~~~~~~~~~~~~~~~~
> 
> I suppose that we may need to run a command so that the devices are
> reconfigured as we need them. I.e. the device-discovery.sh will have to
> output a comand that needs to be executed in order to prepare the

command

> physical environment e.g. relays in case of the UART.
> 
> Device parameters
> ~~~~~~~~~~~~~~~~~
> 
> We may as well need some extra info about the devices, e.g. is hardware
> flow connected in case of UART. So the device-discover.sh will add one

device-discovery.sh

> more environment variable e.g. UART_PARS="hwflow" that could be parsed
> in the test as well.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  device-discovery.sh |   5 +
>  include/tst_test.h  |   3 +
>  lib/tst_devices.c   | 228 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/tst_devices.h   |  32 +++++++
>  lib/tst_test.c      |  60 ++++++++++--
>  5 files changed, 321 insertions(+), 7 deletions(-)
>  create mode 100755 device-discovery.sh
>  create mode 100644 lib/tst_devices.c
>  create mode 100644 lib/tst_devices.h
> 
> diff --git a/device-discovery.sh b/device-discovery.sh
> new file mode 100755
> index 000000000..08460c41f
> --- /dev/null
> +++ b/device-discovery.sh
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +
> +if [ "$1" = "UART_RX-UART_TX" ]; then

I am not getting this condition and what exactly you want to tell by that.
> +	echo "UART_RX=/dev/ttyUSB0 UART_TX=/dev/ttyUSB0"

In fpga world you can connect two uart inside chip and test different
device drivers that's why at the end of day only user knows which uarts
are connected to each other and none will be able to come up with
universal device-deiscovery.sh script to cover all these cases.

Not exactly sure how LTP handles this in general but I think it makes
sense to extend your test (txt_test) parameters to pass TX/RX channel
via parameters directly to test.

Something like this
uart01_115200 uart01 -b 115200 -t /dev/ttyXX0 -r /dev/ttyXX1

IIRC RX and TX device could be the same which can mean that you want to
use internal or external loopbacks.

Thanks,
Michal
