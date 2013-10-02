Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VRNCy-000885-Oq
	for ltp-list@lists.sourceforge.net; Wed, 02 Oct 2013 14:15:20 +0000
Date: Wed, 2 Oct 2013 16:15:37 +0200
From: chrubis@suse.cz
Message-ID: <20131002141537.GA727@rei.suse.cz>
References: <1380029829-8113-1-git-send-email-alexey.kodanev@oracle.com>
	<1380029829-8113-2-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380029829-8113-2-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] device-drivers: pci: fixes
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
> diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile b/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
> index 77c80ec..21972b8 100644
> --- a/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
> +++ b/testcases/kernel/device-drivers/pci/tpci_kernel/Makefile
> @@ -1,22 +1,27 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
>  #
> -# Makefile for GCOV profiling kernel module
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
>  #
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>  
> -#KERNELDIR := /usr/src/linux-2.5.64-gcov
> -CFLAGS := $(CFLAGS) -Wall
> -
> -ifneq ($(KERNELRELEASE),)
> +top_srcdir	?= ../../../../..
>  
> -obj-m	:= tpci.o
> -else
> -KDIR	:= /lib/modules/$(shell uname -r)/build
> -PWD	:= $(shell pwd)
> +include $(top_srcdir)/include/mk/env_pre.mk
>  
> -default:
> -	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> -#	$(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules
> -endif
> +REQ_VERSION_MAJOR	:= 2
> +REQ_VERSION_PATCH	:= 6
>  
> -clean:
> -	rm -f tpci.o 2>/dev/null || true
> +MODULE_NAMES	:= ltp_tpci
>  
> +include $(top_srcdir)/include/mk/module.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

Makefile needs to be updated.

> -	/*
> -	 * free inparms and outparms
> -	 */
> -	if (inparms) {
> -		kfree(inparms);
> -	}
> -	if (outparms) {
> -		kfree(outparms);
> +	if (pci_registered) {
> +		pci_unregister_driver(&ltp_pci_driver);
> +		pci_registered = 0;
>  	}
>  
> -	return rc;
> -}
> -
> -/*
> - * probe_pci_dev
> - * 	find a pci device that can be used for other test
> - * 	calls in this kernel module, select first device
> - * 	that finds for use, do not need a specific device
> - */
> -static int probe_pci_dev()
> -{
> -	unsigned int i, j;
> -	struct pci_dev *dev =
> -	    (struct pci_dev *)kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
> -	struct pci_bus *bus =
> -	    (struct pci_bus *)kmalloc(sizeof(struct pci_bus), GFP_KERNEL);
> +	/* Probe until find a pci device */
> +	for (i = last_bus; i < MAX_BUS; ++i) {
> +		for (j =  last_dev - 1; j >= 0; --j) {

Mutliple spaces before last_dev.

> +	err = device_register(&tdev);
> +	if (err) {
> +		prk_err("Unable to register device");
> +		return err;
> +	}
> +	prk_info("device registered");
>  
> -	rc = unregister_chrdev(Major, DEVICE_NAME);
> -	if (rc < 0)
> -		printk("tpci: unregister failed\n");
> -	else
> -		printk("tpci: unregister success\n");
> +	err = device_create_file(&tdev, &dev_attr_result);
> +	if (err) {
> +		prk_err("Can't create sysfs file 'result'");
> +		device_unregister(&tdev);
> +		return err;
> +	}
>  
> +	err = device_create_file(&tdev, &dev_attr_tcase);
> +	if (err) {
> +		prk_err(": Can't create sysfs file 'tc'");
> +		device_remove_file(&tdev, &dev_attr_result);
> +		device_unregister(&tdev);
> +	}
> +	return err;

We can simplify the error path by the goto err here as well.

> +	int i = 0, res = 1, pci_num = 0;
> +	while (1) {
>  
> -	/* test disable device */
> -	if (ki_generic(tpci_fd, PCI_DISABLE))
> -		printf
> -		    ("Failed to disable device \nMay still be in use by system\n");
> -	else
> -		printf("Disabled device\n");
> +		/* skip pci disable test-case, it is manual */
> +		if (i == PCI_DISABLE)
> +			++i;
>  
> -	/* test enable device */
> -	if (ki_generic(tpci_fd, PCI_ENABLE))
> -		printf("Failed to enable device\n");
> -	else
> -		printf("Enabled device\n");
> -
> -	/* test find from bus */
> -	if (ki_generic(tpci_fd, FIND_BUS))
> -		printf("Failed to find from bus pointer\n");
> -	else
> -		printf("Found device from bus pointer\n");
> -
> -	/* test find from device */
> -	if (ki_generic(tpci_fd, FIND_DEVICE))
> -		printf("Failed to find device from device info\n");
> -	else
> -		printf("Found device from device info\n");
> -
> -	/* test find from class */
> -	if (ki_generic(tpci_fd, FIND_CLASS))
> -		printf("Failed to find device from class\n");
> -	else
> -		printf("Found device from class \n");
> -
> -	/* test find subsys */
> -	if (ki_generic(tpci_fd, FIND_SUBSYS))
> -		printf("Failed to find device from subsys info\n");
> -	else
> -		printf("Found device from subsys info\n");
> -
> -	/* test scan bus */
> -	if (ki_generic(tpci_fd, BUS_SCAN))
> -		printf("Failed on bus scan call\n");
> -	else
> -		printf("Success scanning bus\n");
> -
> -	/* test scan slot */
> -	if (ki_generic(tpci_fd, SLOT_SCAN))
> -		printf("Failed on scan slot \n");
> -	else
> -		printf("Success scan slot\n");
> -
> -	/* test enable bridges */
> -	if (ki_generic(tpci_fd, ENABLE_BRIDGES))
> -		printf("Failed to enable bridges\n");
> -	else
> -		printf("Enabled bridges\n");
> -
> -	/* test bus add devices */
> -	if (ki_generic(tpci_fd, BUS_ADD_DEVICES))
> -		printf("Failed on bus add devices call\n");
> -	else
> -		printf("Success bus add devices\n");
> -
> -	/* test match device */
> -	if (ki_generic(tpci_fd, MATCH_DEVICE))
> -		printf("Failed on match device call\n");
> -	else
> -		printf("Success match device\n");
> -
> -#if 0
> -	/* test unregister driver */
> -	if (ki_generic(tpci_fd, UNREG_DRIVER))
> -		printf("Failed to unregister driver\n");
> -	else
> -		printf("Unregistered driver\n");
> -#endif
> -
> -	/* test register driver */
> -	if (ki_generic(tpci_fd, REG_DRIVER))
> -		printf("Failed to register driver\n");
> -	else
> -		printf("Registerd driver\n");
> -
> -	/* test pci resources */
> -	if (ki_generic(tpci_fd, PCI_RESOURCES))
> -		printf("Failed on pci_resources call\n");
> -	else
> -		printf("Success pci resources\n");
> +		if (i >= TST_TOTAL) {
> +			i = 0;
> +			++pci_num;
> +		}
>  
> -	/* test save state */
> -	if (ki_generic(tpci_fd, SAVE_STATE))
> -		printf("Failed to save state of device\n");
> -	else
> -		printf("Saved state of device\n");
> +		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
> +		SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
>  
> -	/* test restore state */
> -	if (ki_generic(tpci_fd, RESTORE_STATE))
> -		printf("Failed to restore state\n");
> -	else
> -		printf("Restored state\n");
> +		/* didn't find pci device, nothing to test */
> +		if (i == 0 && res) {
> +			tst_resm(res, "didn't find pci device");
> +			break;
> +		}
> +		tst_resm(res, "PCI %02d: Test-case '%d'", pci_num, i);
> +		++i;
> +	}
> +}

So the while cycle runs for all pci devices? How does this works?

It seems to run all tests then increment pci_device until test number
zero fails. This needs to cleaned up so that the codeflow is less
cryptic. Or at least deserves a comment what is done and why.

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
