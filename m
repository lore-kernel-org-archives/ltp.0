Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89E0C61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AA503C71FD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 15:20:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 449043C062E
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:19:42 +0200 (CEST)
Received: from mail-oi2-x05.google.com (mail-oi2-x05.google.com
 [IPv6:2607:f8b0:4864:32::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E80C310009A2
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:19:41 +0200 (CEST)
Received: by mail-oi2-x05.google.com with SMTP id
 46e09a7af769-7e9db59c430so1732961a34.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787663980; x=1788268780; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gs3xRQvSDMYzcNqSkf0mBbmv5uBPwKmMf1zoOx+jJYE=;
 b=fI5fXBu4G+G3A6ycC2z78G0krCLTCtAONRbH7NxlpDV5RuAQnmpy90xsCkN62nnyxf
 XgiQeWAPzDA2jqfICWTLuTQ1nnET4nJQ2ek2NAvjIUoYsc+pVD7An5cBlbXQhO7ysDIT
 c0UGhOGKNddLM7hKaj332I10ya3P8Jm8+RkMPz/MO/eCtBrC1oNYeOZtqNWraP24KMym
 xrnHS7ki2xh5YCWOOE39Lo8Om4pxdHgz2iZtlasR7fJ5+8uiGapn4AeEXbDyo1kIDMwK
 9vGjfg948Qd222v8ZydGhcahaLa+skSvmcBSQGiTkiIPaV2CM2Gv4m5R/jnbeGmBmiC6
 FY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787663980; x=1788268780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gs3xRQvSDMYzcNqSkf0mBbmv5uBPwKmMf1zoOx+jJYE=;
 b=kdyc/Q5NEvIXtllxXNUsMV/OvQTp4kMCANr7vUtkFYvT4VeoSiljf49amMjm2Wsrzf
 I7t/14YNbDviAuIL2kT1PS57rzWAAfHC4JtC8+YIstPlgIYiF2/Dt94v7PbdpdSp84We
 5ZalGCpoj1o6GlPs6yAoukTzMfb0FX6v8dM3kdKnuLCugBNM4/0Ob3iPnnAVf7BMNXCd
 lhiS3ngg7IK6hySupoDFNIcAST11bb+BWYlJJLK55rbMtI6msrVgd27gcHiAQWrun+VY
 skR1LmOnHTWvbksNGqhlUfdlwVUAlcE4mfj0qOe+WhzqARtDddZn9dx+NMQSZd6bveAa
 FT3A==
X-Gm-Message-State: AFuF++mbHRKqExl1ZWahU/C6J9gp6LBxDTkZnUpEqxhRfeyvnMOwkd1K
 l03I5wkgCXUEqPuZm5LIt4lNNTZuB2oQ1WtKKFINeSKrN3jDd6Ll7xhq
X-Gm-Gg: AR+sD11fGLma4rcrNJGVcVWC7L8NgpNJYF1uN/EZBVbDkuvcdSGPUbKUfTRcelHxVbY
 pznAbW/rtjcUfBOvn6zFLMLKgei1uuyZ/cF4P1m61oSew9Ei4vQq06gsnPVr7Y/hqJrfPG5dnTl
 rVUkfkK57sH1KZDwG6xY73PJMlHyjguKg/cngl9RM9o4Sm4fQ6oDhc/FYRpBk9bS8XehHhWw1CI
 f+J+QwJWYZFIdXY+GDJ6//v3NloverDE1yLpGm160XsMgl3aTdo/2CEdkig6UqRyPqstbfra/GM
 K2/qXjTA0lQFjmZx5u2oWtVXm+se5nmuqHyWgXDzQLxdO27xu5fGDkVPzn2IsqLMHtQdtvyU30f
 eOzr0LW7yVf+CcNhO9i5hyYr1nre9K0X1JXWWTEnZwwIBki6RfZoPma0ambiSr5lb11E6eN1vs0
 iXSrD/x03geKfHD0uGDWSjvMBDvQDB1XnQPLC3MS2ooBgH7W6n3RXRrqy4YZ2gl2Ls7PWaj3EoQ
 ArYh+zqmY+2C/TtcJIkaLc0kqD8PfAHzVPxhAJ4R8M2gHRoDc8Ku378jrdK930kI3oAIwqDRBKG
 WPePSyZ9EQ66
X-Received: by 2002:a05:6830:2a03:b0:7e6:8955:c52d with SMTP id
 46e09a7af769-7f4613368demr38812190a34.5.1787663980348; 
 Tue, 25 Aug 2026 06:19:40 -0700 (PDT)
Received: from
 runnervm76f27.0y4ggixqpiae5jt5tzqp2bomxe.ex.internal.cloudapp.net
 ([135.232.232.71]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc4f367sm6678243a34.17.2026.08.25.06.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 06:19:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 Aug 2026 13:19:38 +0000
Message-ID: <20260825131939.5201-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825113625.1624134-2-chrubis@suse.cz>
References: <20260825113625.1624134-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add tst_sysfs_assert
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

Hi Cyril,

On Tue, 25 Aug 2026, Cyril Hrubis wrote:
> lib: Add tst_sysfs_assert

This is a review of the 31-patch sysfs series. Comments are grouped per
patch; only patches with findings are quoted below.

--- [PATCH 1/31] lib: Add tst_sysfs_assert ---

> Adds helpers for a sysfs testcases.

The body only restates the subject. Could it say why the helper API is
needed (which upcoming tests use it, what problem it solves)? A ~1500 line
new public API is not self-explanatory from the subject alone.

> 	/* First pass: only to find the highest id so we can size the bitmap. */
> 	if (parse_list(file, lineno, path, NULL, NULL, &max_id))
> 		return NULL;
>
> 	bytes = max_id < 0 ? 1 : max_id / 8 + 1;
> 	map = SAFE_MALLOC(bytes);
> 	memset(map, 0, bytes);
>
> 	/* Second pass: fill the bitmap. */
> 	if (parse_list(file, lineno, path, map, NULL, NULL)) {

read_list_map() sizes the bitmap from a first parse and then fills it from a
second, independent parse of the same file. parse_list() writes without a
bounds check:

> 		if (map)
> 			map[i / 8] |= 1 << (i % 8);

The documented sources include mutable lists (cpu online/offline, node
online). If the list grows across an 8-id boundary between the two reads,
e.g. a CPU whose id exceeds the first pass's max is onlined by concurrent
hotplug, the second pass parses a higher id than "bytes" was sized for and
map[i / 8] writes past the allocation. Would it be safer to size the bitmap
from a fixed upper bound (kernel_max / nr possible), or to cap parse_list()
writes against the allocation size?

> unsigned long tst_sysfs_read_lx(const char *file, const int lineno,

> /**
>  * TST_SYSFS_READ_LX() - Reads a hexadecimal unsigned long from a file.
>  *
>  * Reads a long value from the file at the path built from fmt and returns it.

The description body says "Reads a long value" while the summary and the
implementation read a hexadecimal unsigned long (looks copy-pasted from
TST_SYSFS_READ_LI).

--- [PATCH 3/31] testcases: sysfs: Add sys_kernel01 ---

> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk

This is a leaf test directory (it holds sys_kernel01.c and no
subdirectories) but includes the trunk target. generic_trunk_target.inc
errors out when SUBDIRS is empty:

    ifeq ($(strip $(SUBDIRS)),)
        $(error SUBDIRS empty -- did you want generic_leaf_target instead?)

so building this directory aborts, and sys_kernel01 is never built even
though runtest/sysfs and .gitignore reference it. Should it use
generic_leaf_target.mk like the sibling power/Makefile?

Note that patch 27 later adds kernel/mm/ under this directory, which makes
SUBDIRS non-empty and hides the hard error, but the trunk target still does
not compile sys_kernel01.c (it only recurses into mm/), so at the end of the
series sys_kernel01 is silently never built.

--- [PATCH 8/31] testcases: sysfs: Add sys_cpu_vulnerabilities01 ---

> +static const char *const known_prefixes[] = {
> +	"Not affected",
> +	"Vulnerable",
> +	"Mitigation:",
> +	"Unknown",
> +	"Processor vulnerable",
> +};

/sys/devices/system/cpu/vulnerabilities/itlb_multihit is emitted by
itlb_multihit_show_state() in arch/x86/kernel/cpu/bugs.c as one of:

    "KVM: Mitigation: VMX unsupported"
    "KVM: Mitigation: VMX disabled"
    "KVM: Mitigation: Split huge pages"
    "KVM: Vulnerable"

These start with "KVM: ", which matches none of the known prefixes, so
check_vuln() reports TFAIL on the common x86 Intel host that exposes
itlb_multihit. Should a "KVM:" prefix be added (or the "Mitigation:"/
"Vulnerable" match allowed after an optional "KVM: ")?

--- [PATCH 12/31] testcases: sysfs: Add sys_ata01 ---

> +static const char *const class_allowed[] = {
> +	"ata", "atapi", "pmp", "semb", "unknown", NULL
> +};

/sys/class/ata_device/<dev>/class is produced by get_ata_class_names() over
ata_class_names[] in drivers/ata/libata-transport.c, whose table also
contains:

    { ATA_DEV_ZAC,   "zac" },
    { ATA_DEV_NONE,  "none" }

A ZAC (host-managed SMR) ATA device reports class "zac", which is not in
class_allowed, so TST_SYSFS_ASSERT_ONEOF reports TFAIL for a valid value.
Should "zac" (and "none") be added?

--- [PATCH 23/31] testcases: sysfs: Add sys_net04 ---

> +	if (tun_fd >= 0)
> +		SAFE_CLOSE(tun_fd);
> +
> +	if (tap_fd >= 0)
> +		SAFE_CLOSE(tap_fd);

Both descriptors are initialized to -1; the convention is to test them with
fd != -1 rather than fd >= 0.

--- [PATCH 30/31] testcases: sysfs: Add sys_swap01 ---

> testcases: sysfs: Add sys_swap01

The test added is sys_mm_swap01 (sys_mm_swap01.c, runtest entry
"sys_mm_swap01 sys_mm_swap01", .gitignore /sys_mm_swap01). The subject names
sys_swap01, which does not match the actual test.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
