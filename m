Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C01EC1428
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 10:51:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6DF13DA326
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 11:51:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C64643C7831
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 11:50:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 49CB41000A4F
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 11:50:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AFEC43F7D8;
 Tue,  3 Mar 2026 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772535044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ieBTWzOXAvFshCiUhBnGO3Fgj4bf2BisLIBTrFDw7to=;
 b=syNUufdt/aeIuFxPKXUhyy4F3+tsL2F2ptlPF4zV7vpxas5iu088n1x0R6DP+9l6atvMdo
 WgunJCPMsbDWE41JDq2P4xu3ulkEiA+SJBv/OAqYWWC59L4E2cxi7x0feRq319pF7LsXhu
 r/sJz3EE3AyIF9SB/djjYig87/Um0P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772535044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ieBTWzOXAvFshCiUhBnGO3Fgj4bf2BisLIBTrFDw7to=;
 b=C3zl/2T/15AD1X7WyaADXDXDEnBVpfo3BzZeylYqw2faRNva7RFuecm7rwPucpMhFebSeN
 ywFX9NYRVMoQSCDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772535044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ieBTWzOXAvFshCiUhBnGO3Fgj4bf2BisLIBTrFDw7to=;
 b=syNUufdt/aeIuFxPKXUhyy4F3+tsL2F2ptlPF4zV7vpxas5iu088n1x0R6DP+9l6atvMdo
 WgunJCPMsbDWE41JDq2P4xu3ulkEiA+SJBv/OAqYWWC59L4E2cxi7x0feRq319pF7LsXhu
 r/sJz3EE3AyIF9SB/djjYig87/Um0P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772535044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ieBTWzOXAvFshCiUhBnGO3Fgj4bf2BisLIBTrFDw7to=;
 b=C3zl/2T/15AD1X7WyaADXDXDEnBVpfo3BzZeylYqw2faRNva7RFuecm7rwPucpMhFebSeN
 ywFX9NYRVMoQSCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D7B73EA6C;
 Tue,  3 Mar 2026 10:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6+0yJgS9pmnRJgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 03 Mar 2026 10:50:44 +0000
Message-ID: <13f0f6bc-425c-4f8a-a03e-805ed9886de8@suse.cz>
Date: Tue, 3 Mar 2026 11:50:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Amir Goldstein <amir73il@gmail.com>
References: <20260302144446.1291724-1-amir73il@gmail.com>
 <aaWvOIlfyIDH7J8A@yuki.lan>
 <CAOQ4uxhpcC76cpj21Dv-279FnVgHLSjCXmYKxu526jV-Uo7G_w@mail.gmail.com>
 <10488dc1-a369-4ad1-b26b-23118f6c9801@suse.cz>
 <CAOQ4uxhqubq4wy8Y5TkOVgtU0VgTcztJnrbycVC=idO_-XbKww@mail.gmail.com>
 <65ea5139-5b0b-41c0-9262-403b9a75fe35@suse.cz>
 <CAOQ4uxgpzhh3a4sDk5LVHP5MC+vPVRWTFNa551xYYu6pCsdSGg@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <CAOQ4uxgpzhh3a4sDk5LVHP5MC+vPVRWTFNa551xYYu6pCsdSGg@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: fix test failure on kernel with
 CONFIG_MODULES=n
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMy8zLzI2IDExOjEwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBUdWUsIE1hciAzLCAy
MDI2IGF0IDEwOjU54oCvQU0gTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PiB3cm90ZToK
Pj4gSSd2ZSB3cml0dGVuIHRoZSB0ZXN0IHRvIHRlc3QgYSBzcGVjaWZpYyBmYW5vdGlmeSByZWdy
ZXNzaW9uLiBUcmFjaW5nIGEKPj4gc3lzY2FsbCB0aGF0IGdldHMgY2FsbGVkIHRvbyBvZnRlbiBj
b3VsZCBpbmNyZWFzZSBzeXN0ZW0gbG9hZCBhbmQgY2hhbmdlCj4+IHRpbWluZyBvZiB0aGUgcmFj
ZSB3aGljaCBJJ20gdHJ5aW5nIHRvIHRyaWdnZXIgd2l0aCBpdC4KPj4KPiAKPiBXaGljaCBmYW5v
dGlmeSByZWdyZXNzaW9uPwo+IEFzIGEgcmV2aWV3ZXIsIEkgZ290IG5vIGluZGljYXRpb24gaW4g
dGhlIGNvbW1pdCBtZXNzYWdlLAo+IFRlc3QgZGVzY3JpcHRpb24sIG5vciBpbiBMVFAgdHN0X3Rl
c3QgdGFncyB0aGF0IHRoaXMgaXMgYSB0ZXN0IGZvciBhIHJlZ3Jlc3Npb24uCj4gCj4gSSBoYXZl
IG5vIG9iamVjdGlvbiB3aGF0c29ldmVyIHRvIHVzaW5nIGFueSBvdGhlciBzeW1ib2wgYXZhaWxh
YmxlCj4gaW4gbW9zdCBvZiB0aGUgY29tbW9uIGJ1aWxkcy4KPiBBbHRlcm5hdGl2ZWx5LCB0aGUg
dGVzdCBjb3VsZCB0ZXN0IGZvciB0aGUgZGVzaXJlZCBjb25maWd1cmF0aW9uLgo+IAo+IEJ1dCBp
ZiB0aGUgdGVzdCBpcyBtZWFudCB0byB0cmFjayBhIHJlZ3Jlc3Npb24sIHRoZW4gKnBsZWFzZSog
ZG9jdW1lbnQKPiB0aGUgcmVncmVzc2lvbiBpbiB0aGUgdGVzdCBkZXNjcmlwdGlvbiBhbmQgdGhl
IGZpeCBjb21taXQgaWYgc3VjaCBmaXgKPiBleGlzdHMgaW4gTFRQIHRzdF90ZXN0IHRhZ3MuCgpU
aGUgcmVncmVzc2lvbiBpbiBxdWVzdGlvbiB3YXMgbm90IGluIHVwc3RyZWFtIGJ1dCBhIGJyb2tl
biBiYWNrcG9ydCBpbiAKYSBjdXN0b20ga2VybmVsIGJyYW5jaC4gSXQgd2FzIGZpeGVkIGJ5IHJl
dmVydGluZyB0aGUgYmFja3BvcnRlZCBwYXRjaC4gClNvIHdoaWxlIHRoZSB0ZXN0IHdpbGwgYmUg
dXNlZnVsIGZvciBkZXRlY3Rpbmcgc2ltaWxhciByZWdyZXNzaW9ucyBpbiAKdXBzdHJlYW0sIHRo
ZXJlIGlzIG5vdGhpbmcgSSBjYW4gcHVibGljbHkgZG9jdW1lbnQgYWJvdXQgaXQuCgotLSAKTWFy
dGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5jegpTVyBRdWFsaXR5IEVuZ2luZWVyClNVU0UgTElO
VVgsIHMuci5vLgpDT1JTTyBJSWEKS3Jpemlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3pl
Y2ggUmVwdWJsaWMKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
