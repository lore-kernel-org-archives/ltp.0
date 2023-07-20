Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E2BC0015E
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 03:14:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A438C3CDCB5
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 05:14:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53B783C02B2
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 05:14:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E355C1000D3B
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 05:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689822855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ZM0Ld+FkCqTXg5eSmpmTe9AJfbuSwWF3Pow64YmaW4=;
 b=go1KLsvf4uX4wo/3h86jxDj4akbyzLTPj61JJT/R2AUEYRNk13SQBgo0MApX6vUhD6MlOW
 hq5jYDQbG0tbmXVPMNQVW5WyDNJgLtA8aYl64YRZk4wdrYbQ0koLUuy8JHOyfepJzGkSuS
 Lgr50dJZvxURXJjPsx70uFHjAdvNQfs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-pEp2vVVUPO-U9XIjDZrz0w-1; Wed, 19 Jul 2023 23:14:13 -0400
X-MC-Unique: pEp2vVVUPO-U9XIjDZrz0w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6fbee0642so1953551fa.1
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 20:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689822851; x=1692414851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ZM0Ld+FkCqTXg5eSmpmTe9AJfbuSwWF3Pow64YmaW4=;
 b=bIc7RQyxtG8W2OkiLNBUZlFhj1hbKpMk4EG/y7RH6OSo4vxkFvyg3dAoi0bd/t4hD+
 vjBrYNGtSzUjPmTJsIiAKo8mGHld7jdSGyZt0nzTs7fA4NOOtwUVtV4rGtjs89etNxbX
 DsYloZYGdfdhjHkU34ke4D2LHtfVFGfCjUFsTD2v3XYIZsv5moRec55XOkieyCjlzMFG
 4tMpLA+R+Bo18yW0FuRbis4NYZGO6N2nbQGVyrjUIwFQQBa/kP75bl5jfqVNhH2HqSb/
 MLhRGkuEt6ecagVYFfg2umGBJJd9MuEU9qJ2uhs4Zkwkll7HrdP9dUZDPvVS2Ll8EKa+
 qb6w==
X-Gm-Message-State: ABy/qLYUaBn3KRVxMxh3S7n5/i2vWXnZhrzfszEQ3kGMlp58nMShTWcw
 L8TzlVDrcRA08n+f4rGw5iEJLJ+K3ipcHFK5K/uaKNSYRKtjH8w3u5ejrzVvGVmTGwmuZh+SU0N
 R5qDsfPt4gVySuFsiIN12b1voyBw=
X-Received: by 2002:a2e:8ec4:0:b0:2b6:d0c1:7cd0 with SMTP id
 e4-20020a2e8ec4000000b002b6d0c17cd0mr488397ljl.22.1689822851712; 
 Wed, 19 Jul 2023 20:14:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4QTs9KrX9DPjJ3I6U29kol44w5ikY73DRWiE1Q9xbX9wdV68g1dAw2AD0ytf0RCcKZFE7yMY6Zp74AnMfvkk=
X-Received: by 2002:a2e:8ec4:0:b0:2b6:d0c1:7cd0 with SMTP id
 e4-20020a2e8ec4000000b002b6d0c17cd0mr488391ljl.22.1689822851403; Wed, 19 Jul
 2023 20:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230718100050.1162482-1-pvorel@suse.cz>
 <CAEemH2fAuHrE4XyBjpudMCJJ4ZJ+9TOu=LpHXzizUp-uRqWXdA@mail.gmail.com>
 <20230719101225.GB1221211@pevik>
In-Reply-To: <20230719101225.GB1221211@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jul 2023 11:13:59 +0800
Message-ID: <CAEemH2esxksDg1NznrCW4QKO3NvEFUENWVcc4s-jf+Yk1-_RHw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] compat_16: Define USE_LEGACY_COMPAT_16_H for
 legacy tests
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
Cc: ltp@lists.linux.it,
 Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFdlZCwgSnVsIDE5LCAyMDIzIGF0IDY6MTLigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gLi4uCj4gPiBJJ20gbm90IHN1cmUg
aGVyZSBpZiB3ZSByZWFsbHkgbmVlZCBDT01QQVRfMTZfSCBmb3IgY2hvb3NpbmcgdHdvIGNvbXBh
dAo+ID4gaGVhZGVyIGZpbGUuCj4gPiBBcyB3ZSBhbHJlYWR5IHVzZSBoYXJkIGNvZGUgaW4gQyBz
b3VyY2UgZmlsZSBsaWtlICNpbmNsdWRlICJjb21wYXRfMTYuaCIKPiBvcgo+ID4gImNvbXBhdF90
c3RfMTYuaCIsCj4gPiBzbyBjb21waWxlIHdpdGggLUkgdGhlIGhlYWRlciBkaXJlY3RvcnkgaXMg
ZW5vdWdoIEkgZ3Vlc3MuCj4KPiA+IFRyeSB0aGlzIHNpbXBsZSBjb21wYXRfMTYubWssIGl0IGF0
IGxlYXN0IHdvcmtzIHdlbGwgb24gbXkgc2lkZS4KPiA+IE9yLCBkaWQgSSBtaXNzIGFueXRoaW5n
IGluIHRoZSAxNmJpdCBjb21waWxhdGlvbj8KPgo+IEkgbGlrZSB0aGlzIHNpbXBsaWZpY2F0aW9u
Lgo+Cj4gV2VsbCwgdG91Y2ggY29tcGF0XzE2LmggY2F1c2VzIHJlYnVpbGRpbmcgdGVzdHMgd2hp
Y2ggdXNlIGNvbXBhdF90c3RfMTYuaC4KPiBJIGRvbid0IG1pbmQgdGhhdC4gQnV0IE9UT0ggdG91
Y2ggY29tcGF0X3RzdF8xNi5oIGRvZXMgbm90IHRyaWdnZXIKPiByZWJ1aWxkaW5nCj4gdGVzdHMg
d2hpY2ggdXNlIGNvbXBhdF90c3RfMTYuaCA6KCAodGVzdGVkIG9uCj4gdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9zZXRyZWdpZCkuIENvdWxkIHlvdSBwbGVhc2UgcmVjaGVjayB0aGF0Pwo+CgpH
b29kIHBvaW50LCBJIG92ZXJsb29rZWQgdGhlIHByZXJlcXVpc2l0ZSBmb3IgdGhlIHRhcmdldCBi
dWlsZCwgc28gaXQgbmVlZHMKYWRkaW5nIGJhY2suCgpCdXQgd2UgZG9uJ3QgaGF2ZSB0aGUgbmVj
ZXNzYXJ5IHRvIGtlZXAgSU5URVJNRURJQVRFIG9iamVjdCBzeW50YXguCgpEZWxldGUgc29tZSBs
aW5lcyBiYXNlZCBvbiB5b3VyIHBhdGNoOgoKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy91dGlscy9jb21wYXRfMTYubWsKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGls
cy9jb21wYXRfMTYubWsKQEAgLTUzLDExICs1Myw4IEBAIENQUEZMQUdTICAgICAgICAgICAgICs9
IC1JJChhYnNfc3JjZGlyKQotSSQoYWJzX3NyY2RpcikvLi4vdXRpbHMKIFNSQ1MgICAgICAgICAg
ICAgICAgICAgPz0gJChzb3J0ICQod2lsZGNhcmQgJChhYnNfc3JjZGlyKS8qLmMpKQoKIE1BS0Vf
VEFSR0VUUyAgICAgICAgICAgOj0gJChub3RkaXIgJChwYXRzdWJzdCAlLmMsJSwkKFNSQ1MpKSkK
LU1BS0VfVEFSR0VUU19PQkpTX1dPX0NPTVBBVF8xNiA6PSAkKGFkZHN1ZmZpeCAubywkKE1BS0Vf
VEFSR0VUUykpCiBNQUtFX1RBUkdFVFMgICAgICAgICAgICs9ICQoYWRkc3VmZml4IF8xNiwkKE1B
S0VfVEFSR0VUUykpCgotIyBYWFggKGdhcnJjb29wKTogVGhpcyBjb2RlIHNob3VsZCBiZSBwdXQg
aW4gcXVlc3Rpb24gYXMgaXQgY2Fubm90IGJlCmFwcGxpZWQKLSMgKG5vIC5oIGZpbGUsIG5vIFRT
VF9VU0VfTkVXRVI2NF9TWVNDQUxMIGRlZikuCiBERUZfMTYgICAgICAgICAgICAgICAgIDo9IFRT
VF9VU0VfQ09NUEFUMTZfU1lTQ0FMTAoKIGlmZXEgKCQoVVNFX0xFR0FDWV9DT01QQVRfMTZfSCks
MSkKQEAgLTY2LDEzICs2Myw3IEBAIGVsc2UKIENPTVBBVF8xNl9IICAgICA6PSAkKGFic19zcmNk
aXIpLy4uL3V0aWxzL2NvbXBhdF90c3RfMTYuaAogZW5kaWYKCi1pZm5lcSAoJCh3aWxkY2FyZCAk
KENPTVBBVF8xNl9IKSksKQotJChNQUtFX1RBUkdFVFNfT0JKU19XT19DT01QQVRfMTYpOiAkKENP
TVBBVF8xNl9IKQotLklOVEVSTUVESUFURTogJChNQUtFX1RBUkdFVFNfT0JKU19XT19DT01QQVRf
MTYpCi1lbmRpZgotCiAlXzE2OiBDUFBGTEFHUyArPSAtRCQoREVGXzE2KT0xCi0jIFhYWCAoZ2Fy
cmNvb3ApOiBFbmQgc2VjdGlvbiBvZiBjb2RlIGluIHF1ZXN0aW9uLi4KCiAlXzE2Lm86ICUuYyAk
KENPTVBBVF8xNl9IKQogICAgICAgICQoQ09NUElMRS5jKSAkKE9VVFBVVF9PUFRJT04pICQ8CgoK
Ci0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
