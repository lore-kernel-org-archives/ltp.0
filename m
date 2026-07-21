Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B8DC44532
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 13:40:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0B1E3E213A
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 15:40:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 486B53C2697
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:40:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9AB9C1400BF1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:40:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2FCDD3DF9;
 Tue, 21 Jul 2026 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784641206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uObg7P51mqXar0x+BR41RoAbP/LjUA3R/URM6bWO19o=;
 b=IOfFg1WjDTkMedn8E9yxIf1ywnDr+hsnl15ahWP/j88iEjJVJamfe1qd1pTgCM3TNxxAoF
 gxHRmKrMpDZlvxcEEf5C1/9iKV4BLJ2YOWyrYdU+M2h/fMqspctpJoSexNZNp3rkVborB3
 A9CpzZvRNx+fBhZD971Yj5pR+TpGc9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784641206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uObg7P51mqXar0x+BR41RoAbP/LjUA3R/URM6bWO19o=;
 b=FkqPiU9E2KYYbLAYcT8059fYKJoYX3v2s9C3mOj8gc7zIqYb57mkN1thtVy/Sfumcxq1kg
 SV9Rl9OA3stepeBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784641206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uObg7P51mqXar0x+BR41RoAbP/LjUA3R/URM6bWO19o=;
 b=IOfFg1WjDTkMedn8E9yxIf1ywnDr+hsnl15ahWP/j88iEjJVJamfe1qd1pTgCM3TNxxAoF
 gxHRmKrMpDZlvxcEEf5C1/9iKV4BLJ2YOWyrYdU+M2h/fMqspctpJoSexNZNp3rkVborB3
 A9CpzZvRNx+fBhZD971Yj5pR+TpGc9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784641206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uObg7P51mqXar0x+BR41RoAbP/LjUA3R/URM6bWO19o=;
 b=FkqPiU9E2KYYbLAYcT8059fYKJoYX3v2s9C3mOj8gc7zIqYb57mkN1thtVy/Sfumcxq1kg
 SV9Rl9OA3stepeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10C3F779AA;
 Tue, 21 Jul 2026 13:40:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id W4rJAbZ2X2oJFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 21 Jul 2026 13:40:06 +0000
Date: Tue, 21 Jul 2026 15:40:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Message-ID: <al92s67_X0D7m01y@yuki.lan>
References: <20260714111307.166205-1-yizhou.tang@shopee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260714111307.166205-1-yizhou.tang@shopee.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] perf_event_open03: Track SUnreclaim growth
 instead of MemAvailable
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> -	if ((sample > 5) || (diff_total > 100 * 1024))
> -		tst_res(TFAIL, "Likely kernel memory leak detected, total decrease: %ld kB", diff_total);
> -	else
> +	if ((sample > 5) || (diff_total > 100 * 1024)) {
> +		tst_res(TFAIL,
> +			"Likely kernel memory leak detected, SUnreclaim increased by %ld kB total",
> +			diff_total);
> +		tst_res(TINFO,
> +			"Unreclaimable slab can also grow due to memory activity from "
> +			"any other unrelated process. If this test fails, re-run it on "
> +			"an otherwise idle system and/or confirm with kmemleak "
> +			"(CONFIG_DEBUG_KMEMLEAK) before treating it as a real regression.");

I wouldn't be that verbose here. Maybe something as:

			"Unreclaimable slab can grow due to unrelated
			reasons as well. You can rerun the test with
			CONFIG_DEBUG_KMEMLEAK to make sure the leak is
			real.

Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
