Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0404CCA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 04:55:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C17433CB03F
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 06:55:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D0C93C4D80
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 06:55:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9445F6168F5
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 06:55:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D76981F452;
 Tue, 12 Aug 2025 04:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754974525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uyJE2G62Uy7YVRSxS9AwtEGclg6XjPocCugiqnQX9No=;
 b=R7di6yZOa6FYqt7cEHlgzxT8CXFIl3oVugzZhgL30qTs424wVbSOqeuOo93cJMXMvIaZTx
 dbeCwwLuxYsaIgtvFTNvrrt8fu72z14rTH42xZLq0dHPsTL3zW2NaYAa+emXV6RiS44EGe
 /H6YejV05NFNb4mSAIZ8QSFHKvmAqSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754974525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uyJE2G62Uy7YVRSxS9AwtEGclg6XjPocCugiqnQX9No=;
 b=9CasX0KcxJ30ataJfmWY8OF2UApZTdghMKvo3n/96aHkCzp7RHk0lq5SG319IHnM5o+3sl
 1XNRV7qTLoPpsiAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754974524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uyJE2G62Uy7YVRSxS9AwtEGclg6XjPocCugiqnQX9No=;
 b=gX2ZlkKyJGyaoTRGkwaYLuUPVmX4UOSffY0J5DqAnjkEmfVAUAFXuTDmj0Q6+yv9xuLYWk
 Z4qpkJ3Xr6HRzuQJacw1gXU/qyf5QezPbXhqrMls4Ia2zGZQ3tMo3UFvndNkMUL2kcOHhv
 0ATGrIU6drCyuHd3GG/AoXERdSKcnXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754974524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uyJE2G62Uy7YVRSxS9AwtEGclg6XjPocCugiqnQX9No=;
 b=tMcYHg1GE+mR8tBfxDrN3dA5tcJgXb8pRG1XPfR3iM5Yk5uZRA/Hx7te9VkxGxGbnRFVsK
 lIOgAaAVw7s15aBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8EBB1351A;
 Tue, 12 Aug 2025 04:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qhRPLDzJmmjjMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Aug 2025 04:55:24 +0000
Date: Tue, 12 Aug 2025 06:55:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
Message-ID: <20250812045518.GA797597@pevik>
References: <20250718-doc_kvm_tests-v1-1-47519ff26d62@suse.com>
 <20250730170913.GB673913@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250730170913.GB673913@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: add kvm tests documentation
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

Hi Andrea,

could you please merge your docs? I'll do suggested fixes afterwards.
Because currently we have KVM doc just an empty file:

https://linux-test-project.readthedocs.io/en/latest/developers/api_kvm_tests.html

And we cannot expect users would find doc/old/ content.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
