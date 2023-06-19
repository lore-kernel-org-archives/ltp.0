Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64390EB64D9
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 09:49:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 215303CB7C3
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 11:49:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02D433CA684
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 11:48:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0CB901A00A29
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 11:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687168128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wTKpe+/2zwIGt/uXZ+Me3UChLgPfdfIM5wx2/JMqDhM=;
 b=TOVs8w0yqvCEgpiiFDiM2rS2DfQ1S1Quzp1wdOxY88T1HoPDDR/7g1Iz+cl/hI+S+4Q3EW
 8gt75wpcIS+mrZCLP+GcdQXAk/1yhKeehiO8O9Z5poUqlNpVHaVPYfj0InsoxfZoBy9GVQ
 AWQ3Do27noY1Rzs/8LxTs9xRK0MKyXU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-seGCiPR-MIe-kcXTp-0ydA-1; Mon, 19 Jun 2023 05:48:45 -0400
X-MC-Unique: seGCiPR-MIe-kcXTp-0ydA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b475f626b6so6355801fa.1
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 02:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687168124; x=1689760124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wTKpe+/2zwIGt/uXZ+Me3UChLgPfdfIM5wx2/JMqDhM=;
 b=CdzvMtb/eSirGNg5rjNjMMaqBpIiq/kPtO+uqeJVhaVOlvamBzYvfu8/Dy7xKcSJcA
 H0B9X8Yh4HmHrM+9IYj9QEO2P1ORwkJGqSU5xht04pnQYbQEADk5FlSH5RZeHPS2HogI
 B6z06ai7vEwSO5eKs+pm692yugQMBWYE2PM03oJK26x38U+IV6j82WjCt+Vvrx5/Ahy2
 A1UNeDwEMQ06t3zBd0sU0a03rFY9e0flZZViiGE9raUosZdRkvEPX6BNwVNlfcca5YZV
 b9A7NRnWZDBGkEt8jBBCzA5Ra1lOmvKOKElfmVDGOV0Va8v6d4jbYyMnWILUJGj/EwFh
 mHEA==
X-Gm-Message-State: AC+VfDyt2bz9qyQAPnVhCnBCOS17xPhvv10qTVdeL0FwcOL+VWZOmtn/
 iCfTdRIPCFgGyyYaDpEmSD5yfdSAIrJ0YFVnP4NzkXOoO6It5OzQYjxcJ+o8rlffueX+0z5XE1l
 E8pOmYYQE+TRQQa0OkNNuMK4gef8=
X-Received: by 2002:a2e:8e89:0:b0:2af:47b2:3f6c with SMTP id
 z9-20020a2e8e89000000b002af47b23f6cmr5888677ljk.31.1687168124368; 
 Mon, 19 Jun 2023 02:48:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6WYYOaKLb0JR4RbFRyWnY+880KxS78xJYZvqna1MJlBJnduxnUuuzL5SKvvAQLsld6bTKEmGCMD9Sy68rrFto=
X-Received: by 2002:a2e:8e89:0:b0:2af:47b2:3f6c with SMTP id
 z9-20020a2e8e89000000b002af47b23f6cmr5888664ljk.31.1687168123994; Mon, 19 Jun
 2023 02:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <BLAPR15MB39870F810F9FC1E9A89F78CCCE50A@BLAPR15MB3987.namprd15.prod.outlook.com>
In-Reply-To: <BLAPR15MB39870F810F9FC1E9A89F78CCCE50A@BLAPR15MB3987.namprd15.prod.outlook.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 19 Jun 2023 17:48:32 +0800
Message-ID: <CAEemH2faFm6PPRVUKgC-CbCOgVR3-mnDYVpDR-sk1MTBQXHqiw@mail.gmail.com>
To: Mahesh Kumar G <Mahesh.Kumar.G@ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Test Case mapping based on Changelog
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
Cc: Krishnaja Balachandran1 <kribalac@in.ibm.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFoZXNoLAoKT24gTW9uLCBKdW4gMTksIDIwMjMgYXQgMzo1OOKAr1BNIE1haGVzaCBLdW1h
ciBHIHZpYSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdD4Kd3JvdGU6Cgo+IEhpIQo+IEdyZWV0aW5n
cyEhCj4KPiBXZSB3YW50IHRvIGNoZWNrIHRoZSBjaGFuZ2Vsb2cgb2YgYSBwYXJ0aWN1bGFyIExp
bnV4IGJ1aWxkIGFuZCBpZGVudGlmeQo+IHRoZSBmaWxlcywgd2hpY2ggYXJlIG1vZGlmaWVkIGFu
ZCB0ZXN0IG9ubHkgdGhvc2UgbW9kaWZpZWQgYXJlYXMgdXNpbmcgb3VyCj4gTFRQIHN1aXRlLgo+
Cj4gVGhlIHBhaW4gcG9pbnQgaGVyZSBpcywgYWZ0ZXIgaWRlbnRpZnlpbmcgdGhlIGNoYW5nZWQg
ZmlsZXMgZnJvbSB0aGUKPiBjaGFuZ2Vsb2cvY29tbWl0IGRldGFpbHMgdGhhdCB3ZW50IGludG8g
dGhlIGJ1aWxkLCBob3cgZG8gd2UgbWFwIGl0IHRvIGEKPiBwYXJ0aWN1bGFyIExUUCB0ZXN0IGNh
c2Ugb3IgdGVzdCBzdWl0ZS4KPgoKTXkgdHdvIGNlbnRzOgoKVGhlIHNpbXBsZSBtZXRob2QgaXMg
dG8gaWRlbnRpZnkgdGhlIGNoYW5nZSBjb2RlIGJlbG9uZ2luZwp0byB3aGljaCBzdWJjb21wb25l
bnQsIGUuZy4gbW0sIHlvdSBjYW4gdXNlIHRoZSBMVFAvbW0KdG8gY292ZXIgdGhlIExpbnV4IGJ1
aWxkLgoKSW4gTFRQIHJ1bnRlc3QvIGRpcmVjdG9yeSwgdGhlcmUgYXJlIG1hbnkgdGFzayBmaWxl
IG1hcHBpbmcgTGludXgKa2VybmVsIHJlbGF0ZXMgbW9kdWxlLCBidXQgaXQgZG9lc24ndCAxMDAl
IHByZWNpc2UsIGZvciBleGFtcGxlLApsdHAvcnVudGVzdC9zeXNjYWxscyBpbmNsdWRlIGtpbmRz
IG9mIHN5c2NhbGwncyB0ZXN0cywgaXQgaXMgaGFyZCB0byBzYXkKd2hpY2gga2VybmVsIHN1YmNv
bXBvbmVudHMgaXQgY292ZXJzLCBidXQgZm9ydHVuYXRlbHksIExUUCBzdXBwb3J0cwpjcmVhdGlu
ZyBhIGN1c3RvbWl6ZWQgdGFza2ZpbGUsIHdoaWNoIG1lYW5zIHBlb3BsZSBjYW4gcmVvcmRlcgp0
aGVtIGluIGEgbmV3IHNwZWNpZmllZCBmaWxlIHRvIGNvdmVyIHNvbWUga2VybmVsLW1vZHVsZSBj
aGFuZ2VzCnRoZXkgd2FudGVkLgoKVGhlc2UgaGlnaGx5IGRlcGVuZCBvbiBob3cgcGVvcGxlIGRv
IHRoZSB0ZXN0aW5nIHRyaWFnZSB3b3JrLgoKCgo+Cj4gRG8geW91IGtub3cgaG93IHRvIGFjaGll
dmUgdGhpcz8KCgo+IFAuUyDigJMgV2UgYXJlIGF3YXJlIG9mIHRoZSBrcGV0IHByb2plY3QgYW5k
IHdhbnRlZCB0byBrbm93IGlmIHRoZXJl4oCZcwo+IHNvbWV0aGluZyBzaW1pbGFyIGZvciBMVFAg
dGVzdGNhc2VzLgo+Cj4gVGhhbmtzLAo+IE1haGVzaCBLdW1hciBHCj4KPiAtLQo+IE1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
