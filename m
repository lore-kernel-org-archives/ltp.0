Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE3606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FpXLA24c;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mb9cBmSX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FpXLA24c;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mb9cBmSX
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B38FC3E9AB9
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:34:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 518AB3E60E9
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 09:34:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D3D86200980
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 09:34:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1986A1F394;
 Wed, 21 Oct 2026 07:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792568062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EJi6UpiSsnoh2AWikYsFRjVPdOhrP5/1w5rfnbkAXI=;
 b=FpXLA24cbpvsfoW28FBmnFdIFOht2g7u6ImtcOVxeQ+W5cKT5YkZoL0OqjLnPaltvkfuJn
 ridCpFbXn151b704OMyoRAEaKoUVdd0+hcamqpggbK+CNec77RqR/UsWO3QCdRqufhEfFd
 TQCNCw7X1ddJwwrckvMMYCce9hVJgaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792568062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EJi6UpiSsnoh2AWikYsFRjVPdOhrP5/1w5rfnbkAXI=;
 b=mb9cBmSXEcfHzI0KfS44U/N+Gq+53K6DGoJHZhV1nKgUl0jUT95w+be2m0C9jeeibe5p6L
 9Ik+7PSE/fwDjkAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792568062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EJi6UpiSsnoh2AWikYsFRjVPdOhrP5/1w5rfnbkAXI=;
 b=FpXLA24cbpvsfoW28FBmnFdIFOht2g7u6ImtcOVxeQ+W5cKT5YkZoL0OqjLnPaltvkfuJn
 ridCpFbXn151b704OMyoRAEaKoUVdd0+hcamqpggbK+CNec77RqR/UsWO3QCdRqufhEfFd
 TQCNCw7X1ddJwwrckvMMYCce9hVJgaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792568062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EJi6UpiSsnoh2AWikYsFRjVPdOhrP5/1w5rfnbkAXI=;
 b=mb9cBmSXEcfHzI0KfS44U/N+Gq+53K6DGoJHZhV1nKgUl0jUT95w+be2m0C9jeeibe5p6L
 9Ik+7PSE/fwDjkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9E54134A5;
 Wed, 21 Oct 2026 07:34:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SNqyLP1q2GoTGwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 Oct 2026 07:34:21 +0000
Date: Wed, 21 Oct 2026 09:34:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <athrEiFc8i3Tf-3G@yuki.lan>
References: <as2dZ8VBuN2NM3TZ@linux.dev>
 <4EkJ88xMyWBqTKeQ8KRctlqrIv8JfY4VYo5D@localhost.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EkJ88xMyWBqTKeQ8KRctlqrIv8JfY4VYo5D@localhost.localdomain>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gPiA+IHdoYXQgYWJvdXQgc2NoZWR1bGluZyBhIG5ldyBMVFAgbWVldGluZyBhZnRlciB0
aGUgcmVsZWFzZT8KPiA+ID4gV2hlbidzIHlvdXIgZmlyc3QgYXZhaWxhYmxlIGRhdGU/Cj4gPiAK
PiA+IFNvdW5kcyBnb29kLgo+ID4gCj4gPiBNeSBhdmFpbGFiaWxpdHkgaXMgb24gd2Vla2RheXMs
IDTigJM2IFBNIEJlaWppbmcgdGltZSAoVVRDKzgpLCB3aGljaAo+ID4gc2hvdWxkIGJlIDnigJMx
MSBBTSBDRVQuIAo+ID4gCj4gPiBJdCBtaWdodCBiZSBiZXR0ZXIgdG8gc2hhcmUgYW4gYWdlbmRh
IG9yIGRpc2N1c3MgdGhlIHRvcGljcyBiZWZvcmVoYW5kLgo+IAo+IHNvcnJ5IGZvciBteSBkZWxh
eSwgY3JhenkgdGltZXMuCj4gCj4gSSB3b3VsZCBsaWtlIHRvIGhhdmUgYSBMVFAgbWVldGluZywg
aWYgeW91IHdhbnQgd2UgY2FuIGRvIGl0IGF0IDEwYW0gdGhlIG5leHQKPiB3ZWVrIGlmIHdlZG5l
c2RheSBhcmUgdGhlIG9ubHkgb3B0aW9uLgo+IAo+IEBQZXRyIEBDeXJpbCBXRFlUPwoKV2VkbmVz
ZGF5IDI4LiBPY3QgaXMgYmFuayBob2xsaWRheSBpbiBDemVjaCByZXB1YmxpYywgYW4gaW5kZXBl
bmRlbmNlIGRheS4KCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
