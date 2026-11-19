Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2A606A320
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=l+RXI/rj;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RZGpTRDN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795074144; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7+dRv2ADhpFI+f740PMXqu9miWR+BJhiGxgu50MGKsc=;
 b=l+RXI/rjWUMdLivAMfZBACitr3mehGWB+VuLiss4mXUsWJCNXU9OcDvkuqm0J9rR0Fchp
 ru1PVVvXR6TwdF/Nzj8/A7btVlxhz7q2v7idZlaZ2HDQBPIOXTdi9xxDoucDkQC5amKsbjA
 5USddfXNu2nMrwGmRIqSXlaffzGagEM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081D53E92B8
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 08:42:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6485F3E1539
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 08:42:03 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE9B91000A00
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 08:42:02 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso18700255e9.3
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 23:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795074122; x=1795678922; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tZAX6syDzPMEbRvny8xROEIn2PVEtSbYt3rYUkBwQRs=;
 b=RZGpTRDNAXnRgia05HgmyfmJhNvlDIrIsPnZ0dWgtgmdrfUrp6V69JHD28yODHhsXh
 FPpOFMDkPFS+TWs2zkyl/VXO46cI3S8rr+BMiujQiIP6pqmE12FmvKPqkU8Pphr4WdOH
 YXknQ7UCiPm8CILuu+P0MF4JbXN9CqoDDy5FbLJiuWliWjbAzcgWTMRe5272E+1rxpmH
 wb8JTqVDzDKOl+XoSQbyZH3TNbgUaj30ABvKvmSxkNBlERWLNA+YQo2P8oWaDmr3POns
 k9o06a8YzPfJlt0fTVtRn02jGGNurj/Jc+S6Q7wOsNRfKd1B4dJ4WvEpQeNOV0o8zV0p
 EI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795074122; x=1795678922;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tZAX6syDzPMEbRvny8xROEIn2PVEtSbYt3rYUkBwQRs=;
 b=UPnjOfcF0jt8K/ZD5Vm/9b+1WW1yU4vi2wzcI82GjLKnWTVsG1RvQjXCGz4+mGNRJB
 U/XKFd28jNTczXQZBKLc4UCP2B/orUyAfFvcwB577VaGe0KEoCgDfWa09LRCO7/ahBwL
 tm6kc5hWdBHYd54cQjqv/V4u1DLKvPE/owc2/jP8yfCRMHMBIyBR/LjWuK613WO0E22S
 xOZTMrHQIe4WBYQTAZzdfr8m0Z3n6VydoLQu4zXyxEGmAa/4Q2I9md/dPz065Nd7skU+
 d2D7HVnr2n1OITImapzlDNbPDk2RoDQW7jCKOuHFcoadZcWED1FnkcUnqWYFsC4wUWoe
 JjXQ==
X-Gm-Message-State: APuU4Z9q6SRuxjcyAel57ly3zwa6vZ0YrGJ0M83UxE3BGzIkwMOdUODg
 OGRhaYrXXotkA/UKfWnvv4iQsHTWCSd7CSwEy9+aaeX2zQzVRKEEApM6fqPBLgI43WT3Z5Lo3ID
 lkhaY7g==
X-Gm-Gg: AYBFou18tSiwxsBH2K4x+IqSpSjaXvin0y86EUUcscR7vcNyqw+aEPkJuyoB0WfoF1c
 fJDVv6ZPdJppDEhYAx8b/cdZ+xBEqHze6FB88lLwiceY9MZCQfQG+PkTbxem1bI0KORtev/wxv8
 sshDQv+vvbimhiVZUfXU5O0r3nJ61MSqyYaRgn5s0yq1TYNt0XXCc+/b4K640vqIAFXiLYt3IBZ
 3W0mzsKbhwdD8c1T6CWpGo951wluIe1m+TO7Uyv2sdOM65SqeLuGTEt1lBLajeG/360ARn3pI4T
 BanB5coKpZ7hGvpf6DEdrlgNCl7ek+Bw9xdNGIerDAm03FJhjlgPsMB07c7vhdCEryi1cc74yyx
 Z7SJ7S9SDEhgOsmEYJGmB4cC+3w5oCc4bICKP5O1ONwQLTAmyccvYlvl+yg4HfdD1LL1NVqGOP7
 yGe/OVeDMenPTX0WFqNV9JnJb5ba/9fx0HbmcZjhUGCTYbH5KzVEc9ak0t4sPy8zBBU/zsdV76b
 TwTb02XODQLEbyJl/Fjz6xqmtjAn8vipYp0z9C7JG+XeQd8YR7ogAEvQf6s5l3/vK2HiKhFkxNO
 /3JVg/lcMLPY2X3N2SOZJhtfr70VDA4mnNrBjfJzaLHWxE5MQRLpCHwmPHo7H6UuKr+sV3y/BBm
 Wal5xOvt8tZezGjauAevQXLaXhIY/Ct8VuSiO9J/8XP8JkNpbmvbdhfLiX7VU12fqFqat+oPRoT
 gtr0xCETcH
X-Received: by 2002:a05:600c:4e02:b0:4bb:6b59:aac3 with SMTP id
 5b1f17b1804b1-4bb7da44054mr97571215e9.29.1795074122126; 
 Wed, 18 Nov 2026 23:42:02 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e804d2sm16486285e9.5.2026.11.18.23.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 23:42:01 -0800 (PST)
Date: Thu, 19 Nov 2026 07:42:00 +0000
To: Stephen Bertram <sbertram@redhat.com>
Message-ID: <av6oSEzI9Tv0EH67@autotest-wegao.qe.prg2.suse.org>
References: <20261116150911.667095-1-sbertram@redhat.com>
 <20261118225144.411166-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118225144.411166-1-sbertram@redhat.com>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] crypto/af_alg09: Test CVE-2026-52972
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Nov 18, 2026 at 05:51:43PM -0500, Stephen Bertram via ltp wrote:
> From: Stephen Bertram <sbertram@redhat.com>
> 
> Add a regression test for the missing cap on the AEAD associated data
> length.  Kernel commit e4c06479d705 ("crypto: af_alg - Cap AEAD AD
> length to 0x80000000") rejects ALG_SET_AEAD_ASSOCLEN values greater
> than or equal to 0x80000000; without it af_alg_sendmsg() accepts any
> 32-bit value.
> 
> The test opens an AF_ALG AEAD request socket, sets ALG_OP_DECRYPT and
> ALG_SET_AEAD_ASSOCLEN to 0x7fffffff, which must be accepted, and to
> 0x80000000 and 0xffffffff, which must fail with EINVAL.  It does not
> call recvmsg(), so the test only depends on the control-message
> validation.
> 
> Since Linux 7.3, /proc/sys/crypto/af_alg_restrict defaults to 1 and bind()
> of gcm(aes) fails with ENOENT. When that file exists and is writable, the
> test sets it to 0 for the run and restores the previous value.
> 
> Assisted-by: Cursor:Grok-4.7
> Signed-off-by: Stephen Bertram <sbertram@redhat.com>
> ---
>  runtest/crypto                     |   1 +
>  runtest/cve                        |   1 +
>  testcases/kernel/crypto/.gitignore |   1 +
>  testcases/kernel/crypto/af_alg09.c | 112 +++++++++++++++++++++++++++++
>  4 files changed, 115 insertions(+)
>  create mode 100644 testcases/kernel/crypto/af_alg09.c
> 
> diff --git a/runtest/crypto b/runtest/crypto
> index a8330db9f..082b906c1 100644
> --- a/runtest/crypto
> +++ b/runtest/crypto
> @@ -6,6 +6,7 @@ af_alg05 af_alg05
>  af_alg06 af_alg06
>  af_alg07 af_alg07
>  af_alg08 af_alg08
> +af_alg09 af_alg09
>  pcrypt_aead01 pcrypt_aead01
>  crypto_user01 crypto_user01
>  crypto_user02 crypto_user02
> diff --git a/runtest/cve b/runtest/cve
> index 0fe25cd83..ccd7e3db3 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -89,6 +89,7 @@ cve-2023-0461 setsockopt10
>  cve-2023-31248 nft02
>  cve-2023-52879 fanotify25
>  cve-2026-43499 ghostlock
> +cve-2026-52972 af_alg09
>  cve-2026-53362 setsockopt11
>  cve-2026-64600 refluxfs
>  cve-2026-99999 pwnescape
> diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
> index aca016b62..e1890d975 100644
> --- a/testcases/kernel/crypto/.gitignore
> +++ b/testcases/kernel/crypto/.gitignore
> @@ -6,6 +6,7 @@ af_alg05
>  af_alg06
>  af_alg07
>  af_alg08
> +af_alg09
>  pcrypt_aead01
>  crypto_user01
>  crypto_user02
> diff --git a/testcases/kernel/crypto/af_alg09.c b/testcases/kernel/crypto/af_alg09.c
> new file mode 100644
> index 000000000..423eee431
> --- /dev/null
> +++ b/testcases/kernel/crypto/af_alg09.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Red Hat, Inc.
> + */
> +
> +/*\
> + * Test for CVE-2026-52972.
> + *
> + * Verify that the AF_ALG AEAD interface rejects an associated data length
> + * greater than or equal to 0x80000000 with EINVAL.
> + *
> + * Before kernel commit e4c06479d705 ("crypto: af_alg - Cap AEAD AD length to
> + * 0x80000000") af_alg_sendmsg() accepted any 32-bit ALG_SET_AEAD_ASSOCLEN
> + * value.
> + */
> +
> +#include "tst_test.h"
> +#include "tst_af_alg.h"
> +#include "lapi/socket.h"
> +
> +#define ASSOCLEN_LIMIT 0x80000000U
> +#define SEND_SIZE 16
> +
> +static int algfd = -1;
> +
> +/*
> + * Send SEND_SIZE bytes with ALG_SET_AEAD_ASSOCLEN set to assoclen and
> + * ALG_SET_OP set to ALG_OP_DECRYPT.  Return the sendmsg() return value, with
> + * errno from sendmsg() preserved.
> + */
> +static ssize_t send_assoclen(int reqfd, uint32_t assoclen)
> +{
> +	char data[SEND_SIZE] = {0};
> +	char control[CMSG_SPACE(sizeof(uint32_t)) * 2];
> +	struct iovec iov = {
> +		.iov_base = data,
> +		.iov_len = sizeof(data),
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +		.msg_control = control,
> +		.msg_controllen = sizeof(control),
> +	};
> +	struct cmsghdr *cmsg;
> +	uint32_t op = ALG_OP_DECRYPT;
> +
> +	memset(control, 0, sizeof(control));
> +
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	cmsg->cmsg_level = SOL_ALG;
> +	cmsg->cmsg_type = ALG_SET_OP;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(op));
> +	memcpy(CMSG_DATA(cmsg), &op, sizeof(op));
> +
> +	cmsg = CMSG_NXTHDR(&msg, cmsg);
> +	cmsg->cmsg_level = SOL_ALG;
> +	cmsg->cmsg_type = ALG_SET_AEAD_ASSOCLEN;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(assoclen));
> +	memcpy(CMSG_DATA(cmsg), &assoclen, sizeof(assoclen));
> +
> +	return sendmsg(reqfd, &msg, 0);
> +}
> +
> +static const uint32_t assoclens[] = {
> +	0x7fffffff,
> +	ASSOCLEN_LIMIT,
> +	0xffffffff,
> +};
> +
> +static void run(unsigned int i)
> +{
> +	int reqfd = tst_alg_accept(algfd);
> +
> +	if (assoclens[i] < ASSOCLEN_LIMIT) {
> +		TST_EXP_VAL(send_assoclen(reqfd, assoclens[i]), SEND_SIZE,
> +			"assoclen=%#x", assoclens[i]);
> +	} else {
> +		TST_EXP_FAIL2(send_assoclen(reqfd, assoclens[i]), EINVAL,
> +			"assoclen=%#x", assoclens[i]);
> +	}
> +
> +	SAFE_CLOSE(reqfd);
> +}
> +
> +static void setup(void)
> +{
> +	algfd = tst_alg_setup("aead", "gcm(aes)", NULL, 16);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (algfd != -1)
> +		SAFE_CLOSE(algfd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(assoclens),
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/crypto/af_alg_restrict", "0",
> +			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
Consider using TST_SR_SKIP_RO instead of TST_SR_TCONF_RO here if no root needed.
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "e4c06479d7059888adf2f22bc1ebcf053bf691a2"},
> +		{"CVE", "2026-52972"},
> +		{}
> +	},
> +};
> -- 
> 2.56.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
