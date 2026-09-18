Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE72FC982D6
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 11:04:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDEDD3E749A
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 13:04:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29A253CE49F
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 13:04:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 472111000D3B
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 13:04:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A84121BBF;
 Fri, 18 Sep 2026 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789729447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpgGT4qJHFTk5TRiIK9I01x/M2u19r9pywR4T9LHDv0=;
 b=SdZ8B8pkXmw3+bslaRkJ7w6bbZpKnYzRl34b9FUmlIbp4z0cjR27PxylaNudImX2yyViTj
 LeaLKXb70i7lH+6sovtgO6Q4ARCV/qjwexOTnCTklVCozrXPgpZqeIx6u2KH+wVxNtc1p4
 E4vGvptmAu/a2lIEvpk6buGnSDKy56Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789729447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpgGT4qJHFTk5TRiIK9I01x/M2u19r9pywR4T9LHDv0=;
 b=Ow0Q3zenQlVX9INQgP8u3lZTdOkCgdabDdFAFcIm0bCyJ+xyn0loEwHBQnRLZ6p131qIDl
 V9ht0QCiJwiLhMBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789729443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpgGT4qJHFTk5TRiIK9I01x/M2u19r9pywR4T9LHDv0=;
 b=j1adDEEtRn6G5SCaHNdY4jEqNiVzbOoVqSa8rE+dLg1BczfpAmYJCXlyvwTSw9GmhErysI
 dm3Z/g2SwCmG633WbeXhcwlRw+vxpmGKROYg/J3P7eyqtvd1By3ZAOkkmDCQ2irKCe4Pc2
 l0rR05h1OEaZ/KopsQp0e3alr/paK4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789729443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpgGT4qJHFTk5TRiIK9I01x/M2u19r9pywR4T9LHDv0=;
 b=3CLbORJRMT/NMSek6C84o/c2aRMG1DCMT7nEDg9Fk1HwETp34VB9+zNs4ib4El/8noX4d3
 FobkXN4rign/41AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AF021398D;
 Fri, 18 Sep 2026 11:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 81F0O6IarWqXIQAAD6G6ig
 (envelope-from <gpathak@suse.de>); Fri, 18 Sep 2026 11:04:03 +0000
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 11:04:02 +0000
From: gpathak <gpathak@suse.de>
To: Petr Vorel <pvorel@suse.cz>
In-Reply-To: <20260917141953.GA1856601@pevik>
References: <20260917025657.327887-1-gpathak@suse.de>
 <20260917105304.9674-1-gpathak@suse.de> <20260917141953.GA1856601@pevik>
User-Agent: Roundcube Webmail
Message-ID: <16747ca18e4f46277867446fa0188353@suse.de>
X-Sender: gpathak@suse.de
X-Spamd-Result: default: False [-8.23 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.14)[-0.687]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx13: Add basic test for
 STATX_WRITE_ATOMIC on regular file
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
Cc: Gaurav Pathak <gaurav.pathak@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2026-09-17 14:19, Petr Vorel wrote:
> Hi Gaurav,
> 
> nit: this is a second version of the patch, it'd help to distinguish 
> them if you
> generate it with git format-patch -v2. It's also mentioned (as "-v 2") 
> in our
> tutorial:
> 
> https://linux-test-project.readthedocs.io/en/latest/developers/test_case_tutorial.html
> 
> (Tutorial is slightly outdated both code and instructions but still 
> more or less
> valid. It should be structured and improved but I still recommend you 
> to read it
> to get various ideas not covered elsewhere).
> 
> Also this second patch failed to build in CI. Could you please enable 
> CI in your
> LTP fork and push the branch before sending? You 1) get results quicker 
> 2) saves
> our time to look on something which is broken.
> 
>> This patch adds a new test to validate these atomic write limit 
>> fields.
>> The test ensures the filesystem correctly advertises the 
>> STATX_ATTR_WRITE_ATOMIC
>> attribute when queried on a file opened with O_DIRECT. It also 
>> verifies that the
>> reported optimized maximum is logically consistent by falling within 
>> the
>> absolute minimum and maximum boundaries. Furthermore, it checks that 
>> all
>> reported atomic write unit sizes are valid powers of two, adhering to 
>> the strict
>> requirements of the kernel block layer.
> 
>> If the underlying storage hardware or filesystem lacks atomic write
>> support, the test gracefully skips with TCONF.
> 
>> Fixes: #1224
> 
>> Signed-off-by: Gaurav Pathak <gaurav.pathak@suse.com>
>> ---
>>  configure.ac                               |   2 +-
>>  testcases/kernel/syscalls/statx/.gitignore |   1 +
>>  testcases/kernel/syscalls/statx/statx13.c  | 130 
>> +++++++++++++++++++++
>>  3 files changed, 132 insertions(+), 1 deletion(-)
> 
> Please go over agent reports (it asked for runtest/syscalls already in 
> the first patch).
> ...
>> index 000000000..ea42a102c
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/statx/statx13.c
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2026 SUSE LLC <gaurav.pathak@suse.com>
>> + */
>> +
>> +/*\
>> + * This test validates the STATX_WRITE_ATOMIC feature (introduced in 
>> Linux 6.13).
>> + * It ensures that supported filesystems (xfs as of now) correctly 
>> report their
> git grep generic_atomic_write_valid (functions mentioned at [1] which 
> was
> mentioned in the "block atomic writes" feature [2]) mentions also ext4. 
> And you
> also test both xfs and ext4, you should either update filesystem list 
> in docs or
> not mention filesystems at all.
> 
> [1] 
> https://lore.kernel.org/linux-xfs/20240607143919.2622319-1-john.g.garry@oracle.com/T/#t
> [2] 
> https://lore.kernel.org/lkml/20240620125359.2684798-1-john.g.garry@oracle.com/
> 
>> + * atomic write limits to user space when queried via statx().
>> + *
>> + * The test performs the following validations:
> nit: there needs to be a blank line otherwise list will not be 
> formatted
> 
> => we should teach agent to recognise it
> 
>> + * - Creates a test file using O_DIRECT (a prerequisite for atomic 
>> writes).
>> + * - Calls statx() with the STATX_WRITE_ATOMIC mask to retrieve the 
>> limits.
>> + * - Verifies that stx_atomic_write_unit_min, 
>> stx_atomic_write_unit_max, and
>> + *    stx_atomic_write_unit_max_opt are logically consistent (e.g., 
>> max_opt is
> And this extra space before stx_atomic_write_unit_max_opt make is 
> formatted as
> bold (see later doc build)
> 
>> + *    within the min and max bounds).
>> + * - Ensures all reported atomic write unit sizes are valid powers of 
>> two.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <sys/param.h>
>> +#include "tst_test.h"
>> +
>> +#define MNTPOINT "mnt_point"
>> +#define TESTFILE MNTPOINT"/testfile"
> 
> nit style check complains, you'll find it with:
> $ make check-statx13
> ...
> CHECK testcases/kernel/syscalls/statx/statx13.c
> statx13.c:25: CHECK: Concatenated strings should use spaces between 
> elements
> 
> 
>> +#define MODE 0644
>> +
>> +#define WRITE_SIZE 4096
>> +#define ALIGNMENT  4096
>> +
>> +static int file_fd = -1;
>> +
>> +static void verify_statx(void)
>> +{
>> +	struct statx buff;
>> +
>> +	TST_EXP_PASS_SILENT(statx(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | 
>> STATX_WRITE_ATOMIC, &buff),
>> +			"statx(AT_FDCWD, %s, 0, STATX_WRITE_ATOMIC, &buf)", TESTFILE);
>> +
>> +	if (!(buff.stx_attributes & STATX_ATTR_WRITE_ATOMIC)) {
>> +		tst_res(TCONF, "Filesystem does not support STATX_WRITE_ATOMIC");
>> +		return;
> 
> This is enough (without following return).
> 		tst_brk(TCONF, "Filesystem does not support STATX_WRITE_ATOMIC");
>> +	}
>> +
>> +	if (buff.stx_atomic_write_unit_min > 0 &&
>> +			__builtin_popcount(buff.stx_atomic_write_unit_min) == 1)
>> +		tst_res(TPASS, "stx_atomic_write_unit_min(%u) is power of 2",
>> +				buff.stx_atomic_write_unit_min);
>> +	else
>> +		tst_res(TFAIL, "stx_atomic_write_unit_min(%u) is not a power of 2",
>> +				buff.stx_atomic_write_unit_min);
>> +
>> +	if (buff.stx_atomic_write_unit_max > 0 &&
>> +			__builtin_popcount(buff.stx_atomic_write_unit_max) == 1)
>> +		tst_res(TPASS, "stx_atomic_write_unit_max(%u) is power of 2",
>> +				buff.stx_atomic_write_unit_max);
>> +	else
>> +		tst_res(TFAIL, "stx_atomic_write_unit_max(%u) is not a power of 2",
>> +				buff.stx_atomic_write_unit_max);
>> +
>> +#ifdef HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MAX_OPT
>> +	if (buff.stx_atomic_write_unit_max_opt == 0) {
>> +		tst_res(TINFO, "stx_atomic_write_unit_max_opt is 0 (no optimized 
>> max reported)");
> Shouldn't this be TPASS?
> 
>> +	} else {
>> +		if (buff.stx_atomic_write_unit_max_opt > 
>> buff.stx_atomic_write_unit_max)
>> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max 
>> (%u)",
>> +					buff.stx_atomic_write_unit_max_opt,
>> +					buff.stx_atomic_write_unit_max);
>> +
>> +		else if (buff.stx_atomic_write_unit_max_opt < 
>> buff.stx_atomic_write_unit_min)
>> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is less than 
>> min (%u)",
>> +					buff.stx_atomic_write_unit_max_opt,
>> +					buff.stx_atomic_write_unit_min);
>> +		else
>> +			tst_res(TPASS, "stx_atomic_write_unit_max_opt (%u) is within valid 
>> range [%u, %u]",
>> +					buff.stx_atomic_write_unit_max_opt,
>> +					buff.stx_atomic_write_unit_min,
>> +					buff.stx_atomic_write_unit_max);
>> +
>> +		if (__builtin_popcount(buff.stx_atomic_write_unit_max_opt) != 1)
>> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is not a power 
>> of 2",
>> +					buff.stx_atomic_write_unit_max_opt);
>> +	}
>> +#else
>> +	tst_res(TCONF, "stx_atomic_write_unit_max_opt is not defined in 
>> struct statx");
>> +#endif
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	char *data_buff = SAFE_MEMALIGN(ALIGNMENT, WRITE_SIZE);
>> +
>> +	if (strcmp(tst_device->fs_type, "xfs") && 
>> strcmp(tst_device->fs_type, "ext4"))
>> +		tst_brk(TCONF, "This test only supports ext4 and xfs");
> FYI .filesystems member in struct tst_test test select filesystems, you 
> don't
> need to check here. Please remove it.
> 
> => we should teach agent to detect this.
> 
>> +
>> +	umask(0);
>> +	memset(data_buff, '@', WRITE_SIZE);
>> +
>> +	file_fd =  SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT | O_DIRECT, MODE);
>> +	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, data_buff, WRITE_SIZE);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (file_fd > -1)
>> +		SAFE_CLOSE(file_fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = verify_statx,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.min_kver = "6.13",
>> +	.needs_root = 1,
>> +	.needs_device = 1,
>> +	.needs_tmpdir = 1,
> nit: Some tags aren't needed and will be later deleted. You can see it:
> 
> $ cd metadata/; make
> /home/pvorel/install/src/ltp.git/metadata/parse.sh > ltp.json
> testcases/kernel/syscalls/statx/statx13.c: useless tag: needs_device
> testcases/kernel/syscalls/statx/statx13.c: useless tag: needs_tmpdir
> 
> Or you could see it at doc build (but that usually requires python 
> virtualenv
> and it's slower, OTOH you can check how the doc will look like)
> 
> $ cd doc; make setup && make
> => see the docs in thml file:
> doc/html/users/test_catalog.html#statx13
> 
>> +	.mntpoint = MNTPOINT,
>> +	.mount_device = 1,
>> +	.filesystems = (struct tst_fs[]) {
>> +		{
>> +			.type = "xfs",
>> +			.mkfs_opts = (const char *const []){"-f", "-bsize=16K", NULL},
>> +		},
>> +		{
>> +			.type = "ext4",
>> +			.mkfs_opts = (const char *const []){"-O", "bigalloc", "-b", 
>> "4096", "-C", "65536", NULL},
> BTW my 7.2.0-4.g080d79d-default still TCONF on ext4. Maybe wrong 
> params?
>> +		},
>> +		{}
>> +	},
>> +};

Hello Petr,
Thanks a lot for reviewing the patch and providing useful pointers.
I am able to fix almost all of the issues reviewed by you and reported 
by automation agent.

>>> +			.type = "ext4",
>>> +			.mkfs_opts = (const char *const []){"-O", "bigalloc", "-b", 
>>> "4096", "-C", "65536", NULL},
>> BTW my 7.2.0-4.g080d79d-default still TCONF on ext4. Maybe wrong 
>> params?

However, for ext4 filesystem case, I used scsi_debug kernel module to 
emulate the behavior of allowing 16K write operation using O_DIRECT flag 
which is bigger than the PAGESIZE of 4096. On my system and some other 
machines on which I ran this test, ext4 is not allowing me to cross 
PAGESIZE boundary, maybe because the kernel running on those machines is 
compiled with 4K PAGESIZE. I believe this is also the same in your case. 
Maybe we need to test this on a kernel having PAGESIZE greater than 
4096.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
