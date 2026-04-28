Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA23FF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:53:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D45A13E28A8
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:53:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7053D3CFBA2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:53:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 947D31400BCA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:53:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A21126A81D;
 Tue, 28 Apr 2026 07:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777362786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ob4VR6DPI5M4l2hQuO+vb91HT83n+uOoI8gpx+GpBBM=;
 b=kmSHcwxxQWmT5Q/jHUw9hqlZ2nCRnYU0rdy7q60QqNnYoxlSrF8jKlNeGdt6z1Rsq1sEgj
 yAe/EieQZUIMFNWmmcT62jU7OsfPPzig+0T9RVTX7eELkYJaYajazgqlfSH3mTOc5rBOF0
 0maj0DISIYMDNefddn3SNjkbFzon42U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777362786;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ob4VR6DPI5M4l2hQuO+vb91HT83n+uOoI8gpx+GpBBM=;
 b=J7Uh+uvCeMJa1i/epKkkXlEj13ZtGc5hAZvRuOyQEnx5+QGdd+rWOlUS/KmFp+kRLUGR0t
 EZmFbnrR6DupKqAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O+KD2XcX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fBQ8AJiZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777362785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ob4VR6DPI5M4l2hQuO+vb91HT83n+uOoI8gpx+GpBBM=;
 b=O+KD2XcXao9cd1VRoVNfX9GSJdPD/4a4eoroaNgmp7sLEWeW04WYy1sozc5qqAU6BDd+4X
 Yj4qBOzBgzzpAb0JvbqZVI/+lCOwtzBQN3/jGzGL2Pz1M/dQvPBHNvtoRlQSNQldufP498
 3/X9Gs0PURVr5M02XJtcVAqG6lYG8CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777362785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ob4VR6DPI5M4l2hQuO+vb91HT83n+uOoI8gpx+GpBBM=;
 b=fBQ8AJiZKxM3qi2wGw9QRuJP7T7ZoWY6PckAzeIK2rPILD8Mqqe1fK5ZHo5aTz1mG0hP6N
 LLuHRysMJqSwRjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 923B5593B0;
 Tue, 28 Apr 2026 07:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id scVlImFn8Gm/EgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 28 Apr 2026 07:53:05 +0000
Date: Tue, 28 Apr 2026 09:53:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: priyama2 <priyama2@linux.ibm.com>
Message-ID: <afBnbxFLCb4vM39Z@yuki.lan>
References: <20260429105114.710966-1-priyama2@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260429105114.710966-1-priyama2@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nvmexpress.org:url,linux-test-project.readthedocs.io:url,linux-test-project.github.io:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,yuki.lan:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A21126A81D
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] testcases/nvme: Add NVMe device discovery and
 identification test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: priyama2 <priyama2@linux.ibm.com>
> ---
>  testcases/kernel/device-drivers/nvme/Makefile |  42 ++++
>  testcases/kernel/device-drivers/nvme/README   | 155 ++++++++++++
>  testcases/kernel/device-drivers/nvme/nvme01.c | 236 ++++++++++++++++++
>  3 files changed, 433 insertions(+)
>  create mode 100644 testcases/kernel/device-drivers/nvme/Makefile
>  create mode 100644 testcases/kernel/device-drivers/nvme/README
>  create mode 100644 testcases/kernel/device-drivers/nvme/nvme01.c
> 
> diff --git a/testcases/kernel/device-drivers/nvme/Makefile b/testcases/kernel/device-drivers/nvme/Makefile
> new file mode 100644
> index 000000000..ace6696f6
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/nvme/Makefile
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024 IBM Corporation
> +#
> +# Standalone Makefile for NVMe LTP test suite
> +
> +# Compiler and flags
> +CC		= gcc
> +CFLAGS		= -Wall -O2 -I/opt/ltp/include
> +LDFLAGS		= -L/opt/ltp/lib
> +LDLIBS		= -lltp -lrt
> +
> +# Test binaries
> +TARGETS		= nvme01 nvme02 nvme03 nvme04
> +
> +# Build all tests
> +all: $(TARGETS)
> +
> +nvme01: nvme01.c
> +	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)
> +
> +nvme02: nvme02.c
> +	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)
> +
> +nvme03: nvme03.c
> +	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)
> +
> +nvme04: nvme04.c
> +	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS)
> +
> +# Install targets
> +install: $(TARGETS)
> +	@mkdir -p /opt/ltp/testcases/bin
> +	@for target in $(TARGETS); do \
> +		install -m 0755 $$target /opt/ltp/testcases/bin/; \
> +	done
> +	@echo "Tests installed to /opt/ltp/testcases/bin/"
> +
> +# Clean
> +clean:
> +	rm -f $(TARGETS) *.o
> +
> +.PHONY: all install clean

We have a buildsystem in LTP, all you need to do is to include the right
file in the Makefile, do that instead.

> diff --git a/testcases/kernel/device-drivers/nvme/README b/testcases/kernel/device-drivers/nvme/README
> new file mode 100644
> index 000000000..6ee5796fe
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/nvme/README
> @@ -0,0 +1,155 @@
> +NVMe Test Suite for Linux Test Project (LTP)
> +==============================================
> +
> +This directory contains test cases for NVMe (Non-Volatile Memory Express) 
> +device functionality testing.
> +
> +Test Cases
> +----------
> +
> +1. nvme01 - Device Discovery & Identification
> +   Tests:
> +   - Detect NVMe controllers
> +   - Enumerate namespaces
> +   - Verify PCI enumeration
> +   - Check driver binding
> +
> +2. nvme02 - Namespace Management
> +   Tests:
> +   - Create namespaces (various sizes)
> +   - Delete namespaces
> +   - Attach/detach namespaces to controllers
> +   - Resize namespaces
> +   - Format namespaces (different block sizes: 512B, 4KB)
> +   - Namespace sharing across controllers
> +
> +3. nvme03 - I/O Operations
> +   Tests:
> +   - Sequential read/write operations
> +   - Random read/write operations
> +   - Mixed workloads
> +   - Different block sizes (512B, 4KB, 8KB)
> +   - Queue depth variations
> +   - Direct I/O vs buffered I/O
> +
> +4. nvme04 - Multipath & Redundancy
> +   Tests:
> +   - Path failover testing
> +   - Load balancing across paths
> +   - Path recovery
> +   - ANA (Asymmetric Namespace Access) states
> +   - Controller failover
> +
> +Requirements
> +------------
> +
> +Hardware:
> +- System with NVMe storage device(s)
> +- For multipath tests: NVMe device with multiple paths configured
> +
> +Software:
> +- Linux kernel with NVMe support (CONFIG_BLK_DEV_NVME=y)
> +- nvme-cli tools (for namespace management tests)
> +- Root/sudo privileges
> +
> +Building
> +--------
> +
> +From the LTP root directory:
> +  make -C testcases/kernel/device-drivers/nvme
> +
> +Or from this directory:
> +  make
> +
> +Running Tests
> +-------------
> +
> +Individual test execution:
> +  ./nvme01
> +  ./nvme02
> +  ./nvme03
> +  ./nvme04
> +
> +Using LTP runtest:
> +  runltp -f nvme
> +
> +Using runtest file:
> +  runltp -f /opt/ltp/runtest/nvme
> +
> +Test Results
> +------------
> +
> +Tests use standard LTP result codes:
> +- TPASS: Test passed
> +- TFAIL: Test failed
> +- TCONF: Test not configured (e.g., no NVMe device found)
> +- TBROK: Test broken (setup failure)
> +- TWARN: Test warning
> +
> +Notes
> +-----
> +
> +1. Some tests require specific hardware configurations:
> +   - nvme02: May require namespace management support
> +   - nvme04: Requires multipath configuration for full testing
> +
> +2. Destructive tests:
> +   - nvme02 includes namespace creation/deletion which may affect data
> +   - Always run on test systems or with proper backups
> +
> +3. Performance tests (nvme03):
> +   - Results vary based on hardware and system load
> +   - Tests measure relative performance, not absolute benchmarks
> +
> +4. Root privileges:
> +   - All tests require root access for device operations
> +
> +Test Coverage
> +-------------
> +
> +The test suite covers:
> +- Basic NVMe device detection and enumeration
> +- Namespace lifecycle management
> +- I/O performance characteristics
> +- Multipath and redundancy features
> +- Driver and controller state verification
> +
> +Known Limitations
> +-----------------
> +
> +1. Namespace management tests may not work on all NVMe devices
> +   (depends on controller capabilities)
> +
> +2. Multipath tests require specific hardware and kernel configuration
> +
> +3. Some tests are informational and may show TCONF on systems
> +   without full NVMe feature support
> +
> +Contributing
> +------------
> +
> +When adding new tests:
> +1. Follow LTP coding standards
> +2. Use tst_test.h framework
> +3. Include proper error handling
> +4. Document test purpose and requirements
> +5. Test on multiple NVMe device types if possible
> +
> +References
> +----------
> +
> +- NVMe Specification: https://nvmexpress.org/specifications/
> +- Linux NVMe Driver: Documentation/block/nvme.rst
> +- nvme-cli: https://github.com/linux-nvme/nvme-cli
> +- LTP Documentation: https://linux-test-project.github.io/
> +
> +Authors
> +-------
> +
> +Copyright (c) 2024 IBM Corporation
> +LTP NVMe Test Suite
> +
> +License
> +-------
> +

No README should be added. Instead the test description should be added
into a special doc comment at the top of the test. That description is
then extracted into online documentation:

https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html

Also this is too verbose, there is a lot of useless information. Just
keep the part that describes what the test actually does. No need to
describe how to compile the tests or how to write new tests, we have
plenty of online docs for LTP now.

> diff --git a/testcases/kernel/device-drivers/nvme/nvme01.c b/testcases/kernel/device-drivers/nvme/nvme01.c
> new file mode 100644
> index 000000000..82fbd315b
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/nvme/nvme01.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 IBM Corporation
> + * Author: LTP NVMe Test Suite
                    ^
		    This does not make any sense.


And the part below should be the special doc comment that is exported
into docs.

> + * Test: NVMe Device Discovery & Identification
> + *
> + * This test verifies:
> + * - Detection of NVMe controllers
> + * - Enumeration of namespaces
> + * - PCI enumeration verification
> + * - Driver binding check
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
> +
> +#define NVME_DEV_PATH "/dev"
> +#define NVME_SYS_PATH "/sys/class/nvme"
> +#define PCI_DEVICES_PATH "/sys/bus/pci/devices"
> +
> +static int nvme_device_found = 0;
> +static char nvme_dev_name[256];
> +
> +/*
> + * Test Case 1: Detect NVMe Controllers
> + * Verifies that NVMe controllers are present in the system
> + */

No obvious comments like this one please. It's pretty clear from the
function name what it does.

> +static void test_detect_nvme_controllers(void)
> +{
> +	DIR *dir;
> +	struct dirent *entry;
> +	int found = 0;
> +
> +	dir = opendir(NVME_DEV_PATH);
> +	if (!dir) {
> +		tst_brk(TBROK | TERRNO, "Failed to open %s", NVME_DEV_PATH);
> +		return;
> +	}

Use SAFE_MACROS() whenever possible. In this case SAFE_OPENDIR().

> +	tst_res(TINFO, "Scanning for NVMe devices in %s", NVME_DEV_PATH);
> +
> +	while ((entry = readdir(dir)) != NULL) {
> +		if (strncmp(entry->d_name, "nvme", 4) == 0 &&
> +		    strlen(entry->d_name) == 5) {  /* nvme0, nvme1, etc. */
                                                  ^
                   No comments commenting obvious like this.

> +			tst_res(TINFO, "Found NVMe controller: %s", entry->d_name);
> +			strncpy(nvme_dev_name, entry->d_name, sizeof(nvme_dev_name) - 1);
> +			found = 1;
> +			nvme_device_found = 1;
> +		}
> +	}
> +
> +	closedir(dir);

SAFE_CLOSEDIR()


And similar comments apply for the rest of the code.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
