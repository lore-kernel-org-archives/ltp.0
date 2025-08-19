Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E25CA0EE6
	for <ltp@archiver.kernel.org>; Tue, 19 Aug 2025 07:29:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56B603CCA61
	for <ltp@archiver.kernel.org>; Tue, 19 Aug 2025 09:29:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C81D23C008D
 for <ltp@lists.linux.it>; Tue, 19 Aug 2025 09:29:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E8B4D200ACE
 for <ltp@lists.linux.it>; Tue, 19 Aug 2025 09:29:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E1152124E;
 Tue, 19 Aug 2025 07:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755588576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jinVMZabAgds5jEYlkAbQ8Ayd3zxw93MOxvrd9NuVYw=;
 b=OqKMELWISMLcXHuQlK+eDW51ixKRKu0mbrcE/NcCDUES8VC3L96qet9Q+aMVS76FKNc5SP
 MpDv4WCirYcLW/zdtcXNWpgxFY62rgz86kiO8WEcFZRYiFuLK2za82KOdDEfsyI6ftnxj1
 510V4e4w1gN0W4nIlIuzktexF4BCkX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755588576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jinVMZabAgds5jEYlkAbQ8Ayd3zxw93MOxvrd9NuVYw=;
 b=Nym5i3cdHYPVabkRNRaQSywqj/xW9zKBIOClmzIXGCm7tI1r5ElCS0xJHKLteJ+JrUH+4K
 BTT1ueXkszdYfeDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755588576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jinVMZabAgds5jEYlkAbQ8Ayd3zxw93MOxvrd9NuVYw=;
 b=OqKMELWISMLcXHuQlK+eDW51ixKRKu0mbrcE/NcCDUES8VC3L96qet9Q+aMVS76FKNc5SP
 MpDv4WCirYcLW/zdtcXNWpgxFY62rgz86kiO8WEcFZRYiFuLK2za82KOdDEfsyI6ftnxj1
 510V4e4w1gN0W4nIlIuzktexF4BCkX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755588576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jinVMZabAgds5jEYlkAbQ8Ayd3zxw93MOxvrd9NuVYw=;
 b=Nym5i3cdHYPVabkRNRaQSywqj/xW9zKBIOClmzIXGCm7tI1r5ElCS0xJHKLteJ+JrUH+4K
 BTT1ueXkszdYfeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EBB713686;
 Tue, 19 Aug 2025 07:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZG2YEeAnpGjgIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 19 Aug 2025 07:29:36 +0000
Date: Tue, 19 Aug 2025 09:29:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250819072934.GA199404@pevik>
References: <20250818140657.10351-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250818140657.10351-1-akumar@suse.de>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] define TST_MAX_CLOCKS to account MAX_AUX_CLOCKS
 also
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

Hi Avinesh,

Thanks for fixing this! Merged!

...
>  /* MAX_CLOCKS is the maximum number of clock sources supported by kernel */
>  #define MAX_CLOCKS 16

> +#define MAX_AUX_CLOCKS 8
> +
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 17, 0)

FYI it still fails on my openSUSE Tumbleweed 6.17-rc2 is due linux-glibc-devel
package which has 6.16 even I have newer kernel from KOTD (the known problem
with kernel headers from glibc vs. kernel mismatch). But once 6.17 is out it will work.


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
