Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Upg1C-0001JM-OV
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 14:39:22 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Upg1A-0001gS-M0
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 14:39:22 +0000
Message-ID: <51C313FB.4080809@oracle.com>
Date: Thu, 20 Jun 2013 18:38:51 +0400
From: alexey.kodanev@oracle.com
MIME-Version: 1.0
References: <1371731503-13164-1-git-send-email-alexey.kodanev@oracle.com>
	<1411057592.110807.1371734969213.JavaMail.root@redhat.com>
In-Reply-To: <1411057592.110807.1371734969213.JavaMail.root@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi!

On 06/20/2013 05:29 PM, Jan Stancek wrote:
>
> Hi,
>
> looks good to me. I ran it with 3.10-rc4 and 2.6.18 kernel, worked as expected.
> This included:
> [PATCH v3] configure: add configure checks to compile kernel modules
> [PATCH] tst_module: create new library functions for kernel modules
> [PATCH v4] fw_load: new test of device firmware loading
>
> I have one small suggestion, likely not worthy of making v5 just for this.
> We could apply it on top later:
>
> --- testcases/kernel/firmware/fw_load_kernel/Makefile	2013-06-20 15:08:19.339046672 +0200
> +++ /tmp/Makefile	2013-06-20 15:11:50.876602284 +0200
> @@ -18,7 +18,9 @@
>
>   ifneq ($(KERNELRELEASE),)
>
> +ifdef CONFIG_FW_LOADER
>   obj-m		:= $(MODULE).o
> +endif
>
I see, firmware loading/release functions works only with this config.
>   else
>
> @@ -26,7 +28,7 @@
>   include $(top_srcdir)/include/mk/env_pre.mk
>
>   MAKE_TARGETS	:= $(MODULE).ko
> -$(MODULE).ko:
> +$(MODULE).ko: fw_load.c
>   	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
>   	-mv $(MODULE).ko $(MODULE).ko~
>   	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean
>
OK

Thanks,
Alexey

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
