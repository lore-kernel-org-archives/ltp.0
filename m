Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04994CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 13:35:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8833D3E56D1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:35:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80A483E48BB
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:35:22 +0200 (CEST)
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com
 [IPv6:2607:f8b0:4864:20::e44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C0EA71400967
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:35:21 +0200 (CEST)
Received: by mail-vs1-xe44.google.com with SMTP id
 ada2fe7eead31-6cfc776e451so422583137.1
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780320920; x=1780925720; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0xXnO/zBSaCQ0EFfO3WqDn585p5lLTskT3VQluvpxM=;
 b=c0RIWLkaEYwVXza7VXS/6W1rn+yLpp8H3anMOjv4r8A/nMLsxH/cb74Q7cMeQVMZGm
 w34LyGjVEN2OsWeAKthDgl9SlrFdtPr5pxSH0ROiVAGLPw0kcV/7Awu9Hd6uYEL1VNsu
 OmQMr0T/kAVXeVji0TX2lmVKREAfTyu79yW0M93dLq7aUP8s1VFOut1xHjxkgzCva41V
 UGO5O1s5yvxS+aCxWCCYXGIyzNq86iGm31kFHV4wf8rJV5H/679tSA2jDRj7LjJ1lwjW
 4Y9Tu4d/vjYAkXOWsdVJMQ+j7s12W9+963W0F8TX6qRy6i4SZVI/7cbNJam6nz80vXfM
 PmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780320920; x=1780925720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0xXnO/zBSaCQ0EFfO3WqDn585p5lLTskT3VQluvpxM=;
 b=L2pGQGO2KQLPqkAGeSqNa7qVzmSttQ6v9zMkB5/EH7Kkoq5g0assR7fsXuyVFIY0rs
 bZvA1tfCag+6U/ztZvkmEvn+0S+HLAv05/WVCwOy/T+5MGSR5Rf2uZHByLvSKMtBfNYU
 ocB3Ytv7zN00uQjpMV7I4APq+VCt5We4r93Tq7QSPbBSYzEew0SAEqv95nfQjCHKdqok
 Om1U7KQQhwkkUzjQ3zhOid5xXmQ4MT2vkb0BRkwJk8qgh0VLciWSzynxYsaXXJk6E+RI
 6Y8IOYsSXa50QQEh9ckLfTs0GNVwQYpQmZdYFKBB9P9PcUjou9JTBD+fwDbaHG5fDj8C
 hu4A==
X-Gm-Message-State: AOJu0YwNflUYHYnqORCU/ILUGJbJft2XcCPssaU76+SgCRykhJgKpZH/
 l2wsyh4VrexuAMgY3vFEi8FEspCOaH5fnV4QsTuZZI2J9hHp8wDe49bxaD78etID
X-Gm-Gg: Acq92OHVYI+avfHLUajkI1ST2rnp9TlBF9A5GfOVnUb5+7zh1tNmfg4wi2vEmQtwq/g
 TOQhu8nO942cojo18YULDdm0OUwjH/Ul3wi9eRSfxy0YzOIvYezb++GUtI/kBo6deEebf3TIUg+
 b/fgj7ok+5Zc/wRFYn9Z/gt+BqaPkzQJpzjXmxJHxbl1JSl7Gq/Spp8TX+deOCl+0TvHNqNY35Z
 kojcWxFO0rZQMWGlnoLtW9hWdP0cw4xjUMA6W6RKue+A/kB0wsdbK7ZeX1jNVyT7vuNRiek67dK
 vgvxm/x11rLqaSRwbJ4CdwaQQ4JoF3V1w41W9QIHapBDZBtqpyHQpmszKgvp+WU7YIzruvEUzao
 UEn4vnqRlEkn1eH1GT6FZozuEcK2QicpJZLXkurvNX9VZ7JYPXshfSNzyBQxpOMqEZjtSkm9rnL
 y+O2hMhDAl6GQA8YYNjiV9Ulw16764ZhhWoFiAfknPhtuGQgrPpXxqcts/XPyc3TQZMi1+qgGH1
 ypNs/CDImMsQGx1hOiYOHq0cIqOI7KnUeJUcM2qymxSv4bI1g==
X-Received: by 2002:a05:6102:3f51:b0:639:4bb7:c915 with SMTP id
 ada2fe7eead31-6c6943bfb5fmr4309175137.16.1780320919791; 
 Mon, 01 Jun 2026 06:35:19 -0700 (PDT)
Received: from
 runnervm3jyl0.scdwe4r0avcedi5afgb1yvudeg.bx.internal.cloudapp.net
 ([20.106.191.51]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea1fbafbsm93319006d6.35.2026.06.01.06.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 06:35:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Darren Chang <chihsheng@google.com>
Date: Mon,  1 Jun 2026 13:35:18 +0000
Message-ID: <20260601133518.3966-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601101302.3858362-1-chihsheng@google.com>
References: <20260601101302.3858362-1-chihsheng@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/xattr: Add runtime probe for socket xattr
 backports
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgRGFycmVuLAoKVGhhbmsgeW91IGZvciB0aGlzIHBhdGNoLiBUaGUgYXBwcm9hY2ggaXMgc291
bmQ6IGEgcnVudGltZSBwcm9iZSBmb3IKYmFja3BvcnRlZCBzb2NrZXQgeGF0dHIgc3VwcG9ydCBp
cyB0aGUgcmlnaHQgd2F5IHRvIGF2b2lkIGZhbHNlCmZhaWx1cmVzIG9uIGRvd25zdHJlYW0ga2Vy
bmVscy4gSG93ZXZlciB0aGVyZSBhcmUgYSBmZXcgaXNzdWVzIGluCmZzZXR4YXR0cjAyLmMgdGhh
dCBuZWVkIGZpeGluZyBiZWZvcmUgdGhpcyBjYW4gYmUgYXBwbGllZC4KClZlcmRpY3Q6IE5lZWRz
IHJldmlzaW9uCgotLS0KClsxXSBmc2V0eGF0dHIwMi5jIOKAlCB2YXJpYWJsZSBkZWNsYXJlZCBh
ZnRlciBleGVjdXRhYmxlIHN0YXRlbWVudAoKVGhlIG5ldyBgaW50IHNvY2tldF9pZHggPSAtMTtg
IGRlY2xhcmF0aW9uIGFwcGVhcnMgYWZ0ZXIgdGhlCmV4ZWN1dGFibGUgc3RhdGVtZW50IGBzb2Nr
ZXRfeGF0dHJfc3VwcG9ydGVkID0gdHN0X2t2ZXJjbXAoNywgMSwgMCkKPj0gMDtgLiBUaGUgZXhp
c3Rpbmcgc2V0dXAoKSBkZWNsYXJlcyBhbGwgaXRzIGxvY2FsIHZhcmlhYmxlcyBhdCB0aGUKdG9w
IG9mIHRoZSBmdW5jdGlvbiAoYHNpemVfdCBpID0gMDtgIGV0Yy4pLiBUaGlzIG5ldyB2YXJpYWJs
ZSBtdXN0CmZvbGxvdyB0aGUgc2FtZSBjb252ZW50aW9uLgoKTW92ZSBgaW50IHNvY2tldF9pZHgg
PSAtMTtgIHRvIHRoZSB0b3Agb2Ygc2V0dXAoKSwgYWxvbmdzaWRlIHRoZQpleGlzdGluZyBkZWNs
YXJhdGlvbnM6CgogIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiAgewogIAlzaXplX3QgaSA9IDA7
CiAgCWludCBzb2NrZXRfaWR4ID0gLTE7ICAgICAgICAgLyogYWRkIGhlcmUgKi8KICAJc3RydWN0
IHNvY2thZGRyX3VuIHN1bjsKICAJLi4uCgpbMl0gZnNldHhhdHRyMDIuYyDigJQgaW5kZW50YXRp
b24gdXNlcyBzcGFjZXMgaW5zdGVhZCBvZiB0YWJzCgpUaGUgYGludCBzb2NrZXRfaWR4ID0gLTE7
YCBsaW5lIGluIHRoZSBwYXRjaCB1c2VzIDQgc3BhY2VzIGZvcgppbmRlbnRhdGlvbiBpbnN0ZWFk
IG9mIGEgdGFiIGNoYXJhY3RlcjoKCiAgLSAgICBpbnQgc29ja2V0X2lkeCA9IC0xOyAgICAgICAv
KiA0IHNwYWNlcyDigJQgd3JvbmcgKi8KICArCWludCBzb2NrZXRfaWR4ID0gLTE7ICAgICAgIC8q
IHRhYiDigJQgY29ycmVjdCAqLwoKVGhlIHJlc3Qgb2YgdGhlIGZ1bmN0aW9uIHVzZXMgdGFicyB0
aHJvdWdob3V0LgoKWzNdIGZzZXR4YXR0cjAyLmMg4oCUIGNvbW1lbnQgZG9lc24ndCByZWZlcmVu
Y2UgdGhlIHVwc3RyZWFtIGNvbW1pdAoKVGhlIGNvbW1lbnQgYWRkZWQgdG8gZnNldHhhdHRyMDIu
YyBpcyB2YWd1ZSBjb21wYXJlZCB0byB0aGUgb25lIGFkZGVkCnRvIHNldHhhdHRyMDIuYywgd2hp
Y2ggbmFtZXMgdGhlIHVwc3RyZWFtIGNvbW1pdCBhbmQgaXRzIHRpdGxlOgoKICBzZXR4YXR0cjAy
LmMgKG5ldyk6CiAgICAvKgogICAgICogQ29tbWl0IGRjMDg3NmI5ODQ2ZCAieGF0dHI6IHN1cHBv
cnQgZXh0ZW5kZWQgYXR0cmlidXRlcyBvbiBzb2NrZXRzIgogICAgICogbWVyZ2VkIGluIDcuMS4w
IG1haW5saW5lLCBidXQgbWlnaHQgYmUgYmFja3BvcnRlZC4KICAgICAqIFRyeSB0byBzZXQgeGF0
dHIgb24gc29ja2V0IHRvIGRldGVjdCBzdXBwb3J0LgogICAgICovCgogIGZzZXR4YXR0cjAyLmMg
KG5ldyk6CiAgICAvKgogICAgICogUHJvYmUgZm9yIGJhY2twb3J0cyBvbiBvbGRlciBrZXJuZWxz
LgogICAgICogSWYgdGhlIHZlcnNpb24gaXMgPCA3LjEuMCBidXQgZnNldHhhdHRyKCkgc3VjY2Vl
ZHMsIHdlIGFzc3VtZSB0aGUgcGF0Y2gKICAgICAqIGhhcyBiZWVuIGJhY2twb3J0ZWQuCiAgICAg
Ki8KClRoZXNlIGRlc2NyaWJlIHRoZSBzYW1lIGZlYXR1cmUuIFRoZSBmc2V0eGF0dHIwMiBjb21t
ZW50IHNob3VsZAppbmNsdWRlIHRoZSBjb21taXQgcmVmZXJlbmNlIGZvciBjb25zaXN0ZW5jeS4g
VXNlIHRoZSBzYW1lIHdvcmRpbmcgYXMKaW4gc2V0eGF0dHIwMi5jLgoKWzRdIGZzZXR4YXR0cjAy
LmMg4oCUIGlubGluZSBjb21tZW50IGlzIHVubmVjZXNzYXJ5CgogIC8qIENsZWFuIHVwIHRoZSBw
cm9iZWQgeGF0dHIgdG8gYXZvaWQgaW50ZXJmZXJpbmcgd2l0aCB0aGUgYWN0dWFsIHRlc3QgKi8K
ICBTQUZFX0ZSRU1PVkVYQVRUUih0Y1tzb2NrZXRfaWR4XS5mZCwgdGNbc29ja2V0X2lkeF0ua2V5
KTsKClRoZSBjb21tZW50IHN0YXRlcyB0aGUgb2J2aW91cy4gU0FGRV9GUkVNT1ZFWEFUVFIgYWZ0
ZXIgYSBzdWNjZXNzZnVsCnNldHhhdHRyLXByb2JlIHNwZWFrcyBmb3IgaXRzZWxmLiBEcm9wIGl0
LCBtYXRjaGluZyB0aGUgc3R5bGUgb2YgdGhlCmVxdWl2YWxlbnQgYmxvY2sgaW4gc2V0eGF0dHIw
Mi5jIHdoaWNoIGhhcyBubyBzdWNoIGNvbW1lbnQuCgotLS0KCkFzaWRlIGZyb20gdGhvc2UgZm91
ciBwb2ludHMgdGhlIGxvZ2ljIGlzIGNvcnJlY3QuIEluIHBhcnRpY3VsYXI6CgotIHNldHhhdHRy
MDIuYyBsb29rcyBjbGVhbjsgbm8gaXNzdWVzIHRoZXJlLgotIFRoZSBwcm9iZSBjb3JyZWN0bHkg
dXNlcyB0aGUgYWxyZWFkeS1vcGVuZWQgc29ja2V0IGZkIGluIGZzZXR4YXR0cjAyLAogIG1pcnJv
cmluZyB0aGUgcGF0aC1iYXNlZCBwcm9iZSBpbiBzZXR4YXR0cjAyLgotIFNpbGVudGx5IGlnbm9y
aW5nIG5vbi16ZXJvIHByb2JlIHJlc3VsdHMgaXMgY29ycmVjdDogRVBFUk0gbWVhbnMgbm8KICBi
YWNrcG9ydCwgYW5kIEVPUE5PVFNVUFAgaXMgY2F1Z2h0IGxhdGVyIGluIHZlcmlmeV9mc2V0eGF0
dHIoKS4KLSBgc29ja2V0X3hhdHRyX3N1cHBvcnRlZCA9IHRydWVgICh1c2luZyBib29sKSBpcyBj
b25zaXN0ZW50IHdpdGggdGhlCiAgZmllbGQgdHlwZSAoYHN0YXRpYyBib29sIHNvY2tldF94YXR0
cl9zdXBwb3J0ZWRgKS4KLSBUaGUgY29tbWl0IG1lc3NhZ2UgaXMgYWNjdXJhdGUgYW5kIHRoZSBT
aWduZWQtb2ZmLWJ5IGlzIHByZXNlbnQuCgotLS0KCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
