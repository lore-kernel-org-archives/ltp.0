Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57CAC4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 07:41:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 859093CEA41
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 08:40:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35A503C88CE
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 08:40:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 82BD11A000B1
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 08:40:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D5061FEDD;
 Mon, 30 Oct 2023 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698651647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x+EeMOmGVBeMKiDXmh3GTaAgRU2ztEyVjnS6NmvFh10=;
 b=0XNYfApblTf3tH+GD2dBfnN16zKuNLz2XQWC6wR2+clg6pREbT8MwMHRhbMi75aVv2o2Ez
 uJWqjgOkwH7K9ygcRaifY6LnuIJJt6+GIQsr0oXoZxlkEvbCSHPa3tP7iqR90ECMh3PcZl
 lOK1Y9miJTipmBT6qbgZk8wPy3R48tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698651647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x+EeMOmGVBeMKiDXmh3GTaAgRU2ztEyVjnS6NmvFh10=;
 b=OEi1iG3FkAw4DO7tiDvvE1kv/l51HThc8hSuS7HNFBF6Np8VVoZUijEZsCtceq720XkVjv
 5fITphgsngAJb3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03AE0138F8;
 Mon, 30 Oct 2023 07:40:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AzrnOv5dP2WYUQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 30 Oct 2023 07:40:46 +0000
Date: Mon, 30 Oct 2023 08:40:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20231030074045.GB9167@pevik>
References: <20231027190029.3820505-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231027190029.3820505-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] getpgid01: On Android,
 pgid(1) is 0 instead of 1
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> Android's init does not call setpgid(0, 0) so it does not have pgid=1.

> In either case, the pgid should match /proc/1/stat, so compare
> getpgid(1) against that.

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  testcases/kernel/syscalls/getpgid/getpgid01.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
> index 479fe5dcb..de05a434b 100644
> --- a/testcases/kernel/syscalls/getpgid/getpgid01.c
> +++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
> @@ -13,6 +13,14 @@

>  #include "tst_test.h"

> +static int get_init_pgid()
static int get_init_pgid(void)

We still use -std=gnu99, thus we need that otherwise compiler complains
warning: old-style function definition [-Wold-style-definition].

It can be fixed during merge.

Kind regards,
Petr

> +{
> +	int pgid;
> +
> +	SAFE_FILE_SCANF("/proc/1/stat", "%*d %*s %*c %*d %d", &pgid);
> +	return pgid;
> +}
> +
>  static void run(void)
>  {
>  	pid_t pid_1, child_pid, pgid;
> @@ -37,7 +45,7 @@ static void run(void)
>  		TST_EXP_EQ_LI(TST_RET, pgid);

>  		TST_EXP_PID(getpgid(1));
> -		TST_EXP_EQ_LI(TST_RET, 1);
> +		TST_EXP_EQ_LI(TST_RET, get_init_pgid());
>  	}

>  	tst_reap_children();

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
