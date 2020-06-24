From: Michal Simek <michal.simek@xilinx.com>
Date: Wed, 24 Jun 2020 11:07:19 +0200
Subject: [LTP] [Automated-testing] [PATCH 2/2] device_drivers/uart01:
 Add uart01 test
In-Reply-To: <20200623112827.10744-3-chrubis@suse.cz>
References: <20200623112827.10744-1-chrubis@suse.cz>
 <20200623112827.10744-3-chrubis@suse.cz>
Message-ID: <4c402cbf-768a-9188-2877-d37168df662d@xilinx.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 23. 06. 20 13:28, Cyril Hrubis via lists.yoctoproject.org wrote:
> This is a first example for a device-driver test.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/kernel_misc                           |   5 +
>  .../kernel/device-drivers/uart/.gitignore     |   1 +
>  testcases/kernel/device-drivers/uart/Makefile |   4 +

I am missing uart folder wiring here.

diff --git a/testcases/kernel/device-drivers/Makefile
b/testcases/kernel/device-drivers/Makefile
index 55e0d25a0..522445b01 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -26,6 +26,7 @@ SUBDIRS               := acpi \
                   rcu \
                   rtc \
                   tbio \
+                  uart \
                   uaccess \
                   zram

M
