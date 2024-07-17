Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5338C3DA4B
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 13:12:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 579C63D1ADD
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 15:12:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B6693D0C85
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 15:12:04 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C66D81A01100
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 15:12:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B68A1FB80;
 Wed, 17 Jul 2024 13:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721221922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mrnCl/wap9+sloXQRbxgupMuIsWg2SfVCaWBA4mNxQ=;
 b=1PYBu2/bzgwqJAm/qJY1GBrXJortF49l0AAUEtc6RrcsNWtD91IfleO+p5pjWHSdylvWkY
 NZKT0D+v+tm4Ux0Q/FHsyhFjtj1PVl0eN3u5ujMCuZyAG55Zvfs0WAa+fLngeaLR2DxfVX
 jLhkHSUltDTwe2KlrX+3IWoTfq6k1Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721221922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mrnCl/wap9+sloXQRbxgupMuIsWg2SfVCaWBA4mNxQ=;
 b=i1HXfwfkeQOdVUSGKg7P6ABMV2zZsGiHWyZSc+e9Wb9OmQI8sZrYKy1U6fwvgvxwOAUBT1
 4+LHAMU1FxXsF3DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721221922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mrnCl/wap9+sloXQRbxgupMuIsWg2SfVCaWBA4mNxQ=;
 b=1PYBu2/bzgwqJAm/qJY1GBrXJortF49l0AAUEtc6RrcsNWtD91IfleO+p5pjWHSdylvWkY
 NZKT0D+v+tm4Ux0Q/FHsyhFjtj1PVl0eN3u5ujMCuZyAG55Zvfs0WAa+fLngeaLR2DxfVX
 jLhkHSUltDTwe2KlrX+3IWoTfq6k1Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721221922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mrnCl/wap9+sloXQRbxgupMuIsWg2SfVCaWBA4mNxQ=;
 b=i1HXfwfkeQOdVUSGKg7P6ABMV2zZsGiHWyZSc+e9Wb9OmQI8sZrYKy1U6fwvgvxwOAUBT1
 4+LHAMU1FxXsF3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC0BB136E5;
 Wed, 17 Jul 2024 13:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /jyvOCHDl2YhbAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jul 2024 13:12:01 +0000
Date: Wed, 17 Jul 2024 15:14:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZpfDu0U1fISLDbqC@rei>
References: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
 <20240522-process_mrelease-v1-2-41fe2fa44194@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240522-process_mrelease-v1-2-41fe2fa44194@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] Add process_mrelease01 test
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
> +/*\
> + * [Description]
> + *
> + * This test verifies that process_mrelease() syscall is releasing memory from
> + * a killed process with memory allocation pending.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +#define CHUNK (1 * TST_MB)
> +#define MAX_SIZE_MB (128 * TST_MB)
> +
> +static void *mem;
> +static volatile int *mem_size;
> +
> +static void do_child(int size)
> +{
> +	tst_res(TINFO, "Child: allocate %d bytes", size);
> +
> +	mem = SAFE_MMAP(NULL,
> +		size,
> +		PROT_READ | PROT_WRITE,
> +		MAP_PRIVATE | MAP_ANON,
> +		0, 0);

This does not actually alloate any memory, it set ups the vmas but the
actual memory is not allocated until you fault it by accessing it, so
you have to actually touch every page to get it faulted, e.g. memset()
it to something.


> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	tst_res(TINFO, "Child: releasing memory");
> +
> +	SAFE_MUNMAP(mem, size);
> +}
> +
> +static void run(void)
> +{
> +	int ret;
> +	int pidfd;
> +	int status;
> +	pid_t pid;
> +	volatile int restart;
> +
> +	for (*mem_size = CHUNK; *mem_size < MAX_SIZE_MB; *mem_size += CHUNK) {
> +		restart = 0;
> +
> +		pid = SAFE_FORK();
> +		if (!pid) {
> +			do_child(*mem_size);
> +			exit(0);
> +		}
> +
> +		TST_CHECKPOINT_WAIT(0);
> +		tst_disable_oom_protection(pid);

What is this needed for?

> +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
> +
> +		tst_res(TINFO, "Parent: killing child with PID=%d", pid);
> +
> +		SAFE_KILL(pid, SIGKILL);
> +
> +		ret = tst_syscall(__NR_process_mrelease, pidfd, 0);
> +		if (ret == -1) {
> +			if (errno == ESRCH) {
> +				tst_res(TINFO, "Parent: child terminated before process_mrelease()."
> +					" Increase memory size and restart test");
> +
> +				restart = 1;

As far as I understand the documentation his condition should not happen
until you have called wait() on the process.

> +			} else {
> +				tst_res(TFAIL | TERRNO, "process_mrelease(%d,0) error", pidfd);
> +			}
> +		} else {
> +			tst_res(TPASS, "process_mrelease(%d,0) passed", pidfd);

Okay it passed, but did we free any memory?

Is the /proc/$pid/ still accessible before we wait on the killed
process? If it is we can parse the proc maps before and after
process_mrelease and check if the memory was really freed.

> +		}
> +
> +		SAFE_WAITPID(-1, &status, 0);
> +		SAFE_CLOSE(pidfd);
> +
> +		if (!restart)
> +			break;
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	mem_size = SAFE_MMAP(
> +		NULL,
> +		sizeof(int),
> +		PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS,
> +		-1, 0);

Why do we keep the size in shared memory? The forked child has COW
access to the parent memory, we can use the variables set in the parent
just fine.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (mem)
> +		SAFE_MUNMAP(mem, *mem_size);

This is allocated in chid and never non NULL in parent.

> +	if (mem_size)
> +		SAFE_MUNMAP((void *)mem_size, sizeof(int));
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.min_kver = "5.15",
> +	.needs_checkpoints = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_MMU=y",
> +	},
> +};
> 
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
