Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1D0C369AB
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745508279; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QyQRBunFpOKp6AMZfgJJNkDQdARDbFzleV6YQs0lTo4=;
 b=ains8p4w37z0KW/8I763TXMI+EraQJgKa51L5E0QKaj3YbxWsL5dh7+EYzzYRz3CSwi8+
 hXg/2mvw9CXI24KFY5eJeRpS9ARY7cs5O0/lKqQOCqMdCerEL6nI6IS9EW3lo2NfFPVI0rZ
 KPkkyQUFFcLk8Lo+RipbLgOGRaETH4Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F17823CB38F
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 17:24:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1BB03CB17F
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 17:24:18 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6EADC200973
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 17:24:17 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso1359693f8f.0
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745508257; x=1746113057; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NTbfJQ9i7p1SR5/uZ2fdsTlGRDPZ5Q8HiILtc4q4m8=;
 b=X/otlw5+65iBNycODybHLzUlJCe872JdVyJqWqO6h6kh5x9I7WtRVZ+qSF5XoScYUt
 7KYoWx7XdX3/9sQihub6xX/8LZRPVtw0V5GKC0cz1KI/kv4mNLbNmVT2so+Cdz+DBBVD
 gqc087oJrphLaQzLbQf3gl9VsVhai/PABBVtikKsmEiVKTIzxbKK3dOoFjnhl3wavpAr
 MQ6PjBZqechtcd3LrfAJydlFzxeP/3SruP9UURvxbm6veA7lIAwRFrPzilAASoXjPHad
 r4q+fxCje39nHgcoQ6ehdLqnHnmVj52MjV4i+NOTndbCZwMvtvZbUpkenNs84CDnAA3Z
 TU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745508257; x=1746113057;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6NTbfJQ9i7p1SR5/uZ2fdsTlGRDPZ5Q8HiILtc4q4m8=;
 b=stPtlNxQIwZ5RKFSeKUqoNHVRd4EkmP60k6rv1qv8EdiDujNQ7q9yqtQNxRSBAckaT
 mYx1NDZFn9vjK4H5Q+bP0YUT1brCDQMTQS9oEsim91gfSHVfkWrpNhjQtyCiThnucfrr
 5F1McMLOFa5r/9FLcZldogVgpOCSPNWwBhezirpS2+1I6r2mwlgA0OnnIE6aDbBsb9ai
 lZ9lkgCxkyEoSihts92dpHqajy4Etl44IKbYc+QiFaVR4ERcamLqrvARwfVFE1NJhUUD
 HTOz+NjjCrIH0PJJgj8nphaytrNZWGipGbESrS/IvH9+GRw3oK85s+x51g4a3iN9emzm
 va3w==
X-Gm-Message-State: AOJu0Yydy0isFWl0cNLATczrryXPHmjCuJnxRJLzI/NDN+q7tMLPdeTm
 1uB6CdAD7a3YKvA0rmz0iJe/aEhdmWiQPf5gy8GT/OrFu06RC1Pe5Svaq4cK4Do=
X-Gm-Gg: ASbGncuIZh4FY2v2FYa8uE+NLz4AOH8m+Gx/93Qs4436IoNyRAKvR21K/ljl/O7REWN
 utOXC9SZiaLkCRpaXsK12vJ52joVdh7rdQ9z9sIvXGNJbUZj0PzmP6xRUl7zHiQf8aoSvP6sYQP
 dhiYlNKUhua+yOQ15iJfG4PzVmFQ2X1j+gY/zosEoR5Mu2EGP1S/S2apcx2MsyEsyAYhKBmH4NL
 iuUcngddjqcWRJ56HAuIc/OkCgW58hw7S2tY3LWfay1OmU8Rph0JarUWYxLD6h1VQyJGgmoWMOz
 nOkHa4o5Bmwvjc4nTPq5ZCN2bDZ3Kw==
X-Google-Smtp-Source: AGHT+IHIzMs+tC5LERWVqorFrAEherqM+v0WqFEPq8orAY7wPjY/iKrJERt6bcyCvXO0/WtUWwgt5w==
X-Received: by 2002:a5d:648c:0:b0:399:6d53:68d9 with SMTP id
 ffacd0b85a97d-3a06cfa5abdmr2820533f8f.38.1745508256637; 
 Thu, 24 Apr 2025 08:24:16 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db50e89acsm14808915ad.113.2025.04.24.08.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 08:24:16 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 24 Apr 2025 12:24:11 -0300
Message-Id: <D9EZ18JNUXD4.179NXEJRFHACL@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250409-fix_make_clean-v3-0-a33a84b2be05@suse.com>
 <20250409-fix_make_clean-v3-2-a33a84b2be05@suse.com>
 <20250423072923.GA969000@pevik>
In-Reply-To: <20250423072923.GA969000@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] include/Makefile: Fix cleaning targets
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
Cc: Joerg
 Vehlow <joerg.vehlow@aox-tech.de>, Joerg Vehlow <joerg.vehlow@aox.de>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gUGV0ciEKCk9uIFdlZCBBcHIgMjMsIDIwMjUgYXQgNDoyOSBBTSAtMDMsIFBldHIgVm9y
ZWwgd3JvdGU6Cj4gSGkgUmljYXJkbywKPgo+IFsgQ2MgSm9lcmcsIHdobyB0b3VjaGVkIGJ1aWxk
IHN5c3RlbSBpbiB0aGUgcGFzdC4gXQo+Cj4+IEFkZCBhYy1jbGVhbiB0YXJnZXQgYXMgZGVwZW5k
ZW5jeSBvZiBhYy1tYWludGFpbmVyLWNsZWFuIGFuZCBhZGQgbWlzc2luZwo+PiBmaWxlcyB0byB0
aGUgcmVtb3ZhbCBsaXN0LiBUaGlzIHdheSB0aGUgcHJvamVjdCB0b3AgbGV2ZWwgTWFrZWZpbGUg
Y2xlYW5pbmcKPj4gdGFyZ2V0cyBjYW4gbWFrZSB1c2Ugb2YgaXQuIEFsc28sIGFkZCAiY29tcGls
ZSIgdG8gdGhlIEFVVE9NQUtFX0ZJTEVTCj4+IGxpc3QuCj4KPiBuaXQ6IFlvdSBhbHNvIHJlbW92
ZSBzdGFtcC1oMSBmcm9tIEFVVE9NQUtFX0ZJTEVTLiBXaHk/IERpZCBJIHN1Z2dlc3QgdGhhdD8K
PiBJdCdzIGNyZWF0ZWQgYnkgY29uZmlndXJlIChlLmcuIG5vdCBhdXRvbWFrZSksIGJ1dCBJIGNv
bnNpZGVyZWQgQVVUT01BS0VfRklMRVMKPiBob2xkaW5nIGZpbGVzIGNyZWF0ZWQgYnkgYXV0b3Rv
b2xzLgo+CgpJbmRlZWQsIGZyb20gbXkgbG9jYWwgdGVzdGluZyB0aGUgb25seSBzdGFtcC1oMSBj
cmVhdGVkIGJ5IGNvbmZpZ3VyZSBpcwppbiBpbmNsdWRlLyBkaXJlY3RvcnksIHdoaWNoIGlzIHdo
eSBJIGFkZGVkIGl0IHRvIGluY2x1ZGUvTWFrZWZpbGUuIElzCnRoZSB0b3AtbGV2ZWwgc3RhbXAt
aDEgc3RpbGwgY3JlYXRlZCBzb21laG93LCBlLmcuIHVzaW5nIGFuIG9sZGVyCnZlcnNpb24gb2Yg
YXV0b21ha2U/IEkgZGlkbid0IGNoZWNrLgoKPj4gQ2M6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4gRllJOiB3ZSB1c3VhbGx5IGRvbid0IGtlZXAgQ2M6IGlu
IHRoZSBjb21taXQgbWVzc2FnZSAoZ2l0IGZvcm1hdC1wYXRjaCAtLWNjIC4uLgo+IG9yIGdpdCBz
ZW5kLWVtYWlsIC0tY2MgLi4uIGhhcyB0aGUgc2FtZSBlZmZlY3QgLSBzZW5kaW5nIG1haWwsIGJ1
dCBkb24ndAo+IHByZXNlcnZlIGl0KS4gT2YgY291cnNlIGl0IGNhbiBzdGF5LiBJIHBlcnNvbmFs
bHkgc2VlIG1vcmUgdmFsdWUgd2l0aCBhZGRpbmcKPiBMaW5rOiB0YWcgdG8gcGF0Y2ggaW4gbG9y
ZSAoZm9yIHRoZXNlIHdobyB3YW50L25lZWQgdG8gZGlnIGluIGhpc3RvcnkpLgo+CgpXaGVuIHdv
cmtpbmcgb24gYSBzZXJpZXMgbGlrZSB0aGlzLCB5b3UgY2FuIHRhZyBpbmRpdmlkdWFsIGNvbW1p
dHMgc28KdGhhdCBgYjRgIHRha2VzIGNhcmUgb2Ygc2VuZGluZyBpdCB0byB0aGUgcmVsZXZhbnQg
cGFydGllcy4gQWRkaW5nIGl0IHRvCnRoZSBjb3ZlciBsZXR0ZXIgd2lsbCBzZW5kIHRoZSB3aG9s
ZSBzZXJpZXMgdG8gdGhlbS4gQnV0IEkgZ3Vlc3Mgd2UKZG9uJ3QgbmVlZCB0aGF0IHRhZyBhbnl3
YXkgZHVlIHRvIGxvdyB0cmFmZmljIGluIExUUCBNTC4gSSdsbCBkcm9wIGl0LgoKPj4gRml4ZXM6
IDgxN2Q4MDk1ZmJmZSAoIlJlbmFtZSBsaW51eF9zeXNjYWxsX251bWJlcnMuaCB0byBsYXBpL3N5
c2NhbGxzLmgiKQo+PiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4+
IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4+IC0t
LQo+Cj4+IE5PVEU6IFRoZSAiY29tcGlsZSIgZmlsZSBpcyBhZGRlZCBkdXJpbmcgdGhlIGF1dG90
b29scyB0YXJnZXQ6Cj4+ICQgbWFrZSBhdXRvdG9vbHMKPj4gPHNuaXA+Cj4+IGNvbmZpZ3VyZS5h
YzoyNjogaW5zdGFsbGluZyAnLi9jb21waWxlJwo+PiBjb25maWd1cmUuYWM6MjQ6IGluc3RhbGxp
bmcgJy4vY29uZmlnLmd1ZXNzJwo+PiBjb25maWd1cmUuYWM6MjQ6IGluc3RhbGxpbmcgJy4vY29u
ZmlnLnN1YicKPj4gY29uZmlndXJlLmFjOjc6IGluc3RhbGxpbmcgJy4vaW5zdGFsbC1zaCcKPj4g
Y29uZmlndXJlLmFjOjc6IGluc3RhbGxpbmcgJy4vbWlzc2luZycKPj4gPHNuaXA+Cj4+IC0tLQo+
PiAgaW5jbHVkZS9NYWtlZmlsZSAgICAgICB8ICA0ICsrLS0KPj4gIGluY2x1ZGUvbWsvYXV0b21h
a2UubWsgfCAxMCArKysrLS0tLS0tCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkKPgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9NYWtlZmlsZSBiL2lu
Y2x1ZGUvTWFrZWZpbGUKPj4gaW5kZXggMjVlOTZkZjliOGNkZDdkMWQ3ZTZmMTk5MjViZjIxNjBk
NjgyZjBkOS4uNmIzMWIwNDZlNDUyZTcxYWZiNTA5N2NjM2ZhZGY4YWYwMTI4MjYyOSAxMDA2NDQK
Pj4gLS0tIGEvaW5jbHVkZS9NYWtlZmlsZQo+PiArKysgYi9pbmNsdWRlL01ha2VmaWxlCj4+IEBA
IC0xOCw4ICsxOCw4IEBAIE1BS0VfVEFSR0VUUwkJOj0KPj4gIGRpc3RjbGVhbjo6IGNsZWFuIGFj
LWRpc3RjbGVhbgo+PiAgbWFpbnRhaW5lci1jbGVhbjo6IGRpc3RjbGVhbiBhYy1tYWludGFpbmVy
LWNsZWFuCj4+ICBhYy1jbGVhbiBhYy1kaXN0Y2xlYW46Ogo+PiAtCSQoUk0pIC1mIGNvbmZpZy5o
Cj4+IC1hYy1tYWludGFpbmVyLWNsZWFuOjoKPj4gKwkkKFJNKSAtZiBjb25maWcuaCBsYXBpL3N5
c2NhbGxzLmggc3RhbXAtaDEKPj4gK2FjLW1haW50YWluZXItY2xlYW46OiBhYy1jbGVhbgo+PiAg
CSQoUk0pIC1mIGNvbmZpZy5oLmluCj4KPj4gIHZwYXRoICUuaCAkKGFic19zcmNkaXIpCj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL21rL2F1dG9tYWtlLm1rIGIvaW5jbHVkZS9tay9hdXRvbWFrZS5t
awo+PiBpbmRleCAzZGYzYjRiYTk5Y2E4NjVjYWE4OTM4ODk5OWU1M2NiYzUwMDYxNWRjLi4zYjI0
OGFjOTU3NWE2MTNjNjk1ZGU3ZWMyMmM0MjdkNGU5N2RhMzlmIDEwMDY0NAo+PiAtLS0gYS9pbmNs
dWRlL21rL2F1dG9tYWtlLm1rCj4+ICsrKyBiL2luY2x1ZGUvbWsvYXV0b21ha2UubWsKPj4gQEAg
LTQ1LDcgKzQ1LDcgQEAgbTQvbHRwLXZlcnNpb24ubTQ6IFZFUlNJT04KPj4gIAlzZWQgLW4gJzF7
czpMVFAtOm00X2RlZmluZShbTFRQX1ZFUlNJT05dLFs6O3M6JCQ6XSk6O3A7cX0nICQ8ID4gJEAK
Pgo+PiAgLlBIT05ZOiBhdXRvbWFrZQo+PiAtQVVUT01BS0VfRklMRVMgOj0gY29uZmlnLmd1ZXNz
IGNvbmZpZy5zdWIgaW5zdGFsbC1zaCBtaXNzaW5nIHN0YW1wLWgxCj4+ICtBVVRPTUFLRV9GSUxF
UyA6PSBjb21waWxlIGNvbmZpZy5ndWVzcyBjb25maWcuc3ViIGluc3RhbGwtc2ggbWlzc2luZwo+
PiAgYXV0b21ha2U6IGFjbG9jYWwgJChBVVRPTUFLRV9GSUxFUykKPj4gICQoQVVUT01BS0VfRklM
RVMpOiBtNC9NYWtlZmlsZS5pbgo+PiAgbTQvTWFrZWZpbGUuaW46IG00L01ha2VmaWxlLmFtIGFj
bG9jYWwubTQKPj4gQEAgLTU1LDE5ICs1NSwxNyBAQCBtNC9NYWtlZmlsZS5pbjogbTQvTWFrZWZp
bGUuYW0gYWNsb2NhbC5tNAo+PiAgYWMtY2xlYW46Ogo+PiAgCSQoUk0pIC1yZiBhdXRvbTR0ZS5j
YWNoZQo+PiAgCSQoUk0pIC1mIGNvbmZpZy5sb2cgY29uZmlnLnN0YXR1cwo+PiAtCSQoUk0pIC1m
IGluY2x1ZGUvY29uZmlnLmggaW5jbHVkZS9zdGFtcC1oMQo+PiAgCSQoUk0pIC1mIG00L01ha2Vm
aWxlIG00L2x0cC12ZXJzaW9uLm00Cj4+IC0JZm9yIGQgaW4gJChBVVRPQ09ORkVEX1NVQkRJUlMp
OyBkbyBcCj4+ICsJZm9yIGQgaW4gJChBVVRPQ09ORkVEX1NVQkRJUlMpIGluY2x1ZGU7IGRvIFwK
PiBuaXQ6IFdvdWxkbid0IGJlIGJldHRlciB0byBoYXZlIGFub3RoZXIgdmFyaWFibGUgd2hpY2gg
d291bGQgYmUgdXNlZCBpbiBmb3IgbG9vcHM/Cj4KPiBDTEVBTl9TVUJESVJTID0gJChBVVRPQ09O
RkVEX1NVQkRJUlMpIGluY2x1ZGUKPgoKQWdyZWVkLgoKPj4gIAkgICAgJChNQUtFKSAtQyAiJCh0
b3Bfc3JjZGlyKS8kJGQiICRAOyBcCj4+ICAJZG9uZQo+Cj4+ICBhYy1kaXN0Y2xlYW46OiBhYy1j
bGVhbgo+PiAgYWMtbWFpbnRhaW5lci1jbGVhbjo6IGFjLWRpc3RjbGVhbgo+PiAtCWZvciBkIGlu
ICQoQVVUT0NPTkZFRF9TVUJESVJTKTsgZG8gXAo+PiArCWZvciBkIGluICQoQVVUT0NPTkZFRF9T
VUJESVJTKSBpbmNsdWRlOyBkbyBcCj4+ICAJICAgICQoTUFLRSkgLUMgIiQodG9wX3NyY2Rpcikv
JCRkIiAkQDsgXAo+PiAgCWRvbmUKPj4gIAkkKFJNKSAtZiBhY2xvY2FsLm00IGNvbmZpZ3VyZSAk
KEFVVE9NQUtFX0ZJTEVTKSBtNC9NYWtlZmlsZS5pbgo+PiAtCSQoUk0pIC1mIGluY2x1ZGUvKmNv
bmZpZy5oLmluCj4KPj4gICMgRG9uJ3QgaW5jbHVkZSBjb25maWcuaCwgb3IgbWFrZSB3aWxsIChy
aWdodGZ1bGx5KSB3aGluZSBhYm91dCBvdmVycmlkaW5nCj4+ICAjIHJ1bGVzLgo+PiBAQCAtODIs
NyArODAsNyBAQCBBVVRPR0VORVJBVEVEX0ZJTEVTCT0gXAo+PiAgCQkJbTQvTWFrZWZpbGUKPgo+
PiAgZGlzdGNsZWFuOjogJTogY2xlYW4gYWMtZGlzdGNsZWFuCj4+IC0JZm9yIGQgaW4gJChBVVRP
Q09ORkVEX1NVQkRJUlMpOyBkbyBcCj4+ICsJZm9yIGQgaW4gJChBVVRPQ09ORkVEX1NVQkRJUlMp
IGluY2x1ZGU7IGRvIFwKPj4gIAkgICAgJChNQUtFKSAtQyAiJCh0b3Bfc3JjZGlyKS8kJGQiICRA
OyBcCj4+ICAJZG9uZQo+PiAgCSQoUk0pIC1mICQoQVVUT0dFTkVSQVRFRF9GSUxFUykKCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
