Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B198CC83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:43:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49E233CCD13
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:43:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D8993C58D0
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 15:42:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A9ED71400BDC
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 15:42:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7C111F7D7;
 Tue, 22 Jul 2025 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753191767;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQm9hFeMxuPqOiCTY66XypcfmZNZDen9IeQ3Cm1O5YU=;
 b=UnqBuHCGHtlYHL/TdoSR/NXT54/I64JPmv7uwqLSm/gEGw7YzxUp5xQlCnN2cFdLYo4kS/
 e72/zOwfCpbJlVLej1JtZfVQtjUh19kQ5zHy5JEyWRLN1PDWGcnK7VYknmK+K50ySzUu4B
 L7Tpr1HhqcoeRLjzkQqKRMyG0PjtY4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753191767;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQm9hFeMxuPqOiCTY66XypcfmZNZDen9IeQ3Cm1O5YU=;
 b=Gc/MCqy1JveRksVQt8WDG+Olm8+eT0ogYiB9j7AybPcDU2LnBakt3kYywLtp4FkMJdZBNr
 uGBPHfY+NDqDvSDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753191767;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQm9hFeMxuPqOiCTY66XypcfmZNZDen9IeQ3Cm1O5YU=;
 b=UnqBuHCGHtlYHL/TdoSR/NXT54/I64JPmv7uwqLSm/gEGw7YzxUp5xQlCnN2cFdLYo4kS/
 e72/zOwfCpbJlVLej1JtZfVQtjUh19kQ5zHy5JEyWRLN1PDWGcnK7VYknmK+K50ySzUu4B
 L7Tpr1HhqcoeRLjzkQqKRMyG0PjtY4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753191767;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQm9hFeMxuPqOiCTY66XypcfmZNZDen9IeQ3Cm1O5YU=;
 b=Gc/MCqy1JveRksVQt8WDG+Olm8+eT0ogYiB9j7AybPcDU2LnBakt3kYywLtp4FkMJdZBNr
 uGBPHfY+NDqDvSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B033813A32;
 Tue, 22 Jul 2025 13:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xKzWKFeVf2jmGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 13:42:47 +0000
Date: Tue, 22 Jul 2025 15:42:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <20250722134246.GA84869@pevik>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <CAEjxPJ6WQRrfAnMtDzvUxYL6smYbKpDQNGp6rxs4dZ=DxC3M9A@mail.gmail.com>
 <CAEjxPJ7gbWRWgbrLv+1xE0dJUq+c9UpNzYUgyis2f8gmJUo1wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEjxPJ7gbWRWgbrLv+1xE0dJUq+c9UpNzYUgyis2f8gmJUo1wQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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

SGkgU3RlcGhlbiwgYWxsLAoKPiBPbiBUdWUsIEp1bCAyMiwgMjAyNSBhdCA5OjE44oCvQU0gU3Rl
cGhlbiBTbWFsbGV5Cj4gPHN0ZXBoZW4uc21hbGxleS53b3JrQGdtYWlsLmNvbT4gd3JvdGU6Cgo+
ID4gT24gVHVlLCBKdWwgMjIsIDIwMjUgYXQgODowNuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToKCj4gPiA+IEhpIEFuZHJlYSwgYWxsLAoKPiA+ID4gWyBDYyBTdGVwaGVu
LCB0aGUgZml4IGF1dGhvciBpbiBjYXNlIEknbSB3cm9uZyB3aXRoIHJlcHJvZHVjaW5nIG9uIGVu
Zm9yY2luZz0wIF0KCj4gPiA+ID4gQWRkIHRzdF9zZWxpbnV4X2VuYWJsZWQoKSB1dGlsaXR5IGlu
IHRzdF9zZWN1cml0eS5oIGluIG9yZGVyIHRvIHZlcmlmeQo+ID4gPiA+IGlmIFNFTGludXggaXMg
Y3VycmVudGx5IHVwIGFuZCBydW5uaW5nIGluIHRoZSBzeXN0ZW0uCj4gPiA+IC4uLgo+ID4gPiA+
ICtpbnQgdHN0X3NlbGludXhfZW5hYmxlZCh2b2lkKQo+ID4gPiA+ICt7Cj4gPiA+ID4gKyAgICAg
aW50IHJlcyA9IDA7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICAgIGlmICh0c3RfaXNfbW91bnRlZChT
RUxJTlVYX1BBVEgpKQo+ID4gPiA+ICsgICAgICAgICAgICAgcmVzID0gMTsKCj4gPiA+IEkgd2Fz
IHdvbmRlcmluZyBpZiBpdCB0aGUgdGVzdCByZXF1aXJlIGVuZm9yY2luZyBvciBub3QgdGhlcmVm
b3JlIEkgcmV0ZXN0ZWQgaXQKPiA+ID4gYW5kIGl0J3MgcmVhbGx5IHJlcHJvZHVjaWJsZSB3aXRo
IHBlcm1pc3NpdmUgbW9kZSwgaS5lLiB3aXRoIGtlcm5lbCBjb21tYW5kIGxpbmUKPiA+ID4gc2Vj
dXJpdHk9c2VsaW51eCBzZWxpbnV4PTEgZW5mb3JjaW5nPTAKCj4gPiA+IEJlY2F1c2UgaWYgZW5m
b3JjaW5nIHdhcyByZXF1aXJlZCwgSSB3b3VsZCBiZSBmb3IgdXNpbmcgdHN0X3NlbGludXhfZW5m
b3JjaW5nKCksCj4gPiA+IHdoaWNoIGNoZWNrcyAvc3lzL2ZzL3NlbGludXgvZW5mb3JjZSBmb3Ig
MSBhcyBXZWkgc3VnZ2VzdGVkIGluIHYzOgoKPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bHRwL2FIZjgzOVdTMEJQSWE1WnFATWlXaUZpLUNSNjYwOC1zcnYvCgo+ID4gPiBAQ3lyaWwgQEFu
ZHJlYSwganVzdCBjaGVja2luZyBpZiAvc3lzL2ZzL3NlbGludXgvZW5mb3JjZSBleGlzdHMgd291
bGQgYmUgZmFzdGVyCj4gPiA+IHRoYW4gbG9vcGluZyAvcHJvYy9tb3VudHMgKHZpYSB0c3RfaXNf
bW91bnRlZChTRUxJTlVYX1BBVEgpKS4gQ2FuIHdlIGp1c3QgbW9kaWZ5Cj4gPiA+IHRoZSBwYXRj
aD8KCj4gPiBOb3Qgc3VyZSBpZiBJIGhhdmUgdGhlIGZ1bGwgY29udGV4dCwgYnV0IG1vZGVybiBs
aWJzZWxpbnV4IGhhcyB0aGlzCj4gPiBmb3IgaXNfc2VsaW51eF9lbmFibGVkKCk6Cgo+ID4gaW50
IGlzX3NlbGludXhfZW5hYmxlZCh2b2lkKQo+ID4gewo+ID4gICAgICAgICAvKiBpbml0X3NlbGlu
dXhtbnQoKSBnZXRzIGNhbGxlZCBiZWZvcmUgdGhpcyBmdW5jdGlvbi4gV2UKPiA+ICAgICAgICAg
ICogd2lsbCBhc3N1bWUgdGhhdCBpZiBhIHNlbGludXggZmlsZSBzeXN0ZW0gaXMgbW91bnRlZCwg
dGhlbgo+ID4gICAgICAgICAgKiBzZWxpbnV4IGlzIGVuYWJsZWQuICovCj4gPiAjaWZkZWYgQU5E
Uk9JRAo+ID4gICAgICAgICByZXR1cm4gKHNlbGludXhfbW50ID8gMSA6IDApOwo+ID4gI2Vsc2UK
PiA+ICAgICAgICAgcmV0dXJuIChzZWxpbnV4X21udCAmJiBoYXNfc2VsaW51eF9jb25maWcpOwo+
ID4gI2VuZGlmCj4gPiB9CgpUaGFua3MgZm9yIHlvdXIgcG9pbnRzLiAgWWVzLCB3ZSBhbHNvIGxv
b2tlZCBpbnRvIHNlbGludXggc291cmNlcyBob3cKc2VsaW51eF9tbnQgaXMgYXNzaWduZWQuCgpG
WUkgKHByb2JhYmx5IG9idmlvdXMpIHdlIGRvbid0IHdhbnQgdG8gdXNlIGxpYnNlbGludXggdG8g
a2VlcCBMVFAgZGVwZW5kZW5jaWVzCm1pbmltYWwuIEFsc28sIHdlIGRvbid0IHJlYWxseSBuZWVk
IHRoYXQgcHJlY2lzZSBjaGVja3MgYXMgZGV0ZWN0aW5nIHByb3Blcmx5IGluCmNocm9vdCBldGMg
d2hpY2ggaXMgaW4gdGhlIGxpYnNlbGludXggKGluIHNlbGludXhfaW5pdF9sb2FkX3BvbGljeSgp
KS4gSU1ITyBteQpzdWdnZXN0aW9uIGZvciBjaGVja2luZyBpZiAvc3lzL2ZzL3NlbGludXgvZW5m
b3JjZSBleGlzdHMgKGZvciBlbmFibGVkIFNFTGludXgKcmVnYXJkbGVzcyBpZiBlbmZvcmNpbmcg
b3IgcGVybWlzc2l2ZSkgb3Igd2hldGhlciB0aGUgdmFsdWUgaXMgMSAoZm9yIGVuYWJsZWQKU0VM
aW51eCBlbmZvcmNlbWVudCkgaXMgZW5vdWdoLgoKPiA+IEFuZCBpbml0X3NlbGludXhtbnQoKSwg
YSBjb25zdHJ1Y3RvciBmb3IgbGlic2VsaW51eCwgZG9lcyB0aGlzOgoKPiA+IHN0YXRpYyB2b2lk
IGluaXRfc2VsaW51eG1udCh2b2lkKQo+ID4gewo+ID4gICAgICAgICBjaGFyICpidWYgPSBOVUxM
LCAqcDsKPiA+ICAgICAgICAgRklMRSAqZnAgPSBOVUxMOwo+ID4gICAgICAgICBzaXplX3QgbGVu
Owo+ID4gICAgICAgICBzc2l6ZV90IG51bTsKCj4gPiAgICAgICAgIGlmIChzZWxpbnV4X21udCkK
PiA+ICAgICAgICAgICAgICAgICByZXR1cm47Cgo+ID4gICAgICAgICBpZiAodmVyaWZ5X3NlbGlu
dXhtbnQoU0VMSU5VWE1OVCkgPT0gMCkgcmV0dXJuOwoKPiA+ICAgICAgICAgaWYgKHZlcmlmeV9z
ZWxpbnV4bW50KE9MRFNFTElOVVhNTlQpID09IDApIHJldHVybjsKCj4gPiAgICAgICAgIC8qIERy
b3AgYmFjayB0byBkZXRlY3RpbmcgaXQgdGhlIGxvbmcgd2F5LiAqLwo+ID4gICAgICAgICBpZiAo
IXNlbGludXhmc19leGlzdHMoKSkKPiA+ICAgICAgICAgICAgICAgICBnb3RvIG91dDsKPiA+IC4u
LgoKPiA+IFNvIGluIHRoZSBjb21tb24gY2FzZSB3ZSBkb24ndCBuZWVkIHRvIGNoZWNrIC9wcm9j
L21vdW50cyBvcgo+ID4gL3Byb2MvZmlsZXN5c3RlbXMsIG9ubHkgaWYgd2UgZG9uJ3QgZmluZCBz
ZWxpbnV4ZnMgb24gb25lIG9mIHRoZQo+ID4gZXhwZWN0ZWQgbW91bnQgZGlyZWN0b3JpZXMgKC9z
eXMvZnMvc2VsaW51eCBvciAvc2VsaW51eCkuCgo+IEFsc28sIGZvciByZWZlcmVuY2UsIHZlcmlm
eV9zZWxpbnV4bW50KCkgaXMgYXMgZm9sbG93czoKCj4gc3RhdGljIGludCB2ZXJpZnlfc2VsaW51
eG1udChjb25zdCBjaGFyICptbnQpCj4gewo+ICAgICAgICAgc3RydWN0IHN0YXRmcyBzZmJ1ZjsK
PiAgICAgICAgIGludCByYzsKCj4gICAgICAgICBkbyB7Cj4gICAgICAgICAgICAgICAgIHJjID0g
c3RhdGZzKG1udCwgJnNmYnVmKTsKPiAgICAgICAgIH0gd2hpbGUgKHJjIDwgMCAmJiBlcnJubyA9
PSBFSU5UUik7Cj4gICAgICAgICBpZiAocmMgPT0gMCkgewo+ICAgICAgICAgICAgICAgICBpZiAo
KHVpbnQzMl90KXNmYnVmLmZfdHlwZSA9PSAodWludDMyX3QpU0VMSU5VWF9NQUdJQykgewo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzdGF0dmZzIHZmc2J1ZjsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICByYyA9IHN0YXR2ZnMobW50LCAmdmZzYnVmKTsKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBpZiAocmMgPT0gMCkgewo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKCEodmZzYnVmLmZfZmxhZyAmIFNUX1JET05MWSkpIHsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2V0X3NlbGludXhtbnQobW50KTsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAwOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAg
fQo+ICAgICAgICAgfQoKPiAgICAgICAgIHJldHVybiAtMTsKPiB9CgpJbnRlcmVzdGluZywgSSB3
YXMgbm90IGF3YXJlIG9mIFNFTElOVVhfTUFHSUMuCgpGb3IgbWUgd2FzIG1vcmUgaW5mb3JtYXRp
dmUgaG93IHRoZSBzZXR1cCB3b3JrcyB0byBzZWUgc2VsaW51eF9pbml0X2xvYWRfcG9saWN5KCkK
Cmh0dHBzOi8vZ2l0aHViLmNvbS9TRUxpbnV4UHJvamVjdC9zZWxpbnV4L3RyZWUvbWFpbi9saWJz
ZWxpbnV4L3NyYy9sb2FkX3BvbGljeS5jCgpLaW5kIHJlZ2FyZHMsClBldHIKLi4uCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
