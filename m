Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A6AC47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 08:52:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 140F43CD0E3
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 09:52:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A8BF3CD010
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 09:51:56 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 306D2141CE8C
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 09:51:54 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 50FF21FB8D;
 Thu, 11 Jan 2024 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704963099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+pEFBT6tBn8K488YQQaGYa6xOa8EDtMUcOmLgWbTmo=;
 b=Ow1KeMfj2y6oSOMphyvZj8l9gMEMkuoN7p/KpFfIjROGV0L70gNKBP9Zy9SPTx07y2EY4C
 5Y+abKHg6GdjrgeLiVcofpKqD7dyoXRTmTNX3K4hdkqpuRT622xRqInGRKAgPaNXBXjjfh
 aYR4tEzu2mCrubpwZpGN2IQoqA7WmsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704963099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+pEFBT6tBn8K488YQQaGYa6xOa8EDtMUcOmLgWbTmo=;
 b=NHypObZDURc/lSQJdT0OsJYphs0k/XS28iKhJ5eHD/mhkHBLIcE+KWd+w8oyamCDyhpBUt
 DkWuCtn6CdJ0M/Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704963023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+pEFBT6tBn8K488YQQaGYa6xOa8EDtMUcOmLgWbTmo=;
 b=adNDjeStCq2/vwjJRuJiuLCj7uyMOcfFhXjKpUg5/1skwmrpK4mF9qsX4809vQg9o0ZF2f
 Ci4CqUrTAYJ11rEo9wqVyel3E2v1Htj5RzDwlvDzIH7OCkIdPOxVx9v40JxYyTH0WjIjMX
 qPEaG0VU4KQ+aj6Z9+F9P8C1ImWmRaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704963023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+pEFBT6tBn8K488YQQaGYa6xOa8EDtMUcOmLgWbTmo=;
 b=E1O7FrHAQ4+GkczBJzFz2yJlXE11b69GCeXJ2MMBtvg5q3qxQwndEkaYEyi75ZEGJG+xQt
 imUaJr9r56+L5lCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E8B13C04;
 Thu, 11 Jan 2024 08:50:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id O8W0Cs+rn2UrJQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jan 2024 08:50:23 +0000
Date: Thu, 11 Jan 2024 09:51:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Pengfei Xu <pengfei.xu@intel.com>
Message-ID: <20240111085152.GA1859394@pevik>
References: <cover.1704949719.git.pengfei.xu@intel.com>
 <48efcb1293a682182fc5db23f01be7af2889e26c.1704949719.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48efcb1293a682182fc5db23f01be7af2889e26c.1704949719.git.pengfei.xu@intel.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.02 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.52)[80.36%];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] keyctl05: improve the dns_res_payload for
 boundary testing
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
Cc: Heng Su <heng.su@intel.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Because the following patch will fix the add_key syscall incoming data boundary
> size issue, 6 bytes incoming data should pass:
> https://lore.kernel.org/all/1784441.1704907412@warthog.procyon.org.uk/
>  -> https://lore.kernel.org/all/1850031.1704921100@warthog.procyon.org.uk/
> In order to test above boundary incoming data size, change the dns_res_payload
> size.

> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  testcases/kernel/syscalls/keyctl/keyctl05.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
> index 90cf1ef06..50e78853c 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl05.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
> @@ -199,11 +199,11 @@ static void do_test(unsigned int i)
>  	 * We need to pass check in dns_resolver_preparse(),
>  	 * give it dummy server list request.
>  	 * From v6.7-rc8 commit 1997b3cb4217b09e49659b634c94da47f0340409:
> -	 * the incoming data for add_key syscall should be larger than 6 bytes,
> -	 * because struct dns_server_list_v1_header without body is 6 bytes.
> +	 * the incoming data for add_key syscall should be not less than 6
> +	 * bytes, because struct dns_server_list_v1_header is 6 bytes.
> +	 * The minimum payload will be tested here for boundary testing.
>  	 */
> -	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, \

nit (already pushed): \ is not needed for arrays.

Kind regards,
Petr

> -					  0x00, 0x00 };
> +	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00 };

>  	switch (i) {
>  	case 0:

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
