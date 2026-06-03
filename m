Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E8DCD6E64
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 09:36:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A605E3E2C5E
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:36:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA6AE3E1D46
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:35:54 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78A311400455
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:35:54 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-306f36df4feso360939eec.0
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780479353; x=1781084153; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWJwWNvmAOdBqHqx+x/ZuM/FuGhEezlCVoagO4Djeeo=;
 b=qKOWQsrV/kzAjA8wVQqw/rDSCmNHD+KlKNIWEnUA8o6jKgP9jRZCxlJvU2/YvYPSvY
 +ezm990MoxU238SHlK84q+50qZSbvBNCiLmp2MJ/s9kH9O1pG/xF2RE59H4/6ZBOVtaj
 AoJGBjSP/YW/OlU1SlAqPs4oLZ2P+p1CWydTQ4BkaZhKeH3deghpNc/OAJ2SFeCkIfwQ
 LT0Y1AViFOsAhyxJoepiPBJDhy/PRLTYrReqTPGsGTDE87/VF4R9lyHiCneTkjfDBf95
 Z1ad7MVpgxe/Dof3jyDSYqhlJoIYX20ntD2EdK1qIVCgK7zt0kili3LEzrSMFXCNRdTX
 kjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780479353; x=1781084153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qWJwWNvmAOdBqHqx+x/ZuM/FuGhEezlCVoagO4Djeeo=;
 b=pp3yTYRT6QMYRJDpB3/fI4cw/tx6+fGSjBnMT++8KgJbbm6AZXRIwklbSEDhxX7PBF
 4Gu58EWQBaWqSEf848JhBG63LawIX3QwprS8/HIZxGmuHyD9QPhLfGYM9SiPAAPqESea
 qX7CiBPhzH/MRwOKEvxRJakWSStiBMxND+76DmjioK409lgSX6uu0H/sd+KRGdycMeYq
 MzZ/U19jLN1qXLVX0IF2IAe/GKefKCJf9u+c271dclZ/jhp/mbc+eRNVaRgxGhhYymle
 LxwGiewgQ3p8HYG6niX3PP9mgKhTzluKDnKovvx0o5JaHeej4gNzqnkG7uO1LhyPkty9
 X05Q==
X-Gm-Message-State: AOJu0YyQxXql+r0+FU/LXWTP908jk8kdaeZtH6MRsZ9ynCMcdkaQSz5c
 mpMeXXSkUi0jfuiMZPjYDdnjnK0YRzZUoQTsBD6MHAfFVqVFPi5RmfpM
X-Gm-Gg: Acq92OHxQ4T8oLxelroN030nXP1lt/lpTrBJIuO1xy2oY0kDjbj0s2C6sRzwlMg/Wbt
 ha2ADsOE+Wha6PHMp1lYtblyUq+MxjTTFa2vC77V/ININhxkhdZfUI9Qe3tQsJ1kvW0DEVPW8Vi
 ZQiZxXkpDw4e8Lajc+cgccTnGoR74ItqeN2gHhuy5Mr5NDD5ccFLEIYDenU65WFe3cfBzrWHHMo
 x076TM6X6gg5AGLXCQMxHKfU13O7v4FsHMC7Ff4WY+MsBRUhuZkfTUYg5HZjXY9Wz5hnP3UXE2w
 6p1I79/n7ZMHfnZkkbOXHEWEyr7XgjbEGAjm4cWERl2L/q6XoDyVy/g6RhlY0hM2yVOolS0s5nI
 WxQjfc3ebCngWKRNxiJS+f+zXwWxA9+XU/0uEY+bZ6lMAV4AOyrZfxxY3aperXM73AYyyZgJGnm
 v03q2Uu/K9mPYPTxRG0XOVvU/fh565xyLn2Qhc2C/adCmaWnbDIdeme1t2UVDkh3UjjfKyvMVet
 qOKT+L6+u/vNstLtGZP0nTtnIsudzntgkHWZaZVNFd1hkw2dLmPydBplfmF
X-Received: by 2002:a05:7300:3252:b0:304:ad0:e91 with SMTP id
 5a478bee46e88-3074fa59f5amr1351670eec.4.1780479352516; 
 Wed, 03 Jun 2026 02:35:52 -0700 (PDT)
Received: from
 runnervm3jyl0.uk0y3m2hcqoulhnsten1kxzdpf.dx.internal.cloudapp.net
 ([52.159.243.18]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df191d0sm2884826eec.21.2026.06.03.02.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 02:35:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Darren Chang <chihsheng@google.com>
Date: Wed,  3 Jun 2026 09:35:50 +0000
Message-ID: <20260603093550.4066-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603051401.658906-1-chihsheng@google.com>
References: <20260603051401.658906-1-chihsheng@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/listmount04: Detect backported commit
 78f0e33cd6c9 dynamically
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

SGkgRGFycmVuLAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guIFRoZSBvdmVyYWxsIGFwcHJvYWNo
IOKAlCBwcm9iaW5nIHRoZSBrZXJuZWwgYXQgcnVudGltZQppbnN0ZWFkIG9mIHJlbHlpbmcgc29s
ZWx5IG9uIHRzdF9rdmVyY21wKCkg4oCUIGlzIHRoZSByaWdodCBmaXggZm9yIGJhY2twb3J0CnNj
ZW5hcmlvcy4gVHdvIGlzc3VlcyBuZWVkIHRvIGJlIGFkZHJlc3NlZCBiZWZvcmUgdGhpcyBjYW4g
YmUgYWNjZXB0ZWQuCgotLS0KCltQQVRDSF0gc3lzY2FsbHMvbGlzdG1vdW50MDQ6IERldGVjdCBi
YWNrcG9ydGVkIGNvbW1pdCA3OGYwZTMzY2Q2YzkgZHluYW1pY2FsbHkKCj4gKwkvKiAyLiBSdW50
aW1lIHByb2JlIGZvciBvbGRlciBrZXJuZWxzOgo+ICsJICogQ2hlY2sgaWYgY29tbWl0IDc4ZjBl
MzNjZDZjOSB3YXMgYmFja3BvcnRlZCBieSBtYW51YWxseSBpc3N1aW5nCj4gKwkgKiBhIHN5c2Nh
bGwgd2l0aCBhbiBpbnZhbGlkIG1udF9uc19mZCAoLTEpLgo+ICsJICovCj4gKwltbnRfaWRfcmVx
IHByb2JlX3JlcSA9IHsKPiArCQkuc2l6ZSA9IE1OVF9JRF9SRVFfU0laRV9WRVIwLAo+ICsJCS5t
bnRfaWQgPSBMU01UX1JPT1QsCj4gKwkJLm1udF9uc19mZCA9IC0xLAo+ICsJCS5wYXJhbSA9IDAK
PiArCX07Cj4gKwo+ICsJdHN0X3N5c2NhbGwoX19OUl9saXN0bW91bnQsICZwcm9iZV9yZXEsIG1u
dF9pZHMsIE1OVF9TSVpFLCAwKTsKPiArCj4gKwkvKiAzLiBTZXQgZ2xvYmFsIGJlaGF2aW9yIGZs
YWcgYmFzZWQgb24gYWN0dWFsIGtlcm5lbCByZXNwb25zZSAqLwo+ICsJaWYgKGVycm5vID09IEVC
QURGKSB7Cj4gKwkJdHN0X3JlcyhUSU5GTywgIkRldGVjdGVkIGJhY2twb3J0ZWQgY29tbWl0IDc4
ZjBlMzNjZDZjOSAocmV0dXJucyBFQkFERikiKTsKPiArCQljdXJyZW50X2ZkX2Vycl9iZWhhdmlv
ciA9IElOVkFMSURfRkRfUkVUX0VCQURGOwo+ICsJfSBlbHNlIHsKPiArCQljdXJyZW50X2ZkX2Vy
cl9iZWhhdmlvciA9IElOVkFMSURfRkRfUkVUX0VJTlZBTDsKPiArCX0KCj4+PiBUaGUgYGVsc2Vg
IGJyYW5jaCBzaWxlbnRseSBtYXBzICphbnkqIHVuZXhwZWN0ZWQgZXJybm8gdG8KPj4+IElOVkFM
SURfRkRfUkVUX0VJTlZBTC4gSWYgdGhlIHByb2JlIHJldHVybnMgc29tZXRoaW5nIG90aGVyIHRo
YW4gRUJBREYKPj4+IG9yIEVJTlZBTCAoZS5nLiBFUEVSTSwgRU5PTUVNLCBvciBhIGh5cG90aGV0
aWNhbCBrZXJuZWwgYnVnKSwgdGhlIHRlc3QKPj4+IHdpbGwgc2lsZW50bHkgY2xhc3NpZnkgdGhl
IGtlcm5lbCBhcyAicHJlLWJhY2twb3J0IiBhbmQgcnVuIHRoZSBFSU5WQUwKPj4+IHRlc3QgY2Fz
ZSBhZ2FpbnN0IHdyb25nIGV4cGVjdGF0aW9ucywgeWllbGRpbmcgYSBmYWxzZSBGQUlMIG9yIGEg
ZmFsc2UKPj4+IFBBU1MuCj4+Pgo+Pj4gdHN0X3N5c2NhbGwoKSBhbHJlYWR5IGhhbmRsZXMgRU5P
U1lTIChpdCBjYWxscyB0c3RfYnJrKCkpLCBidXQgYWxsIG90aGVyCj4+PiB1bmV4cGVjdGVkIGVy
cm5vcyBmYWxsIHRocm91Z2ggdG8gdGhpcyBlbHNlIGJyYW5jaCB1bmNoZWNrZWQuCj4+Pgo+Pj4g
UGxlYXNlIG1ha2UgdGhlIGNoZWNrIGV4cGxpY2l0IGFuZCBhYm9ydCBvbiB1bmV4cGVjdGVkIHZh
bHVlczoKPj4+Cj4+PiAgICAgaWYgKGVycm5vID09IEVCQURGKSB7Cj4+PiAgICAgICAgIHRzdF9y
ZXMoVElORk8sICJEZXRlY3RlZCBiYWNrcG9ydGVkIGNvbW1pdCA3OGYwZTMzY2Q2YzkgKHJldHVy
bnMgRUJBREYpIik7Cj4+PiAgICAgICAgIGN1cnJlbnRfZmRfZXJyX2JlaGF2aW9yID0gSU5WQUxJ
RF9GRF9SRVRfRUJBREY7Cj4+PiAgICAgfSBlbHNlIGlmIChlcnJubyA9PSBFSU5WQUwpIHsKPj4+
ICAgICAgICAgY3VycmVudF9mZF9lcnJfYmVoYXZpb3IgPSBJTlZBTElEX0ZEX1JFVF9FSU5WQUw7
Cj4+PiAgICAgfSBlbHNlIHsKPj4+ICAgICAgICAgdHN0X2JyayhUQlJPSywgIlVuZXhwZWN0ZWQg
ZXJybm8gJWQgZnJvbSBtbnRfbnNfZmQgcHJvYmUiLCBlcnJubyk7Cj4+PiAgICAgfQoKLS0tCgo+
ICsvKgo+ICAgKiBGb3IgY29tbWl0IDc4ZjBlMzNjZDZjOSAoImZzL25hbWVzcGFjZTogY29ycmVj
dGx5IGhhbmRsZSBlcnJvcnMgcmV0dXJuZWQKPiAgICogYnkgZ3JhYl9yZXF1ZXN0ZWRfbW50X25z
IikgZnJvbSB2Ni4xOC1yYzcgYmFja3BvcnRlZCB0byB2Ni4xNy45Lgo+ICsgKiBEZWZpbmVzIHRo
ZSBleHBlY3RlZCBlcnJvciBjb2RlIGJlaGF2aW9yIHdoZW4gYW4gaW52YWxpZCBmaWxlIGRlc2Ny
aXB0b3IKPiArICogaXMgcGFzc2VkIHRvIG1udF9uc19mZCAocHJldmlvdXNseSBrbm93biBhcyBz
cGFyZSkuCj4gICAqLwoKPj4+ICJwcmV2aW91c2x5IGtub3duIGFzIHNwYXJlIiBpcyBpbmFjY3Vy
YXRlLiBUaGUgZmllbGQgaW4gYm90aCB0aGUga2VybmVsJ3MKPj4+IHN0cnVjdCBtbnRfaWRfcmVx
IGFuZCBMVFAncyBtbnRfaWRfcmVxX2ZhbGxiYWNrIGhhcyBhbHdheXMgYmVlbiBuYW1lZAo+Pj4g
bW50X25zX2ZkLiBUaGUgbG9jYWwgaGVscGVyIHN0cnVjdCB0Y2FzZSBzdGlsbCBoYXMgYSBmaWVs
ZCBuYW1lZCBgc3BhcmVgCj4+PiBpbiB0aGlzIHZlcnkgcGF0Y2gg4oCUIGl0IHdhcyBub3QgcmVu
YW1lZCDigJQgc28gInByZXZpb3VzbHkiIGlzIHdyb25nIGluCj4+PiBib3RoIGRpcmVjdGlvbnMu
Cj4+Pgo+Pj4gSWYgdGhlIGludGVudCBpcyB0byBjb25uZWN0IHRoZSB0Y2FzZS5zcGFyZSBmaWVs
ZCB0byB0aGUga2VybmVsJ3MKPj4+IG1udF9uc19mZCBmaWVsZCwgc2F5IHNvIGRpcmVjdGx5Ogo+
Pj4KPj4+ICAgICAqIGlzIHBhc3NlZCB0byBtbnRfbnNfZmQgKG1hcHBlZCBmcm9tIHN0cnVjdCB0
Y2FzZSdzIHNwYXJlIGZpZWxkKS4KPj4+Cj4+PiBPciBzaW1wbHkgZHJvcCB0aGUgcGFyZW50aGV0
aWNhbCDigJQgdGhlIHNlbnRlbmNlIGlzIGNsZWFyIHdpdGhvdXQgaXQuCgotLS0KCkNvbW1pdCBt
ZXNzYWdlOgoKPiBDb21taXQgNzhmMGUzM2NkNmM5ICgiZnMvbmFtZXNwYWNlOiBjb3JyZWN0bHkg
aGFuZGxlIGVycm9ycyByZXR1cm5lZAo+IGJ5IGdyYWJfcmVxdWVzdGVkX21udF9ucyIpIGNoYW5n
ZWQgdGhlIGV4cGVjdGVkIGVycm5vIGZvciBhbiBpbnZhbGlkCj4gbW50X25zX2ZkIGZyb20gRUlO
VkFMIHRvIEVCQURGLiBUaGlzIHdhcyBpbnRyb2R1Y2VkIGluIHY2LjE3LjkuCgpNaW5vciBuaXQg
KG5vdCBhIGJsb2NrZXIpOiAiVGhpcyB3YXMgaW50cm9kdWNlZCBpbiB2Ni4xNy45IiBvbmx5IHRl
bGxzCmhhbGYgdGhlIHN0b3J5LiBUaGUgY2hhbmdlIGxhbmRlZCBpbiBtYWlubGluZSBhdCB2Ni4x
OCAodmlhIHY2LjE4LXJjNykgYW5kCndhcyBjb25jdXJyZW50bHkgYmFja3BvcnRlZCB0byBzdGFi
bGUgdjYuMTcuOS4gVGhlIHNlbnRlbmNlIGNvdWxkIHJlYWQ6CgogICAgVGhpcyBsYW5kZWQgaW4g
bWFpbmxpbmUgdjYuMTggYW5kIHdhcyBiYWNrcG9ydGVkIHRvIHN0YWJsZSB2Ni4xNy45LgoKVGhl
IGNvZGUgaW4gc2V0dXAoKSBpcyBjb3JyZWN0IHJlZ2FyZGxlc3MgKHRzdF9rdmVyY21wKDYsIDE3
LCA5KSA+PSAwCmlzIHRydWUgZm9yIGFsbCB2Ni4xNy45KywgdjYuMTgrLCBhbmQgbGF0ZXIpLCBi
dXQgdGhlIGNvbW1pdCBtZXNzYWdlCmRlc2NyaXB0aW9uIG9mIHRoZSB0aW1lbGluZSBpcyBpbmNv
bXBsZXRlLgoKLS0tCgpWZXJkaWN0OiBOZWVkcyByZXZpc2lvbgoKTFRQIEFJIFJldmlld2VyCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
