Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237A7C3DA7F
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 12:02:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86CCA3D2108
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 14:02:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F38CA3CB1E9
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 14:02:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BEFED1A00888
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 14:02:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B6A51F8BD;
 Mon, 12 Aug 2024 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723464143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsZ2qYH9+zfZFqEH3IeN2FUO+EQRfs8MbU7Czc2jXsQ=;
 b=xiU8XvQ//VNpLejWYYWjjEiPhoiZb6mHv6sSdA835NfAN7kw2iaQTtewd+sTaPGgcDcA/W
 ew1B6ogQdoYTYPiMT9BeOaynJKiyOUX7uKGEkkMDifFAifNoAaF6j8zbtSeKltA20sc5hQ
 JlDwvao04AoxUGj//1/XHV0rXi7XtNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723464143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsZ2qYH9+zfZFqEH3IeN2FUO+EQRfs8MbU7Czc2jXsQ=;
 b=Iqbi5nOQoLbcxMhXVZhTsJ5XwFepyplDX+XinbgK3X15n0Vq1/DDgYWphAmb4MTiFw2tHe
 BnNfhSOfmlrmSRBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723464143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsZ2qYH9+zfZFqEH3IeN2FUO+EQRfs8MbU7Czc2jXsQ=;
 b=xiU8XvQ//VNpLejWYYWjjEiPhoiZb6mHv6sSdA835NfAN7kw2iaQTtewd+sTaPGgcDcA/W
 ew1B6ogQdoYTYPiMT9BeOaynJKiyOUX7uKGEkkMDifFAifNoAaF6j8zbtSeKltA20sc5hQ
 JlDwvao04AoxUGj//1/XHV0rXi7XtNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723464143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsZ2qYH9+zfZFqEH3IeN2FUO+EQRfs8MbU7Czc2jXsQ=;
 b=Iqbi5nOQoLbcxMhXVZhTsJ5XwFepyplDX+XinbgK3X15n0Vq1/DDgYWphAmb4MTiFw2tHe
 BnNfhSOfmlrmSRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DA3D13A23;
 Mon, 12 Aug 2024 12:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OlqgFc/5uWYQYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 12 Aug 2024 12:02:23 +0000
Date: Mon, 12 Aug 2024 14:02:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20240812120221.GA195572@pevik>
References: <9a9b743304c2b6ad1a045f26d33304a3350cdf4c.1723458583.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9a9b743304c2b6ad1a045f26d33304a3350cdf4c.1723458583.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/execve04,
 creat07: skip for kernels 6.11 and later
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
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 Christian Brauner <brauner@kernel.org>,
 kernel test robot <oliver.sang@intel.com>, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> The behaviour is allowed since commit:
>   2a010c412853 ("fs: don't block i_writecount during exec")
> that landed in 6.11-rc1.

Thanks for noticing and fixing this!

It was reported some time ago:
https://lore.kernel.org/all/202406141431.2b72ca61-oliver.sang@intel.com/
https://lore.kernel.org/ltp/202407162117.7730986d-oliver.sang@intel.com/

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/creat/creat07.c   | 10 ++++++++++
>  testcases/kernel/syscalls/execve/execve04.c | 10 ++++++++++
>  2 files changed, 20 insertions(+)

> diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
> index 7bd32ab4d328..f157e1a8fbb2 100644
> --- a/testcases/kernel/syscalls/creat/creat07.c
> +++ b/testcases/kernel/syscalls/creat/creat07.c
> @@ -47,7 +47,17 @@ static void verify_creat(void)
>  	SAFE_WAITPID(pid, NULL, 0);
>  }

> +static void setup(void)
> +{
> +	if ((tst_kvercmp(6, 11, 0)) >= 0) {
> +		tst_brk(TCONF, "Skipping test, write to executed file is "
> +			"allowed since 6.11-rc1.\n"
> +			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
> +	}
> +}
> +
>  static struct tst_test test = {
> +	.setup = setup,
>  	.test_all = verify_creat,
>  	.needs_checkpoints = 1,
>  	.forks_child = 1,
> diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
> index 3bac642e5412..7bbfece85906 100644
> --- a/testcases/kernel/syscalls/execve/execve04.c
> +++ b/testcases/kernel/syscalls/execve/execve04.c
> @@ -65,7 +65,17 @@ static void do_child(void)
>  	exit(0);
>  }

> +static void setup(void)
> +{
> +	if ((tst_kvercmp(6, 11, 0)) >= 0) {
> +		tst_brk(TCONF, "Skipping test, write to executed file is "
> +			"allowed since 6.11-rc1.\n"
> +			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
> +	}
> +}
> +
>  static struct tst_test test = {
> +	.setup = setup,
>  	.test_all = verify_execve,
>  	.forks_child = 1,
>  	.child_needs_reinit = 1,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
