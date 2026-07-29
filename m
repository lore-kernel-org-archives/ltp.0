Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540F0C54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:27:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9F6C3E4B57
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:27:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD8AD3E138C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:27:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5388B1A0092F
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:27:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D4A63E0C;
 Wed, 29 Jul 2026 09:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785317242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KrLH0nziiZ6nec7CsLZBsVrX2lncw53IWupWcdxQQgU=;
 b=rwiz53WsdWt117TpChc8YGzUjSmkErRGZFO1egNocVPtu4jq5GGZ+qNTcCn86yX5fwcfN+
 VfI6f7wAALPI/yAs52xkJwZSmDyg0l552mQP2YQ3p1QQ7x1K4AvQkcP+RS8S8lfOiAlQVJ
 g7lc1zEdsFS9CGMn6aLpYYhw0jqHRbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785317242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KrLH0nziiZ6nec7CsLZBsVrX2lncw53IWupWcdxQQgU=;
 b=kAuxykuf7q/lttMDGGncspLnX/Bdh0mjABDkN0n6RI6qB9kE10k4Yu9zQcm8PY5lEb8Lbv
 3Pc37fPoliIFhGDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785317238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KrLH0nziiZ6nec7CsLZBsVrX2lncw53IWupWcdxQQgU=;
 b=BWi/WYtGAS1L8flYqJDQpY+eNDlkBpk1J/8nUe0/W+ts1O21/AXirj+L46hHT7e6W04AQG
 hEsSo5WluUEy4S0g72L/nh5gG94yc9EL6R3TNwaNC72eqhpzqKoobDBekWuGGtwk1989Ww
 9/87HKxEb5WdFagJzCbjdGAuGsodJqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785317238;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KrLH0nziiZ6nec7CsLZBsVrX2lncw53IWupWcdxQQgU=;
 b=kNIp5V/eljqTfFBfrTC05BKUz0NbstjdAjaJSiqulmesVt70Sam6nkZUgVZHzb3Kbh6O95
 jpbFHWnR2Q0GuTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 252B4779A1;
 Wed, 29 Jul 2026 09:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9e+WCHbHaWoCCQAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 29 Jul 2026 09:27:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id BE94FA131F; Wed, 29 Jul 2026 11:27:09 +0200 (CEST)
Date: Wed, 29 Jul 2026 11:27:09 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <wexuhnkssz5j5kswcmsj73l7i6yrhpsvg36t4hg2e3flxvp4l3@5jczb6r55haj>
References: <20260729091717.23042-1-pvorel@suse.cz>
 <20260729091717.23042-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260729091717.23042-6-pvorel@suse.cz>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.cz,suse.com,gmail.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url, imap1.dmz-prg2.suse.org:helo,
 suse.com:email, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] fanotify20: Skip on v7.2
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 AnonymeMeow <anonymemeow@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 29-07-26 11:17:17, Petr Vorel wrote:
> fanotify_init() used to reject FAN_REPORT_PIDFD combined with
> FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
> reporting pidfds for thread IDs, so this combination is expected to
> succeed.
> 
> The test that these flag combinations are allowed:
>                 FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
> 		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID |
> 			   FAN_REPORT_DFID_NAME),
> 
> Because the above flag combinations are already "tested" by the tests
> that use them and we don't have any tests that >= 5.10 has support for
> FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.
> 
> Reported-by: AnonymeMeow <anonymemeow@gmail.com>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

I agree with the intention. I just think that if the option is called
max_kver, then this suggest this is the last version where the test should
be run. Not the first version where the test shouldn't be run. So the name
is a bit confusing to me.

								Honza

> ---
> Replacement of:
> https://patchwork.ozlabs.org/project/ltp/patch/20260616210448.12175-2-anonymemeow@gmail.com/
> based on
> https://lore.kernel.org/ltp/CAOQ4uxhnrH3=XsCBhuO3oYtS=pZcRjkAchtrVwtnfJzBVmpNfQ@mail.gmail.com/
> 
>  testcases/kernel/syscalls/fanotify/fanotify20.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index b32ecf6aa3..dfcf194755 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -15,6 +15,9 @@
>   *
>   * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
>   * af579beb666a ("fanotify: add pidfd support to the fanotify API").
> + *
> + * NOTE: since v7.2, fanotify supports reporting pidfds for thread IDs => skip
> + * the test.
>   */
>  
>  #define _GNU_SOURCE
> @@ -75,6 +78,7 @@ static void do_cleanup(void)
>  
>  static struct tst_test test = {
>  	.setup = do_setup,
> +	.max_kver = "7.2",
>  	.test = do_test,
>  	.tcnt = ARRAY_SIZE(test_cases),
>  	.cleanup = do_cleanup,
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
