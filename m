Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A186FF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777454638; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nAOmP6PZGUD+4GeYKT2dX9Je156gFZWsxRpMNQgaptM=;
 b=ZEV8HeASAxuYYiGBND96mmwa5KjAcajlPWZC8ZN2uN18ybceVyiOehC2FRHxQib5qkZSt
 lCe00Tkp44SoWXfkzrF4GNvN7wtfLnmoLekHbXz1EFnLgOhJ1liWaMEfs6rJGdyzmJNI0F/
 LC5kJ9iZ2eQRJEqq+LnLpSaQkNET4dU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 252AB3CBDC7
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 11:23:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 094133CBDC7
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 11:23:34 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A88666007A2
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 11:23:32 +0200 (CEST)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c7ec83fff7fso292252a12.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 02:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777454611; cv=none;
 d=google.com; s=arc-20240605;
 b=Fk4sOeWj8yMgel+Ye+NDsMUrKwELJlz+xPXgHbR4xWeZ+mOwA4bAjhzTdfvIF32Rg5
 BbAyCIdPJM1FynEbSluT9g7REAB08Xic6Y3ym04gaudhC802r/GzeygXXZMAFYQNKCj+
 xdnrwX8n4CQ0KFrlxZBot565KBR5wZSu22Ihv9SdM4va9Hk+trOQohnlk/2CudMSQ/Gh
 TkWYXX26R1wnbjF13f/iU3MbLm/y/srnOvt4+cio5OV9tilXhbCEOXAuza5DqyO4hr7A
 E27nGBKdK4hspSPYPlsfmoodIR6MWnWarq5FjNHMe04JbCQETnVJVOR5EL671NKg8And
 cqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aqEEWCxwkNtqhJJ5eQBNqs4E057ulboZ5lKuVzQ785Y=;
 fh=m40UBVrR3nZgKdVqXyBfj/+kwMsS69fSxi2566YNWCw=;
 b=ebTF0GY+uFB2SirLmZFwbVGptmDpSRSMRi/nxjK3ZWfbrc8HBVPINCWF6M7VtZkRAj
 qzrlqXWnsI+J/Cwb0Eut58qDQ5D4KkpzMPeYnVBQNDbD+8kfDoMVPpW8SFpdEosF9IF4
 1VBn+JumzvAVUFa9zAyqh3gbw5l3my9J/oBhUsW9s4MP869fvTiJljIbqOpNFVEdmVNS
 LmOgN2hlpWldOwPSCZeRyqoW9CVtnIZ6XCgHq6kF83DrgepGmtMt9wQV6acXo/IDdY8/
 j+Hpzec8o0ggC9c4dpQAco/v5NCO6+qdqETQLHNL2QhnpERBZjI3aPycMqIYhn0+Crrg
 M1kQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777454611; x=1778059411; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqEEWCxwkNtqhJJ5eQBNqs4E057ulboZ5lKuVzQ785Y=;
 b=WUMkkVZMtY4DwVlT56AFIUjiGsAaW/pz12kVbYahGfdsq0O7mdhVwmrqNFYpB8k4/T
 BVGn46m7Ipzq/F/srwUwAAPm6JPVcWcyakpyWK/DNs8acdWxCSUL4gHs3uZdUSjbZL0l
 zQlThxR+XYL0GGyGUW9oPevFvfGZdZxxQkj2qsxICIxTesZOF7IsVXY3XcqDYHZ8Szhv
 s5enKStX1xf+9Ok5AfIE7n9KqzEBqrLnL3o4crjFw6aXtpMtCdNpRcAruPNOZZlqjBA+
 m3dE9XHgX5HOZm0U8GCwzY3Z0UzndRbjTvSzfpeOKosW3QIlajPhg3UCADY1Q6+lfMBi
 s7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777454611; x=1778059411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aqEEWCxwkNtqhJJ5eQBNqs4E057ulboZ5lKuVzQ785Y=;
 b=naMokVTPkkthfCsxn8DRi8i8AEHwhRcG5E6iPEawffZ2MhsnKxGJtdJ/uBRJoMqVnP
 hLTOVaw76x1P4eYtYB97vFc1lFugiuzj5wOeLdeKXBjTL9GwJDXZbZplMSIlDgXvXKSf
 +lhxAL4oqvqWR29A5UmPWSN3G5B3y8MniUUWsOjIUkvouka9nkmLUEib4+dqBLjS9GZr
 6RZB3VIOWGJRNrjNELXYjaBYY2Zq4QyQSzRFW2r9Q6CAbe3F19bXAtzK5afA8AdawNPy
 n6lmPdP+yh6arMh65PisMJWk/IU6aAy/sjSbZLeF3qe95g3rmgbERy3cead9ehtHyY7K
 4eow==
X-Gm-Message-State: AOJu0YwvCXUrNC/HWe9yEUQahE0BemUaX5Xzgdqqo5xwzw/DMkLqNWa8
 FR5Fwz+/acR6Nn7/9oCALZHqm3UIVCuFD1HFKxE4RhgJbpzroSoHDuRz8ddcynhDqk/c0eNWawb
 OVf/C8CHU8xMGc63V8p9tKc5NSFFgyEn9e28zVwgV
X-Gm-Gg: AeBDietVM4fnz7Yh8dj/EqNYWV8+mnkHJMNgZTW3ahJl3yKzac+WvCt1vIy04UgGx/h
 QL2J2ZcCaoOUKJz4h2/T+Cr1g6qCZOptwXgMHQpVZucyhAOCx1/RFjCjFuUMlj36q41DGxdUJiA
 poi9WroVtkU72aaUuW/bHUNfX3xJOvPOzwgVPFWJ8E6jR1KD9S8yHraAdXlMvgHi1tSMXqpjhGR
 XwGq2F/f9Uf5Qdm6omgYdTJq2AF3dI2/aROo+mJjAPPE2YJ3hVgxwQetg3o/I34J+k6SuI0neGS
 25iCKP6ZCkTCfMhtMBjiPV+gtDqg4Iq/PotZdI923z89I9PJkby5mAolTAA=
X-Received: by 2002:a17:90b:2fce:b0:356:21e9:73ff with SMTP id
 98e67ed59e1d1-364a268fa67mr1910687a91.11.1777454610509; Wed, 29 Apr 2026
 02:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260429062650.3191021-1-wakel@google.com>
 <20260429073433.4027-1-linuxtestproject.agent@gmail.com>
In-Reply-To: <20260429073433.4027-1-linuxtestproject.agent@gmail.com>
Date: Wed, 29 Apr 2026 17:22:53 +0800
X-Gm-Features: AVHnY4IXVo5UY29fbBE6B8URzl29zKuZcRifZiHavbp9Y5CEx4PnQrA9ywbuXp4
Message-ID: <CAOcRiAFuQgk0zYzJCv-CQEV5kxZCbhyqQ2eTzc2henotB7njPw@mail.gmail.com>
To: linuxtestproject.agent@gmail.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/file_attr01: Dynamically expect EOPNOTSUPP on
 tmpfs without xattr
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UmVnYXJkaW5nIHRoZSB2YWxpZGF0aW9uIG9yZGVyIG9mIHVzaXplOiBJIGhhdmUgdmVyaWZpZWQg
dGhhdCB1c2l6ZQp2YWxpZGF0aW9uIChFSU5WQUwvRTJCSUcpIG9jY3VycyBiZWZvcmUgdGhlIGZp
bGVzeXN0ZW0gc3VwcG9ydCBjaGVjawppbiB0aGUga2VybmVsLiBUaGlzIGlzIGNvbmZpcm1lZCBi
eSB0aGUgTFRQIHRlc3QgcmVzdWx0cyBvbiBhIGtlcm5lbAp3aXRoIENPTkZJR19UTVBGU19YQVRU
Uj1uLgoKPGxpbnV4dGVzdHByb2plY3QuYWdlbnRAZ21haWwuY29tPiDmlrwgMjAyNuW5tDTmnIgy
OeaXpemAseS4iSDkuIvljYgzOjM05a+r6YGT77yaCj4KPiBIaSBXYWtlLAo+Cj4gT24gV2VkLCAy
OSBBcHIgMjAyNiwgV2FrZSBMaXUgd3JvdGU6Cj4gPiBzeXNjYWxscy9maWxlX2F0dHIwMTogRHlu
YW1pY2FsbHkgZXhwZWN0IEVPUE5PVFNVUFAgb24gdG1wZnMgd2l0aG91dCB4YXR0cgo+Cj4gPiAr
ICAgICBpZiAodGMtPnVmYXR0ciA9PSAoc3RydWN0IGZpbGVfYXR0ciAqKikoJm51bGxfcHRyKSAm
JiBtaXNzaW5nX3RtcGZzX3hhdHRyKQo+ID4gKyAgICAgICAgICAgICBleHBfZXJybm8gPSBFT1BO
T1RTVVBQOwo+Cj4gVGhlIG92ZXJyaWRlIGlzIHNjb3BlZCBvbmx5IHRvIHRoZSBudWxsLXVmYXR0
ciB0Y2FzZS4gVGhlIGNvbW1pdCBtZXNzYWdlIHNheXMKPiB0aGUga2VybmVsIGNoZWNrcyB4YXR0
ciBzdXBwb3J0ICJiZWZvcmUgZGVyZWZlcmVuY2luZyB0aGUgdXNlciBwb2ludGVyIiwgd2hpY2gK
PiByYWlzZXMgdGhlIHF1ZXN0aW9uIG9mIHdoZXRoZXIgdXNpemUgdmFsaWRhdGlvbiAoRUlOVkFM
L0UyQklHIHRjYXNlcykgYWxzbwo+IG9jY3VycyBhZnRlciB0aGUgc3VwcG9ydCBjaGVjay4gSWYg
c28sIHRob3NlIHRjYXNlcyB3b3VsZCBhbHNvIHJldHVybgo+IEVPUE5PVFNVUFAgb24gdG1wZnMg
d2l0aG91dCB4YXR0ciBhbmQgbmVlZCB0aGUgc2FtZSB0cmVhdG1lbnQuIFBsZWFzZSBjbGFyaWZ5
Cj4gdGhlIGtlcm5lbCdzIHZhbGlkYXRpb24gb3JkZXIgZm9yIHVzaXplIHJlbGF0aXZlIHRvIHRo
ZSB4YXR0ciBzdXBwb3J0IGNoZWNrLgo+Cj4gPiBDaGFuZ2VzIGluIHYzOgo+IFsuLi5dCj4gPiBD
aGFuZ2VzIGluIHYyOgo+IFsuLi5dCj4KPiBWZXJzaW9uIGNoYW5nZWxvZ3Mgc2hvdWxkIGJlIHN0
cmlwcGVkIGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlIGJlZm9yZSBtZXJnaW5nOwo+IHRoZXkgYmVs
b25nIGluIHRoZSBjb3ZlciBsZXR0ZXIgb25seS4KPgo+IC0tLQo+IE5vdGU6Cj4KPiBPdXIgYWdl
bnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUgZnVsbCByZXZpZXcgY2Fu
IGJlCj4gZm91bmQgYXQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRw
LWFnZW50L2FjdGlvbnMvcnVucy8yNTA5NjEzOTQwMAo+Cj4gVGhlIGFnZW50IGNhbiBzb21ldGlt
ZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCj4gZmluZGluZ3Mg
YXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQo+
IGNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dlc3Rpb25zLgo+Cj4gUmVnYXJk
cywKPiBMVFAgQUkgUmV2aWV3ZXIKCgoKLS0gCkJlc3QgUmVnYXJkcywKV2FrZSBMaXUKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
