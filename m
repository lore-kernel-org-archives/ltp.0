Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45952C5AE59
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 16:07:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C6483CA083
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 18:07:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FE9B3C9F6C
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 18:07:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CE3B600D19
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 18:07:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D967211F7;
 Tue,  3 Jun 2025 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748966846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=plkcK2yVOcaYFxduEWvQISK/f/e/daMHQbF6l3MU4IA=;
 b=R1Oy/8XCN2DwL4wVQGs9zyApcPIlQccBevRmi2nuQ3fZBYqlaUwf49QZeYhJhuxTH0Yh86
 4vkiAFRUIcfaJt+Z0c5mCluV7Wog5uOKDSfliLquFpYsnsn694g7U0nPJdLP0FpuqpNbVF
 TAohf3L/XIsEQn2g5ym92aFSRNqg41c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748966846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=plkcK2yVOcaYFxduEWvQISK/f/e/daMHQbF6l3MU4IA=;
 b=BaG7VT1FPMuQMwBIz92E87g31aDaloA7JkpclrlvfU4PVFbZR8589WFVUKcCOKC05/wUSl
 C5qIuCz4f+QAGwCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748966845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=plkcK2yVOcaYFxduEWvQISK/f/e/daMHQbF6l3MU4IA=;
 b=2bNkpT0tpTT9JQSZR+ghtVgk+hCZvMuOaX38lCLOl47aFlBRQ34V1r+tm00Wy4WJVa6ELI
 gQQoGTmGV8p7YCWNXammCf82hUDqIppgwmk++lctctfOCVv/TBuBMvk5P6AVHZ35bM8zNY
 ZnccEI/0Kf0XodEt+GuUmRAli5E06l8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748966845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=plkcK2yVOcaYFxduEWvQISK/f/e/daMHQbF6l3MU4IA=;
 b=Isjx3D21ShsWSVJgwYGJIS0oQg70ZxR7a1co5gZJ5cVUUqwZio5qxhz+I37LyvuOlXSajy
 RVJCNfx9bkoT7mAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5446813A92;
 Tue,  3 Jun 2025 16:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UrBaFL0dP2jQQwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 03 Jun 2025 16:07:25 +0000
Message-ID: <42caf3b4-bcb2-43a9-86fb-d62ed95eb32a@suse.cz>
Date: Tue, 3 Jun 2025 18:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20250602155710.63165-1-mdoucha@suse.cz>
 <ce668d93-0edd-432f-abb4-dc8ca1a870db@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <ce668d93-0edd-432f-abb4-dc8ca1a870db@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] open12: Convert to new API
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

SGksCkknbGwgc2VuZCB2MiBzaG9ydGx5LCBzb21lIG5vdGVzIGJlbG93LgoKT24gMDMuIDA2LiAy
NSAxMDo1NSwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBIaSEKPiAKPiBPbiA2LzIvMjUgMTc6
NTcsIE1hcnRpbiBEb3VjaGEgd3JvdGU6Cj4+IMKgIHN0YXRpYyB2b2lkIHRlc3RfYXBwZW5kKHZv
aWQpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBvZmZfdCBsZW4xLCBsZW4yOwo+PiAtwqDCoMKgIFRF
U1Qob3BlbihURVNUX0ZJTEUsIE9fUkRXUiB8IE9fQVBQRU5ELCAwNzc3KSk7Cj4+ICvCoMKgwqAg
dHN0X3JlcyhUSU5GTywgIlRlc3RpbmcgT19BUFBFTkQiKTsKPj4gKwo+PiArwqDCoMKgIGZkID0g
VFNUX0VYUF9GRF9TSUxFTlQob3BlbihURVNUX0ZJTEUsIE9fUkRXUiB8IE9fQVBQRU5ELCAwNjQ0
KSk7Cj4gSXMgdGhlcmUgYSByZWFzb24gd2h5IG5vdCB1c2luZyBTQUZFX09QRU4oKSA/IEl0IGRv
ZXNuJ3Qgc2VlbSB0byBhZmZlY3QgCj4gdGhlIGNvZGUuCj4gQWxzbywgaWYgb3BlbigpIHN5c2Nh
bGwgZmFpbHMgd2UgYXJlIG5vdCBwcmludGluZyBhbnl0aGluZyBidXQgdGhlIFRJTkZPIAo+IG1l
c3NhZ2UgYW5kIGl0IG1ha2VzIHNlbnNlIHRvIFRCUk9LIGlmIHRoZXJlJ3MgYSBwcm9ibGVtIHdp
dGggb3BlbmluZyAKPiB0aGUgdGVzdCBmaWxlIChMVFAgb3Igc3lzdGVtIGJ1ZykuCgpUU1RfKl9T
SUxFTlQoKSBtYWNyb3MgYXJlIHNpbGVudCBvbmx5IG9uIHN1Y2Nlc3MuIFRoZXkgd2lsbCBjb21w
bGFpbiAKbG91ZGx5IG9uIGZhaWx1cmUuIFRoZSByZWFzb24gdG8gYXZvaWQgU0FGRV9PUEVOKCkg
aXMgdGhhdCBpdCdsbCAKdGVybWluYXRlIHRoZSB0ZXN0IG9uIGZhaWx1cmUuIEkgcHJlZmVyIHRv
IGZpbmlzaCB0aGUgb3RoZXIgdGVzdCBjYXNlcyAKaW5zdGVhZC4KCj4+IC3CoMKgwqAgaWYgKFRF
U1RfUkVUVVJOID09IC0xKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCB0c3RfcmVzbShURkFJTCB8IFRU
RVJSTk8sICJvcGVuIGZhaWxlZCIpOwo+PiArwqDCoMKgIGlmICghVFNUX1BBU1MpCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+IC3CoMKgwqAgfQo+PiAtwqDCoMKgIGxlbjEgPSBTQUZF
X0xTRUVLKGNsZWFudXAsIFRFU1RfUkVUVVJOLCAwLCBTRUVLX0NVUik7Cj4+IC3CoMKgwqAgU0FG
RV9XUklURShjbGVhbnVwLCBTQUZFX1dSSVRFX0FMTCwgVEVTVF9SRVRVUk4sIFRFU1RfRklMRSwK
Pj4gLcKgwqDCoMKgwqDCoMKgIHNpemVvZihURVNUX0ZJTEUpKTsKPj4gLcKgwqDCoCBsZW4yID0g
U0FGRV9MU0VFSyhjbGVhbnVwLCBURVNUX1JFVFVSTiwgMCwgU0VFS19DVVIpOwo+PiAtwqDCoMKg
IFNBRkVfQ0xPU0UoY2xlYW51cCwgVEVTVF9SRVRVUk4pOwo+PiArwqDCoMKgIGxlbjEgPSBTQUZF
X0xTRUVLKGZkLCAwLCBTRUVLX0NVUik7Cj4+ICvCoMKgwqAgU0FGRV9XUklURSgxLCBmZCwgVEVT
VF9GSUxFLCBzdHJsZW4oVEVTVF9GSUxFKSk7Cj4+ICvCoMKgwqAgbGVuMiA9IFNBRkVfTFNFRUso
ZmQsIDAsIFNFRUtfQ1VSKTsKPj4gK8KgwqDCoCBTQUZFX0NMT1NFKGZkKTsKPj4gwqDCoMKgwqDC
oCBpZiAobGVuMiA+IGxlbjEpCj4+IC3CoMKgwqDCoMKgwqDCoCB0c3RfcmVzbShUUEFTUywgInRl
c3QgT19BUFBFTkQgZm9yIG9wZW4gc3VjY2VzcyIpOwo+PiArwqDCoMKgwqDCoMKgwqAgdHN0X3Jl
cyhUUEFTUywgIk9fQVBQRU5EIHdvcmtzIGFzIGV4cGVjdGVkIik7Cj4+IMKgwqDCoMKgwqAgZWxz
ZQo+PiAtwqDCoMKgwqDCoMKgwqAgdHN0X3Jlc20oVEZBSUwsICJ0ZXN0IE9fQVBQRU5EIGZvciBv
cGVuIGZhaWxlZCIpOwo+PiArwqDCoMKgwqDCoMKgwqAgdHN0X3JlcyhURkFJTCwgIk9fQVBQRU5E
IGRpZCBub3QgbW92ZSB3cml0ZSBjdXJzb3IiKTsKPiBNYXliZSB3ZSBjYW4gdXNlIFRTVF9FWFBf
RVhQUiBoZXJlCgpUaGlzIGNoZWNrIGlzIHByZXR0eSBtdWNoIHVzZWxlc3MgYW5kIHRoZSBuZXh0
IHBhdGNoIHJld3JpdGVzIGl0IGZyb20gCnNjcmF0Y2guIE5vdCB3b3J0aCB0aGUgZWZmb3J0LgoK
Pj4gwqAgfQo+PiDCoCBzdGF0aWMgdm9pZCB0ZXN0X25vYXRpbWUodm9pZCkKPj4gQEAgLTEzNiwz
MSArNjksMjMgQEAgc3RhdGljIHZvaWQgdGVzdF9ub2F0aW1lKHZvaWQpCj4+IMKgwqDCoMKgwqAg
Y2hhciByZWFkX2J1ZjsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qgc3RhdCBvbGRfc3RhdCwgbmV3X3N0
YXQ7Cj4+IC3CoMKgwqAgaWYgKHNraXBfbm9hdGltZSkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdHN0
X3Jlc20oVENPTkYsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAidGVzdCBP
X05PQVRJTUUgZmxhZyBmb3Igb3BlbiBuZWVkcyBmaWxlc3lzdGVtcyB3aGljaCAiCj4+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiaXMgbW91bnRlZCB3aXRob3V0IG5vYXRpbWUg
YW5kIHJlbGF0aW1lIik7Cj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+IC3CoMKgwqAgfQo+
PiAtCj4+IC3CoMKgwqAgU0FGRV9TVEFUKGNsZWFudXAsIFRFU1RfRklMRSwgJm9sZF9zdGF0KTsK
Pj4gK8KgwqDCoCB0c3RfcmVzKFRJTkZPLCAiVGVzdGluZyBPX05PQVRJTUUiKTsKPj4gK8KgwqDC
oCBTQUZFX1NUQVQoVEVTVF9GSUxFLCAmb2xkX3N0YXQpOwo+PiDCoMKgwqDCoMKgIHNsZWVwKDEp
Owo+PiArwqDCoMKgIGZkID0gVFNUX0VYUF9GRF9TSUxFTlQob3BlbihURVNUX0ZJTEUsIE9fUkRP
TkxZIHwgT19OT0FUSU1FLCAwNjQ0KSk7Cj4+IC3CoMKgwqAgVEVTVChvcGVuKFRFU1RfRklMRSwg
T19SRE9OTFkgfCBPX05PQVRJTUUsIDA3NzcpKTsKPj4gLQo+PiAtwqDCoMKgIGlmIChURVNUX1JF
VFVSTiA9PSAtMSkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdHN0X3Jlc20oVEZBSUwgfCBUVEVSUk5P
LCAib3BlbiBmYWlsZWQiKTsKPj4gK8KgwqDCoCBpZiAoIVRTVF9QQVNTKQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOwo+PiAtwqDCoMKgIH0KPj4gLcKgwqDCoCBTQUZFX1JFQUQoY2xlYW51
cCwgMSwgVEVTVF9SRVRVUk4sICZyZWFkX2J1ZiwgMSk7Cj4+IC3CoMKgwqAgU0FGRV9DTE9TRShj
bGVhbnVwLCBURVNUX1JFVFVSTik7Cj4+IC3CoMKgwqAgU0FGRV9TVEFUKGNsZWFudXAsIFRFU1Rf
RklMRSwgJm5ld19zdGF0KTsKPj4gKwo+PiArwqDCoMKgIFNBRkVfUkVBRCgxLCBmZCwgJnJlYWRf
YnVmLCAxKTsKPj4gK8KgwqDCoCBTQUZFX0NMT1NFKGZkKTsKPj4gK8KgwqDCoCBTQUZFX1NUQVQo
VEVTVF9GSUxFLCAmbmV3X3N0YXQpOwo+PiDCoMKgwqDCoMKgIGlmIChvbGRfc3RhdC5zdF9hdGlt
ZSA9PSBuZXdfc3RhdC5zdF9hdGltZSkKPj4gLcKgwqDCoMKgwqDCoMKgIHRzdF9yZXNtKFRQQVNT
LCAidGVzdCBPX05PQVRJTUUgZm9yIG9wZW4gc3VjY2VzcyIpOwo+PiArwqDCoMKgwqDCoMKgwqAg
dHN0X3JlcyhUUEFTUywgIkZpbGUgYWNjZXNzIHRpbWUgd2FzIG5vdCBtb2RpZmllZCIpOwo+PiDC
oMKgwqDCoMKgIGVsc2UKPj4gLcKgwqDCoMKgwqDCoMKgIHRzdF9yZXNtKFRGQUlMLCAidGVzdCBP
X05PQVRJTUUgZm9yIG9wZW4gZmFpbGVkIik7Cj4+ICvCoMKgwqDCoMKgwqDCoCB0c3RfcmVzKFRG
QUlMLCAiRmlsZSBhY2Nlc3MgdGltZSBjaGFuZ2VkIik7Cj4gVFNUX0VYUF9FUV9MSSgpIHdvdWxk
IGFsc28gcHJpbnQgdGhlIHZhbHVlcwoKRG8gd2UgY2FyZSBhYm91dCByYW5kb20gdGltZXN0YW1w
IHZhbHVlcz8KCj4+IMKgIH0KPj4gwqAgc3RhdGljIHZvaWQgdGVzdF9jbG9leGVjKHZvaWQpCj4+
IEBAIC0xNjksODAgKzk0LDg4IEBAIHN0YXRpYyB2b2lkIHRlc3RfY2xvZXhlYyh2b2lkKQo+PiDC
oMKgwqDCoMKgIGludCBzdGF0dXM7Cj4+IMKgwqDCoMKgwqAgY2hhciBidWZbMjBdOwo+PiAtwqDC
oMKgIFRFU1Qob3BlbihURVNUX0ZJTEUsIE9fUkRXUiB8IE9fQVBQRU5EIHwgT19DTE9FWEVDLCAw
Nzc3KSk7Cj4+IC0KPj4gLcKgwqDCoCBpZiAoVEVTVF9SRVRVUk4gPT0gLTEpIHsKPj4gLcKgwqDC
oMKgwqDCoMKgIHRzdF9yZXNtKFRGQUlMIHwgVFRFUlJOTywgIm9wZW4gZmFpbGVkIik7Cj4+IC3C
oMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+IC3CoMKgwqAgfQo+PiAtCj4+IC3CoMKgwqAgc3ByaW50
ZihidWYsICIlbGQiLCBURVNUX1JFVFVSTik7Cj4+ICvCoMKgwqAgdHN0X3JlcyhUSU5GTywgIlRl
c3RpbmcgT19DTE9FWEVDIik7Cj4+IC3CoMKgwqAgcGlkID0gdHN0X2ZvcmsoKTsKPj4gLcKgwqDC
oCBpZiAocGlkIDwgMCkKPj4gLcKgwqDCoMKgwqDCoMKgIHRzdF9icmttKFRCUk9LIHwgVEVSUk5P
LCBjbGVhbnVwLCAiZm9yaygpIGZhaWxlZCIpOwo+PiArwqDCoMKgIGZkID0gVFNUX0VYUF9GRF9T
SUxFTlQob3BlbihURVNUX0ZJTEUsIE9fUkRXUiB8IE9fQVBQRU5EIHwgCj4+IE9fQ0xPRVhFQywK
Pj4gK8KgwqDCoMKgwqDCoMKgIDA2NDQpKTsKPiBKdXN0IGluIGNhc2Ugb2YgVFNUX0VYUF9GRF9T
SUxFTlQgdXNhZ2UgYXJvdW5kIHRoZSB0ZXN0cywgVFNUX1BBU1MgaXMgCj4gbm90IGNoZWNrZWQg
aGVyZS4KCkdvb2QgY2F0Y2gsIHdpbGwgZml4IGluIHYyLgoKPj4gK8KgwqDCoCBzcHJpbnRmKGJ1
ZiwgIiVkIiwgZmQpOwo+IHNucHJpbnRmKCkgcHJvYmFibHkgd291bGQgYmUgYSBiZXR0ZXIgY2hv
aWNlLCBldmVuIGlmIGJ1ZmZlciBpcyBiaWcgCj4gZW5vdWdoICg2NGJpdHMgd291bGQgYmUgY29u
dmVydGVkIGludG8gMjEgY2hhcnMsIHNvIDIwIGNoYXJzIGFyZSBlbm91Z2ggCj4gZm9yIDMyLWJp
dHMgaW50ZWdlcikKCkFsc28gZml4ZWQgaW4gdjIgYWxvbmcgd2l0aCB0aGUgc3dpdGNoIGFuZCBs
c2VlaygpIHN1Z2dlc3Rpb25zLgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1c2UuY3oK
U1cgUXVhbGl0eSBFbmdpbmVlcgpTVVNFIExJTlVYLCBzLnIuby4KQ09SU08gSUlhCktyaXppa292
YSAxNDgvMzQKMTg2IDAwIFByYWd1ZSA4CkN6ZWNoIFJlcHVibGljCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
