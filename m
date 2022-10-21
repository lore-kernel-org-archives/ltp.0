Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B30C38A2D
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 20:35:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4A113CB270
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 22:35:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EC653CACEF
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 22:34:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3940B1000413
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 22:34:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1539D21A08;
 Fri, 21 Oct 2022 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666384495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvRZf83HOCu9sNpjsG70LfAxsTRGIk8RRchxXlww2zk=;
 b=d+kVhIXv37MwsrPXGNvAbkxFMZXqylNkRYSMQLALlluAG6Dij0ImmoFtvDaCBH7X00DQVz
 iCo8i5QNz8blxUOh0aP3x2rJ76dpPPso2+fuZBm/1l8ODBeBPxkLCY2qcdSlx0IiNdWJzZ
 i+IMAl5UVj+eNoBZ71mVQ4LN6LLeI4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666384495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvRZf83HOCu9sNpjsG70LfAxsTRGIk8RRchxXlww2zk=;
 b=u2EQqbC0h5qrwD0QeP6CKQOMlkDdy7N8qnVsozDZdR9ecR4QEG1wng02Qh+GxDYKkItkzA
 svGI2DNY+RZbzDCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAFD11331A;
 Fri, 21 Oct 2022 20:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id t+rxLm4CU2NjRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Oct 2022 20:34:54 +0000
Date: Fri, 21 Oct 2022 22:34:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y1MCbP1yjLOuoPLb@pevik>
References: <20221021155740.8339-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221021155740.8339-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Check whether path is writable
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

[ Cc Jan, who implemented the original behavior ]

> Tests using the .save_restore functionality currently cannot run
> without root privileges at all because the test will write
> into the path at least at the end and trigger error, even when
> the config paths are flagged as optional. Check whether .save_restore
> paths are writable and handle negative result the same way as if
> the path does not exist.
Thanks for this effort!

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> This is the first part of sysfile handling fixes to allow running some
> tests without root privileges again. I think this is a good enough solution
> for the save_restore part but we should discuss a few open questions first:

> 1) Is it OK to fail early during sysfile save when the test would otherwise
>    run fine but throw TWARN at the end because the sysfile is read-only?
I don't think that would be a good change.

> 2) Should the '?' flag skip read-only files as if they don't exist?
>    Alternatively, we could still let the '?' flag fail trying to write
>    into read-only sysfiles and instead introduce a new flag for cases where
>    read-only file should be skipped.
Looking at files which use '?', some of them (mostly network related, I guess
written/rewritten by Martin) use SAFE_TRY_FILE_PRINTF() on
/proc/sys/user/max_user_namespaces. It looks to me these need to to skip
read-only files, i.e. define new flag with this behavior.


Kind regards,
Petr

>  doc/c-test-api.txt | 11 +++++------
>  lib/tst_sys_conf.c | 32 ++++++++++++++++++++++----------
>  2 files changed, 27 insertions(+), 16 deletions(-)

> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 64ee3397f..0f36b5a67 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1601,13 +1601,12 @@ If non-NULL value is passed it is written to the respective file at
>  the beginning of the test. Only the first line of a specified file
>  is saved and restored.

> -Pathnames can be optionally prefixed to specify how strictly (during
> -'store') are handled errors:
> +Pathnames can be optionally prefixed to specify how to handle missing or
> +read-only files:

> -* (no prefix) - test ends with 'TCONF', if file doesn't exist
> -* '?'         - test prints info message and continues,
> -                if file doesn't exist or open/read fails
> -* '!'         - test ends with 'TBROK', if file doesn't exist
> +* (no prefix) - test ends with 'TCONF'
> +* '?'         - test prints info message and continues, even on read error
> +* '!'         - test ends with 'TBROK'

>  'restore' is always strict and will TWARN if it encounters any error.

> diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
> index 003698825..1e381a249 100644
> --- a/lib/tst_sys_conf.c
> +++ b/lib/tst_sys_conf.c
> @@ -20,6 +20,22 @@ struct tst_sys_conf {

>  static struct tst_sys_conf *save_restore_data;

> +static void print_access_error(char flag, const char *err, const char *path)
> +{
> +	switch (flag) {
> +	case '?':
> +		tst_res(TINFO, "%s: '%s'", err, path);
> +		break;
> +
> +	case '!':
> +		tst_brk(TBROK|TERRNO, "%s: '%s'", err, path);
> +		break;
> +
> +	default:
> +		tst_brk(TCONF|TERRNO, "%s: '%s'", err, path);
> +	}
> +}
> +
>  void tst_sys_conf_dump(void)
>  {
>  	struct tst_sys_conf *i;
> @@ -59,16 +75,12 @@ int tst_sys_conf_save(const char *path)
>  		path++;

>  	if (access(path, F_OK) != 0) {
> -		switch (flag) {
> -		case '?':
> -			tst_res(TINFO, "Path not found: '%s'", path);
> -			break;
> -		case '!':
> -			tst_brk(TBROK|TERRNO, "Path not found: '%s'", path);
> -			break;
> -		default:
> -			tst_brk(TCONF|TERRNO, "Path not found: '%s'", path);
> -		}
> +		print_access_error(flag, "Path not found", path);
> +		return 1;
> +	}
> +
> +	if (access(path, W_OK) != 0) {
> +		print_access_error(flag, "Path is not writable", path);
>  		return 1;
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
