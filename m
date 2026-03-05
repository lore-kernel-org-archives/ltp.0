Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3DEF33A74
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772721418; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YmX30ll4RGBY3v5ZwvYNWCS9zTa94fRXTBHHFNkAdRg=;
 b=eh+RQo7AK2vleC38X1y4iq/Wal1KrzODplzsvQToxUvpzarhPx9/yrQm+K5DYAWNmfGnk
 1wtzvoBUooH67o9UpC5QhlZiUp20+YZplp200MDIZmMII4UEr1d4g+Kr/tTE/c+ygeFJy/X
 VmCoOnRtbuDxOgX5PAcgnQ0HkmeLlIM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C8673DA1A8
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 15:36:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B410F3C3095
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 15:36:34 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B9392003BE
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 15:36:33 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439ce3605ecso637005f8f.0
 for <ltp@lists.linux.it>; Thu, 05 Mar 2026 06:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772721393; x=1773326193; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=id43wahg8WK7oQ2oQLnoSFDIsyJ1RZJrlRiJhJprtI4=;
 b=INmuNLgjNxccKmnIOQxPLZwTPAZPZrhZe22i81rd42QJd89OHGe2shWvJ+AwMXzOMK
 YUu/DgqUKvJCsv2viMYuwWkCsygOMYNR3gpQnR2ikUE0wR7dHOYOLka+TJeV/kcxCDR3
 sSxcqFdZKnLPamrfy3xYey1CXBIqkX7gXx1wC54ndo71sMZGOnYDGaP6IxGdVkQgs7EW
 ajU2ZgRjXAmA/pCcwvf5EavpPRTw79m/fbK32UnF0Xx88s62uZfWOXtIVIUjmOmpjRHu
 uKo2wQ8O+1KOJ3+WDkgDyfHk6rSm/Q/xHL9XrEnoMg9ULMXwVITwswPLluFhJ/3C/I02
 s5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772721393; x=1773326193;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=id43wahg8WK7oQ2oQLnoSFDIsyJ1RZJrlRiJhJprtI4=;
 b=Lf7wqffVFG1jB2/0mQoc51EX5JEc5pYxgBjicOj1F+RIIKzU7RQm6ZuQ6CD6B4XDXx
 D9HLLpkpqRXAy3WJIudGRK9BgrXjM0FCxREZJp9XDTKyV6q5cvAxbTUMPp4/4C53arU4
 icq0atx8dRqLKfPg34+M0fy2jQLM+b1Z0wZJh+l9mbiW1vHEsrh7GsICh6FVQlHPYZav
 hfblT6lMVrAoLUAZCmc8A20yKJy0TQHhuCSLLC68a9Lcg4EhhxcBjEotMILC/2oG9E7D
 gfAhlD9uas3ZnRZhTjE0BFp3RxI8IYmXE2aWgUOOqMj/qEBUJ1WfN4uzpmEP1Nzp/XpR
 mttA==
X-Gm-Message-State: AOJu0Yxa9nUMgsYAToxhOOQl2+cPKw56/L73kdbzz5BU9LKxjzyYOwOh
 c62TH3H32YRY4MW1qzJdXlt23q87js8Y+xdQpHfBivSEGUKBtHev+YgulKaYOwHq1g==
X-Gm-Gg: ATEYQzx20RJfnpMCcyyR8XlH9h3L2NPcHwPn0JgEoWA6aMfrXJTFMKYKqRYxGrf/r29
 84SRtT6d44uJo/i1IVKu/40LwqfrsQgOuQNNnRoDEdUkWvm1IuXDtXBE6HC07X8anUkPF+CE9XD
 UTLmPRDmFhMDaqHe7OTBriKSD1BW07eqmGSUqKKMFC3KEAGaMYb07kiNsUIaOAMeWSBzgdCIUnB
 nsvjDeeRpDUaDbk9ZG5xw19BpI6rV5IpF4iFeE6PplKervN+qWvCXz1gdOKnxt5iikEcx6oxuti
 AaKjwFLxF8OsxoBZf4tc0J4/O1hScPSW/lm8qrkHPxc3EsX/VkB5c/aUHDgAc/CR132rSVKHZaJ
 NaB/CgKD4kG1XgS52lSrTe/YTNU3DU+W+mgukWIqHyCK3KmEl/qcunu1N97KpIqP58IrxOevmQt
 9KZnvIdE92EgZ9BPSU+Mt70wlJxd2Jm48lF1YWAS6J
X-Received: by 2002:a05:6000:2902:b0:439:c597:646 with SMTP id
 ffacd0b85a97d-439c7f8e114mr10900227f8f.11.1772721392762; 
 Thu, 05 Mar 2026 06:36:32 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b0549600sm36593853f8f.35.2026.03.05.06.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 06:36:32 -0800 (PST)
Date: Thu, 5 Mar 2026 14:36:31 +0000
To: Jan Kara <jack@suse.cz>
Message-ID: <aamU72Q2sW9wFyYY@autotest-wegao.qe.prg2.suse.org>
References: <20260304133810.24585-1-wegao@suse.com>
 <vkxlr754g4xhqhypya7ybullssszqvduqvvisy4e5dzmxwupqr@2qobtjcvvjuy>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <vkxlr754g4xhqhypya7ybullssszqvduqvvisy4e5dzmxwupqr@2qobtjcvvjuy>
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: kernel test robot <oliver.sang@intel.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXIgMDUsIDIwMjYgYXQgMTA6MzY6MDRBTSArMDEwMCwgSmFuIEthcmEgd3JvdGU6
Cj4gT24gV2VkIDA0LTAzLTI2IDEzOjM4OjA3LCBXZWkgR2FvIHdyb3RlOgo+ID4gU2luY2UgdGhl
IGludHJvZHVjdGlvbiBvZiB0aGUgYXN5bmNocm9ub3VzIGZzZXJyb3IgcmVwb3J0aW5nIGZyYW1l
d29yawo+ID4gKGtlcm5lbCBjb21taXQgODFkMmUxM2E1N2M5KSwgZmFub3RpZnkyMiBoYXMgZW5j
b3VudGVyZWQgc3BvcmFkaWMgZmFpbHVyZXMKPiA+IGR1ZSB0byB0aGUgbm9uLWRldGVybWluaXN0
aWMgbmF0dXJlIG9mIGV2ZW50IGRlbGl2ZXJ5IGFuZCBtZXJnaW5nOgo+ID4gCj4gPiAxKSB0Y2Fz
ZTMgZmFpbHVyZTogQSByYWNlIGNvbmRpdGlvbiBvY2N1cnMgd2hlbiB0aGUgdGVzdCByZWFkcyB0
aGUKPiA+ICAgIG5vdGlmaWNhdGlvbiBmZCBiZXR3ZWVuIHR3byBldmVudHMuIEFkZGluZyBhIHNo
b3J0IGRlbGF5Cj4gPiAgICAodXNsZWVwKSBlbnN1cmVzIGFsbCBldmVudHMgYXJlIGRpc3BhdGNo
ZWQgYW5kIHJlYWR5IGJlZm9yZSB0aGUKPiA+ICAgIHJlYWQoKSBjYWxsLgo+IAo+IE9LLCBidXQg
cGxlYXNlIGFkZCBhIGNvbW1lbnQgaW4gdGhlIGNvZGUgd2h5IHRoaXMgaXMgbmVlZGVkLgo+IAoK
VGhhbmtzIGZvciB5b3VyIHF1aWNrIGZlZWRiYWNrLCBpIHdpbGwgYWRkIGNvbW1lbnRzIGluIG5l
eHQgdmVyc2lvbi4KCj4gPiAyKSB0Y2FzZTQgZmFpbHVyZTogVGhlIGtlcm5lbCBtYXkgZGVsaXZl
ciBlcnJvcnMgYXMgaW5kZXBlbmRlbnQgZXZlbnRzCj4gPiAgICBpbnN0ZWFkIG9mIGEgc2luZ2xl
IG1lcmdlZCBldmVudCwgVGhlIHRlc3QgbG9naWMgaXMgdXBkYXRlZCB0bwo+ID4gICAgdmFsaWRh
dGUgdGhlIGV4cGVjdGVkIGVycm9yX2NvdW50IGJ5IGVpdGhlciBhIHNpbmdsZSBtZXJnZWQgZXZl
bnQKPiA+ICAgIG9yIHRoZSBhY2N1bXVsYXRpb24gb2YgbXVsdGlwbGUgaW5kZXBlbmRlbnQgZXZl
bnRzIGluIHRoZSBidWZmZXIuCj4gCj4gRGlkIHlvdSBpbnZlc3RpZ2F0ZSB3aHkgdGhlIGV2ZW50
cyBkaWRuJ3QgZ2V0IG1lcmdlZCBpbiB0aGUga2VybmVsPyBJZiB0aGV5Cj4gYXJlIGFnYWluc3Qg
dGhlIHNhbWUgZmlsZXN5c3RlbSB0aGV5IHNob3VsZCBnZXQgbWVyZ2VkIEFGQUlDUy4KPiAKPiAJ
CQkJCQkJCUhvbnphClNvcnJ5IGkgaGF2ZSBubyBpZGVhIHdoeSB0aGlzIGhhcHBlbiwgSSBqdXN0
IGFkZCBkZWJ1ZyBjb2RlIGludG8gTFRQIGNhc2UgYW5kIApmb3VuZCB0aGUgZXZlbnQgbm90IGxv
c3QgYnV0IGRlbGl2ZXIgaW5kZXBlbmRlbnQsIHRoaXMgbGVhZHMgbWUgdG8gYmVsaWV2ZSB0aGF0
CnRoZSBMVFAgc2hvdWxkIGhhbmRsZSBib3RoIHNjZW5hcmlvc+KAlG1lcmdlZCBhbmQgaW5kZXBl
bmRlbnQgZXZlbnRzLgpJIGFsc28gbm90IHN1cmUgbXkgcGF0Y2ggaXMgY29ycmVjdCBvciBub3Qs
IHRoYXQncyBhbHNvIHRoZSByZWFzb24gaQpDQyB0aGUgcGF0Y2ggdG8geW91IDopCgo+IAo+ID4g
Cj4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNv
bT4KPiA+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjYwMjA0MjEy
NC44N2JkMDBlMy1sa3BAaW50ZWwuY29tCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdh
b0BzdXNlLmNvbT4KPiA+IC0tLQo+ID4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFu
b3RpZnkyMi5jICAgICB8IDMyICsrKysrKysrKysrKysrKystLS0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMjggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMi5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMKPiA+IGluZGV4IDY1Nzg0
NzRhNy4uODJlZWQ3YmE5IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZmFub3RpZnkvZmFub3RpZnkyMi5jCj4gPiBAQCAtNTMsNiArNTMsOCBAQCBzdGF0aWMgc3Ry
dWN0IGZhbm90aWZ5X2ZpZF90IG51bGxfZmlkOwo+ID4gIHN0YXRpYyBzdHJ1Y3QgZmFub3RpZnlf
ZmlkX3QgYmFkX2ZpbGVfZmlkOwo+ID4gIHN0YXRpYyBzdHJ1Y3QgZmFub3RpZnlfZmlkX3QgYmFk
X2xpbmtfZmlkOwo+ID4gIAo+ID4gK3N0YXRpYyBpbnQgZXZlbnRfY291bnQ7Cj4gPiArCj4gPiAg
c3RhdGljIHZvaWQgdHJpZ2dlcl9mc19hYm9ydCh2b2lkKQo+ID4gIHsKPiA+ICAJU0FGRV9NT1VO
VCh0c3RfZGV2aWNlLT5kZXYsIE1PVU5UX1BBVEgsIHRzdF9kZXZpY2UtPmZzX3R5cGUsCj4gPiBA
QCAtODgsNyArOTAsNiBAQCBzdGF0aWMgdm9pZCB0cmlnZ2VyX2JhZF9saW5rX2xvb2t1cCh2b2lk
KQo+ID4gIAkJCXJldCwgQkFEX0xJTkssIGVycm5vLCBFVUNMRUFOKTsKPiA+ICB9Cj4gPiAgCj4g
PiAtCj4gPiAgc3RhdGljIHZvaWQgdGNhc2UzX3RyaWdnZXIodm9pZCkKPiA+ICB7Cj4gPiAgCXRy
aWdnZXJfYmFkX2xpbmtfbG9va3VwKCk7Cj4gPiBAQCAtMTc2LDkgKzE3NywxMCBAQCBzdGF0aWMg
aW50IGNoZWNrX2Vycm9yX2V2ZW50X2luZm9fZXJyb3Ioc3RydWN0IGZhbm90aWZ5X2V2ZW50X2lu
Zm9fZXJyb3IgKmluZm9fZQo+ID4gIHsKPiA+ICAJaW50IGZhaWwgPSAwOwo+ID4gIAo+ID4gLQlp
ZiAoaW5mb19lcnJvci0+ZXJyb3JfY291bnQgIT0gZXgtPmVycm9yX2NvdW50KSB7Cj4gPiAtCQl0
c3RfcmVzKFRGQUlMLCAiJXM6IFVuZXhwZWN0ZWQgZXJyb3JfY291bnQgKCVkIT0lZCkiLAo+ID4g
LQkJCWV4LT5uYW1lLCBpbmZvX2Vycm9yLT5lcnJvcl9jb3VudCwgZXgtPmVycm9yX2NvdW50KTsK
PiA+ICsJaWYgKGluZm9fZXJyb3ItPmVycm9yX2NvdW50ICE9IGV4LT5lcnJvcl9jb3VudCAmJiBl
dmVudF9jb3VudCAhPSBleC0+ZXJyb3JfY291bnQpIHsKPiA+ICsJCXRzdF9yZXMoVEZBSUwsICIl
czogVW5leHBlY3RlZCBlcnJvcl9jb3VudCAoJWQhPSVkICYmICVkIT0lZCkiLAo+ID4gKwkJCWV4
LT5uYW1lLCBpbmZvX2Vycm9yLT5lcnJvcl9jb3VudCwgZXgtPmVycm9yX2NvdW50LAo+ID4gKwkJ
CWV2ZW50X2NvdW50LCBleC0+ZXJyb3JfY291bnQpOwo+ID4gIAkJZmFpbCsrOwo+ID4gIAl9Cj4g
PiAgCj4gPiBAQCAtMjU1LDggKzI1NywzMCBAQCBzdGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVk
IGludCBpKQo+ID4gIAo+ID4gIAl0Y2FzZS0+dHJpZ2dlcl9lcnJvcigpOwo+ID4gIAo+ID4gKwl1
c2xlZXAoMTAwMDAwKTsKPiA+ICsKPiAKPiBPSywgYnV0IGNhbiB5b3UgcGxlYXNlIGFkZCBhIGNv
bW1lbnQgd2h5IHRoZSBzbGVlcCBpcyBoZXJlLgo+IApTdXJlIQo+ID4gIAlyZWFkX2xlbiA9IFNB
RkVfUkVBRCgwLCBmZF9ub3RpZnksIGV2ZW50X2J1ZiwgQlVGX1NJWkUpOwo+ID4gIAo+ID4gKwlz
dHJ1Y3QgZmFub3RpZnlfZXZlbnRfbWV0YWRhdGEgKm1ldGFkYXRhOwo+ID4gKwlzaXplX3QgbGVu
ID0gcmVhZF9sZW47Cj4gPiArCj4gPiArCWV2ZW50X2NvdW50ID0gMDsKPiA+ICsKPiA+ICsJZm9y
IChtZXRhZGF0YSA9IChzdHJ1Y3QgZmFub3RpZnlfZXZlbnRfbWV0YWRhdGEgKilldmVudF9idWY7
Cj4gPiArCQkJRkFOX0VWRU5UX09LKG1ldGFkYXRhLCBsZW4pOwo+ID4gKwkJCW1ldGFkYXRhID0g
RkFOX0VWRU5UX05FWFQobWV0YWRhdGEsIGxlbikpIHsKPiA+ICsJCWV2ZW50X2NvdW50Kys7Cj4g
PiArCQlzdHJ1Y3QgZmFub3RpZnlfZXZlbnRfaW5mb19lcnJvciAqaW5mb19lcnJvciA9IGdldF9l
dmVudF9pbmZvX2Vycm9yKG1ldGFkYXRhKTsKPiA+ICsKPiA+ICsJCWlmIChpbmZvX2Vycm9yKSB7
Cj4gPiArCQkJdHN0X3JlcyhUSU5GTywgIkV2ZW50IFslZF06IGVycm5vPSVkIChleHBlY3RlZCAl
ZCksIGVycm9yX2NvdW50PSVkIChleHBlY3RlZCB0b3RhbCAlZCkiLAo+ID4gKwkJCQkJZXZlbnRf
Y291bnQsIGluZm9fZXJyb3ItPmVycm9yLCB0Y2FzZS0+ZXJyb3IsCj4gPiArCQkJCQlpbmZvX2Vy
cm9yLT5lcnJvcl9jb3VudCwgdGNhc2UtPmVycm9yX2NvdW50KTsKPiA+ICsJCX0gZWxzZSB7Cj4g
PiArCQkJdHN0X3JlcyhUSU5GTywgIkV2ZW50IFslZF06IE5vIGVycm9yIGluZm8gcmVjb3JkIGZv
dW5kIiwgZXZlbnRfY291bnQpOwo+ID4gKwkJfQo+ID4gKwl9Cj4gPiArCj4gCj4gVGhpcyBsb29r
cyB0b28gbGF4IHRvIG1lLiBJIHRoaW5rCj4gCkkgZ3Vlc3MgeW91ciBtZWFuIHRoaXMgaXMgd29y
a2Fyb3VuZCBmb3IgdGhlIGlzc3VlPyBBcmUgeW91IHN1Z2dlc3RpbmcgdGhhdCBJIHNob3VsZCBy
ZWNvbnN0cnVjdCB0aGUgdGVzdCBjYXNlIAp0byBwcm9wZXJseSBoYW5kbGUgaW5kZXBlbmRlbnQg
ZXZlbnRzIHJhdGhlciB0aGFuIHJlbHlpbmcgb24gdGhlIGV4aXN0aW5nIGxvZ2ljPyAKSWYgc28s
IEnigJlkIGJlIGhhcHB5IHRvIGV4cGxvcmUgdGhhdCBhbmQgaW1wbGVtZW50IGEgbW9yZSByb2J1
c3Qgc29sdXRpb24uCgo+IC0tIAo+IEphbiBLYXJhIDxqYWNrQHN1c2UuY29tPgo+IFNVU0UgTGFi
cywgQ1IKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
