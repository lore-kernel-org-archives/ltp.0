Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12C3CCF9E3
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 20:29:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 716603CC022
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 21:29:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C59313CBFBB
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 21:29:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 482831000999
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 21:29:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8466C337B3;
 Thu, 30 Oct 2025 20:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761856178;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNkGW2mKBo8l9m1EiWI8g/1AttMzO+lhSa1H3E/MfRg=;
 b=3RWk9eq0W+V0rumBBBJS0/vj9f12NS/EFBUwEbL7cw4qqlhA2Jjejl0l9GPT5+2MYB9xxv
 GKf7euJphUZGvoSkOIeIr/QwLidEr90c8+f98nPKlivP1THcJ80Wy1JmJUU56khHyZtoTf
 o3DSFFAD3KPzvD8zAFUS2frhL1cFKTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761856178;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNkGW2mKBo8l9m1EiWI8g/1AttMzO+lhSa1H3E/MfRg=;
 b=yX+CR95m4HKxVBv+oaCOncKpfXhSP4fBRrFIi2GA0lZLg9sDinTlQA66LJnAA7kFX7Y2ki
 rfPfLTeXzofoWLDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761856178;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNkGW2mKBo8l9m1EiWI8g/1AttMzO+lhSa1H3E/MfRg=;
 b=3RWk9eq0W+V0rumBBBJS0/vj9f12NS/EFBUwEbL7cw4qqlhA2Jjejl0l9GPT5+2MYB9xxv
 GKf7euJphUZGvoSkOIeIr/QwLidEr90c8+f98nPKlivP1THcJ80Wy1JmJUU56khHyZtoTf
 o3DSFFAD3KPzvD8zAFUS2frhL1cFKTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761856178;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNkGW2mKBo8l9m1EiWI8g/1AttMzO+lhSa1H3E/MfRg=;
 b=yX+CR95m4HKxVBv+oaCOncKpfXhSP4fBRrFIi2GA0lZLg9sDinTlQA66LJnAA7kFX7Y2ki
 rfPfLTeXzofoWLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1517A13393;
 Thu, 30 Oct 2025 20:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bLWqALLKA2lPfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Oct 2025 20:29:38 +0000
Date: Thu, 30 Oct 2025 21:29:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20251030202935.GE753947@pevik>
References: <20251030113534.67798-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251030113534.67798-1-liwang@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmctl02: set 2 huge pages as an enforced
 requirement
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
Cc: ltp@lists.linux.it, Luiz Capitulino <luizcap@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Set hugeshmctl02 to require exactly 2 HugeTLB pages and bail out
> cleanly if unavailable. To prevent shmget EINVAL failures seen when
> the environment cannot provide enough hugepages.

I see "TCONF: No enough hugepages for testing." on ppc64le on Tumbleweed,
hopefully it will have 2 :).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
