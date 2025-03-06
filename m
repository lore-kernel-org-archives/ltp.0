Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB39C282D1
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741249404; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=5+Udn3JpJalP83/xLXmRwTAekbCJxBwXf1ODIoafCM8=;
 b=B8Ywrx9CpLky28GTFYlElOFRck6f+qhlbTIZAv7aHUpgY2lo2LsHxzgBkG16TksQfT4vY
 O1bY8L6oAazO1YYIaKfxEleTINSFBeCxHT/FQdMEOtudDxNNDGfqCtQpLtlrKn7TVQ9a160
 /QEuUFFR94qphKYLPAypbvu2Nq3EL0M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 634EF3C718E
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 09:23:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87CD23C070F
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 09:23:03 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AF70214001ED
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 09:23:02 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394a823036so2826705e9.0
 for <ltp@lists.linux.it>; Thu, 06 Mar 2025 00:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741249382; x=1741854182; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KnLQjPlc8EAYBXPyF3+yvXbuIXQKV18k2V46IK7DCb4=;
 b=TYlzTydGu5Gx2M/3FvkOFy7VtY9I/QdFFc9xkXSKWpqjK2WcyivPD4d2yn/Rd87adp
 8IrIig1IIIK7lwLT0UAs17gc/D4Km7tGGbOttkrR6Zx1eKFZpfxQV/uigZpg0B/ejAen
 LRuGvzhQLtfJsqzGamClvEDCmEfJxAGaqrsjYKgLmmy8JazPhG+GXQjR/oqNlcM49vy7
 aecCMQnxEimUrF6fzngZJOHeBA3fZV20hZbNoJ+W82aHqO1cd49AtpNl2K1hVHr4SObs
 XXjeuV/J/hP4ButOk7r2ZYV3xsV7awvi/i+YWUaW17Nor5+szfVpXjuXI3EauDFSO24e
 T1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741249382; x=1741854182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KnLQjPlc8EAYBXPyF3+yvXbuIXQKV18k2V46IK7DCb4=;
 b=LytAEJXvzFqePyuozTTU3iRFlyUPjmPbo4QtUQk9To4Vd5klCx2jqDgIR2AHGkWhHF
 8dt0xHusJ48k4p53MIV34to6XdNKscNdaD8p3utKnSc4gtQt/NCsS8xYIraKI85yc20Y
 Rgik5ITEq1wVa7lIdxpnmb1/xswdNDXGllQqdrYc3dW1eCDvd9VcVG3v8/wZT3bWutGh
 PyGfOu0vX1dU1AnZD3S+W2VldfBtnOoEPtBVBcaXPokflb2seQVKE27MsuTDT2WX+nEs
 25922afb0IaMVk4MaL8lLuQJT5Uzras+LDJBcwae3+d4n3KtrYjbnemXG8tX6DTwa9Rc
 Dkfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPenG3JEecjwcaeKaEyNbXZ/frjfdcmWqy1Ds6ntE/MO03NkFY7qDt1uCC4j40rPPwJa0=@lists.linux.it
X-Gm-Message-State: AOJu0YyL8OnbkVA2IDmBwP+HLnzdataaxEshAB2JEGHTmjXjRNiQvBcq
 DT1r5/tzMjSWsDfrQ7+WDygKcK6xBskFQkhRS4DS7Tk6ctEfGDGxGeBcWk7whIRrFFYCdJpiR53
 ksNM=
X-Gm-Gg: ASbGnctbFYLF2KajYWUw2wCtNRd/O9f882tqC6cyhD3OykeEZd/3RMiEXI/bF65sZzx
 N/sFtLKByDz/1/UtFjM26tEDJIqUBIBTfACxmEbzPQEcP/D6+5szLZl8D9deAEq6MUC1x3RLxZG
 xbMQb6i+LdDYBEUDqo8m1kzUrwmuoIfj2GFCIQMEqtj+D9Ze0zEOHfZKOmc7cUxzkHZO5YiQ977
 6kH8etrfwtsMCSOboMEVEc1Yh1BiyWGk8aCWvpQJidJp7xkuInMhjM5JkHBBR9SDdw8KY9w6rZk
 YidFhHkjveJRWInHdTac/r92BJ71kM0lgOD5O0mGKlCLuWsWLE8VStDgwQsk0inEK7roA57uxTN
 CaugpHlAunxDqNzwUKTFQiL3KdH5tMz1h1ixc6wBvuaZlKRI1Z4Zud9E6FK+M1JdO21pa7S1Jy8
 JFUBKe
X-Google-Smtp-Source: AGHT+IHpgDh3zkfLCP2qmd0S47RCsgKFqtFD8wnZmOv0ze2Ktaf6zy6pVe/eeb9fIBfuB2P3Xk4Vkg==
X-Received: by 2002:a05:600c:4e8b:b0:43b:cb92:8c52 with SMTP id
 5b1f17b1804b1-43bd29acc84mr50919765e9.12.1741249382060; 
 Thu, 06 Mar 2025 00:23:02 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93c9d6sm11871385e9.26.2025.03.06.00.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 00:23:01 -0800 (PST)
Message-ID: <6624ae62-dad9-460b-a303-14747caea2cb@suse.com>
Date: Thu, 6 Mar 2025 09:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250304040601.23920-1-wegao@suse.com>
 <20250306022239.4363-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250306022239.4363-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] unshare03.c: Add test coverage for dup_fd()
 failure handling in unshare_fd()
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpQdXNoZWQgd2l0aCBhIHNtYWxsIGVkaXQgdG8gZGVmaW5lIGxpbWl0cyBvbiB0b3AuIENv
bW1pdCB0aXRsZSB3YXMgYSBiaXQgCnRvbyBsb25nLCBzbyBJIGNoYW5nZWQgaXQuCgpSZXZpZXdl
ZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KCmRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUvdW5zaGFyZTAzLmMgCmIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJlL3Vuc2hhcmUwMy5jCmluZGV4IDcyOThj
ZGViZS4uN2M1ZTcxYzRlIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vu
c2hhcmUvdW5zaGFyZTAzLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJl
L3Vuc2hhcmUwMy5jCkBAIC0xNywxMiArMTcsMTUgQEAKIMKgI2luY2x1ZGUgImxhcGkvc2NoZWQu
aCIKCiDCoCNkZWZpbmUgRlNfTlJfT1BFTiAiL3Byb2Mvc3lzL2ZzL25yX29wZW4iCisjZGVmaW5l
IE5SX09QRU5fTElNSVQgMTAyNAorI2RlZmluZSBOUl9PUEVOX0RVUCA2NAoKIMKgI2lmZGVmIEhB
VkVfVU5TSEFSRQoKIMKgc3RhdGljIHZvaWQgcnVuKHZvaWQpCiDCoHsKIMKgwqDCoMKgIGludCBu
cl9vcGVuOworwqDCoMKgIGludCBucl9saW1pdDsKIMKgwqDCoMKgIHN0cnVjdCBybGltaXQgcmxp
bWl0OwogwqDCoMKgwqAgc3RydWN0IHRzdF9jbG9uZV9hcmdzIGFyZ3MgPSB7CiDCoMKgwqDCoMKg
wqDCoMKgIC5mbGFncyA9IENMT05FX0ZJTEVTLApAQCAtMzIsMTggKzM1LDE5IEBAIHN0YXRpYyB2
b2lkIHJ1bih2b2lkKQogwqDCoMKgwqAgU0FGRV9GSUxFX1NDQU5GKEZTX05SX09QRU4sICIlZCIs
ICZucl9vcGVuKTsKIMKgwqDCoMKgIHRzdF9yZXMoVERFQlVHLCAiTWF4aW11bSBudW1iZXIgb2Yg
ZmlsZSBkZXNjcmlwdG9yczogJWQiLCBucl9vcGVuKTsKCi3CoMKgwqAgU0FGRV9GSUxFX1BSSU5U
RihGU19OUl9PUEVOLCAiJWQiLCBucl9vcGVuICsgMTAyNCk7CivCoMKgwqAgbnJfbGltaXQgPSBu
cl9vcGVuICsgTlJfT1BFTl9MSU1JVDsKK8KgwqDCoCBTQUZFX0ZJTEVfUFJJTlRGKEZTX05SX09Q
RU4sICIlZCIsIG5yX2xpbWl0KTsKCiDCoMKgwqDCoCBTQUZFX0dFVFJMSU1JVChSTElNSVRfTk9G
SUxFLCAmcmxpbWl0KTsKCi3CoMKgwqAgcmxpbWl0LnJsaW1fY3VyID0gbnJfb3BlbiArIDEwMjQ7
Ci3CoMKgwqAgcmxpbWl0LnJsaW1fbWF4ID0gbnJfb3BlbiArIDEwMjQ7CivCoMKgwqAgcmxpbWl0
LnJsaW1fY3VyID0gbnJfbGltaXQ7CivCoMKgwqAgcmxpbWl0LnJsaW1fbWF4ID0gbnJfbGltaXQ7
CgogwqDCoMKgwqAgU0FGRV9TRVRSTElNSVQoUkxJTUlUX05PRklMRSwgJnJsaW1pdCk7CiDCoMKg
wqDCoCB0c3RfcmVzKFRERUJVRywgIlNldCBuZXcgbWF4aW11bSBudW1iZXIgb2YgZmlsZSBkZXNj
cmlwdG9ycyB0byA6ICVkIiwKLcKgwqDCoMKgwqDCoMKgIG5yX29wZW4gKyAxMDI0KTsKK8KgwqDC
oMKgwqDCoMKgIG5yX2xpbWl0KTsKCi3CoMKgwqAgU0FGRV9EVVAyKDIsIG5yX29wZW4gKyA2NCk7
CivCoMKgwqAgU0FGRV9EVVAyKDIsIG5yX29wZW4gKyBOUl9PUEVOX0RVUCk7CgogwqDCoMKgwqAg
aWYgKCFTQUZFX0NMT05FKCZhcmdzKSkgewogwqDCoMKgwqDCoMKgwqDCoCBTQUZFX0ZJTEVfUFJJ
TlRGKEZTX05SX09QRU4sICIlZCIsIG5yX29wZW4pOwoKQW5kcmVhCgpPbiAzLzYvMjUgMDM6MjIs
IFdlaSBHYW8gdmlhIGx0cCB3cm90ZToKPiBBZGQgYSB0ZXN0IGNhc2UgYmFzZWQgb24ga2VybmVs
IHNlbGYtdGVzdCB1bnNoYXJlX3Rlc3QuYyB0byBjaGVjayB0aGF0Cj4gdGhlIGtlcm5lbCBoYW5k
bGVzIHRoZSBFTUZJTEUgZXJyb3Igd2hlbiBhIHBhcmVudCBwcm9jZXNzIGNoYW5nZXMgZmlsZQo+
IGRlc2NyaXB0b3IgbGltaXRzIGFuZCB0aGUgY2hpbGQgcHJvY2VzcyB0cmllcyB0byB1bnNoYXJl
IChDTE9ORV9GSUxFUykuCj4KPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNv
bT4KPiAtLS0KPiAgIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAxICsKPiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS8uZ2l0aWdub3Jl
ICB8ICAxICsKPiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDMu
YyB8IDc0ICsrKysrKysrKysrKysrKysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0
aW9ucygrKQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
dW5zaGFyZS91bnNoYXJlMDMuYwo+Cj4gZGlmZiAtLWdpdCBhL3J1bnRlc3Qvc3lzY2FsbHMgYi9y
dW50ZXN0L3N5c2NhbGxzCj4gaW5kZXggZGVkMDM1ZWU4Li4xMDgwMGMxYTMgMTAwNjQ0Cj4gLS0t
IGEvcnVudGVzdC9zeXNjYWxscwo+ICsrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBAQCAtMTcxNSw2
ICsxNzE1LDcgQEAgdW5saW5rYXQwMSB1bmxpbmthdDAxCj4gICAKPiAgIHVuc2hhcmUwMSB1bnNo
YXJlMDEKPiAgIHVuc2hhcmUwMiB1bnNoYXJlMDIKPiArdW5zaGFyZTAzIHVuc2hhcmUwMwo+ICAg
Cj4gICAjCj4gICAjIFRoZXNlIHRlc3RzIHJlcXVpcmUgYW4gdW5tb3VudGVkIGJsb2NrIGRldmlj
ZQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUvLmdpdGln
bm9yZSBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS8uZ2l0aWdub3JlCj4gaW5k
ZXggODU1ZmZkMDU1Li5lNWI1YzI2MWQgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy91bnNoYXJlLy5naXRpZ25vcmUKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3Vuc2hhcmUvLmdpdGlnbm9yZQo+IEBAIC0xLDIgKzEsMyBAQAo+ICAgL3Vuc2hhcmUwMQo+
ICAgL3Vuc2hhcmUwMgo+ICsvdW5zaGFyZTAzCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvdW5zaGFyZS91bnNoYXJlMDMuYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAw
MDAwMDAwLi43Mjk4Y2RlYmUKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy91bnNoYXJlL3Vuc2hhcmUwMy5jCj4gQEAgLTAsMCArMSw3NCBAQAo+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5
cmlnaHQgKGMpIDIwMjQgQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+Cj4gKyAqIENv
cHlyaWdodCAoQykgMjAyNCBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiArICovCj4gKwo+ICsv
KlwKPiArICogVGhpcyB0ZXN0IGNhc2UgYmFzZWQgb24ga2VybmVsIHNlbGYtdGVzdCB1bnNoYXJl
X3Rlc3QuYyB0byBjaGVjayB0aGF0Cj4gKyAqIHRoZSBrZXJuZWwgaGFuZGxlcyB0aGUgRU1GSUxF
IGVycm9yIHdoZW4gYSBwYXJlbnQgcHJvY2VzcyBjaGFuZ2VzIGZpbGUKPiArICogZGVzY3JpcHRv
ciBsaW1pdHMgYW5kIHRoZSBjaGlsZCBwcm9jZXNzIHRyaWVzIHRvIHVuc2hhcmUgKENMT05FX0ZJ
TEVTKS4KPiArICovCj4gKwo+ICsjZGVmaW5lIF9HTlVfU09VUkNFCj4gKwo+ICsjaW5jbHVkZSAi
dHN0X3Rlc3QuaCIKPiArI2luY2x1ZGUgImNvbmZpZy5oIgo+ICsjaW5jbHVkZSAibGFwaS9zY2hl
ZC5oIgo+ICsKPiArI2RlZmluZSBGU19OUl9PUEVOICIvcHJvYy9zeXMvZnMvbnJfb3BlbiIKPiAr
Cj4gKyNpZmRlZiBIQVZFX1VOU0hBUkUKPiArCj4gK3N0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ICt7
Cj4gKwlpbnQgbnJfb3BlbjsKPiArCXN0cnVjdCBybGltaXQgcmxpbWl0Owo+ICsJc3RydWN0IHRz
dF9jbG9uZV9hcmdzIGFyZ3MgPSB7Cj4gKwkJLmZsYWdzID0gQ0xPTkVfRklMRVMsCj4gKwkJLmV4
aXRfc2lnbmFsID0gU0lHQ0hMRCwKPiArCX07Cj4gKwo+ICsJU0FGRV9GSUxFX1NDQU5GKEZTX05S
X09QRU4sICIlZCIsICZucl9vcGVuKTsKPiArCXRzdF9yZXMoVERFQlVHLCAiTWF4aW11bSBudW1i
ZXIgb2YgZmlsZSBkZXNjcmlwdG9yczogJWQiLCBucl9vcGVuKTsKPiArCj4gKwlTQUZFX0ZJTEVf
UFJJTlRGKEZTX05SX09QRU4sICIlZCIsIG5yX29wZW4gKyAxMDI0KTsKPiArCj4gKwlTQUZFX0dF
VFJMSU1JVChSTElNSVRfTk9GSUxFLCAmcmxpbWl0KTsKPiArCj4gKwlybGltaXQucmxpbV9jdXIg
PSBucl9vcGVuICsgMTAyNDsKPiArCXJsaW1pdC5ybGltX21heCA9IG5yX29wZW4gKyAxMDI0Owo+
ICsKPiArCVNBRkVfU0VUUkxJTUlUKFJMSU1JVF9OT0ZJTEUsICZybGltaXQpOwo+ICsJdHN0X3Jl
cyhUREVCVUcsICJTZXQgbmV3IG1heGltdW0gbnVtYmVyIG9mIGZpbGUgZGVzY3JpcHRvcnMgdG8g
OiAlZCIsCj4gKwkJbnJfb3BlbiArIDEwMjQpOwo+ICsKPiArCVNBRkVfRFVQMigyLCBucl9vcGVu
ICsgNjQpOwo+ICsKPiArCWlmICghU0FGRV9DTE9ORSgmYXJncykpIHsKPiArCQlTQUZFX0ZJTEVf
UFJJTlRGKEZTX05SX09QRU4sICIlZCIsIG5yX29wZW4pOwo+ICsJCVRTVF9FWFBfRkFJTCh1bnNo
YXJlKENMT05FX0ZJTEVTKSwgRU1GSUxFKTsKPiArCQlleGl0KDApOwo+ICsJfQo+ICsKPiArfQo+
ICsKPiArc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiArewo+ICsJY2xvbmUzX3N1cHBvcnRlZF9i
eV9rZXJuZWwoKTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+
ICsJLmZvcmtzX2NoaWxkID0gMSwKPiArCS5uZWVkc19yb290ID0gMSwKPiArCS50ZXN0X2FsbCA9
IHJ1biwKPiArCS5zZXR1cCA9IHNldHVwLAo+ICsJLnNhdmVfcmVzdG9yZSA9IChjb25zdCBzdHJ1
Y3QgdHN0X3BhdGhfdmFsW10pIHsKPiArCQl7RlNfTlJfT1BFTiwgTlVMTCwgVFNUX1NSX1RDT05G
fSwKPiArCQl7fQo+ICsJfSwKPiArfTsKPiArCj4gKyNlbHNlCj4gK1RTVF9URVNUX1RDT05GKCJ1
bnNoYXJlIHN5c2NhbGwgaXMgdW5kZWZpbmVkLiIpOwo+ICsjZW5kaWYKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
