Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81E0FF8875
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 08:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777452767; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Blu/qJzDQXVXsvZZaqio0Nr50uIl3WFZynUaysEe8a8=;
 b=KWbhmaGGWeLICFNWIr7Kx1SMR0HTU1k0gHFR53yU6nM9J4PSo7PLfIVxC6XJCyxgRqlne
 wtDPlKtemUE3mC00lUWxo2uhH5DGTDbvLoJsE+oljJPMH1c84dZfeWt9fthJUs++O5Vp7MJ
 cOIcdHNSWkimAXFvZA+hEjBhcJapXiM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77E7A3E2536
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:52:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EE3A3C029B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:52:23 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78A87140054B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:52:23 +0200 (CEST)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35fbca04006so6189618a91.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 01:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777452742; cv=none;
 d=google.com; s=arc-20240605;
 b=P1KEPpivfnWoUqN+Xkvj1FpZd3DX3f2S75ET1IFVGL6oi/li2Lg6+7BRuGW8yaFaOq
 z+aMa6oPqqe4ubFcDxnxOZnK/evszm8gSX/lP+IBMh5JKF6cK11cEdLuenIjj70Mhbzm
 Fb0oA9JH4gE5qlnmxKlaIZ/QeEbZ0u+CkbNtBgA2qgbyeem4d1S8lFytWGekREr8zTah
 7ukAduPO2VJeMXXOcdR21wVVIaScVYUF8gadl2JJxPRg2hY3vGRKSAcPDXaPH9CcThOT
 /YvQVmFoLYjy+ZDCqJfeoLypx0utW8iM9iJHVmrI5gMgEh6NEelEUE7HA+36GjaI6CL9
 sdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ali4lNh84g4ts8t+yvPvTEBj7UcWs408h06PEibMbuU=;
 fh=2YQYtMVmMy2j1lD0Oo2Xudl4rUQaR7oOOMixaxmfPUU=;
 b=WelXA1/6ZfXLmH42aiFmtAqpKF6+O9aonNkA45B5kyrKxZI80ujt36bI76BNO+WT3j
 3JQDr3KPcb5cMhxk4XrfdPeDlEPSyLGnI+izx+dUCFbfUzc9UdGNXWY91+5L8hRMr8F7
 QQk9j+Q12Tj4eDMN0ssc9XyR0ljzqGjppKpLTtWh7H5l2So8cNCvAg2Ng2CCIW1BcVc8
 ejCwi0i3RC+oZ0I/f0en37i93TyjbsKnVfJt1dYV+UMNogqq8LSFXFQZZS6feCwa4uLP
 L2jNeBStRperdKvcsT+U4byhWXGMW0usaWrtZYGXXOsBJbH87jk7qx2pAXvetzGT8zWu
 pqYw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777452742; x=1778057542; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ali4lNh84g4ts8t+yvPvTEBj7UcWs408h06PEibMbuU=;
 b=YOtjfAXA9oflxdXye+Iram3m4Rts35pbi25ZsMZbM5SCmcUYM5PyYYWh4T/U6KxNvh
 bIfiuB1G+PTii/mNMQAsIb/wGhMsgEg2Cp8QpZ3wZmq6pCIF+m1KNNr9YsJ823fRc+Yo
 1PDt1/vLVkVj8Dvz6vUIRG9k1LICoCkve2jNY85UBcs80mU0vSMXtcCszB8ylMMpwSal
 P322D+k9MabkgTnieMmG6VceORIQHj3rTSeZcH+AMD6JuXKE3P6rVC/BomLEJFhB5DPE
 p+52z3a0O8I8m5y3lIjvh9fruAXFwmHBdtpIZ76VNaw1LQgV5H7bvD82Ynot1khyKWNJ
 GkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452742; x=1778057542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ali4lNh84g4ts8t+yvPvTEBj7UcWs408h06PEibMbuU=;
 b=ojoKGSQJYpKmmKu7xw1J4RPSmHH6J8uYlNKbaU/6mbMybeip4fOeu01Eo+p/S8ujq4
 yQ1bEcC2XSOew9UslL+XZaZrqBHNrTy0X9OXlh+/xpSZx1L6LQlz3PEURizD0tHep4uW
 uns31ZqjFH329jpcPf6FpVA+3rJLOp75JD8E111IAYt/B8GjXYJYMGaFcQvylEPns2Om
 Yu+fo9aOEBMdcSCh9PY7/vDavYx3TQmUy4w/BvO/0Mgx7XuRHf6d7Za5Tl3DZNqfzB0A
 WyM310G3Efuh+MboArl017k51N5Fn5ummE8BvKzLhEunJaqIsklNNkmnNVmTYsRGIAt+
 YHkQ==
X-Gm-Message-State: AOJu0YwmEAtG6QMogZz+62VO2Vro/aFXSOwxFji3Bs0T/sEDNri0DKRD
 +v4WxGTPkbIwr/oXLpYRIb0zu8bb0Q+raqf3HULLEYo9j9kanEWiML2UkQNMKgsHUJFUznxlwZr
 1SLnFJXRUj9DPON5MniNVQICBYvx81lC6BESvHbVy
X-Gm-Gg: AeBDieve+8kBhBXOqUs5cYSnB4ExYMjS2zRPztUonKAVKR2xJ2MvR15RKrfytAimMWt
 joZBWvsviDrGgV4hDt/TtCVF5VcKh2G1n+09zzoH8WesMv0wY22q5v/AmDru60HXD/oeRE8mtvj
 aQnLSCYO/u2MCfFD2GPRMkqHLMSIkpfCaT6YQ3IZ8kmouuDla1NJyq7WcK5GItCAQGArABKr/y6
 Q/Ub8YvCSxvlQxh2GXkoFf68WcjOwMCw61vyssL5o49VZ0EbnW2XyvsWokwfOGrZ5ddVHvwOdOk
 q00ODLktFwqbdUlioNO1FGAQuWkQF9mXuaQhL3zrd+sGG9zHh6Mc/g18SLQ=
X-Received: by 2002:a17:90b:57cd:b0:35e:5b19:234d with SMTP id
 98e67ed59e1d1-36491fa9c69mr7150299a91.7.1777452741232; Wed, 29 Apr 2026
 01:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260429064011.3200745-1-wakel@google.com>
 <69f1aab3.5d0a0220.2e761c.6b1c@mx.google.com>
In-Reply-To: <69f1aab3.5d0a0220.2e761c.6b1c@mx.google.com>
Date: Wed, 29 Apr 2026 16:51:44 +0800
X-Gm-Features: AVHnY4Ij4VfmWQxk48yw8wHZc8moh1bxcZeTRYhHnZrDSYb8vQzIJLs9WAotyrg
Message-ID: <CAOcRiAEh+CFKBeaT+beQzhX_TRNiau4zP0iCuRFsahPkw7WhxA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/userfaultfd: Handle ENOSYS in
 SAFE_USERFAULTFD
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: camann@suse.com, rbranco@suse.com, Wake Liu via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SSBlbmNvdW50ZXJlZCB0aGlzIGlzc3VlIGR1cmluZyBBbmRyb2lkIEdLSSAoR2VuZXJpYyBLZXJu
ZWwgSW1hZ2UpIGFuZApWVFMgKFZlbmRvciBUZXN0IFN1aXRlKSB0ZXN0aW5nIG9uIHZhcmlvdXMg
ZGV2aWNlIHRhcmdldHMgKGUuZy4sIFBpeGVsCjYsIHZpcnR1YWwgZGV2aWNlcykuIEluIG91ciB0
ZXN0aW5nIGVudmlyb25tZW50LCB3ZSBydW4gdGhlIHNhbWUgdGVzdApzdWl0ZSBhZ2FpbnN0IGEg
d2lkZSB2YXJpZXR5IG9mIGtlcm5lbCB2ZXJzaW9ucyBhbmQgY29uZmlndXJhdGlvbnMuCgpTcGVj
aWZpY2FsbHksIG9uIHNvbWUga2VybmVscyB3aGVyZSBDT05GSUdfVVNFUkZBVUxURkQgaXMgZGlz
YWJsZWQsCnRoZSB1c2VyZmF1bHRmZCgpIHN5c2NhbGwgcmV0dXJucyBFTk9TWVMuIFdoaWxlIHlv
dSBtZW50aW9uZWQKdHN0X3N5c2NhbGwoKSBoYW5kbGVzIGl0LCBpbiB0aGUgdmVyc2lvbi9jb25m
aWd1cmF0aW9uIHdlIGFyZSB1c2luZywKdHN0X3N5c2NhbGwoKSByZXR1cm5zIC0xIGFuZCBzZXRz
IGVycm5vIHRvIEVOT1NZUy4gVGhpcyBpcyB0aGVuIHBhc3NlZAp0byBzYWZlX3VzZXJmYXVsdGZk
KCksIHdoaWNoIGN1cnJlbnRseSBvbmx5IGNoZWNrcyBmb3IgRVBFUk0gdG8gc2tpcAooVENPTkYp
IGFuZCBmYWxscyBiYWNrIHRvIFRCUk9LIGZvciBhbnkgb3RoZXIgZXJyb3IsIGluY2x1ZGluZyBF
Tk9TWVMuCgoKQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4g5pa8
IDIwMjblubQ05pyIMjnml6XpgLHkuIkg5LiL5Y2IMjo1MuWvq+mBk++8mgo+Cj4gSGkgV2FrZSwK
Pgo+ID4gV2hlbiBDT05GSUdfVVNFUkZBVUxURkQgaXMgbm90IGVuYWJsZWQgaW4gdGhlIGtlcm5l
bCwgdGhlIHVzZXJmYXVsdGZkCj4gPiBzeXNjYWxsIHJldHVybnMgRU5PU1lTLiBDdXJyZW50bHks
IFNBRkVfVVNFUkZBVUxURkQgY2FsbHMgdHN0X2JyayhUQlJPSykKPiA+IGZvciBhbnkgZXJyb3Ig
b3RoZXIgdGhhbiBFUEVSTSwgY2F1c2luZyB0ZXN0cyB0byBmYWlsIHdoZW4gdGhleSBzaG91bGQK
PiA+IGJlIHNraXBwZWQuCj4gPgo+ID4gQWRkIGEgY2hlY2sgZm9yIEVOT1NZUyB0byByZXR1cm4g
VENPTkYsIHNvIHRoYXQgdGVzdHMgdXNpbmcKPiA+IFNBRkVfVVNFUkZBVUxURkQgYXJlIHNraXBw
ZWQgYXBwcm9wcmlhdGVseSBvbiBrZXJuZWxzIHdpdGhvdXQKPiA+IHVzZXJmYXVsdGZkIHN1cHBv
cnQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogV2FrZSBMaXUgPHdha2VsQGdvb2dsZS5jb20+Cj4g
PiAtLS0KPiA+ICBpbmNsdWRlL2xhcGkvdXNlcmZhdWx0ZmQuaCB8IDQgKysrKwo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
YXBpL3VzZXJmYXVsdGZkLmggYi9pbmNsdWRlL2xhcGkvdXNlcmZhdWx0ZmQuaAo+ID4gaW5kZXgg
MGM5ZTM0Yzg0Li4wOTEyNmQ4NTYgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xhcGkvdXNlcmZh
dWx0ZmQuaAo+ID4gKysrIGIvaW5jbHVkZS9sYXBpL3VzZXJmYXVsdGZkLmgKPiA+IEBAIC0yNDQs
NiArMjQ0LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IHNhZmVfdXNlcmZhdWx0ZmQoY29uc3QgY2hh
ciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgaW50Cj4gPiAgcmV0cnk6Cj4gPiAgICAgICByZXQg
PSB0c3Rfc3lzY2FsbChfX05SX3VzZXJmYXVsdGZkLCBmbGFncyk7Cj4gPiAgICAgICBpZiAocmV0
ID09IC0xKSB7Cj4gPiArICAgICAgICAgICAgIGlmIChlcnJubyA9PSBFTk9TWVMpIHsKPgo+IFRo
aXMgaXMgYWxyZWFkeSBoYW5kbGVkIGluIHRoZSB0c3Rfc3lzY2FsbCgpIGltcGxlbWVudGF0aW9u
Lgo+IFRoZSBzb2x1dGlvbiB3b3VsZCBiZSB0byB1c2U6Cj4KPiBzdGF0aWMgc3RydWN0IHRzdF90
ZXN0IHRlc3QgPSB7Cj4gICAuLgo+ICAgICAgICAgLm5lZWRzX2tjb25maWdzID0gKGNvbnN0IGNo
YXIgKltdKSB7Cj4gICAgICAgICAgICAgICAgICJDT05GSUdfVVNFUkZBVUxURkQ9eSIsCj4gICAg
ICAgICAgICAgICAgIE5VTEwKPiAgICAgICAgIH0KPiB9Owo+Cj4gZm9yIGFsbCB0aGUgdGVzdHMg
d2hpY2ggbmVlZCB0aGlzIGNvbmZpZ3VyYXRpb24uCj4KPiBXaGVyZSBkaWQgeW91IHNlZSB0aGlz
IGlzc3VlPyBEbyB5b3UgaGF2ZSBhIHVzZSBjYXNlIHNjZW5hcmlvIHdoZXJlCj4gdGhpcyBoYXBw
ZW5lZD8KPgo+IEtpbmQgcmVnYXJkcywKPiAtLQo+IEFuZHJlYSBDZXJ2ZXNhdG8KPiBTVVNFIFFF
IEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKPiBhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCgoK
Ci0tIApCZXN0IFJlZ2FyZHMsCldha2UgTGl1CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
