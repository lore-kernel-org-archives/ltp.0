Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D80DC001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 12:51:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 442573CECF2
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 14:51:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41E083CE1AD
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 14:51:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4897F1A00E74
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 14:51:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E0101FE12;
 Mon, 23 Oct 2023 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698065467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhYqLcZaYM65qf9ogL7c3ADPHqv8/lk0sKo25Dvb3eE=;
 b=S7pehBnJLvYdgBE/eD2dyJixy4eZIDTY8T+fQ5MJbmjS85YTdBSNu4m+KhvezXtCLt8WGS
 +mo3pzCcopR5gkwFePZJ2A/ip3J4LatzuVWJNDsMuxo+vfTeMHIUtHPneRUviA7L3kCy8H
 wKBdPNlEN6jZ30nUcfOtmCWrlgHNPSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698065467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhYqLcZaYM65qf9ogL7c3ADPHqv8/lk0sKo25Dvb3eE=;
 b=VBp5LjPmEoqzJ9CKz6+u7Uz6TgJR5NDyuBIWh3NgK+EYEZ1BeOoQ7SABIpFnxrIe8vXGt7
 Lr2raIcp9T+ejnCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59207132FD;
 Mon, 23 Oct 2023 12:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tOzHFDtsNmXrOAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 23 Oct 2023 12:51:07 +0000
Message-ID: <5f74b10f-2a97-9cdc-69c0-5e90f1d5d986@suse.cz>
Date: Mon, 23 Oct 2023 14:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
References: <20231020150749.21165-1-mdoucha@suse.cz>
 <20231020150749.21165-3-mdoucha@suse.cz>
 <CAOQ4uxgV-PoXQ6Aeimn8T5tUbXX_8RRMwXtAqzUix7ro=BmV-g@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAOQ4uxgV-PoXQ6Aeimn8T5tUbXX_8RRMwXtAqzUix7ro=BmV-g@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FREEMAIL_TO(0.00)[gmail.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] fanotify14: Improve check for unsupported
 init flags
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

T24gMjAuIDEwLiAyMyAxODowNSwgQW1pciBHb2xkc3RlaW4gd3JvdGU6Cj4gT24gRnJpLCBPY3Qg
MjAsIDIwMjMgYXQgNjowN+KAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4gd3Jv
dGU6Cj4+Cj4+IFRlc3QgY2FzZSA4IG9mIGZhbm90aWZ5MTQgdXNlcyBpbml0IGZsYWdzIHN1cHBv
cnRlZCBvbmx5IG9uIGtlcm5lbCA1LjkrCj4+IGJ1dCBkb2VzIG5vdCBwcm9wZXJseSBjaGVjayBm
b3IgdGhlaXIgc3VwcG9ydC4gUmV3cml0ZSBmYW5vdGlmeSBmZWF0dXJlCj4+IGNoZWNrcyB1c2lu
ZyBuZXcgaGVscGVyIGZ1bmN0aW9uLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gRG91Y2hh
IDxtZG91Y2hhQHN1c2UuY3o+Cj4+IC0tLQo+Pgo+PiBDaGFuZ2VzIHNpbmNlIHYxOgo+PiAtIEFk
ZGVkIEZBTl9DTEFTU18qIGNvbnN0YW50cyB0byBzdXBwb3J0IGNoZWNrIGluIHNldHVwKCkKPj4g
LSBBZGRlZCBsb25nZXIgcGF0Y2ggZGVzY3JpcHRpb24KPj4KPj4gQ2hhbmdlcyBzaW5jZSB2Mjog
Tm9uZQo+Pgo+PiBJJ2QgcmF0aGVyIG5vdCBzcXVhc2ggdGhpcyBwYXRjaCBzbyB0aGF0IGl0IGNh
biBiZSByZXZlcnRlZCB3aXRob3V0Cj4+IHBvdGVudGlhbGx5IGJyZWFraW5nIG90aGVyIHRlc3Rz
Lgo+Pgo+PiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5j
IHwgMTUgKysrKysrKysrLS0tLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
YW5vdGlmeS9mYW5vdGlmeTE0LmMKPj4gaW5kZXggNDU5NjUxMWYwLi4wYmI3ODkxODggMTAwNjQ0
Cj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5j
Cj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5j
Cj4+IEBAIC00NSw4ICs0NSw4IEBACj4+Cj4+ICAgc3RhdGljIGludCBwaXBlc1syXSA9IHstMSwg
LTF9Owo+PiAgIHN0YXRpYyBpbnQgZmFub3RpZnlfZmQ7Cj4+IC1zdGF0aWMgaW50IGZhbl9yZXBv
cnRfdGFyZ2V0X2ZpZF91bnN1cHBvcnRlZDsKPj4gICBzdGF0aWMgaW50IGlnbm9yZV9tYXJrX3Vu
c3VwcG9ydGVkOwo+PiArc3RhdGljIHVuc2lnbmVkIGludCBzdXBwb3J0ZWRfaW5pdF9mbGFnczsK
Pj4KPj4gICBzdHJ1Y3QgdGVzdF9jYXNlX2ZsYWdzX3Qgewo+PiAgICAgICAgICB1bnNpZ25lZCBs
b25nIGxvbmcgZmxhZ3M7Cj4+IEBAIC0yNDYsOSArMjQ2LDggQEAgc3RhdGljIHZvaWQgZG9fdGVz
dCh1bnNpZ25lZCBpbnQgbnVtYmVyKQo+PiAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAiVGVzdCBj
YXNlICVkOiBmYW5vdGlmeV9pbml0KCVzLCBPX1JET05MWSkiLCBudW1iZXIsCj4+ICAgICAgICAg
ICAgICAgICAgdGMtPmluaXQuZGVzYyk7Cj4+Cj4+IC0gICAgICAgaWYgKGZhbl9yZXBvcnRfdGFy
Z2V0X2ZpZF91bnN1cHBvcnRlZCAmJiB0Yy0+aW5pdC5mbGFncyAmIEZBTl9SRVBPUlRfVEFSR0VU
X0ZJRCkgewo+PiAtICAgICAgICAgICAgICAgRkFOT1RJRllfSU5JVF9GTEFHU19FUlJfTVNHKEZB
Tl9SRVBPUlRfVEFSR0VUX0ZJRCwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBmYW5fcmVwb3J0X3RhcmdldF9maWRfdW5zdXBwb3J0ZWQpOwo+PiArICAgICAg
IGlmICh0Yy0+aW5pdC5mbGFncyAmIH5zdXBwb3J0ZWRfaW5pdF9mbGFncykgewo+PiArICAgICAg
ICAgICAgICAgdHN0X3JlcyhUQ09ORiwgIlVuc3VwcG9ydGVkIGluaXQgZmxhZ3MiCj4gCj4gc3Vn
Z2VzdCB0byBwcmVzZXJ2ZSB0aGUgaW5mb3JtYXRpb24gcHJpbnRlZCBieQo+IEZBTk9USUZZX0lO
SVRfRkxBR1NfRVJSX01TRywgeW91IGNhbiB1c2UgdGMtPmluaXQuZGVzYwo+IHRoZSBmb3IgdGhl
IGZsYWcgbmFtZSBzdHJpbmcuCgp0Yy0+aW5pdC5kZXNjIGdldHMgcHJpbnRlZCBieSB0aGUgVElO
Rk8gbWVzc2FnZSBhdCB0aGUgc3RhcnQgb2YgdGhlIApwYXRjaCBjaHVuay4gVGhlIHJldHVybiB2
YWx1ZSBmcm9tIGZhbm90aWZ5X2luaXRfZmxhZ3Nfc3VwcG9ydGVkX29uX2ZzKCkgCmlzIG5vdCBw
cmVzZXJ2ZWQgYW55d2hlcmUgYnkgdGhlIG5ldyBmYW5vdGlmeV9nZXRfc3VwcG9ydGVkX2luaXRf
ZmxhZ3MoKSAKaGVscGVyIGZ1bmN0aW9uIHNvIEkgaGF2ZSBub3RoaW5nIHRvIHBhc3MgYXMgdGhl
IHNlY29uZCBhcmd1bWVudCBvZiAKRkFOT1RJRllfSU5JVF9GTEFHU19FUlJfTVNHKCkuCgotLSAK
TWFydGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5jegpTVyBRdWFsaXR5IEVuZ2luZWVyClNVU0Ug
TElOVVgsIHMuci5vLgpDT1JTTyBJSWEKS3Jpemlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgK
Q3plY2ggUmVwdWJsaWMKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
