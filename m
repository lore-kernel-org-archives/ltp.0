Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD02CCD194
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 08:53:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7313D3CEDA4
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 10:53:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A037E3CCD3E
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 10:53:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2069D1400DAA
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 10:53:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FCFE1F7CD;
 Thu, 16 Oct 2025 08:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760604790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=687+W1Zv5N4vDrd59GokqOTr6afdTH2De5beZrhwuvE=;
 b=QRvIZYtS24l9NfP+woe6c+kyUP1j/U/xVFQ5Ul5AKBfM5hifL4bBUcv4/VZ1jyv145Wvlu
 VQ3eeJfoOyapQIIzgCTM7b/bHvlKxlHoHZEG2pkUskOUkmibhn+ici5qMzIBhb+VxunvmG
 h8owC8IwN3LqGUs2VmlCgQW4aFCPchg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760604790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=687+W1Zv5N4vDrd59GokqOTr6afdTH2De5beZrhwuvE=;
 b=tmxKN3hQkkWqJa2W4KMs8hif3MOXzVBHkfEUZg8/XGoUBml8EHg/M2Of9m2GmbDZ9SZ1c+
 HYENAlvxyLn39eBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760604790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=687+W1Zv5N4vDrd59GokqOTr6afdTH2De5beZrhwuvE=;
 b=QRvIZYtS24l9NfP+woe6c+kyUP1j/U/xVFQ5Ul5AKBfM5hifL4bBUcv4/VZ1jyv145Wvlu
 VQ3eeJfoOyapQIIzgCTM7b/bHvlKxlHoHZEG2pkUskOUkmibhn+ici5qMzIBhb+VxunvmG
 h8owC8IwN3LqGUs2VmlCgQW4aFCPchg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760604790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=687+W1Zv5N4vDrd59GokqOTr6afdTH2De5beZrhwuvE=;
 b=tmxKN3hQkkWqJa2W4KMs8hif3MOXzVBHkfEUZg8/XGoUBml8EHg/M2Of9m2GmbDZ9SZ1c+
 HYENAlvxyLn39eBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66AD41376E;
 Thu, 16 Oct 2025 08:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OAlqFnay8Gg9LwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Oct 2025 08:53:10 +0000
Date: Thu, 16 Oct 2025 10:53:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20251016085309.GA262945@pevik>
References: <20251016083534.262078-1-pvorel@suse.cz>
 <86e63f59-88e7-41f8-8223-d322022807b0@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86e63f59-88e7-41f8-8223-d322022807b0@suse.cz>
X-Spamd-Result: default: False [-2.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUBJECT_HAS_CURRENCY(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] prepare_lvm.sh: Use $TMPDIR instead of custom
 $LVM_DIR
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

> Hi,
> I still think there's a valid use case for creating the LVM backing files on
> a different path than TMPDIR because they can be huge. But LVM_DIR should
> default to TMPDIR if not explicitly set. So how about this?

> TMPDIR="${TMPDIR:-/tmp}"
> LVM_DIR="${LVM_DIR:-$TMPDIR}"

Thanks for your review, Martin.
Make sense. And it will be backward compatible.
I'll send v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
