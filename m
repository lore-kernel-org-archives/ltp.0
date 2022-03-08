Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63C2C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 13:00:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FD653C21F5
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 14:00:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B8993C1BA2
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 13:59:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 803356006FA
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 13:59:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72CD9210FE;
 Tue,  8 Mar 2022 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646744391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fnpzuxO7CkyQTJTg9wt63T7ru/CJFA0ZKS3gQIYsPXU=;
 b=kwlUhvbVioF5TGRGtVhnD68fXS5o3U46sJvrQXgIsBYNLtDrzSmSZa70juX3u2mhlErdBX
 vfLQEvJLmafEjEc0bX8pYUWr2+6ngqklXCbT9TvdctEi2b+XN1dLw9gDod+/m31lQVhkFj
 YvFFmp0wSs8dADcgH1Fl3ipvhwm9oSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646744391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fnpzuxO7CkyQTJTg9wt63T7ru/CJFA0ZKS3gQIYsPXU=;
 b=WwBiBEykAOCH0C1kjSQT8wMCOjCcTzX8EQ9Zi43ODRJXfCfXp2lChRC5ASA0SUziCcKYmU
 bZNKAZm4etrUq+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FE6613CB1;
 Tue,  8 Mar 2022 12:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IhCqFUdTJ2KiEAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Mar 2022 12:59:51 +0000
Date: Tue, 8 Mar 2022 14:02:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YidT0piJ3+e9FvhE@yuki>
References: <20220308073709.4125677-1-liwang@redhat.com>
 <20220308073709.4125677-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220308073709.4125677-3-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: enhance .save_restore to support set
 expected value
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
Cc: Bruno Goncalves <bgoncalv@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This extends that .save_restore support set new expected value after
> saving the knob's original, which also avoids additionally checking
> before using the file at other places.
> 
> And, export function tst_sys_conf_set() can be singly used for setting
> new value of knob in the whole LTP.
> 
> Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Jan Stancek <jstancek@redhat.com>
> ---
>  doc/c-test-api.txt     | 16 +++++++++-------
>  include/tst_sys_conf.h |  6 ++++++
>  include/tst_test.h     |  2 +-
>  lib/tst_sys_conf.c     | 13 +++++++++++++
>  lib/tst_test.c         |  9 +++++----
>  5 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 28383ccee..3e167a1d3 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1559,12 +1559,14 @@ itself is not available on the system.
>  1.27 Saving & restoring /proc|sys values
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -LTP library can be instructed to save and restore value of specified
> +LTP library can be instructed to save and restore the value of specified
                                                      ^
						      This shouldn't be
						      here as we do not
						      talk about
						      specific proc/sys
						      files but about
						      any proc/sys file

>  (/proc|sys) files. This is achieved by initialized tst_test struct
> -field 'save_restore'. It is a 'NULL' terminated array of strings where
> -each string represents a file, whose value is saved at the beginning
> -and restored at the end of the test. Only first line of a specified
> -file is saved and restored.
> +field 'save_restore'. It is a NULL-terminated array of struct
> +'tst_path_val' where each tst_path_val.path represents a file, whose
> +value is saved at the beginning and restored at the end of the test.
> +If pass a value to tst_path_val.value that will be set to the knob
> +correspondingly, NULL means do nothing else but save the original value.

"If non-NULL value is passed it is written to the respective file at the
beginning of the test."

> +Only the first line of a specified file is saved and restored.
>  
>  Pathnames can be optionally prefixed to specify how strictly (during
>  'store') are handled errors:
> @@ -1578,8 +1580,8 @@ Pathnames can be optionally prefixed to specify how strictly (during
>  
>  [source,c]
>  -------------------------------------------------------------------------------
> -static const char *save_restore[] = {
> -	"/proc/sys/kernel/core_pattern",
> +static const struct tst_path_val save_restore[] = {
> +	{"/proc/sys/kernel/core_pattern", NULL},
>  	NULL,
>  };
>  
> diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
> index 507a552e8..b7bbe36fc 100644
> --- a/include/tst_sys_conf.h
> +++ b/include/tst_sys_conf.h
> @@ -5,8 +5,14 @@
>  #ifndef TST_SYS_CONF_H__
>  #define TST_SYS_CONF_H__
>  
> +struct tst_path_val {
> +        const char *path;
> +        const char *val;
> +};
> +
>  int tst_sys_conf_save_str(const char *path, const char *value);
>  int tst_sys_conf_save(const char *path);
> +void tst_sys_conf_set(const char *path, const char *value);
>  void tst_sys_conf_restore(int verbose);
>  void tst_sys_conf_dump(void);
>  
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 816fab4dd..e514efa76 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -259,7 +259,7 @@ struct tst_test {
>  	 * NULL terminated array of (/proc, /sys) files to save
>  	 * before setup and restore after cleanup
>  	 */
> -	const char * const *save_restore;
> +	const struct tst_path_val const *save_restore;
>  
>  	/*
>  	 * NULL terminated array of kernel config options required for the
> diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
> index d7118f15f..f9460d228 100644
> --- a/lib/tst_sys_conf.c
> +++ b/lib/tst_sys_conf.c
> @@ -96,6 +96,19 @@ int tst_sys_conf_save(const char *path)
>  	return tst_sys_conf_save_str(path, line);
>  }
>  
> +void tst_sys_conf_set(const char *path, const char *value)
> +{
> +	char flag = path[0];
> +	if (flag  == '?' || flag == '!')
> +		path++;
> +
> +	if (access(path, F_OK) != 0)
> +		tst_brk(TBROK | TERRNO, " The path %s is not exist", path);
                                         ^            ^
					 |           does
                                      useless space?

Also do we really have to check for the file existence here? The
SAFE_FILE_PRINTF() will TBROK if the fopen() fails anyways.


> +	if (value)
> +		SAFE_FILE_PRINTF(path, "%s", value);
> +}
> +
>  void tst_sys_conf_restore(int verbose)
>  {
>  	struct tst_sys_conf *i;
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 9e745c537..fe2e2bb6c 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1105,11 +1105,12 @@ static void do_setup(int argc, char *argv[])
>  		tst_tmpdir();
>  
>  	if (tst_test->save_restore) {
> -		const char * const *name = tst_test->save_restore;
> +		const struct tst_path_val const *pvl = tst_test->save_restore;
>  
> -		while (*name) {
> -			tst_sys_conf_save(*name);
> -			name++;
> +		while (pvl->path) {
> +			if (!tst_sys_conf_save(pvl->path))
> +				tst_sys_conf_set(pvl->path, pvl->val);

Maybe it would be cleaner if we added tst_sys_conf_save_set() function
instead of tst_sys_conf_set() that would do both, saved the value and
set new one if non-NULL.

> +			pvl++;
>  		}
>  	}
>  
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
