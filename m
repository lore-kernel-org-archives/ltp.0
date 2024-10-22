Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4989D2C54B
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 13:22:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34BF3C6FB6
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 15:22:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E9DF3C6F79
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 15:22:14 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D7151100F709
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 15:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729603332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q2BoxIXOGcVjZsrNbtPqvPHYgJWLjY7IKlp/A/mdugY=;
 b=OwF87gWJrMPCdBYJ+kYZkq0qanTqcbiVj1qAPjEU1eHdbWExhAoJ3wQ4126oP0n3VPK2I3
 G9dbfSivhJZolsmPoIRF+Czt1f6sRGCqLXB8724LKH/7Fibj2CqAGRABVq3CCj7rQ6/u4+
 qlK1zBHCxuWN755BOQXyN2uG+U5JW2A=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-k0vgThvqOQiC9rfeRuIUSg-1; Tue, 22 Oct 2024 09:22:10 -0400
X-MC-Unique: k0vgThvqOQiC9rfeRuIUSg-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-288ae5eabaaso4910313fac.1
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 06:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729603330; x=1730208130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2BoxIXOGcVjZsrNbtPqvPHYgJWLjY7IKlp/A/mdugY=;
 b=HDzWqvJVsDUcoQHzll2Xvkwo311qQC7gDd8U4THjICGcN8tlJqIV/GV8nVsPDwC1op
 r+OC6u229/KVR0am8R+1loRvdWLLvO5mp16BenXyH1HY/Olz6cHPCuOQjsthD/Ofq4U3
 G0RJ2OKWKxXMedh8fWu5nplIqTqGc26xT2P7OSvYqDiOTQBkDGgC0ITamZTyTVkp5ZLq
 PVXtdt62mGV6z86WR01f+OsuBhvY0RNuFDAWgaMMjFBaj2c4nuDYcAoydjrPCSXXZlGe
 DJzggkwrYXMlapBwBGUGzBl6QgTMT7ofD50zTtoVQOPu3TEyH8qDArbYQCXoVt47wt2V
 Tdww==
X-Gm-Message-State: AOJu0YzzibzhNU/PatEn6X0f7lRhjBPnIdmadGZgmnlEOg/liH76DpRC
 9lEgOukSGumFHhMlr+lozs3fLCOZkREAxWzEugypSx+yaff3bem7+v8Q7RcGLgdsCleX7lEBWNY
 fLNeSbgutNw2j4NpOLWx1E03urNntakTkBHB2rzQquI8vlrcdr4qcImIvCESGqSXLAOPhn5gMDp
 Rw1OQ4QW22cue/wffSfk8FRl1rQvFrF5p4OA==
X-Received: by 2002:a05:6870:b28a:b0:261:1046:66fc with SMTP id
 586e51a60fabf-2892c27655amr11470732fac.4.1729603330150; 
 Tue, 22 Oct 2024 06:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0pMqvU6Japloo4gvTGXEFnvrNzxIcVsB68nWB2E4VhZ6d6XvFH6lMpbuFWkc3R+eXkIatKI7Ct9VUdFkf8KQ=
X-Received: by 2002:a05:6870:b28a:b0:261:1046:66fc with SMTP id
 586e51a60fabf-2892c27655amr11470713fac.4.1729603329874; Tue, 22 Oct 2024
 06:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <36c63ee52ce1e7ab1f6ce90bc6a4c58272130bee.1729590080.git.jstancek@redhat.com>
 <CAEemH2f3zaf+3jq8346WQNP9QgsvjBUA9GqCb8c8OYuVh2Q+dg@mail.gmail.com>
In-Reply-To: <CAEemH2f3zaf+3jq8346WQNP9QgsvjBUA9GqCb8c8OYuVh2Q+dg@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Oct 2024 15:21:54 +0200
Message-ID: <CAASaF6zojtp0nuGuHy3V64ZzVaHyRkbyg6wrbaPEvDTgD7e65w@mail.gmail.com>
To: Li Wang <liwan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] read_all: limit sysfs tpm entries to single worker
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

T24gVHVlLCBPY3QgMjIsIDIwMjQgYXQgMzowNeKAr1BNIExpIFdhbmcgPGxpd2FuQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4KPgo+IE9uIFR1ZSwgT2N0IDIyLCAyMDI0IGF0IDU6NDXigK9QTSBKYW4g
U3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IFJlcGVhdGVkIHJlYWRz
IGZyb20gVFBNIGVudHJpZXMgKHRjZ19vcGVyYXRpb25zLCB2c19vcGVyYXRpb25zLAo+PiBjYXBz
LC4uKSBhcmUgY2F1c2luZyBiaWcgZGVsYXlzIHdpdGggMyBvciBtb3JlIHJlcGV0aXRpb25zLAo+
PiB3aGljaCBoYXMgc2lnbnMgb2Ygc29tZSBraW5kIG9mIHJhdGUtbGltaXR0aW5nIG9uIGZpcm13
YXJlIHNpZGUuCj4+Cj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIG5ldyBraW5kIG9mIGJsYWNr
bGlzdCwgd2hpY2ggZG9lc24ndAo+PiBjb21wbGV0ZWx5IHNraXBzIHRoZSBlbnRyeSwgYnV0IGFz
c2lnbnMgaXQgdG8gb25seSBzaW5nbGUKPj4gd29ya2VyLgo+Cj4KPiBEaWQgeW91IHRlc3QgdGhh
dCBhIHNpbmdsZSB3b3JrZXIgaXMgZmFzdGVyIGVub3VnaCB3aXRoIHRoZQo+IGRlZmF1bHQgJy5t
YXhfcnVudGltZSA9IDEwMCcgb24gdGhvc2Uga2luZCBvZiBzeXN0ZW1zPwoKSSBkaWQuIEl0IHdh
cyBvbmx5IDNyZCBvciA0dGggaXRlcmF0aW9uIHRoYXQgc3RhcnRzIGdldHRpbmcgcGFpbmZ1bGx5
IHNsb3cuCkl0IGRvZXNuJ3Qgc2VlbSB0byBtYXR0ZXIgaWYgaXQncyBydW5uaW5nIHBhcmFsbGVs
IG9yIHNlcXVlbnRpYWxseS4KCkZvciBleGFtcGxlLCB0Y2dfb3BlcmF0aW9ucyBhZnRlciBjZXJ0
YWluIHBvaW50IHN0YXJ0cyByZXR1cm5pbmcKIkJsb2NrZWQgZm9yIE9TIGJ5IEJJT1MiICh2ZXJ5
IHNsb3dseSkuCgojIHRpbWUgY2F0IC9zeXMvZGV2aWNlcy9wbnAwLzAwOjBhL3RwbS90cG0wL3Bw
aS90Y2dfb3BlcmF0aW9ucyB8IGdyZXAgQmxvY2tlZAoKcmVhbCAgICAwbTMuNDA2cwp1c2VyICAg
IDBtMC4wMDBzCnN5cyAgICAgMG0zLjYzMXMKCiMgdGltZSBjYXQgL3N5cy9kZXZpY2VzL3BucDAv
MDA6MGEvdHBtL3RwbTAvcHBpL3RjZ19vcGVyYXRpb25zIHwgZ3JlcApCbG9ja2VkIHwgd2MgLWwK
MTAyCgpyZWFsICAgIDFtNDQuMjk4cwp1c2VyICAgIDBtMC4wMDBzCnN5cyAgICAgMW00NS4zMTZz
CgoKPgo+IElmIHRoYXQncyBzdGlsbCB0aW1lb3V0IG9uIHRoZSByYXRlLWxpbWl0ZWQgZmlsZXMs
IHdoYXQgc2hvdWxkIHdlIGRvIChtb3ZlIHRvIGJsYWNrbGlzdCk/CgpZZXMsIEknZCBibGFja2xp
c3QgdGhvc2Ugd2hlcmUgc2luZ2xlIHJlYWQgaGFuZ3MgZm9yIGRvemVucyBvZiBzZWNvbmRzLgoK
Pgo+IEFueXdheSwgdGhlIHBhdGNoIGl0c2VsZiBsb29rcyBnb29kIHRvIG1lLgo+IFJldmlld2Vk
LWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KClRoYW5rcyBmb3IgcmV2aWV3LgoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
