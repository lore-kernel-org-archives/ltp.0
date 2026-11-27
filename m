Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F4606A31C
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=vcqRh1ow;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LWJHtQ1R;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YOzltU17;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KiTZzKrq
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8A5A3E9DD5
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 13:38:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F367D3C13EE
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 13:37:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 523112009E8
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 13:37:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D4ED2294C;
 Fri, 27 Nov 2026 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795783075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oA7XhdZTweIftCieAIpwi6wijHAy2Y0+4Q5sCwvnSNo=;
 b=vcqRh1owW8GghR6AflIz3GOuoeUubZk/u5SqQO2rlL4PH53yAjW/W/sfQZFXUSxXU36eyR
 cia2FXYlE3o+M8M83V6dj+RqykeQ0RgshUzKqWhE5+LfziO6jdmqFSf3xXSknUKJzBFJNi
 8IyADn9I+nW/YlmG3IWnf3a7erNW4SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795783075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oA7XhdZTweIftCieAIpwi6wijHAy2Y0+4Q5sCwvnSNo=;
 b=LWJHtQ1RNqaBR3a5h6r+PlEzTnVnaRzRphxRUJzibTSmv2YdxKEzoDkLTRjVzX9/yFsRhd
 1p2HgFHQKM0yYYCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795783074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oA7XhdZTweIftCieAIpwi6wijHAy2Y0+4Q5sCwvnSNo=;
 b=YOzltU17ryIKPwBLJ1Oo03ilZdjHs/9KFEeh1GL0zD6hGEfluUdaQ/jUJZRfnkurGZs3Ph
 ueJkmw/E7Piaqy1ro5a1OfkNfmezXGAczADE8SHTON95a+8HXyLHK2TAdzLK+rSJLUpGGD
 Ft4Ct+5vbE42RU6x7EwJTnDf0JeY2wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795783074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oA7XhdZTweIftCieAIpwi6wijHAy2Y0+4Q5sCwvnSNo=;
 b=KiTZzKrqUhMIjd7CV+YJFcLWTxEBwOtoUvDeIg1u++g9RIjLITxUdxTFjodlShLhEMM8eV
 HXz79fYdEmtbMYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAE07134E8;
 Fri, 27 Nov 2026 12:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jc+mJKF5CWtzYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Nov 2026 12:37:53 +0000
Date: Fri, 27 Nov 2026 13:38:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.ibm.com>
Message-ID: <awl5wbt7yGBnRwnh@yuki.lan>
References: <20261024023044.80055-1-samir@linux.ibm.com>
 <20261024023044.80055-3-samir@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261024023044.80055-3-samir@linux.ibm.com>
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/4] sched/psi: Add psi_multiple_trigger01 test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * Verify that only one PSI trigger can be registered per open file
> + * description.
> + *
> + * Documentation/accounting/psi.rst states: "Write operations to a file
> + * descriptor with an already existing psi trigger will fail with EBUSY."
> + *
> + * - Writing a valid trigger to a freshly opened file succeeds.
> + * - Writing a second trigger through the same file descriptor fails with
> + *   EBUSY.
> + * - Writing a second trigger through a dup() of the file descriptor fails
> + *   with EBUSY, because both descriptors share one open file description.
> + * - Two separately opened files accept different triggers.
> + * - Two separately opened files accept the same trigger.
> + * - After the file holding a trigger is closed a new file accepts a trigger.
> + *
> + * The cases with separately opened files confirm that the limit is per open
> + * file description and not per trigger definition.
> + */
> +
> +#include <string.h>
> +
> +#include "tst_test.h"
> +
> +#define PSI_MEM "/proc/pressure/memory"
> +#define TRIG_A "some 100000 1000000"
> +#define TRIG_B "full 200000 2000000"
> +
> +/*
> + * The kernel overwrites the last byte of the written buffer with a NUL, so
> + * the terminating '\0' has to be part of the write.
> + */
> +#define TRIG_LEN(trig) ((long)strlen(trig) + 1)
> +#define WRITE_TRIG(fd, trig) write((fd), (trig), TRIG_LEN(trig))
> +
> +#define SET_TRIG(fd, trig) \
> +	SAFE_WRITE(SAFE_WRITE_ALL, (fd), (trig), TRIG_LEN(trig))
> +
> +static void first_write_succeeds(void)
> +{
> +	int fd = SAFE_OPEN(PSI_MEM, O_RDWR);
> +
> +	TST_EXP_VAL(WRITE_TRIG(fd, TRIG_A), TRIG_LEN(TRIG_A),
> +		    "first write to a fresh fd");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void second_write_ebusy(void)
> +{
> +	int fd = SAFE_OPEN(PSI_MEM, O_RDWR);
> +
> +	SET_TRIG(fd, TRIG_A);
> +
> +	TST_EXP_FAIL2(WRITE_TRIG(fd, TRIG_B), EBUSY,
> +		      "second write to the same fd");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void dup_fd_shares_trigger(void)
> +{
> +	int fd = SAFE_OPEN(PSI_MEM, O_RDWR);
> +	int dup_fd = SAFE_DUP(fd);
> +
> +	SET_TRIG(fd, TRIG_A);
> +
> +	TST_EXP_FAIL2(WRITE_TRIG(dup_fd, TRIG_B), EBUSY,
> +		      "write to a dup() of an fd that has a trigger");
> +
> +	SAFE_CLOSE(dup_fd);
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void two_fds_different_triggers(void)
> +{
> +	int fd1 = SAFE_OPEN(PSI_MEM, O_RDWR);
> +	int fd2 = SAFE_OPEN(PSI_MEM, O_RDWR);
> +
> +	TST_EXP_VAL(WRITE_TRIG(fd1, TRIG_A), TRIG_LEN(TRIG_A),
> +		    "fd1 write trigger A");
> +	TST_EXP_VAL(WRITE_TRIG(fd2, TRIG_B), TRIG_LEN(TRIG_B),
> +		    "fd2 write trigger B");
> +
> +	SAFE_CLOSE(fd1);
> +	SAFE_CLOSE(fd2);
> +}
> +
> +static void two_fds_same_trigger(void)
> +{
> +	int fd1 = SAFE_OPEN(PSI_MEM, O_RDWR);
> +	int fd2 = SAFE_OPEN(PSI_MEM, O_RDWR);
> +
> +	TST_EXP_VAL(WRITE_TRIG(fd1, TRIG_A), TRIG_LEN(TRIG_A),
> +		    "fd1 write trigger A");
> +	TST_EXP_VAL(WRITE_TRIG(fd2, TRIG_A), TRIG_LEN(TRIG_A),
> +		    "fd2 write trigger A again");
> +
> +	SAFE_CLOSE(fd1);
> +	SAFE_CLOSE(fd2);
> +}
> +
> +static void trigger_after_close(void)
> +{
> +	int fd = SAFE_OPEN(PSI_MEM, O_RDWR);
> +
> +	SET_TRIG(fd, TRIG_A);
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN(PSI_MEM, O_RDWR);
> +
> +	TST_EXP_VAL(WRITE_TRIG(fd, TRIG_B), TRIG_LEN(TRIG_B),
> +		    "write a trigger after closing the previous fd");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void (*const tests[])(void) = {
> +	first_write_succeeds,
> +	second_write_ebusy,
> +	dup_fd_shares_trigger,
> +	two_fds_different_triggers,
> +	two_fds_same_trigger,
> +	trigger_after_close,
> +};
> +
> +static void run(unsigned int n)
> +{
> +	tests[n]();
> +}
> +
> +static void setup(void)
> +{
> +	char buf[64];
> +	int fd;
> +
> +	if (access(PSI_MEM, F_OK))
> +		tst_brk(TCONF, "%s not available (CONFIG_PSI not set)", PSI_MEM);

Here as well, misleading.

> +	fd = SAFE_OPEN(PSI_MEM, O_RDONLY);
> +
> +	/* psi=0 on the kernel command line makes the interface return EOPNOTSUPP */
> +	if (read(fd, buf, sizeof(buf)) < 0) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "PSI is disabled (psi=0 on kernel command line)");
> +
> +		tst_brk(TBROK | TERRNO, "read(%s) failed", PSI_MEM);
> +	}
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tests),
> +	.test = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_REQ, CAP_SYS_RESOURCE),
> +		{}
> +	},
> +	.needs_kconfigs = (const char *const[]) {
> +		"CONFIG_PSI=y",
> +		NULL
> +	},

Here as well .save_restore

> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
