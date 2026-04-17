Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B201F43689
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 09:42:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB7C73E2DF1
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 11:42:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FA443E196A
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:42:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AEADF1A00A33
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:42:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 966A55BE5A;
 Fri, 17 Apr 2026 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776418956;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyXmAbHN3DB6zasEvYtbBrM9Yq0k/Er9Ni5xIIeP2N0=;
 b=TSE5C6zXhJk74gfmhY1LkPtmdLOUekAyZYjK3tHGsS6HQxbPprS+y/iPUw18sK/UJ5AX4x
 7OgYBjzEpLGVuOejllLI1+pkufOwqnDPXBn63rAeIgrj1MMaKGsdtPULDGtXZKlgWY/ZiI
 9TSOSNoOo6Va/Gd05P0hp0IQuGEK56M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776418956;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyXmAbHN3DB6zasEvYtbBrM9Yq0k/Er9Ni5xIIeP2N0=;
 b=KZ2+NpHDCATwemY8T0jtcRt/XhX+ytiVOGJH8KQH2tchpWaCvAZDlgiQ2if+Kj6Mzlfc+4
 NH5TLOFdPGdv/qAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776418956;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyXmAbHN3DB6zasEvYtbBrM9Yq0k/Er9Ni5xIIeP2N0=;
 b=TSE5C6zXhJk74gfmhY1LkPtmdLOUekAyZYjK3tHGsS6HQxbPprS+y/iPUw18sK/UJ5AX4x
 7OgYBjzEpLGVuOejllLI1+pkufOwqnDPXBn63rAeIgrj1MMaKGsdtPULDGtXZKlgWY/ZiI
 9TSOSNoOo6Va/Gd05P0hp0IQuGEK56M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776418956;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyXmAbHN3DB6zasEvYtbBrM9Yq0k/Er9Ni5xIIeP2N0=;
 b=KZ2+NpHDCATwemY8T0jtcRt/XhX+ytiVOGJH8KQH2tchpWaCvAZDlgiQ2if+Kj6Mzlfc+4
 NH5TLOFdPGdv/qAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8070B593AE;
 Fri, 17 Apr 2026 09:42:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NsT6HYwA4mn2CAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 09:42:36 +0000
Date: Fri, 17 Apr 2026 11:42:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260417094231.GB386785@pevik>
References: <20260417084758.329107-1-pvorel@suse.cz>
 <20260417092427.3643-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260417092427.3643-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] safe_stdio: More checks for invalid function return values
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

PiBIaSBQZXRyLAoKPiAtLS0gW1BBVENIIDEvMl0gLS0tCgo+IE9uIDIwMjYtMDQtMTcsIFBldHIg
Vm9yZWwgd3JvdGU6Cj4gPiBzYWZlX3N0ZGlvOiBNb3JlIGNoZWNrcyBmb3IgaW52YWxpZCBmdW5j
dGlvbiByZXR1cm4gdmFsdWVzCgo+ID4gLQlpZiAocmV0ID09IEVPRikKPiA+IC0JCXRzdF9icmtt
XyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLCBOVUxMLCAiZmZsdXNoKCVwKSIsIGYpOwo+
ID4gKwlpZiAocmV0ID09IEVPRikgewo+ID4gKwkJdHN0X2Jya21fKGZpbGUsIGxpbmVubywgVEJS
T0sgfCBURVJSTk8sIE5VTEwsICJmZmx1c2goJXApIGZhaWxlZCIsIGYpOwo+ID4gKwl9IGVsc2Ug
aWYgKCFyZXQpIHsKPiA+ICsJCXRzdF9icmttXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5P
LCBOVUxMLAo+ID4gKwkJCQkgICJJbnZhbGlkIGZmbHVzaCglcCkgcmV0dXJuIHZhbHVlICVkIiwg
ZiwgcmV0KTsKPiA+ICsJfQoKPiAhcmV0IGlzIHJldCA9PSAwLCB3aGljaCBpcyBmZmx1c2goKSdz
IHN1Y2Nlc3MgcmV0dXJuIOKAlCB0aGlzIGJyZWFrcyBldmVyeQo+IGNhbGxlciBvbiBzdWNjZXNz
LiBmZmx1c2goKSBvbmx5IHJldHVybnMgMCBvciBFT0YgcGVyIFBPU0lYOyB0aGVyZSBpcyBubwo+
IGludmFsaWQgcmV0dXJuIHZhbHVlIHRvIGd1YXJkIGFnYWluc3QsIHNvIGRyb3AgdGhlIGVsc2Ug
aWYgYnJhbmNoIGVudGlyZWx5LgoKWWVhaCwgdGhpcyBvbmUgaXMgcmVhbGx5IGludmFsaWQsIHRo
YW5rcyBhZ2VudCA6KS4KSSdsbCB3YWl0IGxpdHRsZSBsb25nZXIgZm9yIG90aGVycyBmZWVkYmFj
ayBiZWZvcmUgc2VuZGluZyB2Mi4KCj4gPiArCX0gZWxzZSBpZiAocmV0IDwgMCkgewo+ID4gKwkJ
dHN0X2Jya21fKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8sIE5VTEwsCj4gPiArCQkJCSAg
IkludmFsaWQgZnRlbGwoJXApIHJldHVybiB2YWx1ZSAlbGQiLCBmLCByZXQpOwoKPiA+ICsJfSBl
bHNlIGlmIChyZXQgPCAwKSB7Cj4gPiArCQl0c3RfYnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8
IFRFUlJOTywgTlVMTCwKPiA+ICsJCQkJICAiSW52YWxpZCBmaWxlbm8oJXApIHJldHVybiB2YWx1
ZSAlZCIsIGYsIHJldCk7Cgo+IFVzZSByZXQgPCAtMSBoZXJlIHRvIGJlIGNvbnNpc3RlbnQgd2l0
aCBzYWZlX2ZzZWVrKCkgaW4gdGhlIHNhbWUgZmlsZSBhbmQKPiB3aXRoIHRoZSBwb2xpY3kgZXN0
YWJsaXNoZWQgYnkgcGF0Y2ggMi8yOyBhbHNvIGZpeCB0aGUgY29udGludWF0aW9uLWxpbmUKPiBp
bmRlbnRhdGlvbiAodGFicyBvbmx5LCBubyBtaXhlZCBzcGFjZXMpLgoKSSBmcmFua2x5IGV4cGVj
dCBzZWNvbmQgcGF0Y2ggYmVpbmcgcmVmdXNlZC4gSWYgbm90LCBJJ2Qgc3dhcCBjb21taXRzIGlu
IHYyLgoKPiAtLS0gW1BBVENIIDIvMl0gLS0tCgo+IE9uIDIwMjYtMDQtMTcsIFBldHIgVm9yZWwg
d3JvdGU6Cj4gPiBsaWI6IEJlIHBlZGFudGljIG9uIGludmFsaWQgY29tcGFyaXNvbiBjaGVjawoK
PiA+IGRpZmYgLS1naXQgYS9saWIvc2FmZV9zdGRpby5jIGIvbGliL3NhZmVfc3RkaW8uYwo+ID4g
QEAgLTY3LDcgKzY3LDcgQEAgaW50IHNhZmVfYXNwcmludGYoLi4uKQo+ID4gLQl9IGVsc2UgaWYg
KHJldCA8IDApIHsKPiA+ICsJfSBlbHNlIGlmIChyZXQgPCAtMSkgewo+ID4gLi4uCj4gPiBAQCAt
MTU0LDcgKzE1NCw3IEBAIGludCBzYWZlX2ZzZWVrKC4uLikKPiA+IC0JfSBlbHNlIGlmIChyZXQg
PCAwKSB7Cj4gPiArCX0gZWxzZSBpZiAocmV0IDwgLTEpIHsKCj4gVGhpcyBmaXhlcyBhc3ByaW50
ZiBhbmQgZnNlZWsgYnV0IG1pc3NlcyBzYWZlX2Z0ZWxsKCkgYW5kIHNhZmVfZmlsZW5vKCkKPiBm
cm9tIHBhdGNoIDEvMiwgd2hpY2ggYXJlIGxlZnQgd2l0aCByZXQgPCAwLiBFaXRoZXIgZml4IHRo
ZW0gaGVyZSBvcgo+IHN3YXAgdGhlIHBhdGNoIG9yZGVyIHNvIG5ldyBjaGVja3MgYXJlIHdyaXR0
ZW4gd2l0aCByZXQgPCAtMSBmcm9tIHRoZSBzdGFydC4KCkdvb2QgY2F0Y2guIEkgd2FzIHN1cmUg
SSB3b3VsZCBub3QgZm9yZ2V0LCBidXQgb2J2aW91c2x5IEkgZGlkLgoKS2luZCByZWdhcmRzLApQ
ZXRyCgo+IC0tLQo+IE5vdGU6Cgo+IE91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0
aGUgcGF0Y2guIFRoZSBmdWxsIHJldmlldyBjYW4gYmUgZm91bmQKPiBpbiB0aGUgY29udmVyc2F0
aW9uIGNvbnRleHQgYWJvdmUuCgo+IFRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFs
c2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVuIGl0cyBmaW5kaW5ncwo+IGFyZSBnZW51aW5lLiBJ
ZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UgY29tbWVudCB0aGlzIGVt
YWlsCj4gb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KCj4gUmVnYXJkcywKPiBMVFAgQUkgUmV2
aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
