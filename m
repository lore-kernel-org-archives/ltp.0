Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3059C54EBE
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 09:17:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D0B33CCB1A
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 10:17:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D77813C85F1
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 10:16:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 03CD11400153
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 10:16:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09CF567CB4;
 Tue, 10 Jan 2023 09:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673342216;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3d8hpVikOBnBpRlknTggUMwu7zElG/lrs32lxonbrY=;
 b=1J5q867NO4HY0axid+odMl5Q2gfjgOtluhDJK6BapCfmMb0MHU1bEHKSNBFhgp8CTO5Rue
 mpJyNjtsIOZ+/UV/X9rsf8wnV2Z4JILTPzGaxLsDWJGgtvJoA2yIvdKnmIOcuN1cwavoO8
 MA+fwjeakOxC6YTwY6EZ6nhMjB+s3bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673342216;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3d8hpVikOBnBpRlknTggUMwu7zElG/lrs32lxonbrY=;
 b=9XN0OlXqu9+Idp6C9bQbU1HpQEEeSjLAIkNywpFw8NN0b6Nk9uo8LEgQoJceOa5JNN8PnG
 lJdcgRZJ+GY3NKAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8A3C13338;
 Tue, 10 Jan 2023 09:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AXXMMwctvWPNLQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 Jan 2023 09:16:55 +0000
Date: Tue, 10 Jan 2023 10:16:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: coolgw <coolgw1126@gmail.com>
Message-ID: <Y70tBhCYADj25GCv@pevik>
References: <20230109051259.30263-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230109051259.30263-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] readahead02.c fixes: use tst_parse_filesize()
 so that we can pass sizes with units e.g. -s 128M
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

SGkgV2VpLAoKSSBzZXQgdGhlIG90aGVyIDMgbWVzYWdlcyBhcyBzdXBwZXJzZWRlZCBpbiBwYXRj
aHdvci4KUGxlYXNlIGJlZm9yZSBzZW5kaW5nIGVtYWlsLCBjaGVjayB3aGV0aGVyIGl0IGhhcyBi
ZWVuIHJlY2VpdmVkIGJ5IE1MLgpZb3Ugc2hvdWxkIGdldCBpdCB0byB5b3VyIG1haWwgeW91IHVz
ZSBhcyBTaWduZWQtb2ZmLWJ5OiwKYWxzbyBpdCdzIGFmdGVyIH4xIG1pbiBpbiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvCmFuZCBpbiBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvbHRwL2xpc3QvLgpBZnRlciBzb21lIHRpbWUgKGZldyBtaW51dGVzKSBp
dCdzIGFsc28gaW4KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLwoKUGF0Y2ggc3ViamVjdCBp
cyBqdXN0IHRvbyBsb25nIGFuZCB5ZXQgbm90IGRlc2NyaWJpbmcgdGhpbmdzIGNvcnJlY3RseS4K
aHR0cHM6Ly9jaHJpcy5iZWFtcy5pby9wb3N0cy9naXQtY29tbWl0LwoKSXQgY291bGQgYmUgc29t
ZXRoaW5nIGxpa2UgdGhpcyAocGF0Y2ggY29udGludWVzIG9uIDNyZCBsaW5lKToKCnJlYWRhaGVh
ZDAyLmM6IGFsbG93IHRvIHBhc3MgaHVtYW4gcmVhZGFibGUgc2l6ZXMKCmUuZy4gLi9yZWFkYWhl
YWQwMiAtcyAxMjhNCgotLS0KTk9URTogaXQncyBub3QgYSBmaXgsIGJ1dCBlbmhhbmNlbWVudC4K
VGhlIGZpeCB3b3VsZCBiZSB0byBmaXggYSByZWFsIHByb2JsZW0sIGUuZy4gdGVzdCBhbGxvd3Mg
dG8gZGVmaW5lIGFuIGludmFsaWQKc2l6ZToKCiQgc3VkbyAuL3JlYWRhaGVhZDAyIC1zIDEwMAp0
c3RfZGV2aWNlLmM6OTM6IFRJTkZPOiBGb3VuZCBmcmVlIGRldmljZSA0ICcvZGV2L2xvb3A0Jwp0
c3RfdGVzdC5jOjEwOTM6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDQgd2l0aCBleHQyIG9w
dHM9JycgZXh0cmEgb3B0cz0nJwpta2UyZnMgMS40Ni41ICgzMC1EZWMtMjAyMSkKdHN0X3Rlc3Qu
YzoxNTU4OiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAxbSAwMHMKdHN0X3Rlc3QuYzox
NTY2OiBUSU5GTzogVXBkYXRpbmcgbWF4IHJ1bnRpbWUgdG8gMGggMDBtIDAxcwp0c3RfdGVzdC5j
OjE1NTg6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMxcwpyZWFkYWhlYWQwMi5j
OjM4NzogVElORk86IHJlYWRhaGVhZCBsZW5ndGg6IDQwOTYKcmVhZGFoZWFkMDIuYzoyMjM6IFRJ
TkZPOiBUZXN0ICMwOiByZWFkYWhlYWQgb24gZmlsZQpyZWFkYWhlYWQwMi5jOjEyODogVElORk86
IGNyZWF0aW5nIHRlc3QgZmlsZSBvZiBzaXplOiAxMDAKcmVhZGFoZWFkMDIuYzoxOTE6IFRCUk9L
OiBtbWFwKChuaWwpLDAsMSwzMjc2OSwzLDApIGZhaWxlZDogRUlOVkFMICgyMikKCj0+IGFsdGhv
dWdoIEkgaGF2ZW4ndCBsb29rZWQgaWYgdGhpcyBpcyBhIGJ1ZyBlbHNld2hlcmUgaW4gYSB0ZXN0
IHdoaWNoIHNob3VsZApiZSBmaXhlZCwgb3IgdGVzdCBqdXN0IG5lZWRzIG1vcmUgc2l6ZSAobGlr
ZWx5KSBhbmQgdGh1cyBzaXplIHNob3VsZCBiZSByZXF1aXJlZApoaWdoZXIuCgo+IFNpZ25lZC1v
ZmYtYnk6IFdFSSBHQU8gPHdlZ2FvQHN1c2UuY29tPgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3JlYWRhaGVhZC9yZWFkYWhlYWQwMi5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgo+IGRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlYWRhaGVhZC9yZWFkYWhlYWQwMi5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDIuYwo+IGluZGV4IDNlZDg4YzAw
NS4uYzI4MmI0ZDY4IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVh
ZGFoZWFkL3JlYWRhaGVhZDAyLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Jl
YWRhaGVhZC9yZWFkYWhlYWQwMi5jCj4gQEAgLTM2Nyw4ICszNjcsOCBAQCBzdGF0aWMgdm9pZCBz
ZXR1cF9yZWFkYWhlYWRfbGVuZ3RoKHZvaWQpCgo+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+
ICB7Cj4gLQlpZiAob3B0X2ZzaXplc3RyKSB7Cj4gLQkJdGVzdGZpbGVfc2l6ZSA9IFNBRkVfU1RS
VE9MKG9wdF9mc2l6ZXN0ciwgMSwgSU5UX01BWCk7Cj4gKyAgICAgICAgaWYgKHRzdF9wYXJzZV9m
aWxlc2l6ZShvcHRfZnNpemVzdHIsICZ0ZXN0ZmlsZV9zaXplLCAxLCBJTlRfTUFYKSkgewoKUnVu
bmluZyBtYWtlIGludHJvZHVjZXMgd2FybmluZ3MgKHdlIGRvbid0IHdhbnQgdG8gaW50cm9kdWNl
IG5ldyB3YXJuaW5ncyk6CgpyZWFkYWhlYWQwMi5jOiBJbiBmdW5jdGlvbiDigJhzZXR1cOKAmToK
cmVhZGFoZWFkMDIuYzozNzA6NDY6IHdhcm5pbmc6IHBhc3NpbmcgYXJndW1lbnQgMiBvZiDigJh0
c3RfcGFyc2VfZmlsZXNpemXigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIFstV2lu
Y29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQogIDM3MCB8ICAgICAgICAgaWYgKHRzdF9wYXJzZV9m
aWxlc2l6ZShvcHRfZnNpemVzdHIsICZ0ZXN0ZmlsZV9zaXplLCAxLCBJTlRfTUFYKSkgewogICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfAogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNpemVfdCAqIHtha2EgbG9uZyB1bnNpZ25lZCBpbnQgKn0KSW4gZmlsZSBpbmNsdWRlZCBmcm9t
IHJlYWRhaGVhZDAyLmM6MzM6Ci4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3QuaDoxMzg6NTI6
IG5vdGU6IGV4cGVjdGVkIOKAmGxvbmcgbG9uZyBpbnQgKuKAmSBidXQgYXJndW1lbnQgaXMgb2Yg
dHlwZSDigJhzaXplX3QgKuKAmSB7YWthIOKAmGxvbmcgdW5zaWduZWQgaW50ICrigJl9CiAgMTM4
IHwgaW50IHRzdF9wYXJzZV9maWxlc2l6ZShjb25zdCBjaGFyICpzdHIsIGxvbmcgbG9uZyAqdmFs
LCBsb25nIGxvbmcgbWluLCBsb25nIGxvbmcgbWF4KTsKICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5efn4KCiB0c3RfcGFyc2VfZmlsZXNp
emUgd291bGQgaGF2ZSB0byBiZSBsb25nIGxvbmcuClRoZXJlZm9yZSBpdCB3b3VsZCBoYXZlIHRv
IGJlIGNhc3RlZCAoc2l6ZV90KSBvbiBvdGhlciBwbGFjZXMKd2hpY2ggZXhwZWN0ZWQgdGhlIG9y
aWdpbmFsIHNpemVfdCB0eXBlLgoKS2luZCByZWdhcmRzLApQZXRyCgo+ICsJCXRzdF9icmsoVEJS
T0ssICJpbnZhbGlkIGluaXRpYWwgZmlsZXNpemUgJyVzJyIsIG9wdF9mc2l6ZXN0cik7Cj4gIAkJ
dHN0X3NldF9tYXhfcnVudGltZSgxICsgdGVzdGZpbGVfc2l6ZSAvIChERUZBVUxUX0ZJTEVTSVpF
LzMyKSk7Cj4gIAl9CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
