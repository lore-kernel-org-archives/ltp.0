Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE8BC28B30
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 03:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742526086; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=R2Tp9OdCbnMCK3C+W5z/oN4jNEss/bFxMDYPEuu2VTc=;
 b=ACyRF2yOhBLV3n45WId7ENwXOIoN+og/vMcGCu5xHNpyAPzOjZu/dYs8aJ6mfByzD1+CN
 w8emdy1pHOuL42qpVcaRrVy6z9+kPgTUrDl+OhizBhRMSnGhB032uJ7llWfidnCxl2nN+8D
 2Nz03ZBRQT2G23uuB1hn8lifC2j0HsQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B28103CAECC
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 04:01:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 501C33CAE68
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 04:01:03 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 34AE71400059
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 04:01:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742526061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3MPd8TBHHwOMOlX415jmLv1jd69jIJ2obZj9gb9t1hQ=;
 b=PDbNoaryuAZ4DhnwfciDSSuHnDc7I+CBKxNswy1//q4iAJnfc4tVfd+TIzhcX3zByT6W+m
 nrQ/DikkADof4EJYgXt+0nqoWf1ZRmqMD4znxMgCSjQVleLCAAukUC4HiwSdsT1KnkhFxC
 lc7ZhSl3pWqVYfgkI+y0D/+8rZ53PPw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-RMmwF_fzOcKlXy8qy0h7VA-1; Thu, 20 Mar 2025 23:00:59 -0400
X-MC-Unique: RMmwF_fzOcKlXy8qy0h7VA-1
X-Mimecast-MFC-AGG-ID: RMmwF_fzOcKlXy8qy0h7VA_1742526058
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff8c5d185aso4411123a91.1
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 20:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742526058; x=1743130858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3MPd8TBHHwOMOlX415jmLv1jd69jIJ2obZj9gb9t1hQ=;
 b=HWdNxHTk2BK8Lo5nWfCqmLMkbUyQu6xNSgdt/vbgEeGEhq1TWDU2LrIUvMo2GUZMiK
 05O1yLUp7gXMDxOnZeV6cSVOm4iFrPgJ5yedH+d/SBuen1ELYTpGvUFvAdZ3xi0j03XP
 aOd62PPilw0Csi6mnM5e4ZfPX8WvA+kfzQshFF8F8XRiUpH5XcSRCjwlcyKOkOfr4Dvk
 oA9vtIyTMypAFgLqFtnzEUsWFySe1A1TVUTjIEw4kPRd+O2JQN8VUkKKEiREThhZxxRh
 6bWUvP36moYidNqVl9rec9NsAl4Mn1ea9R/8ZkaDxvXwGjwF0CnZxpGtz9M7Xr9T/B1G
 chdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgZT0/rhX1UH2iaezf7Qy0NLjtcXPWH+O7YL7lZ5rTow3ZPBEJ79SrMmDNTHYfjD/K7os=@lists.linux.it
X-Gm-Message-State: AOJu0YzlVFKv5aOOk5uyoR3MiHJ2jHB7+rAqvQ/Ee7oMN6cM4Gm0Em0X
 QzQiumAvZWuF6hYX7B491xlSFAlwWcQSkZy6pRuoTb3swCaMYgZ4IF05pvJT7ZWMmlOJR8z6+So
 0Ft/iKxUMuwHKkRtRVn6urOmd8rKzggZQxv9ocBO7owvND2nwI3JgD418nP58vXgKEYmHF14rWN
 6GtuEYa3KtbvzXHd5xwZcdb44=
X-Gm-Gg: ASbGnctAUXx+RvDHgaT2V9A40B4cojTW8gdA3kW03HM261l6xECwe+yoU03QJ0zrYcO
 6tOk1AIN74R5KSz4lY3LO3NDKq9W2hBe/+27F9KQ0L3CiGsTtRBv9sbYlTYofaO3mvlpbOHU0nQ
 ==
X-Received: by 2002:a17:90b:1802:b0:2fe:8fc4:6f4b with SMTP id
 98e67ed59e1d1-3030fe98a52mr2300513a91.8.1742526057844; 
 Thu, 20 Mar 2025 20:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR4b7XbSwhG4jI0xcqyTVZ7A4IKuwIHQtF1mmUtpTg9OQXPk/Xyy9Dslr5z7vshc5DPaSlsqhW3VoP0N0IJhY=
X-Received: by 2002:a17:90b:1802:b0:2fe:8fc4:6f4b with SMTP id
 98e67ed59e1d1-3030fe98a52mr2300479a91.8.1742526057397; Thu, 20 Mar 2025
 20:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240612121106.11127-1-chrubis@suse.cz>
 <20240612121106.11127-2-chrubis@suse.cz>
 <20250320173141.GA114876@pevik>
In-Reply-To: <20250320173141.GA114876@pevik>
Date: Fri, 21 Mar 2025 11:00:44 +0800
X-Gm-Features: AQ5f1JqMeulgeBMYmtkUTJQp9a5aPVNL38DVCBrCNDjmdBsEcaGl8I3PikQ8th0
Message-ID: <CAEemH2d8OzjHVi7ZJD3ah=C+JpDFmGcRTj=4CzDZ950uNqBfmw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2poGj2nWei9V5O2Yvfm1lrbhXbFVjVJo3Mbc--l5H3k_1742526058
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] lib: tst_test: Add per filesystem mkfs and
 mount opts
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMjEsIDIwMjUgYXQgMTozMeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgQ3lyaWwsIGFsbCwKPgo+ID4gVGhpcyBjb21taXQgZG9lczoKPgo+
ID4gKiBHcm91cCB0aGUgZmlsZXN5c3RlbSB0eXBlLCBta2ZzIGFuZCBtb3VudCBvcHRpb25zIGlu
dG8gYSBzZXBhcmF0ZQo+ID4gICBzdHJ1Y3R1cmUKPgo+ID4gKiBBZGQgYW4gYXJyYXkgb2YgdGhl
c2Ugc3RydWN0dXJlcyB0byBiZSBhYmxlIHRvIGRlZmluZSBwZXIgZmlsZXN5c3RlbQo+ID4gICBt
a2ZzIGFuZCBtb3VudCBvcHRpb25zCj4KPiA+IFRoZSBkZXRhaWxzIG9uIHRoZSB1c2FnZSBzaG91
bGQgYmUgaG9wZWZ1bGx5IGNsZWFyIGZyb20gdGhlCj4gPiBkb2N1bWVudGF0aW9uIGNvbW1lbnRz
IGZvciB0aGUgc3RydWN0IHRzdF90ZXN0Lgo+Cj4gRllJLCB0aGlzIG1lcmdlZCBhcyBjY2U2MTg4
OTE2ICgibGliOiB0c3RfdGVzdDogQWRkIHBlciBmaWxlc3lzdGVtIG1rZnMgYW5kCj4gbW91bnQg
b3B0cyIpIGNhdXNlcyB0aGlzIGJlaGF2aW9yIG9mIG5vbmUgdGVzdGluZyBydW4gd2hlbiB0aGVy
ZSBpcyBubwo+IHN1aXRhYmxlCj4gZmlsZXN5c3RlbS4gSSBmb3VuZCBpdCB3aGVuIHRyeWluZyB0
byBiaXNlY3Qgc29tZXRoaW5nIHdpdGggcmFwaWRvLWxpbnV4Cj4gYW5kCj4gY29tcGlsZSBrZXJu
ZWwgd2l0aG91dCBCdHJmcyBhbmQgWEZTLiBEb24ndCB3ZSB3YW50IHRvIGFkZCBzb21lIFRDT05G
Pwo+CgpJIHRoaW5rIHdlIG5lZWQgVENPTkYgdGhlcmUuIENhbiB5b3UgY29uZmlybSBiZWxvdyBj
aGFuZ2UgbWFrZXMgc2Vuc2U/CgotLS0gYS9saWIvdHN0X3Rlc3QuYworKysgYi9saWIvdHN0X3Rl
c3QuYwpAQCAtMTg1Niw2ICsxODU2LDcgQEAgc3RhdGljIGludCBydW5fdGNhc2VzX3Blcl9mcyh2
b2lkKQogICAgICAgIGludCByZXQgPSAwOwogICAgICAgIHVuc2lnbmVkIGludCBpOwogICAgICAg
IGNvbnN0IGNoYXIgKmNvbnN0ICpmaWxlc3lzdGVtcyA9CnRzdF9nZXRfc3VwcG9ydGVkX2ZzX3R5
cGVzKHRzdF90ZXN0LT5za2lwX2ZpbGVzeXN0ZW1zKTsKKyAgICAgICBib29sIGZvdW5kX3ZhbGlk
X2ZzID0gZmFsc2U7CgogICAgICAgIGlmICghZmlsZXN5c3RlbXNbMF0pCiAgICAgICAgICAgICAg
ICB0c3RfYnJrKFRDT05GLCAiVGhlcmUgYXJlIG5vIHN1cHBvcnRlZCBmaWxlc3lzdGVtcyIpOwpA
QCAtMTg2Niw2ICsxODY3LDcgQEAgc3RhdGljIGludCBydW5fdGNhc2VzX3Blcl9mcyh2b2lkKQog
ICAgICAgICAgICAgICAgaWYgKCFmcykKICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7
CgorICAgICAgICAgICAgICAgZm91bmRfdmFsaWRfZnMgPSB0cnVlOwogICAgICAgICAgICAgICAg
cmV0ID0gcnVuX3RjYXNlX29uX2ZzKGZzLCBmaWxlc3lzdGVtc1tpXSk7CgogICAgICAgICAgICAg
ICAgaWYgKHJldCA9PSBUQ09ORikKQEAgLTE4NzcsNiArMTg3OSw5IEBAIHN0YXRpYyBpbnQgcnVu
X3RjYXNlc19wZXJfZnModm9pZCkKICAgICAgICAgICAgICAgIGRvX2V4aXQocmV0KTsKICAgICAg
ICB9CgorICAgICAgIGlmICghZm91bmRfdmFsaWRfZnMpCisgICAgICAgICAgICAgICB0c3RfYnJr
KFRDT05GLCAiTm8gcmVxdWlyZWQgZmlsZXN5c3RlbXMgYXJlIGF2YWlsYWJsZSIpOworCiAgICAg
ICAgcmV0dXJuIHJldDsKIH0KCgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiBpb2N0bF9m
aWNsb25lMDMuYzoKPiAgICAgICAgIC5maWxlc3lzdGVtcyA9IChzdHJ1Y3QgdHN0X2ZzIFtdKSB7
Cj4gICAgICAgICAgICAgICAgIHsudHlwZSA9ICJidHJmcyJ9LAo+ICAgICAgICAgICAgICAgICB7
LnR5cGUgPSAiYmNhY2hlZnMifSwKPiAgICAgICAgICAgICAgICAgewo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIC50eXBlID0gInhmcyIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgLm1pbl9r
dmVyID0gIjQuMTYiLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIC5ta2ZzX3ZlciA9ICJta2Zz
LnhmcyA+PSAxLjUuMCIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgLm1rZnNfb3B0cyA9IChj
b25zdCBjaGFyICpjb25zdCBbXSkgeyItbSIsCj4gInJlZmxpbms9MSIsIE5VTEx9LAo+ICAgICAg
ICAgICAgICAgICB9LAo+ICAgICAgICAgICAgICAgICB7fQo+ICAgICAgICAgfSwKPgo+IHJhcGlk
bzE6L29wdC9sdHAvdGVzdGNhc2VzL2JpbiMgLi9pb2N0bF9maWNsb25lMDM7IGVjaG8gJD8KPiB0
c3RfYnVmZmVycy5jOjU3OiBUSU5GTzogVGVzdCBpcyB1c2luZyBndWFyZGVkIGJ1ZmZlcnMKPiB0
c3RfdG1wZGlyLmM6MzE3OiBUSU5GTzogVXNpbmcgL3RtcC9MVFBfaW9jU0tMUzlsIGFzIHRtcGRp
ciAodG1wZnMKPiBmaWxlc3lzdGVtKQo+IHRzdF9kZXZpY2UuYzo5OTogVElORk86IEZvdW5kIGZy
ZWUgZGV2aWNlIDAgJy9kZXYvbG9vcDAnCj4gdHN0X3Rlc3QuYzoxOTAwOiBUSU5GTzogTFRQIHZl
cnNpb246IDIwMjUwMTMwLTE2Ni1nMTc5NjBkOTUyCj4gdHN0X3Rlc3QuYzoxOTA0OiBUSU5GTzog
VGVzdGVkIGtlcm5lbDogNC41LjAtMDAwMDItZzIyYmQzMzJmMTFkNCAjMTYyIFNNUAo+IFRodSBN
YXIgMjAgMTg6MDA6MTAgQ0VUIDIwMjUgeDg2XzY0Cj4gdHN0X2tjb25maWcuYzo4ODogVElORk86
IFBhcnNpbmcga2VybmVsIGNvbmZpZyAnLy5jb25maWcnCj4gdHN0X3Rlc3QuYzoxNzI0OiBUSU5G
TzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMxcwo+IHRzdF9zdXBwb3J0ZWRf
ZnNfdHlwZXMuYzo5NzogVElORk86IEtlcm5lbCBzdXBwb3J0cyBleHQyCj4gdHN0X3N1cHBvcnRl
ZF9mc190eXBlcy5jOjYyOiBUSU5GTzogbWtmcy5leHQyIGRvZXMgZXhpc3QKPiB0c3Rfc3VwcG9y
dGVkX2ZzX3R5cGVzLmM6OTc6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgZXh0Mwo+IHRzdF9zdXBw
b3J0ZWRfZnNfdHlwZXMuYzo2MjogVElORk86IG1rZnMuZXh0MyBkb2VzIGV4aXN0Cj4gdHN0X3N1
cHBvcnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIGV4dDQKPiB0c3Rf
c3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjI6IFRJTkZPOiBta2ZzLmV4dDQgZG9lcyBleGlzdAo+IHRz
dF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxMDU6IFRJTkZPOiBTa2lwcGluZyBiY2FjaGVmcyBiZWNh
dXNlIG9mIEZVU0UKPiBibGFja2xpc3QKPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6OTc6IFRJ
TkZPOiBLZXJuZWwgc3VwcG9ydHMgdmZhdAo+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo2Mjog
VElORk86IG1rZnMudmZhdCBkb2VzIGV4aXN0Cj4gdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3
OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIHRtcGZzCj4gdHN0X3N1cHBvcnRlZF9mc190eXBlcy5j
OjQ5OiBUSU5GTzogbWtmcyBpcyBub3QgbmVlZGVkIGZvciB0bXBmcwo+Cj4gU3VtbWFyeToKPiBw
YXNzZWQgICAwCj4gZmFpbGVkICAgMAo+IGJyb2tlbiAgIDAKPiBza2lwcGVkICAwCj4gd2Fybmlu
Z3MgMAo+IDAKPgo+IHJhcGlkbzE6L29wdC9sdHAvdGVzdGNhc2VzL2JpbiMgZ3JlcCAtZSBDT05G
SUdfQlRSRlNfRlMgLWUgQ09ORklHX1hGU19GUwo+IC8uY29uZmlnCj4gKyBncmVwIC1lIENPTkZJ
R19CVFJGU19GUyAtZSBDT05GSUdfWEZTX0ZTIC8uY29uZmlnCj4gIyBDT05GSUdfWEZTX0ZTIGlz
IG5vdCBzZXQKPiAjIENPTkZJR19CVFJGU19GUyBpcyBub3Qgc2V0Cj4KPgoKLS0gClJlZ2FyZHMs
CkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
