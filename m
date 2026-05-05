Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09761FF885A
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 03:46:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63ED13E6B43
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 05:46:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 412EE3E4991
 for <ltp@lists.linux.it>; Tue,  5 May 2026 05:46:14 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7263D100074A
 for <ltp@lists.linux.it>; Tue,  5 May 2026 05:46:13 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso41630835e9.2
 for <ltp@lists.linux.it>; Mon, 04 May 2026 20:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777952773; cv=none;
 d=google.com; s=arc-20240605;
 b=KAa9aGSo3bnpAuw+dlfQ+lxRuVr71tYuL2T89SefkcR+YogqWu6i6F8SG1NmrXpbeh
 3REhRLrXa7NC2Jh7E1mqQDPDiS4rsQ63NqOAa9I3qIzSjeIqKn1cBS5+j9jwhSPF21yT
 tmfaAGlxB5ZtumSK24pPqbp+b+quZLQTDjQxFJ+RqOqcFo0KYN8xSmCb61Y9JXme73y+
 2bfi+2bqDeeXs3UfpdXlajCGvnNshT61HxJAMA5oLC4dQ/9OVCMo1UrerEUnHjb0O+YD
 6MAGusAUR655NZPzDHGm8VaiYjpnrriPuQaq8+Pw4ojlgwqZsdrs4hXKS2itCXITWx/A
 dpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LXCx2E7cgsh/1EuqIh6UWzeMp9KhqPh5LYeTY3lJEzI=;
 fh=P1fGHTWhpORWWcTXSIE4Lw1m4G4uzN/G8kfeQYdDoJY=;
 b=L0dWugVTUA3LNf43bU54qX4K001qQswg61TGMEbw5L9h2oG+Je/4TJSuAeZvlBuN++
 97eK1DSZV71KjeO8dAGB+CJAQGmSST4fF1wCkhXiw906koMdOZ8i+9ee6QXzoqMyHLRH
 Kfzq/nb5DFmtunsZ4gmuAc80F1QTIrm3S6ueQM8UxF1FrAleHTY+otGXbkm6WrA9FDbI
 K0iRYhV4ROVC/19l7538jnA7FrjT/JCk3fQgMXi3hV8e8aGtz1NPLIyeO99WrBMKVwG4
 HOwC4n9N6p0c2kQFk9MqDXG2zpqABxJl+PyvD0yNA523uW/oOkhamoGLNXRmVCNafzx2
 cEmg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777952773; x=1778557573; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LXCx2E7cgsh/1EuqIh6UWzeMp9KhqPh5LYeTY3lJEzI=;
 b=rSP9kU1D3FTRiTVKTZDjxR5mP6mR32kd8vew2yp4G5U4SOh7cylUEmg+Y3pSHl55s7
 te4DYkJDVUmpmqlAIFT/YCrUkdul/n5B73pIZI4Wds2TDzY31uMWkiWhX1Gdbs4wLXqF
 VnecJizZFK5o5lGTNgTfNGnMoM0fBxVDCEJ2M790wT90c06Ru0VIjjhRa7vG8RTZRU+6
 9BKMjzh7jBIp80rdn7VunsQZZQgSElo4AIUK/zrkm1dKiii6/IDAb/UOUWVlhMOsl/BK
 anwZ21/uZZ+jc3whISdGXXlCGwWlenuzHPtGoxoXWcr8HJ0YTWb0Yn1oSUeH+Ys1OSvm
 gkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777952773; x=1778557573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXCx2E7cgsh/1EuqIh6UWzeMp9KhqPh5LYeTY3lJEzI=;
 b=PI2yHuNBD0mp1fuP41XYoD15NYyHf4uaA+nBJ0cdMXNS61M+bnJlzkGK/2ujqT0dqd
 sio17bGLVf90C02F5f+qcDG5VN2O0UAVUqMgOugzeXEETxuAwi6JXX6J8Lgpoo53I240
 9SkVzfrNBuzcMnG0OEHmeuqYL55Mg+RY81BZUfnMzpEScmPA9EyDlP6cl+qDeG443wCC
 ccnitYpnuVk/rrctfK5YnoId5RStcoIvRGtLEirLdIvOiQdhN0C7ZMG11+c5i6clM+bG
 bnyUlXNBuJdmUOeqP7S3Gu90HnU18gpJWVXxSr0JIc9JgyGSEdPVAFffzIbyjdBzbP73
 qsMA==
X-Gm-Message-State: AOJu0YzE/kto3CZjA7XGExIjSQxPIuwaWm9vbA8jLw0fUR1g1AHA+LU/
 ycwX4/bc3Fru+gIjbrkjoAlYhbBoiDP/92yiUMk1IY1g0h4Y/vH+DgvpZngQWt2kTC2ZcNoQVjN
 HQ4rN49VrqXLFOCLi/0sZEaiRnLMGy00=
X-Gm-Gg: AeBDiesNjLmRtDtvQs3VX1LFNTiRVcS+h6Q6TJf+Idb/EHRKyRoKDpY4VFEzDC10Ltt
 ykAoFCf9GOwOU8wWuaiDuWaeRKrG84ttkoMCPx1xfskzbRyGtZRZr1xnoURlvIfE6Sm9yW9h/Gi
 GGN2f1tg/GAUje7/jcJQVPZJte08OrzdP7cx5GpU9/4DG2BZeLZ3qFprHPLP7CRu6j4k/NYapmL
 sajAa2dUAO58CvvUZRfIOqtr0TU3INqAMhxTLClpLiEYNde4onSYsYJtPFIsmPPfOY7LpmfL42o
 qbmUHQyuPMyCh8kUwJelib7KuJptqVYbCd+pH9tES5CvgkmgDw==
X-Received: by 2002:a05:600c:4f91:b0:489:1ba8:5be9 with SMTP id
 5b1f17b1804b1-48a98676b26mr186997035e9.29.1777952772538; Mon, 04 May 2026
 20:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260428075302.7320ef7e3@imap1.dmz-prg2.suse.org>
 <20260501151420.1042995-1-priyama2@linux.ibm.com>
In-Reply-To: <20260501151420.1042995-1-priyama2@linux.ibm.com>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Tue, 5 May 2026 05:46:00 +0200
X-Gm-Features: AVHnY4LmoJj4mbhGJUm45uTPakLgnUkuDilVpy6rlL47vvkhuuwjkq4TNGs9TfI
Message-ID: <CAJCsO8epT++TaOs7=NAy+jC4pQDN9tA-1n_tFy233sHKkJ697w@mail.gmail.com>
To: priyama2@linux.ibm.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] testcases/kernel/device-drivers/nvme: Add NVMe
 device discovery test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: daniel.wagner@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Priyama,

Sorry for top-posting, but I have a broader question here.

First of all, thanks for working on this and for looking into NVMe coverage.

Before going further, could you please explain the intended LTP-specific
value of
this test? blktests already has a dedicated NVMe test group with much
broader
coverage, including controller/namespace discovery, NVMe commands, fabrics,
etc.:

https://github.com/linux-blktests/blktests/tree/master/tests/nvme

So I think we should be careful not to duplicate coverage unless there is a
clear
reason for having a small LTP-level smoke test as well. Maybe your
intention is
different? Could you please clarify?

Cheers,
Sebastian

On Thu, 30 Apr 2026 at 07:10, <priyama2@linux.ibm.com> wrote:

> From: priyama2 <priyama2@linux.ibm.com>
>
> This test fills a gap in NVMe test coverage by validating basic device
> enumeration and driver binding, which are fundamental prerequisites for
> any NVMe functionality testing.
>
> The test verifies:
> - Detection of NVMe controllers in /dev
> - Enumeration of namespaces for detected controllers
> - PCI enumeration (class code 0x010802)
> - NVMe driver binding
>
> Changes in v3:
> - Fix subject prefix to match directory path
> - Update copyright year to 2026
> - Add nvme to SUBDIRS in testcases/kernel/device-drivers/Makefile
> - Reset static variables at start of run() for -i support
> - Remove .needs_root (all operations are world-readable)
> - Use SAFE_FOPEN/SAFE_FCLOSE for PCI class file access
> - Use SAFE_READLINK for driver symlink reading
> - Add .gitignore entry for nvme01 binary
> - Add runtest/device-drivers entry for nvme01
> - Fix author field to use priyama2
>
> Changes in v2:
> - Use LTP buildsystem instead of standalone Makefile
> - Remove README file (use doc comments instead)
> - Add proper LTP documentation comment format
> - Use SAFE_OPENDIR() and SAFE_CLOSEDIR() macros
> - Remove obvious and redundant comments
> - Code cleanup and style improvements
>
> Signed-off-by: priyama2 <priyama2@linux.ibm.com>
> ---
>  runtest/device-drivers                        |   1 +
>  testcases/kernel/device-drivers/Makefile      |   1 +
>  .../kernel/device-drivers/nvme/.gitignore     |   1 +
>  testcases/kernel/device-drivers/nvme/Makefile |   7 +
>  testcases/kernel/device-drivers/nvme/nvme01.c | 205 ++++++++++++++++++
>  5 files changed, 215 insertions(+)
>  create mode 100644 runtest/device-drivers
>  create mode 100644 testcases/kernel/device-drivers/nvme/.gitignore
>  create mode 100644 testcases/kernel/device-drivers/nvme/Makefile
>  create mode 100644 testcases/kernel/device-drivers/nvme/nvme01.c
>
> diff --git a/runtest/device-drivers b/runtest/device-drivers
> new file mode 100644
> index 000000000..a7295584e
> --- /dev/null
> +++ b/runtest/device-drivers
> @@ -0,0 +1 @@
> +nvme01 nvme01
> diff --git a/testcases/kernel/device-drivers/Makefile
> b/testcases/kernel/device-drivers/Makefile
> index 229a50683..664f4cd18 100644
> --- a/testcases/kernel/device-drivers/Makefile
> +++ b/testcases/kernel/device-drivers/Makefile
> @@ -9,6 +9,7 @@ SUBDIRS         := acpi \
>                    block \
>                    cpufreq \
>                    locking \
> +                  nvme \
>                    pci \
>                    rcu \
>                    rtc \
> diff --git a/testcases/kernel/device-drivers/nvme/.gitignore
> b/testcases/kernel/device-drivers/nvme/.gitignore
> new file mode 100644
> index 000000000..c60bc210c
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/nvme/.gitignore
> @@ -0,0 +1 @@
> +nvme01
> diff --git a/testcases/kernel/device-drivers/nvme/Makefile
> b/testcases/kernel/device-drivers/nvme/Makefile
> new file mode 100644
> index 000000000..d47e99e6a
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/nvme/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024 IBM Corporation
> +
> +top_srcdir     ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/kernel/device-drivers/nvme/nvme01.c
> b/testcases/kernel/device-drivers/nvme/nvme01.c
> new file mode 100644
> index 000000000..3c3cb92ce
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/nvme/nvme01.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 IBM Corporation
> + * Author: priyama2 <priyama2@linux.ibm.com>
> + */
> +
> +/* * [Description]
> + *
> + * Verify NVMe device discovery and identification.
> + *
> + * This test fills a gap in NVMe test coverage by validating basic device
> + * enumeration and driver binding, which are fundamental prerequisites for
> + * any NVMe functionality testing.
> + *
> + * - Detect NVMe controllers in /dev
> + * - Enumerate namespaces for detected controllers
> + * - Verify PCI enumeration (class code 0x010802)
> + * - Check NVMe driver binding
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <dirent.h>
> +#include <errno.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +
> +#define NVME_DEV_PATH "/dev"
> +#define NVME_SYS_PATH "/sys/class/nvme"
> +#define PCI_DEVICES_PATH "/sys/bus/pci/devices"
> +
> +static int nvme_device_found;
> +static char nvme_dev_name[256];
> +
> +static void test_detect_nvme_controllers(void)
> +{
> +       DIR *dir;
> +       struct dirent *entry;
> +       int found = 0;
> +
> +       dir = SAFE_OPENDIR(NVME_DEV_PATH);
> +
> +       tst_res(TINFO, "Scanning for NVMe devices in %s", NVME_DEV_PATH);
> +
> +       while ((entry = readdir(dir)) != NULL) {
> +               if (strncmp(entry->d_name, "nvme", 4) == 0 &&
> +                   strlen(entry->d_name) == 5) {
> +                       tst_res(TINFO, "Found NVMe controller: %s",
> entry->d_name);
> +                       strncpy(nvme_dev_name, entry->d_name,
> sizeof(nvme_dev_name) - 1);
> +                       found = 1;
> +                       nvme_device_found = 1;
> +               }
> +       }
> +
> +       SAFE_CLOSEDIR(dir);
> +
> +       if (found)
> +               tst_res(TPASS, "NVMe controller(s) detected successfully");
> +       else
> +               tst_res(TCONF, "No NVMe controllers found in system");
> +}
> +
> +static void test_enumerate_namespaces(void)
> +{
> +       DIR *dir;
> +       struct dirent *entry;
> +       int ns_count = 0;
> +       char search_pattern[32];
> +
> +       if (!nvme_device_found) {
> +               tst_res(TCONF, "No NVMe device found, skipping namespace
> enumeration");
> +               return;
> +       }
> +
> +       snprintf(search_pattern, sizeof(search_pattern), "%sn",
> nvme_dev_name);
> +
> +       dir = SAFE_OPENDIR(NVME_DEV_PATH);
> +
> +       tst_res(TINFO, "Enumerating namespaces for %s", nvme_dev_name);
> +
> +       while ((entry = readdir(dir)) != NULL) {
> +               if (strncmp(entry->d_name, search_pattern,
> strlen(search_pattern)) == 0) {
> +                       tst_res(TINFO, "Found namespace: %s",
> entry->d_name);
> +                       ns_count++;
> +               }
> +       }
> +
> +       SAFE_CLOSEDIR(dir);
> +
> +       if (ns_count > 0)
> +               tst_res(TPASS, "Enumerated %d namespace(s) successfully",
> ns_count);
> +       else
> +               tst_res(TPASS, "No namespaces found for %s (device may not
> have namespaces configured)", nvme_dev_name);
> +}
> +
> +static void test_verify_pci_enumeration(void)
> +{
> +       DIR *dir;
> +       struct dirent *entry;
> +       int found = 0;
> +       char class_path[512];
> +       FILE *fp;
> +       char class_id[16];
> +
> +       if (!nvme_device_found) {
> +               tst_res(TCONF, "No NVMe device found, skipping PCI
> enumeration check");
> +               return;
> +       }
> +
> +       dir = SAFE_OPENDIR(PCI_DEVICES_PATH);
> +
> +       tst_res(TINFO, "Checking PCI enumeration for NVMe devices");
> +
> +       while ((entry = readdir(dir)) != NULL) {
> +               if (entry->d_name[0] == '.')
> +                       continue;
> +
> +               snprintf(class_path, sizeof(class_path), "%s/%s/class",
> +                        PCI_DEVICES_PATH, entry->d_name);
> +
> +               fp = SAFE_FOPEN(class_path, "r");
> +
> +               if (fgets(class_id, sizeof(class_id), fp)) {
> +                       if (strncmp(class_id, "0x010802", 8) == 0) {
> +                               tst_res(TINFO, "Found NVMe PCI device: %s
> (class: %s)",
> +                                       entry->d_name, class_id);
> +                               found = 1;
> +                       }
> +               }
> +               SAFE_FCLOSE(fp);
> +       }
> +
> +       SAFE_CLOSEDIR(dir);
> +
> +       if (found)
> +               tst_res(TPASS, "NVMe device properly enumerated on PCI
> bus");
> +       else
> +               tst_res(TFAIL, "NVMe device not found on PCI bus");
> +}
> +
> +static void test_check_driver_binding(void)
> +{
> +       char driver_path[512];
> +       char driver_link[512];
> +
> +       if (!nvme_device_found) {
> +               tst_res(TCONF, "No NVMe device found, skipping driver
> binding check");
> +               return;
> +       }
> +
> +       snprintf(driver_path, sizeof(driver_path), "%s/%s/device/driver",
> +                NVME_SYS_PATH, nvme_dev_name);
> +
> +       SAFE_READLINK(driver_path, driver_link, sizeof(driver_link));
> +
> +       tst_res(TINFO, "Driver binding: %s", driver_link);
> +
> +       if (strstr(driver_link, "nvme") != NULL)
> +               tst_res(TPASS, "NVMe driver properly bound to device");
> +       else
> +               tst_res(TFAIL, "Unexpected driver bound to NVMe device:
> %s", driver_link);
> +}
> +
> +static void setup(void)
> +{
> +       if (access("/sys/module/nvme", F_OK) != 0)
> +               tst_brk(TCONF, "NVMe kernel module not loaded");
> +
> +       tst_res(TINFO, "NVMe Device Discovery & Identification Test");
> +}
> +
> +static void run(unsigned int n)
> +{
> +       /* Reset state for each iteration */
> +       nvme_device_found = 0;
> +       memset(nvme_dev_name, 0, sizeof(nvme_dev_name));
> +
> +       switch (n) {
> +       case 0:
> +               test_detect_nvme_controllers();
> +               break;
> +       case 1:
> +               test_enumerate_namespaces();
> +               break;
> +       case 2:
> +               test_verify_pci_enumeration();
> +               break;
> +       case 3:
> +               test_check_driver_binding();
> +               break;
> +       }
> +}
> +
> +static struct tst_test test = {
> +       .test = run,
> +       .tcnt = 4,
> +       .setup = setup,
> +};
> --
> 2.52.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
