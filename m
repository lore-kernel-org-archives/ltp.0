Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF241FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 12:08:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 495DD3E49FA
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:08:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14BC43CFBA2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:07:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1A43C600B5E
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:07:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B28236A83A;
 Tue, 28 Apr 2026 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777378057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HnmBHsQGgw/LesFMbY+Qls6OBxM/oMAD56oh3DlAds=;
 b=G6aLZ28eAG8L6460FCtJ1xEpw86sZHOlHqbWbJH8fWLUZ6zDrNo3wbdFjRw9836zm0yGsh
 MBax3dukZF7CfUa5LuMEMD5ZXfY3IFVJ3vg3PaRhYv/5msE3Sq/HUJmfoFoLmaTMipnpPc
 9apaCjXkm1zU80vOVk82nGivvgDTyn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777378057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HnmBHsQGgw/LesFMbY+Qls6OBxM/oMAD56oh3DlAds=;
 b=EDnUVP3oR5Ogs7kiFBwHnzYk+EoUQUBqdSnriNl0He0u+HLfJtNr55Wm9rSNbWV5L5QhHP
 b2VlhnDMvItQg1DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777378055;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HnmBHsQGgw/LesFMbY+Qls6OBxM/oMAD56oh3DlAds=;
 b=haBq7qAMA6Sx+yHih3+QH2VAqlVApg14b7OKRrM8NsBT8zacXxTOoZRiB6CVun4ZfSA3dX
 Buik4s8vynOVGfgSIFlzPVen3x17kG5mSJCkYZmGPm/lSfKVtf6oaLWV3FZs+drq6Cpp7d
 oCIZlcC1I01dVBKfBz8bIrhywe/Hz1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777378055;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HnmBHsQGgw/LesFMbY+Qls6OBxM/oMAD56oh3DlAds=;
 b=9+rqUCdIWu6KfL+t/MuuQYCNeBrKMPUn9S+Gahc3J5Z6eLxNlxGca+VRoqdqrErRNNJnnJ
 SHBLmlq1rOaOqDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C6E1593B0;
 Tue, 28 Apr 2026 12:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8JiDIQej8GlXFAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Apr 2026 12:07:35 +0000
Date: Tue, 28 Apr 2026 14:07:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
Message-ID: <20260428120734.GA893521@pevik>
References: <20260427005658.31295-1-wegao@suse.com>
 <ae7M3tFbMFwjUzV4@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ae7M3tFbMFwjUzV4@linux.dev>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,opensuse.org:url];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ld01.sh: Relax grep pattern for linker error
 message
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Merged, thanks!

FYI, while checking that error message should contain argv[0] is not much
related to ld functionality, but it found a real bug [1] (which I suppose it
will be fixed) caused by the alternatives -> libalts switch.

Kind regards,
Petr

[1] https://bugzilla.opensuse.org/show_bug.cgi?id=1262785

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
