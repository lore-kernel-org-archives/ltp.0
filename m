Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC532EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 08:30:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1126B3CACBD
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:30:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4824C3CC4A8
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:30:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4EF4A10009CC
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687249835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vttWfEgPbwtqx7Rc989ppwhmsAAjyLFUiOjFuy05OlA=;
 b=hYBuDpEUDZC6jOGRtic5QUTGjFRd734LDyvfB1ORaWCaCgqiOlQsLksZoCeFJr8IEUN2Wp
 Vjqy2C90fzp0ix+sJ6E+eOEZpoPnsdExcv0XUvm0KvAQV9eM7tU0wrB4jvLPqZ3PpdZ6/F
 xBEypajbzI+3QfKRr/dSrUsalFolOqU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-PXFM7JXiPDi1DWZbo1oNGQ-1; Tue, 20 Jun 2023 04:30:33 -0400
X-MC-Unique: PXFM7JXiPDi1DWZbo1oNGQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b466bbc5f9so22140641fa.3
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 01:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249831; x=1689841831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vttWfEgPbwtqx7Rc989ppwhmsAAjyLFUiOjFuy05OlA=;
 b=eXt6KnLULULYa70HcPdhsTbY1uX97PKpAC6vUy/Km6IHff6fdjvF+VFLZsrgG0KML1
 qB7m30XIExUbifaL6v0GLXALn4A1OjywZ0QJtS2lzIelMgjRnjAQrPQgUAlc+d/Qa9KO
 dZ01A/CnLFjaixCfLeutfPyc8OKyXAj+Syw1WIYPwt1Zsa/wT4fk0NLlgVdNtKJyfiiX
 LbSXo3A1q0OEn2SS458rls491ueP/hFZfRgKzZMnSYT053sNHl6BCwDaDChj2nnLYAJW
 BjIFyWVVwj0UmB9XBD+q23v33oE1Y9ceiDTi3d7hH9plJZLO/gh43YeIToP6Zs8xK9gn
 diTA==
X-Gm-Message-State: AC+VfDy3HLu4EZNMo2n0vU6tyV2GZ+03CF0doQd4yblfNt7iTC4XsETT
 91BnNqtpammC7lR5VAVA/7ro8bwb2dyYnsKs7425Bd3b6FhKNTeAODkZL0e9lfaNEb4MC9vkfXK
 GjX5AlasCcCmIwlBka5RaHNdgaxDUYCorBsxeUeDx
X-Received: by 2002:a2e:7819:0:b0:2b4:7fc5:21ab with SMTP id
 t25-20020a2e7819000000b002b47fc521abmr2738401ljc.51.1687249831309; 
 Tue, 20 Jun 2023 01:30:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fCGbziWFeXifhRStiFAMaKGa6vWuAl4EH7ZnRO5YuvRrVotD/WBYNioby7RAYyo4+zzXolyRLq7h7QlM4ezI=
X-Received: by 2002:a2e:7819:0:b0:2b4:7fc5:21ab with SMTP id
 t25-20020a2e7819000000b002b47fc521abmr2738391ljc.51.1687249830977; Tue, 20
 Jun 2023 01:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <84e75a194e19b8519badb8a5db29b928150cca14.1687247631.git.souta.kawahara@miraclelinux.com>
 <47b3fb5d30bf7a1884f7dc0970832d0b07f8174a.1687247631.git.souta.kawahara@miraclelinux.com>
In-Reply-To: <47b3fb5d30bf7a1884f7dc0970832d0b07f8174a.1687247631.git.souta.kawahara@miraclelinux.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Jun 2023 16:30:18 +0800
Message-ID: <CAEemH2f_hnT-0o1p7+jK=eU=Lu07rP6ssBZAFPaF5W-buyu4oQ@mail.gmail.com>
To: Souta Kawahara <souta.kawahara@miraclelinux.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 2/2] syscalls/keyctl07: Use correct CVE tag
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

T24gVHVlLCBKdW4gMjAsIDIwMjMgYXQgNDoxN+KAr1BNIFNvdXRhIEthd2FoYXJhIDwKc291dGEu
a2F3YWhhcmFAbWlyYWNsZWxpbnV4LmNvbT4gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IFNvdXRh
IEthd2FoYXJhIDxzb3V0YS5rYXdhaGFyYUBtaXJhY2xlbGludXguY29tPgo+CgpSZXZpZXdlZC1i
eTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9rZXljdGwva2V5Y3RsMDcuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMDcuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9rZXljdGwva2V5Y3RsMDcuYwo+IGluZGV4IDg3NWVmMGJiOC4uZDllMjBkYjVmIDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3RsL2tleWN0bDA3LmMKPiArKysg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwwNy5jCj4gQEAgLTEwNCw3
ICsxMDQsNyBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gICAgICAgICAudGVz
dF9hbGwgPSBkb190ZXN0LAo+ICAgICAgICAgLmZvcmtzX2NoaWxkID0gMSwKPiAgICAgICAgIC50
YWdzID0gKGNvbnN0IHN0cnVjdCB0c3RfdGFnW10pIHsKPiAtICAgICAgICAgICAgICAgeyJDVkUi
LCAiMjAxNy0xMjkxMiJ9LAo+ICsgICAgICAgICAgICAgICB7IkNWRSIsICIyMDE3LTEyMTkyIn0s
Cj4gICAgICAgICAgICAgICAgIHsibGludXgtZ2l0IiwgIjM3ODYzYzQzYjJjNiJ9LAo+ICAgICAg
ICAgICAgICAgICB7fQo+ICAgICAgICAgfQo+IC0tCj4gMi4zMS4xCj4KPgo+IC0tCj4gTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
