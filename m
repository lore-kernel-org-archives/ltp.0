Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF53CCFA1A
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762857700; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tpCDFosFHxQ81pTI+63S5TFqpjzSRF7zVTTraJcazBk=;
 b=FRLy+9qRMQZyjj3GoauepiOBipkH5lJu1ZJd5EO04nsj6Z1b6irKOF/e1h5ySfIGWyXRI
 vyhYk7E1041KuMK+dxHdzEo0VmSiT+bMA0j9rSop//excTrj6O7I/oiJ2aqOFXttOIef6Pw
 DE9Hxs3mbd62PpJzHvKLcqZKIk1UwTw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0156E3CF656
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 11:41:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D5AB3CF2D8
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 11:41:19 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C3075200757
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 11:41:18 +0100 (CET)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b72dad1b713so500254966b.2
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 02:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762857678; x=1763462478; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QnOQfys73b6NbFJWGt9JdzN2eMc+Cz3o+C4fabgRW+Y=;
 b=bI19TzMK92xmyAId5dm823IS2h0Prr/0eLy20ebBLYhgaP7mmegcWKT+RJhbnzpO/n
 cznm3VIKwVeC4DGWZcB0tiO+WasT+9EnmFo383X9rlRNjonWYsMExe1tlcDGJOsO/HXT
 OJxSq/gReyjmfUgHDjJNQvL9aR/6cG9Y8w3yBDrQ3qEDIQbnF44BPVD0hCxKlUPBNuho
 steZDVLHEX37nU+jCaRKK3poQjH8vdYo9D3AG3aRP/U3m/6VJgSz3y3+bkSXLWBGx8FI
 kYv5z/iF+WPCn4jCoQOwfMzOGfy/Vx7CsVf3pc2gebvHVeUro+ZQBCAkYOLL821yGQ+a
 7zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762857678; x=1763462478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnOQfys73b6NbFJWGt9JdzN2eMc+Cz3o+C4fabgRW+Y=;
 b=BbrUrCPg7wPut3QTU3FguOCLV9UXg1a71vNRrKyXFtf4VdVddDmIuTEJA/77/dohdP
 OCLKHYqb4hNJpsS+p44L1qs23+On9tDDPpFVgrnTLa0tfU1gaOo04lVkf9xJM+38H/B8
 jUE7Wgt/j0RFgsPjc6zeCm5V6o6c2LqHPZd5Gnzb+XJQOoRjqBBaw9++RL45U9TCM69e
 OsJxzmg1CONb0OzDI7ECpUEYqeo6Dx82GZbDG2mgvE03AKTO3DiV080Sd96HsrBMW569
 BRy6WcV9le4wQSN+gxDy880365XRTCxHiDzslc2XzvFYOh2KHUTcwZiqmeZU48snxlBj
 mQvw==
X-Gm-Message-State: AOJu0YzQUPwRe4LpUokjzccDrwq0PcaoHJz1qOnOBIs+LQTfzjDV2M06
 //X1lkzsZIeX55d0edGM3BORoqfFC1TsG243uFHZvZ44/bVUPOL97chK+or6nQQrmGiKTS2W3CJ
 yueeg4Kuf61og81DSTgLsoYik//ZwmocHLjIKz+GmDfig9bT+adqfCg==
X-Gm-Gg: ASbGncsd7Cx/oZnI8aPp7rf+Ju8GTIAVeY8ONAdtlrROhJqZauIuE8dJcjLbj9XjFGp
 mGDVFAsDJgL48zsZMUuLY2DmYAEGaYNR/YW941g84SekVm9B7uujUmEtL/HKM72BK3fZO1jPPlL
 1xDBjKWVb/EWVhWQZGA5EenmSK9PfkOlCcO7gbeXkE2wVMdNnZIpMvkuDiEq9UvwNysMHe8pnPj
 PTYvBzLaJaQZOnttgpqMSG/vlF2QQWEUZGP94O1tlwwR5OQeVqDG9dtrijES9OgV5EWuQE=
X-Google-Smtp-Source: AGHT+IGV1DaXcpmXrSdJhrkPQJ8k4YFkjm8n3VdWgQw+Fp3pNs0JKJqRp/mk6XUq/Ugl8zCr0S0E0ZT6soDn837tNAA=
X-Received: by 2002:a17:907:3f9b:b0:b72:a5bd:c585 with SMTP id
 a640c23a62f3a-b72e05e5a10mr1084899766b.46.1762857677882; Tue, 11 Nov 2025
 02:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-4-wegao@suse.com>
In-Reply-To: <20251110024805.31070-4-wegao@suse.com>
Date: Tue, 11 Nov 2025 18:41:03 +0800
X-Gm-Features: AWmQ_bm9CROfzI_asaO9fMN1RTmov9qW-5H1V_RAMpA3BIg-I-bwJ55ENkge7oQ
Message-ID: <CAJs-1pVyryF18L1QLjGGJSf2ERm04pppvS2Jcd3UakBRtiFH8g@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 3/3] shell_loader_cmd.sh: New test case check
 needs_cmds
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U29ycnksIEl0IHNlZW1zIHNvbWUgc3RyYW5nZSBDSSBmYWlsdXJlIHRyaWdnZXJlZCBieSAiY21k
IjogIm1rZnMuZXh0NCA+PQoxLjAuMCIsIGkgbmVlZCBmdXJ0aGVyIGNoZWNrIGFuZCB3aWxsIHVw
ZGF0ZSBpdC4KCk9uIE1vbiwgTm92IDEwLCAyMDI1IGF0IDEwOjQ44oCvQU0gV2VpIEdhbyA8d2Vn
YW9Ac3VzZS5jb20+IHdyb3RlOgoKPiBTdWdnZXN0ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6Pgo+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+IC0tLQo+
ICB0ZXN0Y2FzZXMvbGliL3J1bl90ZXN0cy5zaCAgICAgICAgICAgICAgfCAgMSArCj4gIHRlc3Rj
YXNlcy9saWIvdGVzdHMvc2hlbGxfbG9hZGVyX2NtZC5zaCB8IDI4ICsrKysrKysrKysrKysrKysr
KysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBt
b2RlIDEwMDc1NSB0ZXN0Y2FzZXMvbGliL3Rlc3RzL3NoZWxsX2xvYWRlcl9jbWQuc2gKPgo+IGRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMvbGliL3J1bl90ZXN0cy5zaCBiL3Rlc3RjYXNlcy9saWIvcnVu
X3Rlc3RzLnNoCj4gaW5kZXggNWMzMDliYmViLi4yNGFjODFhNDQgMTAwNzU1Cj4gLS0tIGEvdGVz
dGNhc2VzL2xpYi9ydW5fdGVzdHMuc2gKPiArKysgYi90ZXN0Y2FzZXMvbGliL3J1bl90ZXN0cy5z
aAo+IEBAIC02LDYgKzYsNyBAQCBzaGVsbF9sb2FkZXIuc2gKPiAgc2hlbGxfbG9hZGVyX2FsbF9m
aWxlc3lzdGVtcy5zaAo+ICBzaGVsbF9sb2FkZXJfY19jaGlsZC5zaAo+ICBzaGVsbF9sb2FkZXJf
ZmlsZXN5c3RlbXMuc2gKPiArc2hlbGxfbG9hZGVyX2NtZC5zaAo+ICBzaGVsbF9sb2FkZXJfa2Nv
bmZpZ3Muc2gKPiAgc2hlbGxfbG9hZGVyX3N1cHBvcnRlZF9hcmNocy5zaAo+ICBzaGVsbF9sb2Fk
ZXJfdGNudC5zaAo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvbGliL3Rlc3RzL3NoZWxsX2xvYWRl
cl9jbWQuc2gKPiBiL3Rlc3RjYXNlcy9saWIvdGVzdHMvc2hlbGxfbG9hZGVyX2NtZC5zaAo+IG5l
dyBmaWxlIG1vZGUgMTAwNzU1Cj4gaW5kZXggMDAwMDAwMDAwLi40ZThlNjFlYjYKPiAtLS0gL2Rl
di9udWxsCj4gKysrIGIvdGVzdGNhc2VzL2xpYi90ZXN0cy9zaGVsbF9sb2FkZXJfY21kLnNoCj4g
QEAgLTAsMCArMSwyOCBAQAo+ICsjIS9iaW4vc2gKPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vci1sYXRlcgo+ICsjIENvcHlyaWdodCAoYykgMjAyNSBXZWkgR2FvIDx3ZWdh
b0BzdXNlLmN6Pgo+ICsjCj4gKyMgLS0tCj4gKyMgZW52Cj4gKyMgewo+ICsjICAibmVlZHNfY21k
cyI6IFsKPiArIyAgIHsKPiArIyAgICAiY21kIjogImxzIiwKPiArIyAgICAib3B0aW9uYWwiOiAx
Cj4gKyMgICB9LAo+ICsjICAgewo+ICsjICAgICJjbWQiOiAibWtmcy5leHQ0ID49IDEuMC4wIiwK
PiArIyAgICAib3B0aW9uYWwiOiAxCj4gKyMgICB9Cj4gKyMgIF0KPiArIyB9Cj4gKyMgLS0tCj4g
Kwo+ICsuIHRzdF9sb2FkZXIuc2gKPiArCj4gK3RzdF90ZXN0KCkKPiArewo+ICsgICAgICAgdHN0
X3JlcyBUUEFTUyAiV2UgYXJlIHJ1bm5pbmcgd2l0aCBuZWVkc19jbWRzIgo+ICt9Cj4gKwo+ICsu
IHRzdF9ydW4uc2gKPiAtLQo+IDIuNTEuMAo+Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
