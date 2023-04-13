Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1210C77B61
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 08:21:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6FB73CC4A9
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 10:21:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52AE53CB4F9
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 10:21:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 592B11A00686
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 10:20:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681374058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exuGddY6UvlUoTqXzkxnLcZiARMPQZPkN4Ke2atudgw=;
 b=buTRznFotGDXeCSeiqn74gOaKwKKC6h7Y8mPAbn5hRch+yWjfZxPbqbuA5s4mYRq/8pPvj
 GpefUlNiBAuqS206qOhDTI5z1z89j5Ow8pBYajWP4fhAGXIdrhfdXZoFAu8of9CkeXInKq
 cErMSBSHNr2WTZpSJFmV47keB+2d/jg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Cg8HctphP8WnUgmzsQodog-1; Thu, 13 Apr 2023 04:20:57 -0400
X-MC-Unique: Cg8HctphP8WnUgmzsQodog-1
Received: by mail-wm1-f71.google.com with SMTP id
 k4-20020a05600c1c8400b003f08ed470c2so4138960wms.1
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 01:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681374056; x=1683966056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=exuGddY6UvlUoTqXzkxnLcZiARMPQZPkN4Ke2atudgw=;
 b=dQ92gLjOnzGf/Vdz5G/gwNy8LDWqcwuIaZtiYrsdAr/22twBcgQNlcXq3a4iqEi9zz
 9Q2QclqdW2Gq9pdUQshmd+J7sFXvom+jEmob+wHQWdTJQAshXNn2rqnSu69v31Gr0Cqo
 /GfvBH94FYfbbglQnV4/cnxx7xmziZ5Mv76PhI/xDlhnJoVxxhN641cvEfGO5UznvitY
 ttdNc8z/JBRIIUsNfWdnZZz03UY52pEB96xK8tk+lUtuh910YXUvoBtseHtPr6+pGoNI
 07a2G4+VcmRQsjBSse/Fd9UhqneZO/iBX4HcUFcWNexstTeWmjFnCmuM98tYY7hMZlIT
 30GA==
X-Gm-Message-State: AAQBX9eowszKsccOCBAVXAH7Jo1BIcWllqzV7bj3uLg5rIFcp0N6/ggo
 ag6RlZynGs3rXxTKQ4xEYSIqW7XkC3fWkkTA6yjdkYAKM/jnaly57Oql35RSa/zuNLw1R4kkOL8
 +3K+ILPIGyu/x+04ZrzpkkOiE4ld9b97UfnRTJhT8bfo=
X-Received: by 2002:a05:600c:2059:b0:3ef:6935:da8d with SMTP id
 p25-20020a05600c205900b003ef6935da8dmr371434wmg.8.1681374055892; 
 Thu, 13 Apr 2023 01:20:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350YjZ4x3tzF6/k8NcUqWUL1eI5kk5C33cnv4cJF9/BghiYXu6pNjZ7TsiGLY+J8capzYUnsZcehCQe+eweM/ZVY=
X-Received: by 2002:a05:600c:2059:b0:3ef:6935:da8d with SMTP id
 p25-20020a05600c205900b003ef6935da8dmr371428wmg.8.1681374055634; Thu, 13 Apr
 2023 01:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230412073953.1983857-1-pvorel@suse.cz>
 <CAEemH2eGHMkUCZXJRmPBXM=qqVFA37eyEecNb8cn6j_F3dSO2g@mail.gmail.com>
 <20230413080210.GB2072620@pevik>
In-Reply-To: <20230413080210.GB2072620@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Apr 2023 16:20:44 +0800
Message-ID: <CAEemH2fSrefp5pSbajkhbpHNyp2NCYY94pP-HfdO0BGCVbRavw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Remove possible double/trailing
 slashes from TMPDIR
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

T24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgNDowMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBPbiBXZWQsIEFwciAxMiwgMjAyMyBhdCAzOjQw4oCvUE0gUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gPiA+IE5GUyB0ZXN0cyBoYXZlIHByb2Js
ZW0gd2hlbiBUTVBESVIgcGF0aCBjb250YWlucyBkb3VibGUgc2xhc2hlcywKPiA+ID4gYmVjYXVz
ZSB0aGV5IGdyZXAgZXhwb3J0ZnMgb3V0cHV0IHdoaWNoIGlzIG5vcm1hbGl6ZWQuCj4KPgo+ID4g
SSdtIG9rIHRvIHJlbW92ZSByZWR1bmRhbnQgc2xhc2hlcywgSSBqdXN0IHdvbmRlcmluZyB3aGVy
ZQo+ID4gaXMgdGhlIHNlY29uZCBzbGFzaCBjb21lcyBmcm9tPwo+ID4gSXMgdGhhdCBhZGRlZCBi
eSBhY2NpZGVudCB3aGVuIGVudiB2YXJpYWJsZSBkZWZpbml0aW9uPwo+Cj4gWWVzLCB0aGF0J3Mg
dGhlIGxhc3Qgc2xhc2ggaW4gVE1QRElSPS92YXIvdG1wLy4KPiBUTVBESVI9L3Zhci90bXAgd291
bGQgd29yay4KPgoKT2ssIEkgYWdyZWUgd2l0aCB0aGUgc2Vjb25kYXJ5IHRyZWF0bWVudCBpbnNp
ZGUgbGliIChpbmNsdWRlcyBDIEFQSSksCmFzIHdlIGNhbid0IGdyYW50ZWUgdGhlIGFsbCB1c2Vy
cyB0byByZW1lbWJlciB0aGlzIHRyaXZpYWwuCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5n
QHJlZGhhdC5jb20+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
