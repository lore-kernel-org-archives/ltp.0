Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C534EC83F1B
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752240013; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=YbmnK83DA2Eb7R5qePPuL0efHlGZdeGLrL3QmiEaXc8=;
 b=hyFrf34ySK7yrpZIkNkDfl9RVx9mRXQFubBzutB1SOXNDmdP1B7GFmUU6Q3JzC+jq5ZEG
 8JYLnY4LC0Hz+9TgW7o2EpGIxEP0Fb5bsytRxDIkC7kOqKO84Vqh+HaZuL/tCVGBGSFwjSW
 /AY+NnfQ03iErleZ+Xd5vjarDeu8d80=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580F23CA08B
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 15:20:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71D253C2F9D
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 15:19:51 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9A3B71400968
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 15:19:50 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so1646520f8f.2
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752239990; x=1752844790; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xJynMWMEZl5j7XsTYLbXonek1USxiBk0tiutpn8ohm8=;
 b=XZWeNOkELP13oU1ggia/8u2ekCSHkfeHEdceKCjZfUYyXbnIHAo8OOc272cL6WqRrl
 1tCVJPaJ9pjwBefhHG/Hr9brvQauWSvRl+hQPXEVr9GE8wYwK0tExT4DmM+TPvs6bO2C
 d4tJa9FIpBGoQ/dc1R3nV3q9FJkE3fp081eC3ty8dmUctWZybXdK9wQ2KOeV6O1DzHS7
 U0Yc1zqrCX56XfGnpuFAoTJdBVjB6/YqfQucqHyMFaXa3afs+4o58b7itEpOE+PtiC2u
 78tMuWJPvl1lgOHaLb3DMTnVy3XTIa73sifWBVbFd/IyfZBABZPCNoVHGxNvwXeSOswL
 +hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752239990; x=1752844790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xJynMWMEZl5j7XsTYLbXonek1USxiBk0tiutpn8ohm8=;
 b=KMgAYlVdYq8xzsmAtoDkcO0ex+npKDl7YqvPbGjOZR8jtoWKVj80i03qMMop1rg1wa
 n/B3RknNQ3yJcaQc+uJpzXXexJf0oorZm20pDouulghCcfecuNOfN8+B9cVPto0gRy58
 07wu0omFYSftVLQMWfJpk8F0QULwXid7TnvD54SKs0wSoNkyjxdCjYd6m8MMTm7h9gBp
 bcE+efMPaac0a3G8rI0VWPMitMRWrvZufoEXrsAjUbquKM54ZDPIOYs6zt8sMiJU9lJp
 OX4+MHdO7m+Qupr8JVlCNekaIh4QZhXiTEmYa4dP5GBPrZ/bdMmIQJKLQRygZKg5bGjN
 TQBQ==
X-Gm-Message-State: AOJu0YzWWLmECvDnPWuxhLXmaLsyrfJwLuXmooI8HDgg6pSNYyYqg+uI
 M/yrojXlBnI6l9Nm0NsOOGL/UIr96+DyYKzuJXXqMKYSPU+Guygm5VBsU88ZLZm+EDw=
X-Gm-Gg: ASbGnct6FcVILGJu7aIn2jRaYKOkhNuZHKqlxpJfz4CPZTvc/Z+FMZHvye7JJt26iIM
 lqi6L6Ft0cgxQnijRDJvLs62RARjnxWOVGZRTjht99ujE4Z4H5FOZCkBeSj5zxNwLFv1VjId2qg
 sZHD4UKj7lpJfgdPxR7bf7qhOzJtka6CffGsV+unRjSD69l2l3y+EyQsZ3HAS6mjeNrSRBQG1l/
 ugmo6TSeOggZM598z55ocFBPy+jAtefFW5Vvlwa9052LG7gnaAFZG2uUvzt/AykmoPN3HZ44DXb
 UiXQQNnnBxUHyk+637FX2oX/7icXa0Tv6GAEbffibgxuyn3880w50JCvxQHTE76c+7EqNK0An5j
 Kwkd9iJCUl/tIZdsD35DHWkiAIPIlSkioNSePFmGiE0D6MmUDehGakOKJyup7THiRl6HmA1Cyge
 +osIwl3AUdRVmd+eQpRLuANgmYtItfNX6Y/c7wbweoBiaM9Oe6qLtC6ZCmiKBM+w==
X-Google-Smtp-Source: AGHT+IGJlZrlgfJf/FEHK0bi+fnSvomrhccIYdagC2zrYxlcrpjAe1ohE2XGR9WrbOg1zoE4bvd60g==
X-Received: by 2002:a5d:5f55:0:b0:3a9:dc5:df15 with SMTP id
 ffacd0b85a97d-3b5f2dc1ee2mr2440114f8f.13.1752239989921; 
 Fri, 11 Jul 2025 06:19:49 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f1b54bsm5612857b3a.90.2025.07.11.06.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 06:19:49 -0700 (PDT)
Message-ID: <11ef4d27-3542-436c-bdaf-5c662ca88a5c@suse.com>
Date: Fri, 11 Jul 2025 15:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250711113632.11391-1-chrubis@suse.cz>
 <20250711113632.11391-3-chrubis@suse.cz>
 <b3b69967-a546-473d-8be6-e1cbe0e2ac06@suse.com> <aHEOHsSZe1ZRftqx@yuki.lan>
Content-Language: en-US
In-Reply-To: <aHEOHsSZe1ZRftqx@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] metaparse: Map arrays with designated
 initializers to JSON objects
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDcvMTEvMjUgMzoxNCBQTSwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+IEhpIQo+PiBOb3cgZG9j
cyBzZWVtIHRvIGJlIGJyb2tlbiBmb3IgdHN0X3Rlc3QuZmlsZXN5c3RlbXMuIFRoaXMgcGF0Y2gg
d2lsbAo+PiBzb2x2ZSB0aGUgaXNzdWUgYW5kIGl0IG5lZWRzIHRvIGJlIGFkZGVkIHRvIHRoZSBw
YXRjaC1zZXQ6Cj4+Cj4+IGRpZmYgLS1naXQgYS9kb2MvY29uZi5weSBiL2RvYy9jb25mLnB5Cj4+
IGluZGV4IGRhNzY4MjMyYi4uY2FkZmViMmIzIDEwMDY0NAo+PiAtLS0gYS9kb2MvY29uZi5weQo+
PiArKysgYi9kb2MvY29uZi5weQo+PiBAQCAtNDA2LDEzICs0MDYsMTIgQEAgZGVmIF9nZW5lcmF0
ZV9zZXR1cF90YWJsZShrZXlzKToKPj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZToK
Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWx1ZXMuYXBwZW5kKGYne3Zh
bHVlWzBdfSwge3ZhbHVlWzFdfScpCj4+ICAgwqDCoMKgwqDCoMKgwqDCoCBlbGlmIGtleSA9PSAn
ZmlsZXN5c3RlbXMnOgo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgdiBpbiB2YWx1ZToK
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgaXRlbSBpbiB2Ogo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgaXNpbnN0YW5jZShpdGVtLCBs
aXN0KToKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29udGludWUKPj4gLQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgaXRlbS5zdGFydHN3aXRoKCcudHlwZScpOgo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWx1ZXMuYXBwZW5kKGl0ZW0ucmVwbGFjZSgnLnR5cGU9
JywgJycpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgcGFyYW1zIGluIHZhbHVlOgo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciBwa2V5LCBwdmFsIGluIHBhcmFt
cy5pdGVtcygpOgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
cGtleSA9PSAidHlwZSI6Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHZhbHVlcy5hcHBlbmQoZiItIHtwdmFsfSIpCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlOgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWx1ZXMuYXBwZW5kKGYiIHtwa2V5fToge3B2YWx9IikK
Pj4gICDCoMKgwqDCoMKgwqDCoMKgIGVsaWYga2V5ID09ICJzYXZlX3Jlc3RvcmUiOgo+PiAgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgaXRlbSBpbiB2YWx1ZToKPj4gICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWx1ZXMuYXBwZW5kKGl0ZW1bMF0pCj4gQ2FuIHlvdSBw
bGVhc2Ugc2VuZCBhIHByb3BlciBwYXRjaCBzbyB0aGF0IEkgY2FuIGFwcGx5IGFsbCB0aHJlZSBw
YXRjaGVzCj4gdG9nZXRoZXI/Cj4KIEZyb20gMDcyZGFjZDIwNzJkMGNmM2FjY2U5ZDYyMzA5MWFi
MGU1ODZlNDc5OSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEKRnJvbTogQW5kcmVhIENlcnZlc2F0
byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KRGF0ZTogRnJpLCAxMSBKdWwgMjAyNSAxNTox
NzoxMiArMDIwMApTdWJqZWN0OiBbUEFUQ0ggdjFdIGRvYzogdXBkYXRlIGZpbGVzeXN0ZW1zIGlu
Zm8gYWNjb3JkaW5nIHRvIG5ldyBtZXRhZGF0YQpUbzogbHRwQGxpc3RzLmxpbnV4Lml0CgpOZXcg
bWV0YWRhdGEgaXMgbm93IHVzaW5nIGEgZGljdGlvbmFyeSBkZWZpbml0aW9uIGZvcgp0c3RfdGVz
dC5maWxlc3lzdGVtcy4gVGhpcyBwYXRjaCB3aWxsIGNvcnJlY3RseSBzaG93IHRoZSBmaWxlc3lz
dGVtcwpzZXR1cCBpbmZvcm1hdGlvbiBpbnNpZGUgdGhlIGh0bWwgcGFnZS4KClNpZ25lZC1vZmYt
Ynk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Ci0tLQogwqBk
b2MvY29uZi5weSB8IDEzICsrKysrKy0tLS0tLS0KIMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kb2MvY29uZi5weSBiL2RvYy9j
b25mLnB5CmluZGV4IGRhNzY4MjMyYi4uY2FkZmViMmIzIDEwMDY0NAotLS0gYS9kb2MvY29uZi5w
eQorKysgYi9kb2MvY29uZi5weQpAQCAtNDA2LDEzICs0MDYsMTIgQEAgZGVmIF9nZW5lcmF0ZV9z
ZXR1cF90YWJsZShrZXlzKToKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlOgogwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsdWVzLmFwcGVuZChmJ3t2YWx1ZVswXX0sIHt2
YWx1ZVsxXX0nKQogwqDCoMKgwqDCoMKgwqDCoCBlbGlmIGtleSA9PSAnZmlsZXN5c3RlbXMnOgot
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgdiBpbiB2YWx1ZToKLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBmb3IgaXRlbSBpbiB2OgotwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgaXNpbnN0YW5jZShpdGVtLCBsaXN0KToKLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWUKLQotwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgaXRlbS5zdGFydHN3aXRoKCcudHlwZScpOgotwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWx1ZXMuYXBwZW5k
KGl0ZW0ucmVwbGFjZSgnLnR5cGU9JywgJycpKQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3Ig
cGFyYW1zIGluIHZhbHVlOgorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciBwa2V5
LCBwdmFsIGluIHBhcmFtcy5pdGVtcygpOgorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgcGtleSA9PSAidHlwZSI6CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHZhbHVlcy5hcHBlbmQoZiItIHtwdmFsfSIpCivCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlOgorwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWx1ZXMuYXBwZW5kKGYiIHtwa2V5fToge3B2YWx9
IikKIMKgwqDCoMKgwqDCoMKgwqAgZWxpZiBrZXkgPT0gInNhdmVfcmVzdG9yZSI6CiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZm9yIGl0ZW0gaW4gdmFsdWU6CiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB2YWx1ZXMuYXBwZW5kKGl0ZW1bMF0pCi0tIAoyLjUwLjAKCgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
