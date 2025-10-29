Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6E8CCF9F0
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 08:17:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB7653CA723
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 09:17:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A44BC3C9D1E
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 09:17:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4D2BE2001A0
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 09:17:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A439D20255;
 Wed, 29 Oct 2025 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761725819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elJ4Ndz8K2VqK87MjgNpgO8UZnQZLhrgPg5S4ehLWHs=;
 b=P0HUm20kEAtSl8E9nYz7rE1qi8ag5VdY/ou0NBQKrJNG2Iu/b1RGZ5gJuBusstnfT0L04k
 ikx2FiyCjbE5OtdfVUkOFwzz28zuDSpbZU+B3ZAnm3ncNDVx/LnZInn2Q5BOAu3N+07ww4
 tOWN/WB8LkWto48Pzd/nBefcMXhhSfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761725819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elJ4Ndz8K2VqK87MjgNpgO8UZnQZLhrgPg5S4ehLWHs=;
 b=KLdo0TPTE+wgymepWZWnwOibMEAxOi7MLaPtSvdBQauLF5vu3dwENuwA+UmZse7GzzwG5X
 8yP80IgbrsZg+9DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761725819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elJ4Ndz8K2VqK87MjgNpgO8UZnQZLhrgPg5S4ehLWHs=;
 b=P0HUm20kEAtSl8E9nYz7rE1qi8ag5VdY/ou0NBQKrJNG2Iu/b1RGZ5gJuBusstnfT0L04k
 ikx2FiyCjbE5OtdfVUkOFwzz28zuDSpbZU+B3ZAnm3ncNDVx/LnZInn2Q5BOAu3N+07ww4
 tOWN/WB8LkWto48Pzd/nBefcMXhhSfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761725819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elJ4Ndz8K2VqK87MjgNpgO8UZnQZLhrgPg5S4ehLWHs=;
 b=KLdo0TPTE+wgymepWZWnwOibMEAxOi7MLaPtSvdBQauLF5vu3dwENuwA+UmZse7GzzwG5X
 8yP80IgbrsZg+9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F17CC1396A;
 Wed, 29 Oct 2025 08:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XZU9NHrNAWk6OQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Oct 2025 08:16:58 +0000
Date: Wed, 29 Oct 2025 09:16:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251029081653.GA616441@pevik>
References: <20251024125649.2343520-1-anders.roxell@linaro.org>
 <aP81KaVnfcm1sj8j@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aP81KaVnfcm1sj8j@rei>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] isofs: Add ISO9660 kernel config requirement
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
Cc: benjamin.copeland@linaro.org, dan.carpenter@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> >  TST_NEEDS_CMDS="mount umount"
> >  TST_NEEDS_TMPDIR=1
> > +TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS=y | CONFIG_ISO9660_FS=m"

> If you add just TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS" it will match both
> =y and =m I've added this shortcut to the library so that we do not need
> to write it as you did above.

Thanks for catching this, Cyril!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
