Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CF8C5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 15:08:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 871273CA062
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 17:08:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CACC33C9FE5
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 17:08:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 414B060190D
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 17:08:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FD701FD0D;
 Tue,  3 Jun 2025 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748963286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RsB2bgVmc4Y5iA/zZw1LOSyf8Dx75DlUQtGTc1003PE=;
 b=2gMvkgMx08FgItT83t+RaG8XLr7EF8v35UgvUhTigrHjrejdFXQssL7m8+y3H3rN6TjkLu
 87+QJ1CI2JHCXvvs8avTudMMo06oTiCRMcUbVsPT1Z+bg2AZapzsKV60RwxwEnLBiOrsbF
 6DFKb+uLNDniP7T/xPKW4Mk0Av8CuNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748963286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RsB2bgVmc4Y5iA/zZw1LOSyf8Dx75DlUQtGTc1003PE=;
 b=TgZxcqVFEaz8rK80d1f/AjlDnn80CJSzBCgJBcQvJpR7NJPgVR2n1m6vkqhQsCIpeEqKdP
 We9/1jO9uoOI+FBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Tzeip4Zo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bbjku+gV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748963285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RsB2bgVmc4Y5iA/zZw1LOSyf8Dx75DlUQtGTc1003PE=;
 b=Tzeip4Zorqdjzvq+0ydNBfRB+cT6ZJZZxFsfAoYLjRwT1kSz2/zE9iq85ie7ztfm4HAUyt
 uyKh5LiA9xMVXtvwuEkD05hd1v96LagftwPfsH9oI5SnpsTCNWmi8iA+3JEl4hgHzBLpbN
 yIj/dufzIlP83GtS2FazDnucoId6M2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748963285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RsB2bgVmc4Y5iA/zZw1LOSyf8Dx75DlUQtGTc1003PE=;
 b=bbjku+gVggEHy4ZlFej2czc3CX5xsVDyZtwTUJ7c/mXgEYkDQNZ6KJRnrRaEIT/smgnFfu
 xg00Tf5iSrucVrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1146513A1D;
 Tue,  3 Jun 2025 15:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JCbzA9UPP2jrMAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 03 Jun 2025 15:08:05 +0000
Message-ID: <e27c1ab1-7a00-47e3-aac6-66d325896d9d@suse.cz>
Date: Tue, 3 Jun 2025 17:08:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20250603141320.161026-1-mdoucha@suse.cz>
 <20250603141320.161026-3-mdoucha@suse.cz>
 <7f20da41-8cb2-4e93-86e0-09a6be42af36@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <7f20da41-8cb2-4e93-86e0-09a6be42af36@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 1FD701FD0D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add regression test for epoll_pwait2() timeout
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCkknbGwgc2VuZCB2MiBzaG9ydGx5IGJ1dCBzb21lIG5vdGVzIGJlbG93LgoKT24gMDMuIDA2
LiAyNSAxNjozMywgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBIaSEKPiAKPiBPbiA2LzMvMjUg
MTY6MTMsIE1hcnRpbiBEb3VjaGEgd3JvdGU6Cj4+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBEb3Vj
aGEgPG1kb3VjaGFAc3VzZS5jej4KPj4gLS0tCj4+Cj4+IE5vdGU6IFRoZSB0ZXN0IHdpbGwgZ2V0
IGtpbGxlZCBieSBTSUdBTFJNIG9uIGZhaWx1cmUuCj4+Cj4+IMKgIHJ1bnRlc3Qvc3lzY2FsbHPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxICsKPj4gwqAgLi4uL2tlcm5lbC9zeXNjYWxscy9lcG9sbF9wd2FpdC8uZ2l0aWdub3Jl
wqDCoMKgIHzCoCAxICsKPj4gwqAgLi4uL3N5c2NhbGxzL2Vwb2xsX3B3YWl0L2Vwb2xsX3B3YWl0
MDYuY8KgwqDCoMKgwqAgfCA4NiArKysrKysrKysrKysrKysrKysrCj4+IMKgIDMgZmlsZXMgY2hh
bmdlZCwgODggaW5zZXJ0aW9ucygrKQo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9lcG9sbF9wd2FpdC8gCj4+IGVwb2xsX3B3YWl0MDYuYwo+Pgo+PiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9lcG9sbF9wd2FpdC9lcG9sbF9w
d2FpdDA2LmMgYi8gCj4+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXBvbGxfcHdhaXQvZXBv
bGxfcHdhaXQwNi5jCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAwMC4u
NDg3OTkyNzQ0Cj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9lcG9sbF9wd2FpdC9lcG9sbF9wd2FpdDA2LmMKPj4gQEAgLTAsMCArMSw4NiBAQAo+PiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPj4gKy8qCj4+ICsg
KiBDb3B5cmlnaHQgKGMpIDIwMjUgU1VTRSBMTEMgPG1kb3VjaGFAc3VzZS5jej4KPj4gKyAqLwo+
PiArCj4+ICsvKlwKPj4gKyAqIFZlcmlmeSB0aGF0IHZhcmlvdXMgdGltZW91dCB2YWx1ZXMgZG9u
J3QgZ2V0IG1pc2ludGVycHJldGVkIGFzIAo+PiBpbmZpbml0eQo+PiArICogYnkgZXBvbGxfcHdh
aXQoKSBhbmQgZXBvbGxfcHdhaXQyKCkKPiBJdCB3b3VsZCBiZSBuaWNlIHRvIGdpdmUgdGhlIHJl
ZmVyZW5jZSBvZiB0aGUgY29tbWl0IHdoaWNoIGludHJvZHVjZWQgCj4gdGhlIGJ1ZyBpbiB0aGUg
dHN0X3Rlc3Qgc3RydWN0dXJlLgoKLnRhZ3MgaXMgZm9yIGZpeGVzLCBub3QgYnVnZ3kga2VybmVs
IGNvbW1pdHMuIFYyIHdpbGwgaGF2ZSB0aGUgZml4IGNvbW1pdC4KCj4+ICsKPj4gK8KgwqDCoMKg
wqDCoMKgIGRvIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWxhcm0oMSk7Cj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHRpbWVvdXQudHZfbnNlYyAvPSAxMDsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZG9fZXBvbGxfcHdhaXQoZWZkLCAmZSwgMSwgJnRpbWVvdXQsIE5VTEwpOwo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGFybSgwKTsKPiBXaGF0IGFib3V0IGFkZGluZyBh
IFRJTkZPIGhlcmU/IEl0IHNob3VsZCBiZSBzaG93biBhcm91bmQgMTAgdGltZXMsIGJ1dCAKPiBl
dmVudHVhbGx5IHdlIHdvdWxkIGhhdmUgc29tZSBkZWJ1Z2dpbmcgZGF0YSBvbiBjb25zb2xlIHRv
IHVzZSBqdXN0IGluIAo+IGNhc2UgdGhlIHRlc3Qgc3R1Y2suCgpUaGUgVElORk8gd291bGQgb25s
eSBjb3VudCBiYWNrd2FyZHMgZnJvbSAxMDAgbWlsbGlvbiB0byB6ZXJvLCB3ZSBkb24ndCAKbmVl
ZCB0byBrbm93IHRoZSBzcGVjaWZpYyBudW1iZXIgd2hpY2ggdHJpZ2dlcmVkIHRoZSBidWcuIFRo
ZSB0ZXN0IHdvbid0IApnZXQgc3R1Y2ssIFNJR0FMUk0gd2lsbCBraWxsIGl0IG9uIGZhaWx1cmUu
Cgo+PiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+PiArwqDCoMKgIC50ZXN0X2Fs
bCA9IHJ1biwKPj4gK8KgwqDCoCAuc2V0dXAgPSBzZXR1cCwKPj4gK8KgwqDCoCAuY2xlYW51cCA9
IGNsZWFudXAsCj4+ICvCoMKgwqAgLnRlc3RfdmFyaWFudHMgPSBURVNUX1ZBUklBTlRTLAo+IEl0
J3Mgd29ydGggdG8gYWRkIGEgdGltZW91dCBmb3IgdGhlIHRlc3QsIHNpbmNlIGl0J3MgYSB0ZXN0
IHdoaWNoIGlzIAo+IHRlc3RpbmcgdGltZW91dCBsaW1pdHMuCj4+ICt9Owo+IAo+IEFsc28gd2Ug
bWlnaHQgbW92ZSB0aGUgcnVuKCkgaW5zaWRlIGEgcHJvY2VzcyBhbmQgY2hlY2sgaWYgaXQgZXZl
bnR1YWxseSAKPiBnZXRzIGtpbGxlZCBmcm9tIHRoZSBwYXJlbnQgZHVlIHRvIFNJR0FMQVJNIGFu
ZCBub3Qgb3RoZXIgc2lnbmFscy4KClRoZSB0ZXN0IHRha2VzIDIgc2Vjb25kcyBvbiBzdWNjZXNz
LCAzIHNlY29uZHMgaW4gdGhlIHdvcnN0IGNhc2Ugb24gCmZhaWx1cmUuIE9uZSBpbm5lciBsb29w
IHRha2VzIH4xMjBtcyBpbiB0b3RhbC4KCldlIGRvbid0IGNhcmUgd2hpY2ggc2lnbmFsIGtpbGxl
ZCBpdCBiZWNhdXNlIGl0J3MgYSBmYWlsdXJlIHN0YXRlLiBBbmQgCnNpbmNlIHYyIHdpbGwgcHJp
bnQgdGhlIGZpeCBjb21taXQsIHdlIGRvbid0IG5lZWQgYSBkZXRhaWxlZCBmYWlsdXJlIApleHBs
YW5hdGlvbiBlaXRoZXIuIE9uIHN1Y2Nlc3MsIHRoZSB0ZXN0IHdpbGwgZXhpdCB3aXRob3V0IHRy
aWdnZXJpbmcgCmFueSBzaWduYWxzLgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1c2Uu
Y3oKU1cgUXVhbGl0eSBFbmdpbmVlcgpTVVNFIExJTlVYLCBzLnIuby4KQ09SU08gSUlhCktyaXpp
a292YSAxNDgvMzQKMTg2IDAwIFByYWd1ZSA4CkN6ZWNoIFJlcHVibGljCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
