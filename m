Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Upevg-0006Vs-Q1
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 13:29:36 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Upevf-0006BT-Gr
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 13:29:36 +0000
Date: Thu, 20 Jun 2013 09:29:29 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1411057592.110807.1371734969213.JavaMail.root@redhat.com>
In-Reply-To: <1371731503-13164-1-git-send-email-alexey.kodanev@oracle.com>
References: <1371731503-13164-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v4] fw_load: new test of device firmware loading
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
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>, "Alexey Kodanev" <alexey.kodanev@oracle.com>
> Sent: Thursday, 20 June, 2013 2:31:43 PM
> Subject: [LTP] [PATCH v4] fw_load: new test of device firmware loading
> 
> This test checks the device firmware loading. Since Linux 3.7 it can be
> loaded
> directly (by-pass udev). The test consists of the two parts: userspace and
> kernelspace.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

Hi,

looks good to me. I ran it with 3.10-rc4 and 2.6.18 kernel, worked as expected.
This included:
[PATCH v3] configure: add configure checks to compile kernel modules
[PATCH] tst_module: create new library functions for kernel modules
[PATCH v4] fw_load: new test of device firmware loading

I have one small suggestion, likely not worthy of making v5 just for this.
We could apply it on top later:

--- testcases/kernel/firmware/fw_load_kernel/Makefile	2013-06-20 15:08:19.339046672 +0200
+++ /tmp/Makefile	2013-06-20 15:11:50.876602284 +0200
@@ -18,7 +18,9 @@
 
 ifneq ($(KERNELRELEASE),)
 
+ifdef CONFIG_FW_LOADER
 obj-m		:= $(MODULE).o
+endif
 
 else
 
@@ -26,7 +28,7 @@
 include $(top_srcdir)/include/mk/env_pre.mk
 
 MAKE_TARGETS	:= $(MODULE).ko
-$(MODULE).ko:
+$(MODULE).ko: fw_load.c
 	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
 	-mv $(MODULE).ko $(MODULE).ko~
 	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean

Regards,
Jan

> ---
>  runtest/syscalls                                   |    2 +
>  testcases/kernel/Makefile                          |    1 +
>  testcases/kernel/firmware/Makefile                 |   44 ++++
>  .../kernel/firmware/fw_load_kernel/.gitignore      |    1 +
>  testcases/kernel/firmware/fw_load_kernel/Makefile  |   37 ++++
>  testcases/kernel/firmware/fw_load_kernel/README    |   16 ++
>  testcases/kernel/firmware/fw_load_kernel/fw_load.c |  173 +++++++++++++++
>  testcases/kernel/firmware/fw_load_user/.gitignore  |    1 +
>  testcases/kernel/firmware/fw_load_user/Makefile    |   20 ++
>  testcases/kernel/firmware/fw_load_user/README      |   11 +
>  testcases/kernel/firmware/fw_load_user/fw_load.c   |  219
>  ++++++++++++++++++++
>  11 files changed, 525 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/firmware/Makefile
>  create mode 100644 testcases/kernel/firmware/fw_load_kernel/.gitignore
>  create mode 100644 testcases/kernel/firmware/fw_load_kernel/Makefile
>  create mode 100644 testcases/kernel/firmware/fw_load_kernel/README
>  create mode 100644 testcases/kernel/firmware/fw_load_kernel/fw_load.c
>  create mode 100644 testcases/kernel/firmware/fw_load_user/.gitignore
>  create mode 100644 testcases/kernel/firmware/fw_load_user/Makefile
>  create mode 100644 testcases/kernel/firmware/fw_load_user/README
>  create mode 100644 testcases/kernel/firmware/fw_load_user/fw_load.c
> 

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
