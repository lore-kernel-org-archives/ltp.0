Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078BDC54EBD
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 11:04:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB5173CCA69
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 12:04:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ECD93CB535
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 12:03:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9BD761000955
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 12:03:53 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AA51B21F65;
 Thu, 12 Jan 2023 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673521432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VlPOdJ0GH98bFANF9RacrBo2WII7NtggSQ7Z2wAw8Rw=;
 b=VbfRD8EoJ7E2oOMxedS32yBClIDxhbB1f7cU/fF30H1hkzARM9lyUxBbZRx5K5uTnLk1w+
 8HcdjNh0Gc5km1E2oy0mtUggPk8Q0Te04T8SrJyaIrIfO2xwVtANTWy/5xVlmEguQBTNOV
 4s8ffltf+/LpREhiaXGWzjjkc4ZHvRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673521432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VlPOdJ0GH98bFANF9RacrBo2WII7NtggSQ7Z2wAw8Rw=;
 b=D2+1UUfGWaTIxTO7Y4vm0MCVy1snIvGaovwGrKzWTnqjTFUqxTaDFw4dXlBg6NL02M9SzY
 A65e/N8sa/UbEzDA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 42E952C141;
 Thu, 12 Jan 2023 11:03:52 +0000 (UTC)
References: <20230111142316.A0DBECA25@mail.steuer-voss.de>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Nikolaus Voss <nikolaus.voss@haag-streit.com>
Date: Thu, 12 Jan 2023 11:03:39 +0000
Organization: Linux Private Site
In-reply-to: <20230111142316.A0DBECA25@mail.steuer-voss.de>
Message-ID: <87lem8hv54.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl/keyctl09.c: fix test encrypted
 key
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
Reply-To: rpalethorpe@suse.de
Cc: Yael Tzur <yaelt@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, Thanks!

Nikolaus Voss <nikolaus.voss@haag-streit.com> writes:

> This commit fixes the test for adding encrypted keys with unencrypted data.
> Unencryted data must be provided hex-ascii encoding. Due to a kernel
> bug, the unencypted data was not decoded to binary thus the length of
> the key was only half the specified key size. This patch doubles the key
> size.
>
> Fixes: 342e7a0dd ("syscalls/keyctl09: test encrypted keys with provided decrypted data.")
> Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> ---
> v2: add linux-git tag for kernel fix, only correct test input data
>
>  testcases/kernel/syscalls/keyctl/keyctl09.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
> index c88c481b9..cfd5f7e5f 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl09.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
> @@ -13,8 +13,8 @@
>  #include "tst_test.h"
>  #include "lapi/keyctl.h"
>  
> -#define ENCRYPTED_KEY_VALID_PAYLOAD	"new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaa"
> -#define ENCRYPTED_KEY_INVALID_PAYLOAD	"new enc32 user:masterkey 32 plaintext123@123!123@123!123@123"
> +#define ENCRYPTED_KEY_VALID_PAYLOAD	"new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaaabcdefABCDEF1234567890aaaaaaaaaa"
> +#define ENCRYPTED_KEY_INVALID_PAYLOAD	"new enc32 user:masterkey 32 plaintext123@123!123@123!123@123plaintext123@123!123@123!123@123"
>  
>  static void do_test(void)
>  {
> @@ -28,7 +28,8 @@ static void do_test(void)
>  
>  	TST_EXP_POSITIVE(add_key("encrypted", "ltptestkey1",
>  			    ENCRYPTED_KEY_VALID_PAYLOAD,
> -			    60, KEY_SPEC_PROCESS_KEYRING));
> +			    strlen(ENCRYPTED_KEY_VALID_PAYLOAD),
> +			    KEY_SPEC_PROCESS_KEYRING));
>  
>  	if (!TST_PASS)
>  		return;
> @@ -39,7 +40,8 @@ static void do_test(void)
>  		return;
>  
>  	TST_EXP_FAIL2(add_key("encrypted", "ltptestkey2",
> -			    ENCRYPTED_KEY_INVALID_PAYLOAD, 60,
> +			    ENCRYPTED_KEY_INVALID_PAYLOAD,
> +			    strlen(ENCRYPTED_KEY_INVALID_PAYLOAD),
>  			    KEY_SPEC_PROCESS_KEYRING), EINVAL);
>  
>  	keyctl(KEYCTL_CLEAR, KEY_SPEC_PROCESS_KEYRING);
> @@ -50,5 +52,9 @@ static struct tst_test test = {
>  	.needs_kconfigs = (const char *[]) {
>  		"CONFIG_USER_DECRYPTED_DATA=y",
>  		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{ "linux-git", "5adedd42245af"},
> +		{}
>  	}
>  };
> -- 
> 2.34.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
