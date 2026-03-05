Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA62CF3D319
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 15:51:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 899453CCB72
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 16:51:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695973CCB72
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 16:51:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6C85D200773
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 16:50:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04E2C3F26F;
 Thu,  5 Mar 2026 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772725858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiP58wOzz1ukHnJJTgLSQ1dCP3wC1Gknbtfz3xuaFnI=;
 b=fyWoA1yJCDJvuLCLTiUPJ+h9/reokLh/i8PjqtWr8r3CeCo3y9SLx6WAaI2mHzuXaiJm4j
 qNVal9iMwM5DJbB8xUV+n4HUIcW1NnrXdQzkwSjk43OZDd0LSa6e7LBuzG4S0AAZ71oMfz
 3HX4TjL7LtsD31ne5PhcpbZB/Duzj1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772725858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiP58wOzz1ukHnJJTgLSQ1dCP3wC1Gknbtfz3xuaFnI=;
 b=k3HaOLe9W3LdunNGN4Yn5Rq5Hr/WhR/VolVFeb7CZHVu+UkQPNG+iuBl88V7pTfUodHkMq
 NG6n0EmALGGQ+KCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fyWoA1yJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k3HaOLe9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772725858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiP58wOzz1ukHnJJTgLSQ1dCP3wC1Gknbtfz3xuaFnI=;
 b=fyWoA1yJCDJvuLCLTiUPJ+h9/reokLh/i8PjqtWr8r3CeCo3y9SLx6WAaI2mHzuXaiJm4j
 qNVal9iMwM5DJbB8xUV+n4HUIcW1NnrXdQzkwSjk43OZDd0LSa6e7LBuzG4S0AAZ71oMfz
 3HX4TjL7LtsD31ne5PhcpbZB/Duzj1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772725858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiP58wOzz1ukHnJJTgLSQ1dCP3wC1Gknbtfz3xuaFnI=;
 b=k3HaOLe9W3LdunNGN4Yn5Rq5Hr/WhR/VolVFeb7CZHVu+UkQPNG+iuBl88V7pTfUodHkMq
 NG6n0EmALGGQ+KCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED5CE3EA68;
 Thu,  5 Mar 2026 15:50:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 523tOWGmqWm/TAAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 15:50:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id AD555A0B71; Thu,  5 Mar 2026 16:50:57 +0100 (CET)
Date: Thu, 5 Mar 2026 16:50:57 +0100
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <lgnxbae2vbq2imklzkf5alkft54zngu6asopgifpp5byldscpi@q6zprbl7rmyt>
References: <20260304133810.24585-1-wegao@suse.com>
 <vkxlr754g4xhqhypya7ybullssszqvduqvvisy4e5dzmxwupqr@2qobtjcvvjuy>
 <aamU72Q2sW9wFyYY@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aamU72Q2sW9wFyYY@autotest-wegao.qe.prg2.suse.org>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_THREE(0.00)[3]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_LAST(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:email, suse.cz:dkim, intel.com:email]
X-Rspamd-Queue-Id: 04E2C3F26F
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1IDA1LTAzLTI2IDE0OjM2OjMxLCBXZWkgR2FvIHdyb3RlOgo+IE9uIFRodSwgTWFyIDA1
LCAyMDI2IGF0IDEwOjM2OjA0QU0gKzAxMDAsIEphbiBLYXJhIHdyb3RlOgo+ID4gPiAyKSB0Y2Fz
ZTQgZmFpbHVyZTogVGhlIGtlcm5lbCBtYXkgZGVsaXZlciBlcnJvcnMgYXMgaW5kZXBlbmRlbnQg
ZXZlbnRzCj4gPiA+ICAgIGluc3RlYWQgb2YgYSBzaW5nbGUgbWVyZ2VkIGV2ZW50LCBUaGUgdGVz
dCBsb2dpYyBpcyB1cGRhdGVkIHRvCj4gPiA+ICAgIHZhbGlkYXRlIHRoZSBleHBlY3RlZCBlcnJv
cl9jb3VudCBieSBlaXRoZXIgYSBzaW5nbGUgbWVyZ2VkIGV2ZW50Cj4gPiA+ICAgIG9yIHRoZSBh
Y2N1bXVsYXRpb24gb2YgbXVsdGlwbGUgaW5kZXBlbmRlbnQgZXZlbnRzIGluIHRoZSBidWZmZXIu
Cj4gPiAKPiA+IERpZCB5b3UgaW52ZXN0aWdhdGUgd2h5IHRoZSBldmVudHMgZGlkbid0IGdldCBt
ZXJnZWQgaW4gdGhlIGtlcm5lbD8gSWYgdGhleQo+ID4gYXJlIGFnYWluc3QgdGhlIHNhbWUgZmls
ZXN5c3RlbSB0aGV5IHNob3VsZCBnZXQgbWVyZ2VkIEFGQUlDUy4KPiA+IAo+IFNvcnJ5IGkgaGF2
ZSBubyBpZGVhIHdoeSB0aGlzIGhhcHBlbiwgSSBqdXN0IGFkZCBkZWJ1ZyBjb2RlIGludG8gTFRQ
IGNhc2UgYW5kIAo+IGZvdW5kIHRoZSBldmVudCBub3QgbG9zdCBidXQgZGVsaXZlciBpbmRlcGVu
ZGVudCwgdGhpcyBsZWFkcyBtZSB0byBiZWxpZXZlIHRoYXQKPiB0aGUgTFRQIHNob3VsZCBoYW5k
bGUgYm90aCBzY2VuYXJpb3PigJRtZXJnZWQgYW5kIGluZGVwZW5kZW50IGV2ZW50cy4KPiBJIGFs
c28gbm90IHN1cmUgbXkgcGF0Y2ggaXMgY29ycmVjdCBvciBub3QsIHRoYXQncyBhbHNvIHRoZSBy
ZWFzb24gaQo+IENDIHRoZSBwYXRjaCB0byB5b3UgOikKCk9LIDopLiBIb3cgZWFzaWx5IGlzIHRo
aXMgcmVwcm9kdWNpYmxlPyBCZWNhdXNlIGluIHByaW5jaXBsZSBldmVudCBtZXJnaW5nCmlzIG5v
dCAqZ3VhcmFudGVlZCogc28gaXQgaXNuJ3Qgd3JvbmcgZm9yIHRoZSBMVFAgdGVzdCB0byBoYW5k
bGUgc3BsaXQKZXZlbnRzIGJ1dCBiZWZvcmUgd2UgY29tcGxpY2F0ZSB0aGUgdGVzdCB0b28gbXVj
aCBpdCB3b3VsZCBiZSBnb29kIHRvCmZpZ3VyZSBvdXQgd2h5IHRoZSBrZXJuZWwgYmVoYXZlcyBp
biB1bmV4cGVjdGVkIHdheSBhbmQgZG9lc24ndCBtZXJnZSB0aGUKZXZlbnRzLi4uCgoJCQkJCQkJ
CUhvbnphCgo+ID4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5n
QGludGVsLmNvbT4KPiA+ID4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1sa3Av
MjAyNjAyMDQyMTI0Ljg3YmQwMGUzLWxrcEBpbnRlbC5jb20KPiA+ID4gU2lnbmVkLW9mZi1ieTog
V2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgLi4uL2tlcm5lbC9zeXNj
YWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMgICAgIHwgMzIgKysrKysrKysrKysrKysrKy0tLQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4g
PiA+IAo+ID4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlm
eS9mYW5vdGlmeTIyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90
aWZ5MjIuYwo+ID4gPiBpbmRleCA2NTc4NDc0YTcuLjgyZWVkN2JhOSAxMDA2NDQKPiA+ID4gLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMKPiA+ID4g
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMKPiA+
ID4gQEAgLTUzLDYgKzUzLDggQEAgc3RhdGljIHN0cnVjdCBmYW5vdGlmeV9maWRfdCBudWxsX2Zp
ZDsKPiA+ID4gIHN0YXRpYyBzdHJ1Y3QgZmFub3RpZnlfZmlkX3QgYmFkX2ZpbGVfZmlkOwo+ID4g
PiAgc3RhdGljIHN0cnVjdCBmYW5vdGlmeV9maWRfdCBiYWRfbGlua19maWQ7Cj4gPiA+ICAKPiA+
ID4gK3N0YXRpYyBpbnQgZXZlbnRfY291bnQ7Cj4gPiA+ICsKPiA+ID4gIHN0YXRpYyB2b2lkIHRy
aWdnZXJfZnNfYWJvcnQodm9pZCkKPiA+ID4gIHsKPiA+ID4gIAlTQUZFX01PVU5UKHRzdF9kZXZp
Y2UtPmRldiwgTU9VTlRfUEFUSCwgdHN0X2RldmljZS0+ZnNfdHlwZSwKPiA+ID4gQEAgLTg4LDcg
KzkwLDYgQEAgc3RhdGljIHZvaWQgdHJpZ2dlcl9iYWRfbGlua19sb29rdXAodm9pZCkKPiA+ID4g
IAkJCXJldCwgQkFEX0xJTkssIGVycm5vLCBFVUNMRUFOKTsKPiA+ID4gIH0KPiA+ID4gIAo+ID4g
PiAtCj4gPiA+ICBzdGF0aWMgdm9pZCB0Y2FzZTNfdHJpZ2dlcih2b2lkKQo+ID4gPiAgewo+ID4g
PiAgCXRyaWdnZXJfYmFkX2xpbmtfbG9va3VwKCk7Cj4gPiA+IEBAIC0xNzYsOSArMTc3LDEwIEBA
IHN0YXRpYyBpbnQgY2hlY2tfZXJyb3JfZXZlbnRfaW5mb19lcnJvcihzdHJ1Y3QgZmFub3RpZnlf
ZXZlbnRfaW5mb19lcnJvciAqaW5mb19lCj4gPiA+ICB7Cj4gPiA+ICAJaW50IGZhaWwgPSAwOwo+
ID4gPiAgCj4gPiA+IC0JaWYgKGluZm9fZXJyb3ItPmVycm9yX2NvdW50ICE9IGV4LT5lcnJvcl9j
b3VudCkgewo+ID4gPiAtCQl0c3RfcmVzKFRGQUlMLCAiJXM6IFVuZXhwZWN0ZWQgZXJyb3JfY291
bnQgKCVkIT0lZCkiLAo+ID4gPiAtCQkJZXgtPm5hbWUsIGluZm9fZXJyb3ItPmVycm9yX2NvdW50
LCBleC0+ZXJyb3JfY291bnQpOwo+ID4gPiArCWlmIChpbmZvX2Vycm9yLT5lcnJvcl9jb3VudCAh
PSBleC0+ZXJyb3JfY291bnQgJiYgZXZlbnRfY291bnQgIT0gZXgtPmVycm9yX2NvdW50KSB7Cj4g
PiA+ICsJCXRzdF9yZXMoVEZBSUwsICIlczogVW5leHBlY3RlZCBlcnJvcl9jb3VudCAoJWQhPSVk
ICYmICVkIT0lZCkiLAo+ID4gPiArCQkJZXgtPm5hbWUsIGluZm9fZXJyb3ItPmVycm9yX2NvdW50
LCBleC0+ZXJyb3JfY291bnQsCj4gPiA+ICsJCQlldmVudF9jb3VudCwgZXgtPmVycm9yX2NvdW50
KTsKPiA+ID4gIAkJZmFpbCsrOwo+ID4gPiAgCX0KPiA+ID4gIAo+ID4gPiBAQCAtMjU1LDggKzI1
NywzMCBAQCBzdGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBpKQo+ID4gPiAgCj4gPiA+
ICAJdGNhc2UtPnRyaWdnZXJfZXJyb3IoKTsKPiA+ID4gIAo+ID4gPiArCXVzbGVlcCgxMDAwMDAp
Owo+ID4gPiArCj4gPiAKPiA+IE9LLCBidXQgY2FuIHlvdSBwbGVhc2UgYWRkIGEgY29tbWVudCB3
aHkgdGhlIHNsZWVwIGlzIGhlcmUuCj4gPiAKPiBTdXJlIQo+ID4gPiAgCXJlYWRfbGVuID0gU0FG
RV9SRUFEKDAsIGZkX25vdGlmeSwgZXZlbnRfYnVmLCBCVUZfU0laRSk7Cj4gPiA+ICAKPiA+ID4g
KwlzdHJ1Y3QgZmFub3RpZnlfZXZlbnRfbWV0YWRhdGEgKm1ldGFkYXRhOwo+ID4gPiArCXNpemVf
dCBsZW4gPSByZWFkX2xlbjsKPiA+ID4gKwo+ID4gPiArCWV2ZW50X2NvdW50ID0gMDsKPiA+ID4g
Kwo+ID4gPiArCWZvciAobWV0YWRhdGEgPSAoc3RydWN0IGZhbm90aWZ5X2V2ZW50X21ldGFkYXRh
ICopZXZlbnRfYnVmOwo+ID4gPiArCQkJRkFOX0VWRU5UX09LKG1ldGFkYXRhLCBsZW4pOwo+ID4g
PiArCQkJbWV0YWRhdGEgPSBGQU5fRVZFTlRfTkVYVChtZXRhZGF0YSwgbGVuKSkgewo+ID4gPiAr
CQlldmVudF9jb3VudCsrOwo+ID4gPiArCQlzdHJ1Y3QgZmFub3RpZnlfZXZlbnRfaW5mb19lcnJv
ciAqaW5mb19lcnJvciA9IGdldF9ldmVudF9pbmZvX2Vycm9yKG1ldGFkYXRhKTsKPiA+ID4gKwo+
ID4gPiArCQlpZiAoaW5mb19lcnJvcikgewo+ID4gPiArCQkJdHN0X3JlcyhUSU5GTywgIkV2ZW50
IFslZF06IGVycm5vPSVkIChleHBlY3RlZCAlZCksIGVycm9yX2NvdW50PSVkIChleHBlY3RlZCB0
b3RhbCAlZCkiLAo+ID4gPiArCQkJCQlldmVudF9jb3VudCwgaW5mb19lcnJvci0+ZXJyb3IsIHRj
YXNlLT5lcnJvciwKPiA+ID4gKwkJCQkJaW5mb19lcnJvci0+ZXJyb3JfY291bnQsIHRjYXNlLT5l
cnJvcl9jb3VudCk7Cj4gPiA+ICsJCX0gZWxzZSB7Cj4gPiA+ICsJCQl0c3RfcmVzKFRJTkZPLCAi
RXZlbnQgWyVkXTogTm8gZXJyb3IgaW5mbyByZWNvcmQgZm91bmQiLCBldmVudF9jb3VudCk7Cj4g
PiA+ICsJCX0KPiA+ID4gKwl9Cj4gPiA+ICsKPiA+IAo+ID4gVGhpcyBsb29rcyB0b28gbGF4IHRv
IG1lLiBJIHRoaW5rCj4gPiAKPiBJIGd1ZXNzIHlvdXIgbWVhbiB0aGlzIGlzIHdvcmthcm91bmQg
Zm9yIHRoZSBpc3N1ZT8gQXJlIHlvdSBzdWdnZXN0aW5nIHRoYXQgSSBzaG91bGQgcmVjb25zdHJ1
Y3QgdGhlIHRlc3QgY2FzZSAKPiB0byBwcm9wZXJseSBoYW5kbGUgaW5kZXBlbmRlbnQgZXZlbnRz
IHJhdGhlciB0aGFuIHJlbHlpbmcgb24gdGhlIGV4aXN0aW5nIGxvZ2ljPyAKPiBJZiBzbywgSeKA
mWQgYmUgaGFwcHkgdG8gZXhwbG9yZSB0aGF0IGFuZCBpbXBsZW1lbnQgYSBtb3JlIHJvYnVzdCBz
b2x1dGlvbi4KPiAKPiA+IC0tIAo+ID4gSmFuIEthcmEgPGphY2tAc3VzZS5jb20+Cj4gPiBTVVNF
IExhYnMsIENSCi0tIApKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4KU1VTRSBMYWJzLCBDUgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
