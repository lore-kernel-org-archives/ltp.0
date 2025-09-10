Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D5DCA101F
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 22:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757542841; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qiKaf5UQ8ZO9vEk5/7z3b3B3zVBNrE9E8xxwEuItAGw=;
 b=K6wTnFXJTqhB26hXz9YAiZiE+wiUrT2Z5GCVUcqxsA6DVtUd7B7jd9aS/pBHMrLMNkSaB
 4tJrQRRY0OJYWp3DsZghtRS1uhHqraA6T0M3FzR4ITh2Qdp2HAJ3Aris1C0upFc5uFHUXbl
 +iIYC1ba3FQQhtDNWudCOkzH6h0Ie3c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 244493CD807
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 00:20:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CAA33CD7F0
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 00:20:00 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD40220091E
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 00:19:59 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso97330f8f.3
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757542799; x=1758147599; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k/9fb8POq3uvWHFvtExXze7dzlBbxmqBY7LjwHqFJ+s=;
 b=Kc4YYsZk+Q2uNWbrl9zqpa+uFfo5GZfTJXzv/WrF33mxDudQI1VcLPOD6tgPYiysIq
 3uJAcsMO7w5G6Cc7BA11rx+bcdOIrqfWrOysBwMYqNGPRFMHWL0KHdwrRyFlxSqt6zbo
 0xfnh+RbV5uiTDcl4xNK1XXCAeA1VbZgUZeFcKsr9agJRUEUFNzVZ1pzHNNhd4YVdKfu
 ChNoNGPkAjB9S+TavhYGLdzeprJen5wpdiRfHOZnUSkx1RCs/bvrH6jRI5RHz+fTjGib
 +tlbQQT+xqEgimPBwDdioY4X8yvgQJJ+Q829wJUlu/CczHK0Hvz8bSkApum5lCa3X+TH
 88rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757542799; x=1758147599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/9fb8POq3uvWHFvtExXze7dzlBbxmqBY7LjwHqFJ+s=;
 b=BZtoITzkTtLHut4g8kbEyKqcFWqoBpjSJlKfVjEiRypzaVm/9NatJ9QPo6+pd0WtgZ
 6ErAWzX6YV2WhSDbtl5ZFIIXkmbG4szApt5cvOvbwVTwlyEvNHzw9HVHcHv+hHWcyiEs
 h3TkWzvbZI9hBBOtlsmkA9vHDN5x02ZV4Ah5nHTiNgmSRNPG+0tcZJTcodwMjCohcecq
 0kJqGgsLdNogkNC4nYnFJ3NfOcKmcp9dXxYVcbYCPPz5u79N3zM+Zjg5CpqGzUUZbS64
 PBkL//TcHcir9w+YTGtug98QS9LzDAFkXq+Y9kG7LNm4aYcwoNNj0A4rXLfyIbuLzZg1
 nYag==
X-Gm-Message-State: AOJu0YysCo1K3lMhcvEmxhrair6fM4bjjMX2CUcCmHzBzrppHmtFeO2t
 dLQGrbvSaU4R5izJumAyrTwgEYfLqlgyZxp0WmNqmMbmfyktRWhOGmlKsXhsP+SYY1jGlpOWdFB
 RzuRF
X-Gm-Gg: ASbGncvD5uusYQSvGo1sEdSU0+F8R8okC9GTT9Lz2WjLcdx3rlsLG6H09LNOc7H1keR
 tNuOUhiTOcsWqEBYouYfW1avEyczvSfmVkXEk+nQ5y77OoQoih3fuwjZimQnn4SOlAVidrH0z73
 4Xfygud64/8Bcl289AZeMtWTRLpYYBw3jh3dfhUeGlur/OqNcxQuGD/NqzaaFl2n4UPNp+e1Ge7
 dKTbcNKL7ubUWBtvJ/LvrsTPu07gewS1nptMuoZ356nToHYbIRIr/YRpqryM/X8R0TQ1WnEwnLf
 uphx6h9KMqoXIIxO0EznxkW1IHdAYgu+sJRxJH0CiCN2GWKe78Su1Ff2fQGC4Gua7wGzQKrsdje
 hKwv/Q0N8tA==
X-Google-Smtp-Source: AGHT+IG49pdhcXz0vl5tQtLDnc7Z4up/6MtgdAe+F4BM8fC3+tA2ChPAYK8iUcU+mNbpPytYC9boDg==
X-Received: by 2002:a05:6000:18a3:b0:3e3:e7a0:1fee with SMTP id
 ffacd0b85a97d-3e636d8f73bmr16297765f8f.5.1757542799294; 
 Wed, 10 Sep 2025 15:19:59 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-5531e64239dsm11816137.12.2025.09.10.15.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 15:19:58 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:19:47 -0300
MIME-Version: 1.0
Message-Id: <20250910-conversions-lchown-v6-1-a133444cdb6a@suse.com>
References: <20250910-conversions-lchown-v6-0-a133444cdb6a@suse.com>
In-Reply-To: <20250910-conversions-lchown-v6-0-a133444cdb6a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=rbm@suse.com;
 h=from:subject:message-id; bh=Hwires67BmRGFajPCFScGmR4duFBmyY+UqvUIyHGsIk=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBowfmIT1fKIIoCMEIUATTJqrqhxCT7F+wU/gnr8
 YU/zyrWjamJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaMH5iBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKZDbg/+JTihopme3XRJzW7hNOFmXoYPIUsxidi
 adYjoyjMhAfJTiTjMpHlnvSUMqUprubwJVIbZTsfKt3RHLUs+hKyLYYj1ZiPFw/vEv7HKiEF8sJ
 TyW9LGQe0OErcD2Jf1PpklTfTKmBqDo2Ihws/lTNxaDhJYTcTjqkvKRT5NRxfr4JVT7bvAdUUpb
 crddOYfNVWCoyWuHHeyB6WORcwkdNnXPOK/LDWi2aPaBOcHcjs7EJSmgbcJg5wNBsqV3y4uQDPc
 E4x7GvHQODZVrEhWahJtqJ5Uya7zI/J1P42RNfU3XmwaNaMuXVVJIhqshyBd29fNqph8pz4odjc
 40lJtq7oVaa9xZJ74h4lHUd5WcZdclLSUIjyzC9QNRneJgo9PVyeknEv39AKEjkts35EKBD/ZNo
 3u2lXpF+/Rasx8EMM/am4GTy6CXvXYbM3kuoCh31nNAChKAotx2rWTA03bOE+OC+AhrADYFdJ48
 G5c+uVLOl3txDmJZQVkPDMUAABm2VRRoNENEmk3HZWO0PvIp86c6CtyvthEuqkEUDNNpi2/MO0+
 jwWMaUBqWn0bzfUbdpfvivSSkikSwcVW0PlzG0R5+nwN6eH3WUPPHhcyPJKPV8q/0pSmMkQUMuU
 VW4x8gy9KuWxf2IE16m8rkimSAPrnkNLisfMsQRPnTkrjzJqqEeU=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/4] lib: Add SAFE_LCHOWN
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
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClJldmlld2VkLWJ5OiBB
bmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgpSZXZpZXdlZC1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBDeXJpbCBIcnViaXMgPGNo
cnViaXNAc3VzZS5jej4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBz
dXNlLmNvbT4KLS0tCiBpbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmggIHwgIDMgKysrCiBpbmNsdWRl
L3RzdF9zYWZlX21hY3Jvcy5oIHwgIDMgKysrCiBsaWIvc2FmZV9tYWNyb3MuYyAgICAgICAgIHwg
MTkgKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oIGIvaW5jbHVkZS9zYWZlX21h
Y3Jvc19mbi5oCmluZGV4IGQyNTYwOTFiNzZhZDEwYjA2YjI5ZTNmZDVmYWQ4ODUzZmFhMTRjMDgu
LjM3OTk4NzNhMjQ4ZjM2ZTBmZjMxYzg2MmRlMjcwM2ExM2ZlZTFiZmQgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvc2FmZV9tYWNyb3NfZm4uaAorKysgYi9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKQEAg
LTE1MSw2ICsxNTEsOSBAQCBpbnQgc2FmZV9jaG93bihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBp
bnQgbGluZW5vLCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKIGludCBzYWZlX2ZjaG93bihjb25z
dCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwK
ICAgICAgICAgICAgICAgICBpbnQgZmQsIHVpZF90IG93bmVyLCBnaWRfdCBncm91cCk7CiAKK2lu
dCBzYWZlX2xjaG93bihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCB2b2lkICgq
Y2xlYW51cF9mbikodm9pZCksCisJCWNvbnN0IGNoYXIgKnBhdGgsIHVpZF90IG93bmVyLCBnaWRf
dCBncm91cCk7CisKIHBpZF90IHNhZmVfd2FpdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQg
bGluZW5vLCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKICAgICAgICAgICAgICAgICBpbnQgKnN0
YXR1cyk7CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggYi9pbmNsdWRl
L3RzdF9zYWZlX21hY3Jvcy5oCmluZGV4IDE5NTA0YmViNTdhZDM3OWM4MzVhMTNlZDVkMzVmZTA2
ZTQyYTZlZDYuLjQxZDE3YjFjYTQ1OTA0NThjZjY1MWE1OWE2ZTM3N2MyMTU3MjcwOTQgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKKysrIGIvaW5jbHVkZS90c3Rfc2FmZV9t
YWNyb3MuaApAQCAtMjIwLDYgKzIyMCw5IEBAIGludCBzYWZlX2dldGdyb3Vwcyhjb25zdCBjaGFy
ICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCBpbnQgc2l6ZSwgZ2lkX3QgbGlzdFtdKTsKICNkZWZp
bmUgU0FGRV9GQ0hPV04oZmQsIG93bmVyLCBncm91cCkgXAogCXNhZmVfZmNob3duKF9fRklMRV9f
LCBfX0xJTkVfXywgTlVMTCwgKGZkKSwgKG93bmVyKSwgKGdyb3VwKSkKIAorI2RlZmluZSBTQUZF
X0xDSE9XTihwYXRoLCBvd25lciwgZ3JvdXApIFwKKwlzYWZlX2xjaG93bihfX0ZJTEVfXywgX19M
SU5FX18sIE5VTEwsIChwYXRoKSwgKG93bmVyKSwgKGdyb3VwKSkKKwogI2RlZmluZSBTQUZFX1dB
SVQoc3RhdHVzKSBcCiAJc2FmZV93YWl0KF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgKHN0YXR1
cykpCiAKZGlmZiAtLWdpdCBhL2xpYi9zYWZlX21hY3Jvcy5jIGIvbGliL3NhZmVfbWFjcm9zLmMK
aW5kZXggNzI2YzlhZThlZTUzNzU5YmE5ODMzMzk2NjJhNmI0MWU5NGVhY2Q3YS4uNjBkMjhiNWJk
ZjJiZDZmZGQzNDhmYWQ1MGJlNDVjYTY2ZmIxNTlhMSAxMDA2NDQKLS0tIGEvbGliL3NhZmVfbWFj
cm9zLmMKKysrIGIvbGliL3NhZmVfbWFjcm9zLmMKQEAgLTc3NSw2ICs3NzUsMjUgQEAgaW50IHNh
ZmVfZmNob3duKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKGNsZWFu
dXBfZm4pKHZvaWQpLAogCXJldHVybiBydmFsOwogfQogCitpbnQgc2FmZV9sY2hvd24oY29uc3Qg
Y2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbikodm9pZCksCisJ
CQljb25zdCBjaGFyICpwYXRoLCB1aWRfdCBvd25lciwgZ2lkX3QgZ3JvdXApCit7CisJaW50IHJ2
YWw7CisKKwlydmFsID0gbGNob3duKHBhdGgsIG93bmVyLCBncm91cCk7CisKKwlpZiAocnZhbCA9
PSAtMSkgeworCQl0c3RfYnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywgY2xlYW51
cF9mbiwKKwkJCSJsY2hvd24oJXMsJWQsJWQpIGZhaWxlZCIsIHBhdGgsIG93bmVyLCBncm91cCk7
CisJfSBlbHNlIGlmIChydmFsKSB7CisJCXRzdF9icmttXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwg
VEVSUk5PLCBjbGVhbnVwX2ZuLAorCQkJIkludmFsaWQgbGNob3duKCVzLCVkLCVkKSByZXR1cm4g
dmFsdWUgJWQiLCBwYXRoLAorCQkJb3duZXIsIGdyb3VwLCBydmFsKTsKKwl9CisKKwlyZXR1cm4g
cnZhbDsKK30KKwogcGlkX3Qgc2FmZV93YWl0KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBs
aW5lbm8sIHZvaWQgKGNsZWFudXBfZm4pKHZvaWQpLAogICAgICAgICAgICAgICAgIGludCAqc3Rh
dHVzKQogewoKLS0gCjIuNTEuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
