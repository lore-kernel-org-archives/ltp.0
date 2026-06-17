Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070E4CD98F2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 15:33:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FBC63E6BED
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 17:33:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E29563E2FA9
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 17:33:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3E8C12009F3
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 17:33:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7F6D75A87;
 Wed, 17 Jun 2026 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781710413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4xKtPdznEQQTaJCwugwiRJJumiWRojwEBIqWdxadzE=;
 b=x5G79OIkhcI04tsNcrQqSL08DMiRt7wzLgElk7LjsPF2lwqK8KTSMrjxme0mMlp1rv6ACW
 cnkDJyW3sGDCxfHc3K7o0OOZCL1ltMjCk4tX5Sph+QnOUAfbTfgWxBcumIfGGkPPor/0DS
 TZmP1q46EnZMWYl5GJ3Ji573ej1i97Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781710413;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4xKtPdznEQQTaJCwugwiRJJumiWRojwEBIqWdxadzE=;
 b=SO6z+O//Kn79E1kE+MAuP3pXeQYhnfFRyYzbIz2vqLMAxUeHUzOZNzeCnJBSqqzLX5L+Ki
 XPUa47BE9Wq4BMDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781710412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4xKtPdznEQQTaJCwugwiRJJumiWRojwEBIqWdxadzE=;
 b=QdIoJbfkLsAkfBggLnZimBWYV20fQA14IeaD8tyytQznOfi6Fm4RSGN6dUfc0j/iNLqGtP
 rCIUfxpc6Ln8cx40mNG0Khqc3w/4Zk2VofBr9PmnxS6Pa63ziqPuP10+zSWhWRSjFDBgjG
 PvPDVz0Z1f+BxO5FbxWd+uf+V+UVgmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781710412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4xKtPdznEQQTaJCwugwiRJJumiWRojwEBIqWdxadzE=;
 b=ggO7c/dJBm6MgD7DrpPdUdFYAbmEyeL8ZrwfbhLiMWy0osMWwBwncMb4uowFR+xvsRQKHM
 CO4z+L765LLZ/PAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE91F779A8;
 Wed, 17 Jun 2026 15:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yN+ALky+MmqSYQAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 17 Jun 2026 15:33:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 543B9A0EC0; Wed, 17 Jun 2026 17:33:28 +0200 (CEST)
Date: Wed, 17 Jun 2026 17:33:28 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <qvztwkwtesalldjybep577roegy77c6snq7xh6xkykc2cgctus@bdigqlb4buit>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
 <20260616210448.12175-2-anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616210448.12175-2-anonymemeow@gmail.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] fanotify20: Skip FAN_REPORT_PIDFD |
 FAN_REPORT_TID test on v7.2+
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
Cc: amir73il@gmail.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 17-06-26 05:04:44, AnonymeMeow wrote:
> fanotify_init() used to reject FAN_REPORT_PIDFD combined with
> FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
> reporting pidfds for thread IDs, so this combination is expected to
> succeed.
> 
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  testcases/kernel/syscalls/fanotify/fanotify20.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index b32ecf6aa..f395d77ee 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -8,13 +8,15 @@
>  
>  /*\
>   * This source file contains a test case which ensures that the
> - * :manpage:`fanotify(7)` API returns an expected error code when provided an
> - * invalid initialization flag alongside FAN_REPORT_PIDFD. Additionally, it
> - * checks that the operability with existing FAN_REPORT_* flags is maintained
> - * and functioning as intended.
> + * :manpage:`fanotify(7)` API returns an expected error code when provided
> + * unsupported initialization flags, e.g. FAN_REPORT_PIDFD combined with
> + * FAN_REPORT_TID. Additionally, it checks that the operability with
> + * supported FAN_REPORT_* flags is maintained and functioning as intended.
>   *
>   * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
>   * af579beb666a ("fanotify: add pidfd support to the fanotify API").
> + * FAN_REPORT_PIDFD combined with FAN_REPORT_TID is supported since v7.2-rc1
> + * in 17171128513b ("fanotify: report thread pidfds for FAN_REPORT_TID").
>   */
>  
>  #define _GNU_SOURCE
> @@ -45,6 +47,10 @@ static struct test_case_t {
>  
>  static void do_setup(void)
>  {
> +	if (tst_kvercmp(7, 2, 0) >= 0)
> +		tst_brk(TCONF, "FAN_REPORT_PIDFD | FAN_REPORT_TID is supported "
> +			       "since v7.2, skipping test");
> +
>  	/*
>  	 * An explicit check for FAN_REPORT_PIDFD is performed early on in the
>  	 * test initialization as it's a prerequisite for all test cases.
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
