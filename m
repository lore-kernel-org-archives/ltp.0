Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0375BC79F82
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 08:35:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 337773E4E3F
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 10:35:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72C4B3E1107
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 10:35:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D46BE1A00995
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 10:35:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3710E21964
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788856515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHmgOlM/0EvVGR/UHJ4FB9AP4VnDGwKU0E9qMdXTzdk=;
 b=aLNRM95k2MPYj+pYjbBNKMgZMT/gMbZjwuhiLPoefbnYMzLGHwRfQQUgdQLtfMij8MqAb2
 tRARVLsGIRlYeOeeADybbo35VyWrWNYu2ZerHGL5NNiV9MaWAhXSvLbZXm6hAfgaqQg4We
 3i9j1VOGn18yywXr4CYX0NgF1b7TGls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788856515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHmgOlM/0EvVGR/UHJ4FB9AP4VnDGwKU0E9qMdXTzdk=;
 b=t6KtigpAX0wc29PsSSCz6hpLt7zL3jftVYSFFj/n9VuNT5/lwbZAJJ8+gC2zmizMUJyJAM
 /5PiZkeIanRqkQBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788856515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHmgOlM/0EvVGR/UHJ4FB9AP4VnDGwKU0E9qMdXTzdk=;
 b=aLNRM95k2MPYj+pYjbBNKMgZMT/gMbZjwuhiLPoefbnYMzLGHwRfQQUgdQLtfMij8MqAb2
 tRARVLsGIRlYeOeeADybbo35VyWrWNYu2ZerHGL5NNiV9MaWAhXSvLbZXm6hAfgaqQg4We
 3i9j1VOGn18yywXr4CYX0NgF1b7TGls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788856515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHmgOlM/0EvVGR/UHJ4FB9AP4VnDGwKU0E9qMdXTzdk=;
 b=t6KtigpAX0wc29PsSSCz6hpLt7zL3jftVYSFFj/n9VuNT5/lwbZAJJ8+gC2zmizMUJyJAM
 /5PiZkeIanRqkQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11B151347F
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pS5OBMPIn2qEJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 08 Sep 2026 08:35:15 +0000
Date: Tue, 8 Sep 2026 10:35:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <ap_IyOqNwuc5E1JX@yuki.lan>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 00/31] Add sysfs sanity tests
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I've pushed the patchset with a few minor fixes, mostly doc changes
found by Peter. Thanks for the reviews!

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
