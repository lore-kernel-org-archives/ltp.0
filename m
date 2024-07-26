Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CD3C3DA7F
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 09:10:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E27933D1C10
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 11:10:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 910133CF05A
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 11:10:35 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 987371BC1C1F
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 11:10:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D63091F894;
 Fri, 26 Jul 2024 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721985032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83UFqojkegRkpYZqCgW2sUmivj4u56qOuKE9iFW/gms=;
 b=om8onlDUbUwiPb7KroiTjMI2CM8LjgWBtmNCE3mqXa7gpuXPREpz1fMwkPYHtqZ0BkCKzW
 tnLLoR+iGAIjyeIro5bQYfgURpnf+k93vSOhM5aisJGANKgB8zQf/VcyhUT3QcKBKt9hXg
 CGjOpCtxOzQlanuU80uDNKtThi0ZcqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721985032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83UFqojkegRkpYZqCgW2sUmivj4u56qOuKE9iFW/gms=;
 b=Q7LgLJEa6aXIND9mJ2FsKgzTQWUCWwOYMMObr0d84HWFoGtG6Qv72Rx57PykNEuUPF9ogO
 swUgEO2qjKfATaBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721985031;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83UFqojkegRkpYZqCgW2sUmivj4u56qOuKE9iFW/gms=;
 b=y1wypyreYQg0eRbMKE+8R3b/w3K+1HaVzvnoBOl7fqHwdI55wXyWAEV5HJozgKPKnElJk7
 i10vm6567TVnykJzjpQeaF53M0dKcD/LtOy47s1INsmI+q95kCqSco9i5sNE29WNX2lHBN
 LcDJrb0hob/G87RYgpoBJAzeiPWnZA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721985031;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83UFqojkegRkpYZqCgW2sUmivj4u56qOuKE9iFW/gms=;
 b=Sohyml0Y62YGm07MBaSE0W+uYUGy52AKGip2cEhsgJ9FeGOMkDAItUJm7QADIDKuiHXR8c
 u7Bm8yZ59if+gXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAEA5138A7;
 Fri, 26 Jul 2024 09:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 53yXLAdoo2ZBQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 09:10:31 +0000
Date: Fri, 26 Jul 2024 11:10:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240726091028.GB1027477@pevik>
References: <20240724071123.923397-1-pvorel@suse.cz>
 <CAEemH2drtpWy66aFKkhx4_zht4JGbbXu+AmLOccREcyqDvxCvg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2drtpWy66aFKkhx4_zht4JGbbXu+AmLOccREcyqDvxCvg@mail.gmail.com>
X-Spamd-Result: default: False [-0.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Print used temporary dir and its
 filesystem
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCj4gT24gV2VkLCBKdWwgMjQsIDIwMjQgYXQgMzoxMuKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiBJdCBoZWxwcyBkZWJ1Z2dpbmcgdG8ga25vdyB1c2Vk
IGZpbGVzeXN0ZW0gKGFuZCBpbiBjYXNlIG9mCj4gPiAuYWxsX2ZpbGVzeXN0ZW1zIHRoZSB1bmRl
cmx5aW5nIGZpbGVzeXN0ZW0pLgoKCj4gTWFrZSBzZW5zZSEKPiBSZXZpZXdlZC1ieTogTGkgV2Fu
ZyA8bGl3YW5nQHJlZGhhdC5jb20+CgpUaGFua3MsIG1lcmdlZCEKCkkgbWlnaHQgc2VuZCBhbm90
aGVyIG9uZSB0byBwcmludCB0ZXN0ZWQga2VybmVsIHZlcnNpb24uCgpLaW5kIHJlZ2FyZHMsClBl
dHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
