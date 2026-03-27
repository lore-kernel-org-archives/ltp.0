Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6807210ED64A
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 11:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774611181; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=MAb6r9DL4oUAm8sC+8h2RjDRNFK5JB3FeJA/dj2ZUks=;
 b=KA9RHASyiLf0UropNFtY3Q+P2tWhOWVIGTHfXSDe4+6+9piJpHuQNrAvloePrrbFQfWKf
 LcQWr4FEqSWracRsajqnS5j+wHM2W0607WXJG/IjwttrvRZEM/BZhEldX69rtXhSMVFABYK
 EWZYL9sG/jVgLbSFOcnfSxteKHDc6sI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2CE83CFBB1
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 12:33:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EF9D3C3212
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 12:32:37 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 859AA140165D
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 12:32:36 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso19025605e9.0
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774611156; x=1775215956; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QRbaMCZw6/n2TYduvObGKCgIffvrMyvxGW3Ti4/DXzg=;
 b=D4fWu2wvRPAnVh0RxLh/ve6mOQ6cURUKv9gaWM3pXuCFu3H4Eq5ldfY+Ha72iRHxIq
 bE6Du762ib24MsK1DlGLvdMXMoMHRa5zLDyLq6ncnigtCBX6fA/yxZJr+H0zOYhmN34T
 9hL2BU4Bpl5sqaH9Ik6ffFUGo8PRXqzD8J2lALWX4r3N+iKdbUm+RYnQ0lP5vzBOgtqc
 CB4zUQdxbnfRKVJJy/YFSZXuhT0HiTqsWN1z9PuXMhTfTddxl9iYaJ9Vc/K4GFVzVeUC
 0obwAdL/sOWqTum01cubahUA0F1BZDF/pUtp0UeMD+BwqIAkFPri1lAvrP4qo4KSWVk6
 vDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774611156; x=1775215956;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRbaMCZw6/n2TYduvObGKCgIffvrMyvxGW3Ti4/DXzg=;
 b=NBOXcKj5gjYpTOF5BH4kl1jfcZGCeUEiOSg2Xfgs3t6NEl232ns45clG6ZI/5lkWiz
 Wt0GmcUoWiGz6OkgO1BlyN5Iy+/GVuQ8ralUzaIEW6/p/oxETNlk8/0SVIZvI6iA8bu9
 8+t1x83nJ4qkkgFUZlTtoYaRs3pVsqKuQgDWWC4Yp5thaszEfJ2I/Nl09dsTpz28rvre
 Kth2xOARaBajuWSd1P8AiKmswSrpJ5MXjHf59UDFnWwuyoJbqDzGfH6TYvVCzj3VGVSV
 bsdaJ/yO/Es6/iAtkawotAqgKwo21xscipB2X4rl5Z3mCUTwJ2QHK86QkMsXo8A416Nk
 xSmg==
X-Gm-Message-State: AOJu0Yw8B6a5/N4If1jlvWAr8ivPBcLekCHbvfRIskiGkAoXeGB5p1nY
 Z/WCE2wtUiFuxMH/gJ+yDEo+FDOdDOFr9Apx5jrXH5xoeiftD62SpLxe/+IZMAhu1uYoifOzbjx
 WQVAbymhWBg==
X-Gm-Gg: ATEYQzzx5EXjMFr2YPl1JpLNycJFYwZBqM8yIYNWBP3LysTxbuDFj7mV1RMfAkMxX9O
 DdM0SgkmclYoNxrD7fbuoz50lwPX3QvxBWce81U9Ih8KYUnX9+F61+SHAVkR8RVVAM/qBZ0C5I+
 8m50LwtEbdaSwLpPf4/ZANhhG0hU1jwO/QW2eF9U56wf/2BGsNmpfjka5082+tkTtTb4SB9qk7D
 MbXVtLACipJ8g9At9czddEfajtMytUfQ2E8/zSNyLwSwD/v+/byya5Di+HsFltc++p0BBZuYz/L
 n3Bh9v0jMaz1eqTL8fC1R+msTPmXy+7OgNnvm9KJJxaFBsqJJ3oPJDKLAGGaY44kiXnezubK736
 M20dxTxqrbNPmgVPEdypHEO5AjrVBM5CcMNAtECZf7W5xsqTXIojMHTILSfZcrYMJYAYhnLZyYz
 l96Wbket768vPplnaFyOZuRxm1CrcHD9B30Zt23XhPWtWQn98IOZvex1syKgSc/kqDKWBmikJBI
 GA3Bw0LvlgGS4rxSHTDQBqGSdCZJKaeM5A3IdyAjvsvoLBT7D5JwxoqtlsP2LA9ih22lXJE8Fel
 FQ==
X-Received: by 2002:a05:600c:c089:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-48729109d76mr22357335e9.9.1774611155720; 
 Fri, 27 Mar 2026 04:32:35 -0700 (PDT)
Received: from p200300ef2f4fc90094f4c5ce75c4603f.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df7e7sm13941280f8f.26.2026.03.27.04.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:32:35 -0700 (PDT)
Message-ID: <69c66ad3.5d0a0220.2aca14.6aee@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260311082011.229856-1-pavrampu@linux.ibm.com>
Date: Fri, 27 Mar 2026 11:32:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH]  [PATCH] Add hugemmap37,
 migrated task-size-overrun.c from libhugetlbfs v3
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGF2aXRocmEsCgpUaGUgY29tbWl0IG1lc3NhZ2UgYm9keSBkZXNjcmliZXMgIkNoYW5nZXMg
aW4gdjMiIGJ1dCBkb2Vzbid0IGV4cGxhaW4Kd2h5IHRoaXMgdGVzdCBpcyBiZWluZyBtaWdyYXRl
ZC4gVGhlIHYzIGNoYW5nZWxvZyBiZWxvbmdzIGJlbG93IHRoZSAtLS0KbGluZTsgdGhlIGJvZHkg
c2hvdWxkIGRlc2NyaWJlIHdoYXQgdGhlIHRlc3QgZG9lcyBhbmQgd2h5IGl0J3MgdXNlZnVsLgoK
PiArLyoKPiArICogQ29weXJpZ2h0IChDKSAyMDA1LTIwMDYgRGF2aWQgR2lic29uICYgQWRhbSBM
aXRrZSwgSUJNIENvcnBvcmF0aW9uLgo+ICsgKi8KClRoaXMgaXMgYSBuZXcgZmlsZSwgc28gaXQg
bmVlZHMgYSBjb3B5cmlnaHQgbGluZSB3aXRoIHRoZSBjdXJyZW50IHllYXIKYW5kIHlvdXIgbmFt
ZSwgZS5nLjoKQ29weXJpZ2h0IChjKSAyMDI2IFBhdml0aHJhIDxwYXZyYW1wdUBsaW51eC5pYm0u
Y29tPgoKPiArLypcCj4gKyAqW0Rlc2NyaXBpdG9uXQoKVHlwbyAoIkRlc2NyaXBpdG9uIiksIGFu
ZCBbRGVzY3JpcHRpb25dIGlzIGRlcHJlY2F0ZWQg4oCUIHJlbW92ZSB0aGUgdGFnCmVudGlyZWx5
LiBUaGUgZG9jIHRleHQgYWxvbmUgaXMgc3VmZmljaWVudC4KCj4gKyNkZWZpbmUgTUFQU19CVUZf
U1ogNDA5Ngo+ICsjZGVmaW5lIF9MQVJHRUZJTEU2NF9TT1VSQ0UKCl9MQVJHRUZJTEU2NF9TT1VS
Q0UgbXVzdCBiZSBkZWZpbmVkIGJlZm9yZSBhbnkgaW5jbHVkZXMgdG8gdGFrZSBlZmZlY3QuCkl0
IGFsc28gYXBwZWFycyB1bnVzZWQgaGVyZSDigJQgZHJvcCBpdC4KCj4gK3N0YXRpYyBpbnQgZmQ7
CgpNdXN0IGJlIGluaXRpYWxpemVkIHRvIC0xLiBaZXJvIGlzIGEgdmFsaWQgZmQgKHN0ZGluKS4K
Cj4gKwl0c3RfcmVzKFRJTkZPLCAiTGFzdCBtYXA6IGF0IDB4JWx4LTB4JWx4XG4iLCBzdGFydCwg
ZW5kKTsKClsuLi5dCgo+ICsJdHN0X3JlcyhUSU5GTywgIkJpbmFyeSBzZWFyY2hpbmcgZm9yIHRh
c2sgc2l6ZSBQRk5zIDB4JWx4Li4weCVseFxuIiwgbG93LCBoaWdoKTsKClsuLi5dCgo+ICsJCXRz
dF9yZXMoVElORk8sICJNYXAgc3VjY2VlZGVkIGF0IDB4JWx4XG4iLCBhZGRyKTsKClsuLi5dCgo+
ICsJdHN0X3JlcyhUSU5GTywgIlRBU0tfU0laRSA9IDB4JWx4XG4iLCB0YXNrX3NpemUpOwoKRHJv
cCB0aGUgdHJhaWxpbmcgXG4gaW4gYWxsIHRzdF9yZXMoKSBjYWxscyDigJQgdGhlIGZyYW1ld29y
ayBhZGRzCm5ld2xpbmVzIGF1dG9tYXRpY2FsbHkuCgo+ICsJcCA9IG1tYXAoKHZvaWQgKilzdHJh
ZGRsZV9hZGRyLCAyKmhwYWdlX3NpemUsIFBST1RfUkVBRHxQUk9UX1dSSVRFLAo+ICsJCU1BUF9T
SEFSRUQsIGZkLCAwKTsKPiArCWlmIChwID09ICh2b2lkICopc3RyYWRkbGVfYWRkcikKPiArCQl0
c3RfcmVzKFRGQUlMLCAiQXBwYXJlbnRseSBzdWNlZWRlZCBpbiBtYXBwaW5nIGFjcm9zcyBUQVNL
X1NJWkUgYm91bmRhcnkiKTsKCklmIG1tYXAgc3VjY2VlZHMgYXQgYSBkaWZmZXJlbnQgYWRkcmVz
cywgdGhlIG1hcHBpbmcgaXMgbmV2ZXIgdW5tYXBwZWQKKHJlc291cmNlIGxlYWspLiBBbHNvIG5l
ZWQgdG8gbXVubWFwIHdoZW4gaXQgZG9lcyBsYW5kIGF0IHN0cmFkZGxlX2FkZHIKYWZ0ZXIgcmVw
b3J0aW5nIFRGQUlMLiBUeXBvOiAic3VjZWVkZWQiIC0+ICJzdWNjZWVkZWQiLgoKPiArCXAgPSBt
bWFwKCh2b2lkICopc3RyYWRkbGVfYWRkciwgMipocGFnZV9zaXplLCBQUk9UX1JFQUR8UFJPVF9X
UklURSwKPiArCQlNQVBfU0hBUkVEfE1BUF9GSVhFRCwgZmQsIDApOwo+ICsJaWYgKHAgIT0gTUFQ
X0ZBSUxFRCkKPiArCQl0c3RfcmVzKFRGQUlMLCAiQXBwYXJlbnRseSBzdWNlZWRlZCBpbiBtYXBw
aW5nIGFjcm9zcyBUQVNLX1NJWkUgYm91bmRhcnkiKTsKClNhbWUgaGVyZSDigJQgbXVubWFwIHRo
ZSBtYXBwaW5nIGFmdGVyIFRGQUlMLiBTYW1lIHR5cG8uCgo+ICsJdHN0X3JlcyhUUEFTUywgIlRl
c3QgcGFzc2VkISIpOwoKVGhpcyBmaXJlcyB1bmNvbmRpdGlvbmFsbHksIGV2ZW4gYWZ0ZXIgVEZB
SUwgd2FzIHJlcG9ydGVkIGFib3ZlLiBFYWNoCnN1Yi1jYXNlIChub24tTUFQX0ZJWEVEIGFuZCBN
QVBfRklYRUQpIHNob3VsZCBoYXZlIGl0cyBvd24gVFBBU1MvVEZBSUwKcGFpciwgc28gdGhlIHJl
c3VsdCBpcyBwZXItY2FzZSByYXRoZXIgdGhhbiBhIGJsYW5rZXQgcGFzcy4KCj4gK3N0YXRpYyB2
b2lkIGNsZWFudXAodm9pZCkKPiArewo+ICsJaWYgKGZkID4gMCkKPiArCQlTQUZFX0NMT1NFKGZk
KTsKPiArfQoKVXNlICJmZCAhPSAtMSIsIG5vdCAiZmQgPiAwIi4gVGhlID4gMCBjaGVjayBzaWxl
bnRseSBza2lwcyBmZCAwLgoKUmVnYXJkcywKLS0KQW5kcmVhIENlcnZlc2F0bwpTVVNFIFFFIEF1
dG9tYXRpb24gRW5naW5lZXIgTGludXgKYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
