Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64221D1CDC6
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 13:19:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F9A73D0317
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 14:19:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C06A83CF578
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 14:19:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47440600636
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 14:19:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 233515BE30;
 Tue,  9 Dec 2025 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765286345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sylz5wWwmP56dJcE/RoAYIM6tFs023Qu1Eal5VNdntg=;
 b=dXyT3H0vmdbo6oPMOZ/9l8UzulPXt/Mn8MP2RpAS6qsKfuztTfFZNyFlXvseGkYCRg+gRx
 jeDOvirOjU3dky67yAYHpXvTBdVQ7Fsy7UusWoa4GbFAOGy2NXPaovdluZTotvbEDLLzo/
 LLsBHfPBuuJA2SJRAZgm7yq4/yCZpw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765286345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sylz5wWwmP56dJcE/RoAYIM6tFs023Qu1Eal5VNdntg=;
 b=XNE1Yg3iljK6OHnEpvyx5ZxLm2fHdtLeuWxZQP9Gi/frZQ5MVKCDkMPasNdSHzAP22KHan
 T4jTt61ekzHgOECw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ah62tPCg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0T5uCkzN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765286344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sylz5wWwmP56dJcE/RoAYIM6tFs023Qu1Eal5VNdntg=;
 b=ah62tPCglLY8qMDeVJzFizNg/P9TZzGM6ol0+Is+IytsQx94qvNwPjwcQRCNXXHxNmU2Ks
 vWYdj482IBSSVWuoWpVWPTy7+cP8oobxKSmJx8kb0e30OMDX7vznmgU+pe+Zq1uXejNl67
 FfRUxt+O5fCKu+Mmglzern/Y4bQCOhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765286344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sylz5wWwmP56dJcE/RoAYIM6tFs023Qu1Eal5VNdntg=;
 b=0T5uCkzN6qxaN6f3sHRcAM4ktnifCCkiiMkffyPsx2BcFmrEdcg7QYXQFLWObTwvMj4qYG
 n/xNRGWZVYUwOGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 104773EA63;
 Tue,  9 Dec 2025 13:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7LkZA8ghOGkdEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Dec 2025 13:19:04 +0000
Date: Tue, 9 Dec 2025 14:19:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aTgh9CIRfVWniUZD@yuki.lan>
References: <20251127082638.224110-1-pvorel@suse.cz>
 <20251127082638.224110-2-pvorel@suse.cz>
 <CAEemH2cUYekSphFW_uj2w1FzYt3RWXDDnhmQ5TFAyr0T3HFxow@mail.gmail.com>
 <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 233515BE30
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] shell: Add tst_sudo.c helper
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gPiBJIGZlZWwgdGhhdCB0aGUgZmlsZW5hbWUgdHN0X3N1ZG8uYyBpcyBhIGJpdCBtaXNs
ZWFkaW5nLiBUaGUgaGVscGVyCj4gPiBkb2VzbuKAmXQKPiA+IHJlcGxpY2F0ZSBzdWRvIGJlaGF2
aW9yIChhdXRoZW50aWNhdGlvbiwgcHJpdmlsZWdlIGVzY2FsYXRpb24pLCBpdCBzaW1wbHkKPiA+
IGRyb3BzIGZyb20gcm9vdCB0byBhIGZpeGVkIFVJRC9HSUQgYmVmb3JlIGV4ZWN1dGluZyBhIGNv
bW1hbmQuCj4gPgo+ID4gU28gcmVhZGVycyBtYXkgZXhwZWN0IGEg4oCcc3Vkby1saWtl4oCdIGVs
ZXZhdGlvbiB3cmFwcGVyIHdoZW4sIGhvd2V2ZXIKPiA+IGl04oCZcyBhIHByaXZpbGVnZS1kcm9w
cGluZyB0cmFtcG9saW5lLgo+ID4KPiA+IFdoYXQgYWJvdXQgcmVuYW1pbmcgaXQgdG86Cj4gPiAg
IHRzdF9ydW5hcy5jLAo+ID4gICB0c3RfcnVuYXNfbm9ib2R5LmMsIG9yCj4gPiAgIHRzdF9kcm9w
X3ByaXZzLmM/Cj4gPgo+IAo+IAo+IFBlcnNvbmFsbHksIEkgcHJlZmVyIHRoZSB0c3RfcnVuYXNf
bm9keS5jIGJlY2F1c2UgaXQgcmVmbGVjdHMgdGhlCj4gZGVmYXVsdCBwcml2aWxlZ2UsCj4gYnV0
IGR1ZSBpdCBzdXBwb3J0cyB0aGUgbW9yZSBlbnYgc28gY29udGFpbnMgInN1IiBtYXliZSBiZXR0
ZXI6Cj4gICB0c3Rfc3Vfc3dpdGNoLmMsIHRzdF9zdV9jbWQuYwoKTWF5YmUganVzdCB0c3RfcnVu
YXMuYyBJIHRoaW5rIHRoYXQgJ3J1bmFzJyBpbiB0aGUgbmFtZSBpcyBwcm9iYWJseSB0aGUKYmVz
dCBkZXNjcmlwdGlvbi4KCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
