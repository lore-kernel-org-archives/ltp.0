Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E1C4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 14:24:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 687EC3CFBB6
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 15:24:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAACE3CC7B2
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 15:23:53 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9AE291401254
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 15:23:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705933430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyoqP7uuFGI7fLHoivnviHRJBXWVLSV2mFuU1rdpnFg=;
 b=H0K5MMth2FQBMmNzNWH+haWpgUCx7+KihyksPq6QzXgvguRO19MNkK+zGx2JBl1aRU8QGv
 RxKG6PMErbVefn3O9jaGYUTnOk1wO569E0QvQRxfab+yjru/hSzy6tWLlgqbrMLqcb/Ebt
 /wdqL2drRR2X9BPmwvUdNJDxHKm36q4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-OtuLbHNRO7iD8e5fZpPIPw-1; Mon, 22 Jan 2024 09:23:48 -0500
X-MC-Unique: OtuLbHNRO7iD8e5fZpPIPw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29041401e70so1880276a91.1
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 06:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705933428; x=1706538228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gyoqP7uuFGI7fLHoivnviHRJBXWVLSV2mFuU1rdpnFg=;
 b=ZMqkqZsSciCVoo9z/UlPtlf53BbUYUkGjxKqmqBYfJBjU1Qqt2Nl69RFNSMuOkn/9s
 2RdHSLM4brni8FkpnZ3KWionO8rr6GMjQTpUfw0y+Hhv4xzsSk2P/C+OvbjXlIN5K7CZ
 l7lWNhzW5bqKKp/XCCgYGKJfoC66OY8auWPDkNa1hIhDk+3+AAPj92rBJm9fWtkR+Q/K
 E5kevKQvoi/oYvIuF0aa81ntHMfb2Nwd7VqXSfwWLhQ/nutivgUvp1KFpfiEtFJmzQjA
 R/5eYwid3ng0Nsv1P++HTouxgMr+lGkTIZxZagqNlb9tGySmX9WOiGvuFAziPVHDCPz9
 zn6w==
X-Gm-Message-State: AOJu0YxmGVfuRs4mgTBc11LWMmop68ibZtWXSUiCyA+dxMMGEGndyGDH
 CzoTdcwk9CT4e0yAsYrmKnTNBZfpeiK4Nr92jV6N8jY/kHxkWR4XTtHYamUzLkfeuyeDO9OUaQq
 c7NYsaNLecLjY311L/Rwe8hFmx99MJGj5tyGaf1F745HEl9jt7PD8GHyMNH1HkAscqczM8tddE6
 QHyGTmLjdT49zYA35fBM6yytk=
X-Received: by 2002:a17:90a:684e:b0:290:5ad4:db7 with SMTP id
 e14-20020a17090a684e00b002905ad40db7mr1419545pjm.65.1705933427839; 
 Mon, 22 Jan 2024 06:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoinmNsHYZGnQt1ZcQMebwG8AMwyOfoOpS4V7MZs6i4HVtvsOYp+8dADbK2KuNePTvB333C2qVjMCDJOlnuvw=
X-Received: by 2002:a17:90a:684e:b0:290:5ad4:db7 with SMTP id
 e14-20020a17090a684e00b002905ad40db7mr1419533pjm.65.1705933427411; Mon, 22
 Jan 2024 06:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122091356.GF76754@pevik>
 <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
 <20240122110344.GB95077@pevik>
In-Reply-To: <20240122110344.GB95077@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jan 2024 22:23:35 +0800
Message-ID: <CAEemH2cNn1kyWrnqXHHeOteGT_FQ=PBVc55NFhkZbmkbMOoD=A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

T24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgNzowM+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBIaSBQZXRyLAo+Cj4gPiBPbiBNb24sIEphbiAyMiwgMjAyNCBhdCA1
OjE04oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gPiA+IEhpIExp
LAo+Cj4gPiA+ID4gVGhpcyBpbnRyb2R1Y2UgYW4gZW5oYW5jZW1lbnQgdG8gdGhlIGxpYnJhcnkn
cyBpc19zd2FwX3N1cHBvcnRlZAo+ID4gPiA+IGZ1bmN0aW9uIHRvIGNoZWNrIGZvciBmaWxlc3lz
dGVtIGNvbXBhdGliaWxpdHkgYmVmb3JlIGF0dGVtcHRpbmcKPiA+ID4gPiB0byBjcmVhdGUgYW5k
IGVuYWJsZSBhIHN3YXAgZmlsZS4gIEEgbGlzdCBvZiBzdXBwb3J0ZWQgZmlsZXN5c3RlbXMKPiA+
ID4gPiBpcyBhZGRlZCAoZXh0MiwgZXh0MywgZXh0NCwgeGZzLCB2ZmF0LCBleGZhdCwgbnRmcyks
IGFuZCBhIGNoZWNrCj4gPiA+ID4gYWdhaW5zdCB0aGlzIGxpc3QgaXMgcGVyZm9ybWVkIHRvIGVu
c3VyZSB0aGF0IHRoZSBzd2FwIG9wZXJhdGlvbnMKPiA+ID4gPiBhcmUgb25seSBhdHRlbXB0ZWQg
b24ga25vd24gY29tcGF0aWJsZSBmaWxlc3lzdGVtcy4KPgo+ID4gPiA+IElmIHRoZSBtYWtlX3N3
YXBmaWxlIGZ1bmN0aW9uIGZhaWxzLCB0aGUgZXJyb3IgaGFuZGxpbmcgaXMgbm93Cj4gPiA+ID4g
bW9yZSBkZXNjcmlwdGl2ZTogaXQgZGlzdGluZ3Vpc2hlcyBiZXR3ZWVuIGZhaWx1cmVzIGR1ZSB0
byB0aGUKPiA+ID4gPiBmaWxlc3lzdGVtIG5vdCBzdXBwb3J0aW5nIHN3YXAgZmlsZXMgYW5kIG90
aGVyIHR5cGVzIG9mIGZhaWx1cmVzLgo+ID4gPiA+IFNpbWlsYXJseSwgd2hlbiBhdHRlbXB0aW5n
IHRvIGVuYWJsZSB0aGUgc3dhcCBmaWxlIHdpdGggc3dhcG9uLAo+ID4gPiA+IHRoZSBwYXRjaCBl
bnN1cmVzIHRoYXQgY2xlYXJlciBlcnJvciBtZXNzYWdlcyBhcmUgcHJvdmlkZWQgaW4KPiA+ID4g
PiBjYXNlcyB3aGVyZSB0aGUgb3BlcmF0aW9uIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGZpbGVz
eXN0ZW0uCj4KPiA+ID4gKzEKPgo+ID4gPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+Cj4KPiA+ID4gZm9ybWF0dGluZyBpc3N1ZXMgKHRhYnMpIGFyZSBhY3R1YWxseSBt
b3N0bHkgZnJvbSB0aGlzIGNvbW1pdCwgcGxlYXNlCj4gZml4Cj4gPiA+IHRoZW0KPiA+ID4gYmVm
b3JlIG1lcmdlLgo+Cj4KPiA+IFRoYW5rcyB2ZXJ5IG11Y2gsIFBldHIuCj4KPiA+IFRoZSBwYXRj
aHNldCBWMiAoYmFzZWQgb24geW91ciBzdWdnZXN0aW9ucykgaXMgcHVibGlzaGVkIGluIG15IGdp
dAo+IGJyYW5jaC4KPiA+IEluIGNhc2UgeW91IHdhbnQgdG8gZG8gbW9yZSB0ZXN0cyB0b2RheS4K
Pgo+IFRoYW5rcywgSSBhbHJlYWR5IHNjaGVkdWxlZCB0ZXN0cywgbGV0IHlvdSBrbm93IGxhdGVy
IHRvZGF5Lgo+CgpHcmVhdCwgYW5kIEZZSS4KCkkganVzdCBwdXNoZWQgYSBuZXcgY29tbWl0IHRv
IHJlc29sdmUgdGhlIEZJQk1BUCAodW5zdXBwb3J0ZWQgb24gQlRSRlMpCnByb2JsZW0gb24gbXkg
bHRwOmxpYnN3YXAgYnJhbmNoLgoKaHR0cHM6Ly9naXRodWIuY29tL3dhbmdsaTU2NjUvbHRwL2Nv
bW1pdC82OTk3MTFiZmU4YzhkYmMzNTk3YzQ2NTg3MzQ1ZmExMTk3YzA1NGM5CgpIb3BlIHlvdSBj
YW4gdHJ5IG9uIHlvdXIgc2lkZSBhbmQgZ2l2ZSBzb21lIGZlZWRiYWNrIDopLgoKCgo+ID4gaHR0
cHM6Ly9naXRodWIuY29tL3dhbmdsaTU2NjUvbHRwL3RyZWUvbGlic3dhcAo+Cj4gPiBBbmQsIEkg
cHJlZmVyIHRvIHdhaXQgZm9yIENyeWlsJ3MgZmVlZGJhY2sgYmVmb3JlIHBvc3RpbmcgdGhlbSBp
biBNTDopCj4KPiArMQo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+CgotLSAKUmVnYXJkcywK
TGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
