Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DDBC87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 03:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754537915; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9DlMT3vlb5EuHkb8YG65myvkF4J0H4pZJUhS5Fp4V3o=;
 b=FNvH3lS0nE2D4h66fVAUrsXJyi/WYVDeg6ZSCG2xrRDnMNmxyjJXnXCKo4GOVlHW3c4e/
 ohjzrkmHA5nZf/LUC1Xr3JEPk1U9lXr0FaCB+ASUsnumsvu4ZpKkYrsxHApbJ2fLEZRCM0R
 J0ti+X2TpOcZV7hmAy3o1wk4F7fI5zg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB6B93C8CE8
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 05:38:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 843AF3C008D
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 05:38:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0F7F460085B
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 05:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754537891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jfY8ActhC0ELUxgqATAim5LRDMvTThlAYjPzBw0HKjI=;
 b=FIe2Tvneh5X0eeQXv2YZZ93RhD/gatiq8zrtuphKMsl8Ox/5HV6BB82zj2qqxHorNfhByU
 Ud8pMKLLENyL/rD3ESRzVxIDF+Oz19ViWYXnjJqvnOw0PgsqpTroPSWbNHjHX+QM6lyZzu
 tn1jaPbaJPuzcyfSIQ6sYY9uSIsWB+Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-IJWFflQNOxmE8NnTZnDKeg-1; Wed, 06 Aug 2025 23:38:08 -0400
X-MC-Unique: IJWFflQNOxmE8NnTZnDKeg-1
X-Mimecast-MFC-AGG-ID: IJWFflQNOxmE8NnTZnDKeg_1754537886
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2425364e0b2so5644965ad.1
 for <ltp@lists.linux.it>; Wed, 06 Aug 2025 20:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754537886; x=1755142686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfY8ActhC0ELUxgqATAim5LRDMvTThlAYjPzBw0HKjI=;
 b=hlM0Fbkkb73zPn46RKUmqItk2KdzGRlA0WZYlzjI9Eu5CV8IVu8poy0JLCLiPyC5h7
 AXV1wUnYcuGMAQLXj4ZK1AT/wpDmtDxviQxnte/hXY17ONDAAxZC/jbTcIWicScNqXhA
 KDAPy/7YQzpHnsLs/7FhO00fl/Ps/oY3zZR0pP2nyxHKUH4SkODhITmP42tBdyhRpcO0
 R1dgdmZSJJb46dVyIbh6bVxiJmOSXXCBcUEodR3MfMllxDZAtuxnbqzc4yj1SvIM/Ke9
 USoDXwbYV1J+svs63JYHHcTHFEuJD1oEG5Ljkvx5Fq+CIgEF0uwexqOFZXZKfPxsVe1w
 3XgA==
X-Gm-Message-State: AOJu0YzS5Kc0r2lsvwQSBc6uyrfX6baCNleIS4wcBuL1ZRNt5QdrRUga
 hfvscGlEQUiqnjmBwKL50c6SwP7l93fnLRyBobkp0y7WG5qLpGLekLI2dZLYScsPALgUoBjqOmI
 XXwvWvSHS51OYoun/nd4WDS/d8S5ewfsJVbN0zCd6sAeEUM1DYQBzazNwavMAc0URzCXNTWSaE2
 dla2q6RRSg4Y39J6J9QMqqKzT+bKU=
X-Gm-Gg: ASbGncsS7Us3Bo5b0qWX7zlQBSjbDjn/PCT9qCQo4YY+FlrXqm/xekN6HRwbz5zDoD0
 4DZ8p7j5l8PunDl7Gs0iIjv4APG+0SkmXnbuY3aGUzVJRzqibNGXP3XlZAM6b5WimJoey3nDPXH
 05E1kCKWwDiCNybO3h5vCixw==
X-Received: by 2002:a17:902:fc48:b0:23f:f074:415e with SMTP id
 d9443c01a7336-2429f2fcddamr61901305ad.14.1754537886376; 
 Wed, 06 Aug 2025 20:38:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExJyx5iUyS/415fw/EiPHUbXkYUKluXyxCH/Bi7jnmc6BHvD+5BS1M+WhKPzc1C5McRE0iM4GtRQu2Ia0Bq28=
X-Received: by 2002:a17:902:fc48:b0:23f:f074:415e with SMTP id
 d9443c01a7336-2429f2fcddamr61900975ad.14.1754537885872; Wed, 06 Aug 2025
 20:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250806211420.445452-1-pvorel@suse.cz>
 <20250806211420.445452-2-pvorel@suse.cz>
In-Reply-To: <20250806211420.445452-2-pvorel@suse.cz>
Date: Thu, 7 Aug 2025 11:37:53 +0800
X-Gm-Features: Ac12FXwpYfLno6aPyS6lKK6ed0mBuTCJb-O9yr6rsdc6S8Bn_gedgl-hcGd_THo
Message-ID: <CAEemH2cG1+_UD02Hp5oSNXkhirNjn6drH=eL-4X55ZOqi8P8BA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G3zqbrJTBo21fMGGQuWHvjiSxEf0-fMW5Z2PJe8PH54_1754537886
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
 error
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBdWcgNywgMjAyNSBhdCA1OjE04oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBLZXJuZWwgbW9kdWxlcyBkZWxpYmVyYXRlbHkgbm90IGZhaWwgb24gZXJy
b3IgZHVlIGtBQkkKPiAoTGludXggS2VybmVsIERyaXZlciBJbnRlcmZhY2UpIG5vdCBiZWluZyBz
dGFibGUgWzFdLgo+Cj4gQnV0IHRoYXQgYWxzbyBzaWxlbnRseSBoaWRlcyBtb2R1bGVzIG5vdCBi
ZWluZyBidWlsZCBkdWUgY2hhbmdlCj4gKExUUCBtb2R1bGUgbmVlZHMgdG8gYmUgdXBkYXRlZCkg
b3IgZGlzdHJvIGJ1Zy4KPgo+IEludHJvZHVjZSBGT1JDRV9NT0RVTEVTPTEgdmFyaWFibGUgZm9y
IG1ha2UgdG8gZm9yY2UgZmFpbCBvbiBlcnJvci4KPiBUaGlzIGNhbiBoYXBwZW4gaWYKPiAqIHBh
Y2thZ2UgZm9yIGJ1aWxkaW5nIGtlcm5lbCBtb2R1bGVzIGlzIG5vdCBpbnN0YWxsZWQKPiAqIExU
UCBrZXJuZWwgbW9kdWxlIGVycm9yIG1lbnRpb25lZCBhYm92ZQo+Cj4gJCBtYWtlIG1vZHVsZXMg
Rk9SQ0VfTU9EVUxFUz0xCj4gQnVpbGQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9maW5pdF9t
b2R1bGUKPiAgQ2hlY2sgdGhhdCBwYWNrYWdlIGZvciBidWlsZGluZyBrZXJuZWwgbW9kdWxlcyBm
b3IgNi42LjE1LWFtZDY0IGlzCj4gaW5zdGFsbGVkIGFuZCB0cnkgYWdhaW4uCj4gICogb3BlblNV
U0UvU0xFUzoga2VybmVsLWRlZmF1bHQtZGV2ZWwKPiAgKiBGZWRvcmEvUkhFTDoga2VybmVsLWRl
dmVsL2tlcm5lbC1oZWFkZXJzCj4gICogRGViaWFuL1VidW50dTogbGludXgta2J1aWxkCj4gIFlv
dSBjYW4gYnVpbGQgYW55d2F5IGJ5IG9taXR0aW5nIEZPUkNFX01PRFVMRVM9MS4gIFN0b3AuCj4g
Li4uCj4KPiBOT1RFOiBwcmV2aW91c2x5IGFkZGVkICdtb2R1bGVzJyBtYWtlIHRhcmdldCBrZWVw
cyB0cnlpbmcgdG8gYnVpbGQgYWxsCj4gbW9kdWxlcyAoZG9uJ3Qgc3RvcCBvbiBmaXJzdCBlcnJv
cikuCj4KPiBbMV0gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9zdGFibGUtYXBpLW5v
bnNlbnNlLmh0bWwKPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
Pgo+IC0tLQo+IE5ldyBpbiB2Mwo+Cj4gIElOU1RBTEwgICAgICAgICAgICAgIHwgIDYgKysrKysr
Cj4gIGluY2x1ZGUvbWsvbW9kdWxlLm1rIHwgMjEgKysrKysrKysrKysrKysrKysrKystCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL0lOU1RBTEwgYi9JTlNUQUxMCj4gaW5kZXggMTBjMTlkNDEwNS4uN2MyNWMyMzM0NyAx
MDA2NDQKPiAtLS0gYS9JTlNUQUxMCj4gKysrIGIvSU5TVEFMTAo+IEBAIC0xNzIsOSArMTcyLDE1
IEBAIExUUCBjb250YWlucyBmZXcga2VybmVsIG1vZHVsZXMgYW5kIHRlc3RzIHdoaWNoIGFyZQo+
IHVzaW5nIHRoZW0uCj4gIFRoZXNlIHJlcXVpcmUgdG8gYmUgYnVpbHQgd2l0aCB0aGUgc2FtZSBr
ZXJuZWwgaGVhZGVycyBhcyB0aGUgcnVubmluZwo+IGtlcm5lbCAoU1VUKS4KPiAgU29tZXRpbWVz
IHRoZSBiZXN0IHdheSB0byBhY2hpZXZlIHRoaXMgaXMgdG8gY29tcGlsZSB0aGVtIG9uIHRoZSBT
VVQuCj4KPiArRHVlIExpbnV4IEtlcm5lbCBEcml2ZXIgSW50ZXJmYWNlIHVuc3RhYmlsaXR5IFsx
XSwgZXJyb3IgZHVyaW5nIGJ1aWxkaW5nCj4ga2VybmVsCj4gK21vZHVsZXMgZG9lcyBub3QgYnJl
YWsgdGhlIGJ1aWxkLiBNYWtlIGVycm9ycyBmYXRhbCBjYW4gYmUgZG9uZSBieQo+IEZPUkNFX01P
RFVMRVM9MQo+ICttYWtlIHZhcmlhYmxlLgo+ICsKPiAgJ21vZHVsZXMnLCAnbW9kdWxlcy1jbGVh
bicgYW5kICdtb2R1bGVzLWluc3RhbGwnIG1ha2UgdGFyZ2V0cyBhcmUKPiBzaG9ydGN1dHMKPiAg
dG8gYnVpbGQganVzdCB0aGVzZSBtb2R1bGVzIGFuZCB0ZXN0cy4KPgo+ICtbMV0gaHR0cHM6Ly9k
b2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9zdGFibGUtYXBpLW5vbnNlbnNlLmh0bWwpCj4gKwo+ICBB
bmRyb2lkIFVzZXJzCj4gIC0tLS0tLS0tLS0tLS0KPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL21r
L21vZHVsZS5tayBiL2luY2x1ZGUvbWsvbW9kdWxlLm1rCj4gaW5kZXggYzNjYmY5YzIxZi4uNjUw
NTRhZTUwMiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL21rL21vZHVsZS5tawo+ICsrKyBiL2luY2x1
ZGUvbWsvbW9kdWxlLm1rCj4gQEAgLTEsMTQgKzEsMjIgQEAKPiAgIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICAjIENvcHlyaWdodCAoYykgMjAxMyBPcmFjbGUg
YW5kL29yIGl0cyBhZmZpbGlhdGVzLiBBbGwgUmlnaHRzIFJlc2VydmVkLgo+IC0jIENvcHlyaWdo
dCAoYykgTGludXggVGVzdCBQcm9qZWN0LCAyMDE0LTIwMjEKPiArIyBDb3B5cmlnaHQgKGMpIExp
bnV4IFRlc3QgUHJvamVjdCwgMjAxNC0yMDI1Cj4gICMgQXV0aG9yOiBBbGV4ZXkgS29kYW5ldiA8
YWxleGV5LmtvZGFuZXZAb3JhY2xlLmNvbT4KPiAgIwo+ICAjIEluY2x1ZGUgaXQgdG8gYnVpbGQg
a2VybmVsIG1vZHVsZXMuCj4gICMgUkVRX1ZFUlNJT05fTUFKT1IgYW5kIFJFUV9WRVJTSU9OX1BB
VENIIG11c3QgYmUgZGVmaW5lZCBiZWZvcmVoYW5kLgo+ICsjCj4gKyMgRk9SQ0VfTU9EVUxFUz0x
OiBGb3JjaW5nIHRvIGZhaWwgb24gZXJyb3Igb3IgbWlzc2luZyBrZXJuZWwgaGVhZGVycwo+IChl
LmcuIGZvciBDSSkpLgo+Cj4gICQoaWYgJChSRVFfVkVSU0lPTl9NQUpPUiksLCQoZXJyb3IgWW91
IG11c3QgZGVmaW5lIFJFUV9WRVJTSU9OX01BSk9SKSkKPiAgJChpZiAkKFJFUV9WRVJTSU9OX1BB
VENIKSwsJChlcnJvciBZb3UgbXVzdCBkZWZpbmUgUkVRX1ZFUlNJT05fUEFUQ0gpKQo+Cj4gK2Rl
ZmluZSBuZXdsaW5lCj4gKwo+ICsKPiArZW5kZWYKPiArbiA6PSAkKG5ld2xpbmUpCj4gKwo+ICBp
ZmVxICgkKFdJVEhfTU9EVUxFUyksbm8pCj4gIFNLSVAgOj0gMQo+ICBlbHNlCj4gQEAgLTI0LDYg
KzMyLDE1IEBAIGVuZGlmCj4KPiAgaWZuZXEgKCQoU0tJUCksMCkKPiAgTUFLRV9UQVJHRVRTIDo9
ICQoZmlsdGVyLW91dCAlLmtvLCAkKE1BS0VfVEFSR0VUUykpCj4gK2lmZXEgKCQoRk9SQ0VfTU9E
VUxFUyksMSkKPiArJChlcnJvciBLZXJuZWwgbW9kdWxlcyBub3QgYnVpbHQhJChuKVwKPiArQ2hl
Y2sgdGhhdCBwYWNrYWdlIGZvciBidWlsZGluZyBrZXJuZWwgbW9kdWxlcyBmb3IgJChMSU5VWF9W
RVJTSU9OKVwKPiAraXMgaW5zdGFsbGVkIGFuZCB0cnkgYWdhaW4uJChuKVwKPiArKiBvcGVuU1VT
RS9TTEVTOiBrZXJuZWwtZGVmYXVsdC1kZXZlbCQobilcCj4gKyogRmVkb3JhL1JIRUw6IGtlcm5l
bC1kZXZlbC9rZXJuZWwtaGVhZGVycyQobilcCj4gKyogRGViaWFuL1VidW50dTogbGludXgta2J1
aWxkJChuKVwKPiArWW91IGNhbiBidWlsZCBhbnl3YXkgYnkgb21pdHRpbmcgRk9SQ0VfTU9EVUxF
Uz0xKQo+ICtlbmRpZgo+ICBlbmRpZgo+Cj4gIGlmbmVxICgkKGZpbHRlciBpbnN0YWxsIGNsZWFu
LCQoTUFLRUNNREdPQUxTKSksKQo+IEBAIC00MSw3ICs1OCw5IEBAIE1PRFVMRV9TT1VSQ0VTIDo9
ICQocGF0c3Vic3QgJS5rbywlLmMsJChmaWx0ZXIgJS5rbywKPiAkKE1BS0VfVEFSR0VUUykpKQo+
ICAjIGtlcm5lbCBpbnRlcm5hbCBBUEkgY2hhbmdlcy4gVGhlIHVzZXItc3BhY2UgdGVzdCB3aWxs
IHJldHVybiBUQ09ORiwgaWYKPiBpdAo+ICAjIGRvZXNuJ3QgZmluZCB0aGUgbW9kdWxlIChpLmUu
IGl0IHdhc24ndCBidWlsdCBlaXRoZXIgZHVlIHRvIGtlcm5lbC1kZXZlbAo+ICAjIG1pc3Npbmcg
b3IgbW9kdWxlIGJ1aWxkIGZhaWx1cmUpLgo+ICtpZm5lcSAoJChGT1JDRV9NT0RVTEVTKSwxKQo+
ICAlLmtvOiAlLmMgLmRlcF9tb2R1bGVzIDsKPiArZW5kaWYKPgoKVW5mb3J0dW5hdGVseSwgdGhp
cyB3b3VsZG4ndCB3b3JrIGFzIGV4cGVjdGVkLCB0aGUgbW9kdWxlJ3MgYnVpbGQgcHJvY2Vzcwpv
bmx5IHNraXBwZWQgc2lsZW50bHkgd2l0aCBgbWFrZSBtb2R1bGVzIEZPUkNFX01PRFVMRVM9MWAu
CgoKPiAgLmRlcF9tb2R1bGVzOiAkKE1PRFVMRV9TT1VSQ0VTKQo+ICAgICAgICAgQGVjaG8gIkJ1
aWxkaW5nIG1vZHVsZXM6ICQoTU9EVUxFX1NPVVJDRVMpIgo+IC0tCj4gMi41MC4xCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
