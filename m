Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872CCC5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 09:58:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF3963CA31A
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 11:58:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AB7B3CA010
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 11:58:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A82AA600052
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 11:58:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C66EA5C0AC;
 Thu,  5 Jun 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5677B1373E;
 Thu,  5 Jun 2025 09:58:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7co1EERqQWjUZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 09:58:28 +0000
Date: Thu, 5 Jun 2025 11:58:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250605095826.GB1206250@pevik>
References: <20250605-lsm_fix_attr_is_overset-v2-1-dd10ddb04238@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605-lsm_fix_attr_is_overset-v2-1-dd10ddb04238@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: C66EA5C0AC
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lsm: fix overset attr test
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 ltp@lists.linux.it, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> LSM(s) usually handle their own internal errors in a different way,
> so the right way to check if they return error, is to verify that the
> common return value is -1. This is the max we can do, since errno might
> vary according to the LSM implementation.

> At the same time, overset attr test is _not_ checking if attr is
> overset, but rather checking if attr is out-of-bounds, considering OR
> operator as a valid way to generate an invalid value with
> LSM_ATTR_CURRENT. This is not correct, since any OR operation using
> LSM_ATTR_CURRENT will generate a valid value for the LSM(s) code. So we
> remove this test that doesn't make much sense at the moment and replace
> it with an "invalid attr test" instead.

Thanks for the fix, LGTM.

Fixes: ad4ab6ce4f ("Add lsm_set_self_attr01 test")
Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> This patch will fix all false positive errors, where LSM(s) might
> be implemented in a different way. We just skip errno check.

> This will also fix:
> https://openqa.opensuse.org/tests/5087893#step/lsm_set_self_attr01/8
> ---
> Changes in v2:
> - remove exp_errno from struct
> - change attr overset test
> - Link to v1: https://lore.kernel.org/r/20250604-lsm_fix_attr_is_overset-v1-1-46ff86423a14@suse.com
> ---
>  testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

> diff --git a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> index caccdda7ecf2edaac1fa8e2dc2ccdd0aff020804..cde9c2e706ed607024dff362b7ff00cbcef1d6a5 100644
> --- a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> +++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> @@ -23,28 +23,24 @@ static struct tcase {
>  	struct lsm_ctx **ctx;
>  	uint32_t *size;
>  	uint32_t flags;
> -	int exp_errno;
>  	char *msg;
>  } tcases[] = {
>  	{
>  		.attr = LSM_ATTR_CURRENT,
>  		.ctx = &ctx_null,
>  		.size = &ctx_size,
> -		.exp_errno = EFAULT,
>  		.msg = "ctx is NULL",
>  	},
>  	{
>  		.attr = LSM_ATTR_CURRENT,
>  		.ctx = &ctx,
>  		.size = &ctx_size_small,
> -		.exp_errno = EINVAL,
>  		.msg = "size is too small",
>  	},
>  	{
>  		.attr = LSM_ATTR_CURRENT,
>  		.ctx = &ctx,
>  		.size = &ctx_size_big,
> -		.exp_errno = E2BIG,
>  		.msg = "size is too big",
>  	},
>  	{
> @@ -52,15 +48,13 @@ static struct tcase {
>  		.ctx = &ctx,
>  		.size = &ctx_size,
>  		.flags = 1,
> -		.exp_errno = EINVAL,
>  		.msg = "flags must be zero",
>  	},
>  	{
> -		.attr = LSM_ATTR_CURRENT | LSM_ATTR_EXEC,
> +		.attr = -1000,
>  		.ctx = &ctx,
>  		.size = &ctx_size,
> -		.exp_errno = EINVAL,
> -		.msg = "attr is overset",
> +		.msg = "attr is invalid",
>  	}
>  };

> @@ -77,9 +71,9 @@ static void run(unsigned int n)
>  	ctx_size_small = 1;
>  	ctx_size_big = ctx_size + 1;

> -	TST_EXP_FAIL(lsm_set_self_attr(tc->attr, *tc->ctx, *tc->size, tc->flags),
> -	      tc->exp_errno,
> -	      "%s", tc->msg);
> +	TST_EXP_EXPR(lsm_set_self_attr(
> +		tc->attr, *tc->ctx, *tc->size, tc->flags) == -1,
> +		"%s", tc->msg);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
