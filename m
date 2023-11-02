Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F856C4332F
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 09:51:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBA933CE4FE
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 10:51:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 872253CB831
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 04:02:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B014600AD1
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 04:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698894124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XQCQj5geVnZ+0WvFn3eMsdAzGEZlly7DoPULEtnC1tI=;
 b=ByKtO0ZJIid8rwRaArQ4mGs3CmEzPUn04xR5YSUhFWag6iUfArnmEcz40NWT8pysnUQ6y6
 DDQcDmyyK1JBxe6iaAQ2y23xsJoqf4WGj9zXmbhxrX1TEyi4/h4CIQjmYGhIkmWQR6aGpe
 AjDKEQxHj5s9+l0GfJNdBMuTRgIi1lA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-uJMnVNZ2OWC8nmXL2jt9TA-1; Wed, 01 Nov 2023 23:02:00 -0400
X-MC-Unique: uJMnVNZ2OWC8nmXL2jt9TA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-581e2fc1178so651170eaf.0
 for <ltp@lists.linux.it>; Wed, 01 Nov 2023 20:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698894120; x=1699498920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XQCQj5geVnZ+0WvFn3eMsdAzGEZlly7DoPULEtnC1tI=;
 b=mu9x3Kvu6FxzCk8otF2a2tnDP07AqZjxyUm5BfehU51ExBQffOiOtvqjV+fyPY292J
 RmhEbe7CKL/UE8qCfQ1pG12BgGjTIVguX+DmauDfLHNgOYpaPyqXw6aiorlAJik22E/W
 0R0bRFQY6OPR093D57Jt+lahL6tvqLilh87EjP2niGSMUvkqG62X0RP8nqp+DqZexWA4
 RtxlS7sDaiQsrN+xU7Y07grBfMPffcz1r95C7C9CeQb/cF8iCR/JEhwayZos0UhNKaBB
 MJEeEZ5ek29MtMU2CeE90Zvwe51UfAsUdZJoCBxk2FgHCIkPqciJVnVI8K0swcD2tqjd
 pejA==
X-Gm-Message-State: AOJu0Yz/2wvl1lHp535kZhCQpHUKbxULKd8knpy7sGIfrIxT1q4jvfcc
 Un8yKZk+oGoJPEh/FKlvq25aksgivx2UJWDDXoV5jMWdZ5BT4W6/jveHNYzHHTBI5njvhQLajt2
 k6XvoKBN1ccoNiOZKidUIa3sUgGE=
X-Received: by 2002:a05:6820:179a:b0:581:d6a6:478a with SMTP id
 bs26-20020a056820179a00b00581d6a6478amr2770302oob.0.1698894120153; 
 Wed, 01 Nov 2023 20:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcsOfRJZghUoPnVHTrB9d1chRc02QuE7++9FC8uC9BkaJQcyNsp+mJPbvnn/g5hZU/xJDixerfVKG44ePp4bQ=
X-Received: by 2002:a05:6820:179a:b0:581:d6a6:478a with SMTP id
 bs26-20020a056820179a00b00581d6a6478amr2770282oob.0.1698894119836; Wed, 01
 Nov 2023 20:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140109.340441-1-pvorel@suse.cz>
 <CAASaF6yVnrBK0UCxj4HRbi_scm84KS5Jm_xi8rUEuXcZXo=rZQ@mail.gmail.com>
 <20231101111722.GB896131@pevik>
 <CAASaF6zVpEvG8NXLOyKo5Lp9rKcbg_=5_=xRRpVFKjRaqGzL6w@mail.gmail.com>
 <CAEemH2eehZbY9S=xYtOLAas=TOzFqdfvPyTy5UY-uFs20OtX7g@mail.gmail.com>
In-Reply-To: <CAEemH2eehZbY9S=xYtOLAas=TOzFqdfvPyTy5UY-uFs20OtX7g@mail.gmail.com>
From: Chao Ye <cye@redhat.com>
Date: Thu, 2 Nov 2023 11:01:23 +0800
Message-ID: <CAL3eej4VQ3hrfT2Q=oi_=zjCFkj9JBuGz2Cduu-PFXu0U0w1vA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>, Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 14 Nov 2023 10:50:40 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/2] Remove CentOS 7 support
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
Cc: Ulrich Hecht <uli@kernel.org>, Martin Doucha <martin.doucha@suse.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IOS6jjIwMjPlubQxMeaciDLml6Xlkajlm5sgMTA6
NTDlhpnpgZPvvJoKCj4gSGkgSmFuLCBBbGwsCj4KPgo+IE9uIFdlZCwgTm92IDEsIDIwMjMgYXQg
ODoyOOKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPiB3cm90ZToKPgo+PiBP
biBXZWQsIE5vdiAxLCAyMDIzIGF0IDEyOjE34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+PiA+Cj4+ID4gSGkgYWxsLAo+PiA+Cj4+ID4gTm90ZSBmb3IgbXlzZWxmOiB0
eXBvIGluIHN1YmplY3Qgcy9SZUFwbGFjZS9SZXBsYWNlLwo+PiA+Cj4+ID4gPiA+IHdlIHJlY2Vu
dGx5IGhhZCB5ZXQgYW5vdGhlciByZWdyZXNzaW9uIG9uIG9sZCBDZW50T1MgNyAoa2VybmVsIDMu
MTAsCj4+ID4gPiA+IGdsaWJjIDIuMTcsIGdjYyA0LjguNSBbMV0uIFRoYXQgYnJvdWdodCBtZSB0
byB0aGUgcXVlc3Rpb24gaWYgd2UKPj4gc3RpbGwKPj4gPiA+ID4gd2FudCB0byBzdXBwb3J0IGl0
Lgo+PiA+Cj4+ID4gPiA+IEFsdGhvdWdoIHdlIHRlc3QgaW4gU1VTRSBhbHNvIHZlcnkgb2xkIFNM
RVMgcmVsZWFzZXMsIHRoZXNlIGFyZQo+PiB0ZXN0ZWQKPj4gPiA+ID4gd2l0aCBvbGRlciBMVFAg
cmVsZWFzZXMuIEkgc3VwcG9zZSBSZWQgSGF0IGRvZXMgdGhlIHNhbWUgd2l0aCBSSEVMCj4+ID4g
PiA+IChMaSwgSmFuLCBwbGVhc2UgY29ycmVjdCBtZSBpZiBub3QsIG9yIGZlZWwgZnJlZSB0byBp
bnRyb2R1Y2UKPj4gYW5vdGhlcgo+PiA+ID4gPiBDZW50T1MgdmVyc2lvbiwgYXMgdGhlcmUgd2ls
bCBub25lIHdpdGggdGhpcyBwYXRjaHNldCksIHRodXMgd2h5Cj4+ID4gPiA+IHByZXRlbmQgY3Vy
cmVudCBMVFAgaXMgdXNlZnVsIG9uIHRoZXNlIG9sZCByZWxlYXNlcy4KPj4gPgo+PiA+ID4gTG9v
a2luZyBhdCBpbnRlcm5hbCBMVFAgdGVzdCB3cmFwcGVyLCBpdCdzIHVzaW5nIG9sZGVyIExUUCBy
ZWxlYXNlCj4+IGZvciBSSEVMNywKPj4gPiA+IHNvIHlvdXIgYXNzdW1wdGlvbiBhcHBlYXJzIHRv
IGJlIGNvcnJlY3QuCj4+ID4KPj4gPgo+PiA+ID4gPiBJIHdvbmRlciB3aG8gaXMgYWN0dWFsbHkg
aW50ZXJlc3RlZCBpbiBrZWVwaW5nIExUUCBjb21waWxhYmxlIGZvcgo+PiBDZW50T1MgNy4KPj4g
PiA+ID4gQWNjb3JkaW5nIHRvIGRpc3Ryb3dhdGNoIGl0IEVPTCBpbiAyMDI0LTA2IFsyXSwgYnV0
IGRvZXMgYW55Ym9keQo+PiBldmVuIHJ1biBuZXcKPj4gPiA+ID4gTFRQIG9uIGl0LiBJZiB5ZXMs
IHBsZWFzZSBzcGVhayB1cCwgYnV0IEknZCBleHBlY3QgdGhhdCBwZXJzb24gdG8KPj4gPiA+ID4g
YWN0dWFsbHkgbWFpbnRhaW4gQ0kgZmFpbHVyZXMuCj4+ID4KPj4gPiA+IFRoZXJlJ3MgcGxhbm5l
ZCBFTFMgdW50aWwgMjAyNiwgYnV0IEknZCBleHBlY3QgdGhhdCBjb250aW51ZXMgdXNpbmcKPj4g
PiA+IG9sZGVyIExUUCBmb3IgdGVzdHMuCj4+ID4KPj4gPiBATGksIEphbiBDb3VsZCB5b3UgcGxl
YXNlIGFkZCB5b3VyIEFCVCBvciBSQlQ/Cj4+Cj4+IEFja2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0
YW5jZWtAcmVkaGF0LmNvbT4KPj4KPgo+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVk
aGF0LmNvbT4KPgo+Cj4+Cj4+ID4gQWxzbywgZmVlbCBmcmVlIHRvIGFkZCBxdWF5LmlvL2NlbnRv
cy9jZW50b3M6c3RyZWFtOSBvciByb2NreWxpbnV4Ojkgb3IKPj4gPiByb2NreWxpbnV4Ojggb3Ig
d2hhdGV2ZXIgbWFrZXMgc2Vuc2UgdG8geW91LiBUaGVzZSBhcmUgdGVzdGVkIGluCj4+ID4gaHR0
cHM6Ly9naXRodWIuY29tL2lwdXRpbHMvaXB1dGlscy9ibG9iL21hc3Rlci8uZ2l0aHViL3dvcmtm
bG93cy9jaS55bWwKPj4gPiAoaXQgd291bGQgaGF2ZSB0byBiZSBjaGVja2VkIGlmIGNpL2NlbnRv
cy5zaCBuZWVkcyBiZSBtb2RpZmllZCB0bwo+PiBzdXBwb3J0KS4KPj4KPj4gQExpOiBEbyB5b3Ug
a25vdyB3aG8vaG93IGZyZXF1ZW50bHkgdXBkYXRlcyBjOXMgaW1hZ2U/Cj4+Cj4KPiBJJ20gbm90
IHN1cmUgYWJvdXQgaXQuIEkgZ3Vlc3MgQ2hhbyBZZSBrbm93cyBiZXR0ZXIgdGhhbiBtZS4KPgo+
ClRoZSBvZmZpY2FsIGNlbnRvcyBzdHJlYW0gaW1hZ2VzIHdvdWxkIGJlOgpodHRwczovL3F1YXku
aW8vY2VudG9zL2NlbnRvczpzdHJlYW05Cmh0dHBzOi8vcXVheS5pby9jZW50b3MvY2VudG9zOnN0
cmVhbTgKCkFjY29yZGluZyB0byBodHRwczovL3NpZ3MuY2VudG9zLm9yZy9oeXBlcnNjYWxlL2Nv
bnRlbnQvY29udGFpbmVycy8KIlRoaXMgY29udGFpbmVyIGltYWdlIGlzIGF1dG9tYXRpY2FsbHkg
YnVpbHQgZnJvbSBzY3JhdGNoIG9uIHRoZSBDZW50T1MgQ0kKaW5mcmFzdHJ1Y3R1cmUgYW5kIHB1
c2hlZCB3ZWVrbHkuIgpSZWY6IGh0dHBzOi8vcGFndXJlLmlvL2NlbnRvcy1zaWctaHlwZXJzY2Fs
ZS9jb250YWluZXJzLXJlbGVuZwoKVGhhbmtzLApDaGFvCgoKPiBDYydpbmcgQ2hhbyBZZS4KPgo+
IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5nCj4KCgotLSAKTmFtZTogQ2hhbyBZZQpUZWFtOiBLZXJu
ZWwtUUUKTW9iaWxlOiArODYtMTg2MC0xMTItMDc0NQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
