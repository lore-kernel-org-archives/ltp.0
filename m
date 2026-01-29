Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC04D358E4
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 09:02:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A69573CB69A
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 10:02:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AF303CAF03
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 10:01:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 665806008AB
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 10:01:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3456C5BCDC;
 Thu, 29 Jan 2026 09:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769677300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09SHPBeT/tETc2pyefnwSvOKQpZZd+eaUTIb47MpC7w=;
 b=OJ1qSNnZ0NoG3ZjaNu5vqZ5bkVJZSp/pXgw3UY8HDr2Ufy7BuMWy1Em70Q5yQBPvwkJ2hM
 HRToZj0keiur6kR3535417nBxFINOH4GxRr3KNpFmz9rMXa740jCWkNjRFP62XYIs9OXDm
 9NxdyYRIiEAvieQWloZirRmQdgX6L/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769677300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09SHPBeT/tETc2pyefnwSvOKQpZZd+eaUTIb47MpC7w=;
 b=+gY/lWCJhVWuYx4cHrVMenU3z9ewZqi9Q+yvzKzI8z1bDppRFegxnY1RDpdnV2f+D8D+jq
 u5iwmxmH1CQJ47Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769677295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09SHPBeT/tETc2pyefnwSvOKQpZZd+eaUTIb47MpC7w=;
 b=t0347X+cFw8o0zADKH+El1HeDXGhvmo80BKKQ93AsP0UzKSJLNHXPKq2PABMLgxnwCJXCp
 rDGX6FHkyRtZT9caNs9bNO+Ko8a8uyy6jDCSkh0j6BePKVrxVYSYm6wv8jEKi/U1/6fNLq
 XB5VA+5KzLj6WOyTbthsVmTDUstgW7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769677295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09SHPBeT/tETc2pyefnwSvOKQpZZd+eaUTIb47MpC7w=;
 b=XTdUOy/POL7JiT1CPDek8kWT/meP/u8pJywcxWm9WmsZApZot0ZsNakwcT/8Rr3lsPFNKV
 NTmK1Dkuxkf6jLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 163AB3EA61;
 Thu, 29 Jan 2026 09:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k+w+BO8he2nxAwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 29 Jan 2026 09:01:35 +0000
Date: Thu, 29 Jan 2026 09:59:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aXshZzXAG8L0GFEC@rei.lan>
References: <20260128080121.18878-1-pvorel@suse.cz>
 <20260128205044.GA58055@pevik>
 <CAEemH2fc_C_vGnKtbYqsMzMVKLSNLhCFWLGemSyVTWBzAATDCA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fc_C_vGnKtbYqsMzMVKLSNLhCFWLGemSyVTWBzAATDCA@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[suse.cz:query timed out];
 RCPT_COUNT_FIVE(0.00)[5]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/ground_rules: Add Kernel features check
 rules
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gPiBJIHdvbmRlciBob3cgYWJvdXQgLm5lZWRzX2tjb25maWdzIHZzLiBuZWVkc19kcml2
ZXJzLiBEbyB3ZSBwcmVmZXIgYW55IG9mIHRoZXNlPwo+ID4gSSBzdXBwb3NlIHRoZSBydWxlIGNv
dWxkIGJlIC5uZWVkc19kcml2ZXJzIHdoZW4gbm90aGluZyBzcGVjaWZpYyBmcm9tIG1vZHVsZSBp
cwo+ID4gbmVlZGVkLCAubmVlZHNfa2NvbmZpZ3Mgb3RoZXJ3aXNlLgo+IAo+IEhtbSwgdGhpcyBs
b29rcyBvbmx5IGJlbG9uZ3MgdG8gdGhlIHNlY29uZCBzZWN0aW9uLgo+IE1heWJlOgo+IAo+ICAg
LSBUcmlzdGF0ZS9tb2R1bGUgZmVhdHVyZTogSWYgdGhlIGZ1bmN0aW9uYWxpdHkgaXMgY29udHJv
bGxlZCBieSBhIEtjb25maWcgb2YKPiAgICAgIHR5cGUgdHJpc3RhdGUgKGB0cmlzdGF0ZQo+IDxo
dHRwczovL2RvY3Mua2VybmVsLm9yZy9rYnVpbGQva2NvbmZpZy1sYW5ndWFnZS5odG1sI21lbnUt
YXR0cmlidXRlcz5gXyksCj4gICAgICBpdCBtaWdodCBiZSBidWlsdCBhcyBhIG1vZHVsZS4gTW9k
dWxlcyBjYW4gYmUgYWJzZW50IG9yIHVubG9hZGVkCj4gYXQgcnVudGltZSwKPiAgICAgIHNvIGNo
ZWNraW5nIHRoZSBLY29uZmlnIG9wdGlvbiBhbG9uZSBpc27igJl0IGVub3VnaC4gSW5zdGVhZCBv
Zgo+IC5uZWVkc19rY29uZmlncywKPiAgICAgIHJlbHkgb24gLm5lZWRzX2RyaXZlcnMgb3IgYSBy
dW50aW1lIGNoZWNrIHRvIGNvbmZpcm0gdGhlIG1vZHVsZSBpcyBsb2FkZWQuCgpTb3VuZHMgZ29v
ZCB0byBtZS4KCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
