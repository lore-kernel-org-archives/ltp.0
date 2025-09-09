Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E97ACA0FED
	for <ltp@archiver.kernel.org>; Tue,  9 Sep 2025 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757429361; h=date :
 message-id : to : mime-version : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ild6JqS70C6JSeAmcpBI6yUX6qrMks5AifSNNsWaems=;
 b=Z284/RpSDafxikxMffhI9jmXlxMnujMXIctl+zTFO9X6NnNtAhzvHKBquu9U7hdiXoPwr
 jCWqZDWry/YKwQey0ADHC8kJEUTS6YP/Un4/3CtPeOATPnhCrZBH3S4TRZDYbiREc7aeH74
 4oW0E4BbXBPQWlpkfZ/VLGsAO+jwG4k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C49B3CD3DC
	for <ltp@archiver.kernel.org>; Tue,  9 Sep 2025 16:49:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 235813C84D0
 for <ltp@lists.linux.it>; Tue,  9 Sep 2025 16:48:58 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 601C72005EB
 for <ltp@lists.linux.it>; Tue,  9 Sep 2025 16:48:58 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3e07ffffb87so2721098f8f.2
 for <ltp@lists.linux.it>; Tue, 09 Sep 2025 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757429338; x=1758034138; darn=lists.linux.it;
 h=in-reply-to:references:mime-version:content-transfer-encoding:cc
 :subject:from:to:message-id:date:from:to:cc:subject:date:message-id
 :reply-to; bh=mM6EY+qvR/YqOntTKGXNSeR2dt9g3iUyjTVl0i3Joic=;
 b=dCc898AM4JmHKXHBtVt2BMwop2XvVigTMqHQ+xvr9Xo95iFJ1OlH+jBFnepd7iEM3x
 JSj2zrgEPuV4s9KroLkWwv7iN4HqwGCqTyyXJ8u+msTPN+3q1wM5F25GsxtZyyXTmCpH
 TqgzunoyGrCG5VmCBbfcf/ND8NmICxOmCedKIJwB+WzD3Ag7SGiDFJEzHtNlYVJYx1xj
 KMTbiIFPsIUNZGhbpLXKWFFB6sAf2gAeg5hXD/FD9Y7LDY4NVncY+iTJUbRDKkdD2FaF
 ariKGO4Up12RieY3rF4yPIbvC7EzE/GmFhB+gy0WcYawEEeF6MDA/yrtRMvQ0Ah/HHPW
 O2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757429338; x=1758034138;
 h=in-reply-to:references:mime-version:content-transfer-encoding:cc
 :subject:from:to:message-id:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mM6EY+qvR/YqOntTKGXNSeR2dt9g3iUyjTVl0i3Joic=;
 b=v6wRM2iVJWU0Uqm8r861dSJE/4o80c7z/Mc66PqpBqaKt7udU/nRWUT5w6jkrWCCG1
 ZyG07NrvkrJX1r1buEz41IWwTeM65IJdpYHnq1pQzTpkA6k8IfyxKo7YhT4MNYqiBMOL
 rRTGGGO2Iq/Hm9GlzyNaDhQFL7dDp9LVMuI691EemBXs6lCnNYVFfQmrgNAAAabXHByi
 allR9Nv5PVt4RRi+796bFuDp8SywYfGYogZsLwZEbH66r5C5MzAIZKY7eMxjUFZ4JIA4
 9fJnjga5o68aSfeQVFJdWIEsbIe+uTjWwNHb6ntpVpjsmQauseFKdKMREoNEgGMUWHzY
 5vTQ==
X-Gm-Message-State: AOJu0YwM7JnmUj733aADeaDsiI6BU7wQvfGmiI6UJUO8HRgzJv6UeYXw
 ySJhI7BfU85GoWuTaBX31V8g6i/EG5OWbT2+xDd0twsMW9n0IJ3KRV2QB31/I5Likog=
X-Gm-Gg: ASbGncso9tNVLO4QzajU3vWhYNV0ia7aQHqgkZCLpMy+/SwqP+Xvnka/O0hcnhWdV+Y
 pvg5eQU+OLK5Z5pkM9ihcQHjArjHi+NAYg96VhT9MUn9bs+XwjfyPxYyQ7wcSId/fTn5N0j/kX3
 NANUNGo/wANG9ILegGXIyamZ+xVLLIbkQ6nTLKms/jP7eDaoK0Vbvhm0mElsFP0EIIptLR04+01
 E7hbsU5RhV0uPv/bZ7oFNs8xuJLg8KKzivQhDoEJ7bqUolbGeq4b0+t0mamhbNo5I912Ng3ADLU
 0AZriXAA1tIZBf9nVqR/2/znMsQBfBamvtuuUVv+J2BXI7mYs2y4jlaqJvDLXQbAfKLvvgOSMr3
 zOBZ34MZcKw==
X-Google-Smtp-Source: AGHT+IEYSh61qEFCHNmfHeySVPDar8Hu4dAfzSfHZndR5LG9CLBHzfgWys8daCuDbI2V7ojb9RhOhA==
X-Received: by 2002:a05:6000:40da:b0:3b8:d360:336f with SMTP id
 ffacd0b85a97d-3e643555d57mr9503326f8f.28.1757429337720; 
 Tue, 09 Sep 2025 07:48:57 -0700 (PDT)
Received: from localhost ([177.94.120.255]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8982751bf54sm8358799241.21.2025.09.09.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:48:57 -0700 (PDT)
Date: Tue, 09 Sep 2025 11:48:52 -0300
Message-Id: <DCOCPDWMUTF5.PXSIFKQYF1IW@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Mime-Version: 1.0
X-Mailer: aerc 0.20.1-125-gabe5bb884bbc-dirty
References: <20250829-conversions-lchown-v5-0-7c3f25cd1de4@suse.com>
 <20250829-conversions-lchown-v5-4-7c3f25cd1de4@suse.com>
 <aLb-uPKS6ZCmpUTc@yuki.lan>
In-Reply-To: <aLb-uPKS6ZCmpUTc@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/4] syscalls: lchown03: Merge into lchown02
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIFNlcCAyLCAyMDI1IGF0IDExOjI3IEFNIC0wMywgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+
IEhpIQo+PiAgc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBpKQo+PiBAQCAtNzAsOCArNzcs
MTQgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPj4gIHsKPj4gIAliYWRfYWRkciA9IHRzdF9n
ZXRfYmFkX2FkZHIoTlVMTCk7Cj4+ICAKPj4gLQltZW1zZXQobG9uZ3BhdGgsICdhJywgTE9OR1BB
VEhTSVpFIC0gMSk7Cj4+IC0JbG9uZ3BhdGhbTE9OR1BBVEhTSVpFLTFdID0gMDsKPj4gKwltZW1z
ZXQobWF4cGF0aCwgJ2EnLCBNQVhQQVRIIC0gMSk7Cj4+ICsJbWF4cGF0aFtNQVhQQVRILTFdID0g
MDsKPj4gKwo+PiArCXNucHJpbnRmKGxvbmdwYXRoLCBzaXplb2YobG9uZ3BhdGgpLCAiLiIpOwo+
PiArCVNBRkVfTUtESVIoImxvbmdwYXRoIiwgMDc1NSk7Cj4+ICsJU0FGRV9TWU1MSU5LKCIuLi9s
b25ncGF0aCIsICJsb25ncGF0aC9sb25ncGF0aCIpOwo+PiArCWZvciAoaW50IGkgPSAwOyBpIDwg
NDM7IGkrKykKPj4gKwkJc3RyY2F0KGxvbmdwYXRoLCAiL2xvbmdwYXRoIik7Cj4KPiBUaGVyZSBp
cyBtdWNoIG1vcmUgZWFzaWVyIHdheSBob3cgdG8gZ2V0IEVMT09QLCBqdXN0IGNyZWF0ZSB0d28g
c3ltbGlua3MKPiBwb2ludGluZyB0byBlYWNoIG90aGVyLgo+Cj4gCVNBRkVfU1lNTElOSygiaW5m
aW50ZV9sb29wX2EiLCAiaW5maW5pdGVfbG9vcF9iIik7Cj4gCVNBRkVfU1lNTElOSygiaW5maW50
ZV9sb29wX2IiLCAiaW5maW5pdGVfbG9vcF9hIik7Cj4KPiBUcnlpbmcgdG8gcmVzb2x2ZSBlaXRo
ZXIgb2YgdGhlc2UgZW5kcyB1cCBpbiBFTE9PUC4KCkkgZG9uJ3QgdGhpbmsgdGhhdCB3aWxsIHdv
cmsgZm9yIGxjaG93biwgZnJvbSBpdCdzIG1hbiBwYWdlOgoKICAgICAgIOKAoiAgbGNob3duKCkg
aXMgbGlrZSBjaG93bigpLCBidXQgZG9lcyBub3QgZGVyZWZlcmVuY2Ugc3ltYm9saWMgbGlua3Mu
CgpJIGd1ZXNzIHRoZSBvcmlnaW5hbCBjb2RlIHdvcmtzIGJlY2F1c2UgdGhlIGZpbmFsIGNvbXBv
bmVudCBpcyBub3QgYSBsaW5rLgoKSGVyZSdzIHRoZSBkaWZmIChmYWlscyB3aXRoIEVQRVJNKToK
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sY2hvd24vbGNob3duMDIu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL2xjaG93bjAyLmMKaW5kZXggZGIw
Njg4NjVhY2RjLi5kYjhiMjljNjFkMDcgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbGNob3duL2xjaG93bjAyLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9s
Y2hvd24vbGNob3duMDIuYwpAQCAtMzMsNiArMzMsNyBAQAogI2RlZmluZSBTRklMRTIgInRlc3Rk
aXJfMS9zZmlsZV8yIgogI2RlZmluZSBURklMRTMgInRfZmlsZSIKICNkZWZpbmUgU0ZJTEUzICJ0
X2ZpbGUvc2ZpbGUiCisjZGVmaW5lIEVGSUxFMSAiZWxvb3AiCiAjZGVmaW5lIFRFU1RfRVJPRlMg
Im1udHBvaW50IgogI2RlZmluZSBNQVhQQVRIIChQQVRIX01BWCsyKQogCkBAIC00Miw3ICs0Myw3
IEBAIHN0YXRpYyBjaGFyICpiYWRfYWRkcjsKIHN0YXRpYyBjaGFyICptYXhwYXRoOwogc3RhdGlj
IGNoYXIgKnNmaWxlMzsKIHN0YXRpYyBjaGFyICplbXB0eTsKLXN0YXRpYyBjaGFyICpsb25ncGF0
aDsKK3N0YXRpYyBjaGFyICplbG9vcDsKIHN0YXRpYyBjaGFyICplcm9mczsKIHN0YXRpYyBzdHJ1
Y3QgcGFzc3dkICpsdHB1c2VyOwogCkBAIC01NywyMCArNTgsMTUgQEAgc3RhdGljIHN0cnVjdCB0
ZXN0X2Nhc2VfdCB7CiAJeyAmbWF4cGF0aCwgIlBhdGhuYW1lIHRvbyBsb25nIiwgRU5BTUVUT09M
T05HIH0sCiAJeyAmc2ZpbGUzLCAiUGF0aCBjb250YWlucyByZWd1bGFyIGZpbGUiLCBFTk9URElS
IH0sCiAJeyAmZW1wdHksICJQYXRobmFtZSBpcyBlbXB0eSIsIEVOT0VOVCB9LAotCXsgJmxvbmdw
YXRoLCAiVG9vIG1hbnkgc3ltbGlua3MiLCBFTE9PUCB9LAorCXsgJmVsb29wLCAiVG9vIG1hbnkg
c3ltbGlua3MiLCBFTE9PUCB9LAogCXsgJmVyb2ZzLCAiUmVhZC1vbmx5IGZpbGVzeXN0ZW0iLCBF
Uk9GUyB9LAogfTsKIAogc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBpKQogewotCXVpZF90
IHVzZXJfaWQ7Ci0JZ2lkX3QgZ3JvdXBfaWQ7CiAJc3RydWN0IHRlc3RfY2FzZV90ICp0YyA9ICZ0
ZXN0X2Nhc2VzW2ldOwogCi0JVUlEMTZfQ0hFQ0soKHVzZXJfaWQgPSBnZXRldWlkKCkpLCAibGNo
b3duIik7Ci0JR0lEMTZfQ0hFQ0soKGdyb3VwX2lkID0gZ2V0ZWdpZCgpKSwgImxjaG93biIpOwot
Ci0JVFNUX0VYUF9GQUlMKGxjaG93bigqdGMtPnBhdGhuYW1lLCB1c2VyX2lkLCBncm91cF9pZCks
IHRjLT5leHBfZXJybm8sICIlcyIsIHRjLT5kZXNjKTsKKwlUU1RfRVhQX0ZBSUwobGNob3duKCp0
Yy0+cGF0aG5hbWUsIGx0cHVzZXItPnB3X3VpZCwgbHRwdXNlci0+cHdfZ2lkKSwgdGMtPmV4cF9l
cnJubywgIiVzIiwgdGMtPmRlc2MpOwogfQogCiBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQpAQCAt
ODAsMTUgKzc2LDIxIEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiAJbWVtc2V0KG1heHBhdGgs
ICdhJywgTUFYUEFUSCAtIDEpOwogCW1heHBhdGhbTUFYUEFUSC0xXSA9IDA7CiAKLQlzbnByaW50
Zihsb25ncGF0aCwgc2l6ZW9mKGxvbmdwYXRoKSwgIi4iKTsKLQlTQUZFX01LRElSKCJsb25ncGF0
aCIsIDA3NTUpOwotCVNBRkVfU1lNTElOSygiLi4vbG9uZ3BhdGgiLCAibG9uZ3BhdGgvbG9uZ3Bh
dGgiKTsKLQlmb3IgKGludCBpID0gMDsgaSA8IDQzOyBpKyspCi0JCXN0cmNhdChsb25ncGF0aCwg
Ii9sb25ncGF0aCIpOworCS8vIHNucHJpbnRmKGxvbmdwYXRoLCBzaXplb2YobG9uZ3BhdGgpLCAi
LiIpOworCS8vIFNBRkVfTUtESVIoImxvbmdwYXRoIiwgMDc1NSk7CisJLy8gU0FGRV9TWU1MSU5L
KCIuLi9sb25ncGF0aCIsICJsb25ncGF0aC9sb25ncGF0aCIpOworCS8vIGZvciAoaW50IGkgPSAw
OyBpIDwgNDM7IGkrKykKKwkvLyAJc3RyY2F0KGxvbmdwYXRoLCAiL2xvbmdwYXRoIik7CisKKwlT
QUZFX1NZTUxJTksoRUZJTEUxLCAiaW5maW5pdGVfbG9vcCIpOworCVNBRkVfU1lNTElOSygiaW5m
aW5pdGVfbG9vcCIsIEVGSUxFMSk7CiAKIAlsdHB1c2VyID0gU0FGRV9HRVRQV05BTShURVNUX1VT
RVIpOwogCVNBRkVfU0VUR0lEKGx0cHVzZXItPnB3X3VpZCk7CiAKKwlVSUQxNl9DSEVDSyhsdHB1
c2VyLT5wd191aWQsICJsY2hvd24iKTsKKwlHSUQxNl9DSEVDSyhsdHB1c2VyLT5wd19naWQsICJs
Y2hvd24iKTsKKwogCVNBRkVfVE9VQ0goVEZJTEUxLCAwNjY2LCBOVUxMKTsKIAlTQUZFX1NFVEVV
SUQoMCk7CiAJU0FGRV9TWU1MSU5LKFRGSUxFMSwgU0ZJTEUxKTsKQEAgLTExNSw3ICsxMTcsNyBA
QCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CiAJCXsmc2ZpbGUxLCAuc3RyID0gU0ZJ
TEUxfSwKIAkJeyZzZmlsZTIsIC5zdHIgPSBTRklMRTJ9LAogCQl7JnNmaWxlMywgLnN0ciA9IFNG
SUxFM30sCi0JCXsmbG9uZ3BhdGgsIC5zaXplID0gUEFUSF9NQVh9LAorCQl7JmVsb29wLCAuc3Ry
ID0gRUZJTEUxfSwKIAkJeyZlbXB0eSwgLnN0ciA9ICIifSwKIAkJeyAmZXJvZnMsIC5zdHIgPSBU
RVNUX0VST0ZTIH0sCiAJCXt9CgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
