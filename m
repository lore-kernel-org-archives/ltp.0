Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABE3C6FD18
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 12:42:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 476CF3CD114
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 14:42:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A30A3CA2FA
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 14:42:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8EB4B200B60
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 14:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680007356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJMEZy3Z+KhBgoNXlmlb/RzIahwmvwGDDQr4KrLwgpI=;
 b=gkmeVF+zcKZxQyuK0Ad2TW7gGt3zDZFYjMDHIENfvJOm9B0K9zjEvjrXsarNbrjdGbgZ6e
 BkyCgpboBscOIMclxOj2EvzrFMdZl5B2YOKyT8BhLLHLLoJGr8f8YxCgI+GdBnoe4UamHF
 okTRdupLLqFJpt1z7ZZjVIp5uGD0YyU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-U0Dk47XnNguzOBCKB-LJyA-1; Tue, 28 Mar 2023 08:42:34 -0400
X-MC-Unique: U0Dk47XnNguzOBCKB-LJyA-1
Received: by mail-wm1-f72.google.com with SMTP id
 d11-20020a05600c34cb00b003ee89ce8cc3so6248746wmq.7
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 05:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680007353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJMEZy3Z+KhBgoNXlmlb/RzIahwmvwGDDQr4KrLwgpI=;
 b=FAMeeOYBYZH7TNsVi+GBM+i6tQ0Zj8joBiIrrvAssiVFPlnrvOmonyzSyu6eBbqeJQ
 ItVWgIfjzDTAEnRMPsMUoGx5vGhm+wqkjSP0AVXM5zETBrzoCgKbes8KMjqiYRr6L/rS
 B5dhrua7WHPvFSFUdUdVIItgkOVa8ozAAvO7LhYzrteqWNH/3G5WZHQrtx89EPzHnT9P
 nXdOitGwZgfzL+yN8qgUWtKJYq3wR9JgNl5mtH+5JIQGTIBqKldfBtFOFYWywtuLbjBZ
 O9+0oPP/Gg/aqSraCEtuILpkAjTHVXiGSx+Sp9g8Sr4Gr9C52oa+FRNBYcM5YR2FICZS
 p8Hw==
X-Gm-Message-State: AAQBX9d7S//0Bzpu8wX37YGVBUpjE3jhgStH0SMosbFq5+DoaMT11YEf
 o4oCO6nCBpaH4tpQ+WQfPNUnc4pSw281+TR3spMz3H1UFHbtuUjgYN4ti8MRbE5rnNOJvtwXg1I
 mpESxVoceZcrf4RPwHD80N6GIkq4=
X-Received: by 2002:a05:6000:511:b0:2c5:5817:f241 with SMTP id
 a17-20020a056000051100b002c55817f241mr2613336wrf.7.1680007353264; 
 Tue, 28 Mar 2023 05:42:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZvquJ1m0LgHNXgk27zQW4XxluhPmMjec6GVpg35seueTy7dHGYi4XO8qpoFjNIfms4uryrynyiJMB7YpWNaQs=
X-Received: by 2002:a05:6000:511:b0:2c5:5817:f241 with SMTP id
 a17-20020a056000051100b002c55817f241mr2613326wrf.7.1680007352855; Tue, 28 Mar
 2023 05:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230328111338.766712-1-pvorel@suse.cz>
 <20230328111338.766712-3-pvorel@suse.cz>
In-Reply-To: <20230328111338.766712-3-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2023 20:42:21 +0800
Message-ID: <CAEemH2ekO=T1x4+q+dHR5ONvGTE-jgKT1uDsoVtdG-oboBNzRQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] doc: Add Release procedure
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClRoYW5rcyBmb3IgZHJhZnRpbmcgdGhpcywgcXVpdGUgdXNlZnVsfgoKT24gVHVl
LCBNYXIgMjgsIDIwMjMgYXQgNzoxNOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3
cm90ZToKPgo+IFRoaXMgc2xpZ2h0bHkgb3V0ZGF0ZWQgZG9jdW1lbnQgZXhpc3RzIGluIExUUCB3
aWtpLCBzdGFydCB2ZXJzaW9uaW5nIGl0Cj4gaW4gdGhlIG9yaWdpbmFsIHJlcG9zaXRvcnkuIFRo
ZSBvbmx5IHVudmVyc2lvbmVkIGZpbGUgaW4gdGhlIHdpa2kgaXMKPiBub3cgSG9tZS5yZXN0Lgo+
Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4gVGhp
cyBzaG91bGQgYmUgdXBkYXRlZCwgc28gSSdtIG9rIG5vdCB0byBtZXJnZSBpdCBhbmQgcHJlcGFy
ZSBtb3JlIHVwIHRvCj4gZGF0ZSB2ZXJzaW9uIChhbHRob3VnaCBJJ2QgbmVlZCBDeXJpbCdzIGhl
bHApLgo+Cj4gQWxzbyAoc2VwYXJhdGUgZWZmb3J0KSwgdGhlcmUgaXMgdW52ZXJzaW9uZWQgc2Ny
aXB0LCB3aGljaCBjb3VsZCBiZQo+IGFkZGVkIHRvIGdpdC4gQW5kIHdlIGNvdWxkIHJlbW92ZSBN
YWtlZmlsZS5yZWxlYXNlLCB3aGljaCBJTUhPIGlzIG5vdAo+IHVzZWQgKGFsdGhvdWdoIGl0IHNv
bHZlcyBkZXBlbmRlbmN5OiBydW5uaW5nIGF1dG90b29scyBhbmQgZGlzdGNsZWFuOwo+IG1heWJl
IHdlIGNvdWxkIGNvbWJpbmUgYm90aDogQWRkIHNjcmlwdCBhbmQgYWRkIG1ha2UgdGFyZ2V0IHdo
aWNoIHdvdWxkCj4gcnVuIHRoZSBzY3JpcHQgYWZ0ZXIgc29sdmluZyB0aGUgZGVwZW5kZW5jaWVz
KS4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiAgZG9jL0xUUC1SZWxlYXNlLVByb2NlZHVy
ZS5hc2NpaWRvYyB8IDY3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUg
Y2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jL0xUUC1S
ZWxlYXNlLVByb2NlZHVyZS5hc2NpaWRvYwo+Cj4gZGlmZiAtLWdpdCBhL2RvYy9MVFAtUmVsZWFz
ZS1Qcm9jZWR1cmUuYXNjaWlkb2MgYi9kb2MvTFRQLVJlbGVhc2UtUHJvY2VkdXJlLmFzY2lpZG9j
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAuLmNkNzY4MmZiOAo+IC0t
LSAvZGV2L251bGwKPiArKysgYi9kb2MvTFRQLVJlbGVhc2UtUHJvY2VkdXJlLmFzY2lpZG9jCj4g
QEAgLTAsMCArMSw2NyBAQAo+ICtMVFAgUmVsZWFzZSBQcm9jZWR1cmUKPiArPT09PT09PT09PT09
PT09PT09PT09Cj4gKwo+ICtUaGlzIHBhZ2UgY29udGFpbnMgcXVpY2sgc3VtbWFyeSBvZiB3aGF0
IG5lZWRzIHRvIGJlIGRvbmUgdG8gZG8gYSBMVFAgcmVsZWFzZS4gSXQncyBleHBlY3RlZCB0aGF0
IExUUCBnaXQgaXMgZnJvemVuIGFuZCBnaXQgSEVBRCB3YXMgcHJvcGVybHkgdGVzdGVkIGFuZCB0
aGF0IExUUCBnaXQgdHJlZSBpcyBjbG9uZWQgdG8gYSBkaXJlY3RvcnkgbmFtZWQgJ2x0cCcuCgpT
aG91bGQgd2UgbWVudGlvbiB0aGUgcmVsZWFzZSBpcyBoYXBwZW5pbmcgZXZlcnkgNCBtb250aHM/
Cgo+ICtOT1RFOiBUaGUgc3RyaW5nIFlZWVlNTUREIHNob3VsZCBiZSBzdWJzdGl0dXRlZCB0byB0
aGUgY3VycmVudCBkYXRlLgoKT3IsIG1heWJlIGFkZCBvbmUgbW9yZSBpdGVtIGFib3V0IHRoZSBy
ZWxlYXNlIGV2ZSB3b3JrPwpMaWtlIHdoYXQgd2UgZGlzY3Vzc2VkIGluOgogIC0gaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjItU2VwdGVtYmVyLzAzMDYxNC5odG1sCgpG
b3IgZXhhbXBsZToKCjAuIFJlbGVhc2UgZXZlIHdvcmsKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCgpbc291cmNlLHNoXQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKYS4gQ29sbGVjdGluZyB0aGUgKG11c3QgaGF2
ZSkgcGF0Y2ggbGlzdCBmb3IgbmV3IHJlbGVhc2UKYi4gUmV2aWV3aW5nIGFuZCBtZXJnaW5nIHRo
ZSBwYXRjaCBsaXN0IG9mIChhLikKYy4gV2lkZWx5IHRlc3RpbmcsIGV4cGxpY2l0bHkgcG9zdCBy
ZXN1bHRzCmQuIFRpbnkgZml4IGFjY29yZGluZyB0byByZWxlYXNlIHRlc3RpbmcKZS4gV3JpdGlu
ZyByZWxlYXNlIG5vdGUKLi4uCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgoKPiArMS4gVGFnIHRoZSBnaXQKPiArLS0t
LS0tLS0tLS0tLS0KPiArCj4gK1tzb3VyY2Usc2hdCj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gK2NkIGx0cAo+
ICtlY2hvIFlZWVlNTUREID4gVkVSU0lPTgo+ICtnaXQgY29tbWl0IC1zIC1tICdMVFAgWVlZWU1N
REQnIFZFUlNJT04KPiArZ2l0IHRhZyAtYSBZWVlZTU1ERCAtbSAnTFRQIFlZWVlNTUREJwo+ICst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ICsKPiArMi4gUHVzaCBjaGFuZ2VzIHRvIGdpdGh1Ygo+ICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4gK1tzb3VyY2Usc2hdCj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gK2dpdCBwdXNo
Cj4gK2dpdCBwdXNoIC0tdGFncwo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICsKPiArMy4gUHJlcGFyZSB0YXJi
YWxscwo+ICstLS0tLS0tLS0tLS0tLS0tLS0tCj4gK1tzb3VyY2Usc2hdCj4gKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gK2NkIC4uCj4gK2dpdCBjbG9uZSBsdHAgbHRwLWZ1bGwtWVlZWU1NREQKPiArY2QgbHRwLWZ1
bGwtWVlZWU1NREQKPiArIyBVcGRhdGUgbWNlLWluamVjdCBzdWJtb2R1bGUKPiArZ2l0IHN1Ym1v
ZHVsZSBpbml0Cj4gK2dpdCBzdWJtb2R1bGUgdXBkYXRlCj4gKyMgR2VuZXJhdGUgY29uZmlndXJl
IHNjcmlwdAo+ICttYWtlIGF1dG90b29scwo+ICsjIFByZXBhcmUgdGhlIGFyY2hpdmVzCj4gK2Nk
IC4uCj4gK3RhciAtY2pmIGx0cC1mdWxsLVlZWVlNTURELnRhci5iejIgbHRwLWZ1bGwtWVlZWU1N
REQgLS1leGNsdWRlIC5naXQKPiArdGFyIC1jSmYgbHRwLWZ1bGwtWVlZWU1NREQudGFyLnh6IGx0
cC1mdWxsLVlZWVlNTUREIC0tZXhjbHVkZSAuZ2l0Cj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gKwo+ICs0LiBV
cGxvYWQgdGhlIHRhcmJhbGxzIHRvIEdpdEh1Ygo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+ICsKPiArQ2xpY2sgb24gJ3JlbGVhc2VzJyB0aGVuIHN3aXRjaCB0byAndGFncycg
dGhlbiBjbGljayBvbiAnQWRkIHJlbGVhc2Ugbm90ZXMnIHRoZXJlIHNob3VsZCBiZSAnQXR0YWNo
IGJpbmFyaWVzIC4uLicgbGluayBhdCB0aGUgYm90dG9tIG9mIHRoZSBwYWdlLgo+ICsKPiArRG9u
J3QgZm9yZ2V0IHRvIHVwbG9hZCBtZDUgYW5kIHNoYS0xIHN1bXMgZm9yIHRoZSB0YXJiYWxscyBh
cyB3ZWxsLgo+ICsKPiArNS4gU2VuZCByZWxlYXNlIGFubm91bmNlbWVudAo+ICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gKwo+ICtIYXZlIGEgbG9vayBhdCBodHRwOi8vc291cmNlZm9y
Z2UubmV0L3AvbHRwL21haWxtYW4vbWVzc2FnZS8zNDQyOTY1Ni8gdG8gZ2V0IHRoZSBpZGVhIGhv
dyBpdCBzaG91bGQgbG9vay4KPiArCj4gK1RoZSBhbm5vdW5jZW1lbnQgaXMgc2VuZCB0bzoKPiAr
Cj4gKyogbHRwIGF0IGxpc3RzLmxpbnV4Lml0Cj4gKyogbGludXgta2VybmVsIGF0IHZnZXIua2Vy
bmVsLm9yZwo+ICsqIGxpYmMtYWxwaGEgYXQgc291cmNld2FyZS5vcmcKPiArCj4gK0NDZWQgdG86
Cj4gKwo+ICsqIGx3biBhdCBsd24ubmV0Cj4gKyogYWtwbSBhdCBsaW51eC1mb3VuZGF0aW9uLm9y
Zwo+ICsqIHRvcnZhbGRzIGF0IGxpbnV4LWZvdW5kYXRpb24ub3JnLgo+IFwgTm8gbmV3bGluZSBh
dCBlbmQgb2YgZmlsZQo+IC0tCj4gMi40MC4wCj4KCgotLQpSZWdhcmRzLApMaSBXYW5nCgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
