Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C88DC678D5
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 11:23:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53C113CD9E6
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 12:23:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F68E3CB86E
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 12:23:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5CE5B600779
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 12:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678188217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jzXgh5JkP2ikxUVsp8LnOilAYhlufUP5w20iaDyMFGc=;
 b=QTOvI9AceA2HUnezy4CXwHfXmtfHPDNal/3kUgpxylEKGDwUkB1IF8BrwULD6Sb1X6rCsH
 chRaX3lKGyEHI3bdLrdO6uOFdbjTgDoH7WkohWZ/ZzQFBjVSzWwNpnuFCRP1xDudbLrGI+
 eHykpifYJyX8bk0PRGf/Mt+qmqLojFk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-tioZsxnKMfmk_lHK2yNcQA-1; Tue, 07 Mar 2023 06:23:36 -0500
X-MC-Unique: tioZsxnKMfmk_lHK2yNcQA-1
Received: by mail-wm1-f70.google.com with SMTP id
 j32-20020a05600c1c2000b003e9bdf02c9fso8120660wms.6
 for <ltp@lists.linux.it>; Tue, 07 Mar 2023 03:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678188215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzXgh5JkP2ikxUVsp8LnOilAYhlufUP5w20iaDyMFGc=;
 b=llCkcfQMIU9KY5B+l7fJ1Qxb0xfdQuIWVz2BOLbh5yxbZRLSyFAiL6iDTt5P28V/XA
 O3hF6i7pZQOumnodISQCn5fdTX8kHpFvSRHWI2ycnwr2gDI22N71pAzQEg2puBkyNZcl
 Fobe7ruE1Op0VMI11bjzVwyKKAPv+lheC0AfKFnvDv/ySUNFD5DxJViy7/k8jeY4Jh7R
 9OR9Fl2v3u/+jkL/NYYlnOyRAL0DGijJkkICW21vWaeptQSG/iL3kuns3ppyL9LWRROx
 WU6Ek1qDmIo4nIJf0VLOWZgpbj1j77SGPp3J7naD6I3h690x2HOMAPMccqYEVatdmiJo
 1AFQ==
X-Gm-Message-State: AO0yUKUxvnHAAF05AQe9nREA79WV4KWZSwoO2UgXEbq7UluuknnU3Fvd
 l8XtvihYKG938FYuyIFKod8ZoQkxt5D5rnav7hBHnW0J6HFXAo0YcrtxH16XDDRjvqorU6aWJUs
 fPp1qtBWhVl+A10QxjtM13u8aKOc=
X-Received: by 2002:a05:600c:16c6:b0:3e0:12e2:985c with SMTP id
 l6-20020a05600c16c600b003e012e2985cmr3112634wmn.7.1678188215511; 
 Tue, 07 Mar 2023 03:23:35 -0800 (PST)
X-Google-Smtp-Source: AK7set83YMnq9NjM5ITMcT2JHkjRBr0bdtku2QTFgtKhvhTHVpcMtHSAn98VytzpqZWvN6Tex7WWxi7siJrUNHWr0wA=
X-Received: by 2002:a05:600c:16c6:b0:3e0:12e2:985c with SMTP id
 l6-20020a05600c16c600b003e012e2985cmr3112627wmn.7.1678188215204; Tue, 07 Mar
 2023 03:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20230306151303.2757-1-wegao@suse.com>
 <20230306235715.29868-1-wegao@suse.com>
 <CAEemH2fZs33CkwHY+Jre71eKpkB6bPPmOOxuHZQTGHOofa9KaA@mail.gmail.com>
 <20230307082755.GA13371@localhost>
In-Reply-To: <20230307082755.GA13371@localhost>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Mar 2023 19:23:23 +0800
Message-ID: <CAEemH2d6XBSHp3SgNgZrQ+SxHTB8P+noNoz7CoVf_5cP_ecs0A@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] kill01: New case cgroup kill
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

T24gVHVlLCBNYXIgNywgMjAyMyBhdCA0OjI44oCvUE0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+
IHdyb3RlOgoKPiBPbiBUdWUsIE1hciAwNywgMjAyMyBhdCAwMzoxMzo1NlBNICswODAwLCBMaSBX
YW5nIHdyb3RlOgo+ID4gSGkgV2VpLAo+ID4KPiA+IFRoZSBuZXcgdGVzdCBnZW5lcmFsbHkgbG9v
a3MgZ29vZCB0byBtZS4KPiA+Cj4gPiBJJ20gdGhpbmtpbmcgbWF5YmUgd2UgbWFrZSB1c2Ugb2Yg
Z3VhcmRlZCBidWZmZXJzIHdoaWNoIGNvdWxkCj4gPiByZW1vdmUgdGhlIHNldHVwL2NsZWFudXAg
ZnVuY3Rpb24gdGhlbi4gQW5kIGRvaW5nIG1lbXNldChidWYsLi4uKQo+ID4gYmVmb3JlIHJlYWRp
bmcgaW50byBidWZbXSBpcyBxdWl0ZSBuZWNlc3NhcnksIHRvIGF2b2lkIHNvbWVvbmUKPiA+IHJ1
bm5pbmcgdGhpcyB0ZXN0IHdpdGggcGFyYW1ldGVyICctaSBOJyB0aGF0IHRoZSBidWZbXSBpcyBw
b2xsdXRlZAo+ID4gYnkgdGhlIGZpcnN0IHRpbWUuCj4gPgo+ID4KPiBodHRwczovL2dpdGh1Yi5j
b20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rlci9kb2MvYy10ZXN0LWFwaS50eHQj
TDE3OTkKPiA+Cj4gPiA8Cj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9s
dHAvYmxvYi9tYXN0ZXIvZG9jL2MtdGVzdC1hcGkudHh0I0wxNzk5Cj4gPgo+ID4gZS5nLgo+Cj4g
SSBoYXZlIHRyaWVkIHVzZSBndWFyZGVkIGJ1ZmZlcnMgYnV0IGNvbXBpbGUgY2FuIG5vdCBwYXNz
Lgo+IEZvbGxvd2luZyBlcnJvciB3aWxsIHRyaWdnZXIgc2luY2UgYnVmX2xlbiBpcyBjYWN1bGF0
ZSBpbnN0ZWFkIG9mIEZJWAo+IGNvbnN0YW50LiBTbwo+IEkgc3VwcG9zZSB3ZSBjYW4gbm90IHVz
ZSBndWFyZGVkIGJ1ZmZlcnM/Cj4KClN1cmUsIGl0IGRvZXNuJ3QgbWF0dGVyLgpZb3UgdXNlZCBh
biB1bmNlcnRhaW4gdmFyaWFibGUgaW4gLnNpemUgb2YgdHN0X2J1ZmZlciwgdGhhdCdzIHdoeSBp
dCB0aHJvd3MKb3V0IHRoZSBjb21waWxpbmcgZXJyb3IuCgoKCj4KPiBraWxsMDEuYzoxMzE6MzQ6
IGVycm9yOiBpbml0aWFsaXplciBlbGVtZW50IGlzIG5vdCBjb25zdGFudAo+ICAgLmJ1ZnMgPSAo
c3RydWN0IHRzdF9idWZmZXJzIFtdKSB7Cj4KPiBGb3IgbWVtc2V0IGJlZm9yZSByZWFkaW5nIGJ1
ZiBpc3N1ZSwgaSB3aWxsIHVwZGF0ZSBpbiBuZXh0IHBhdGNoLgo+Cj4gPgo+ID4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9raWxsL2tpbGwwMS5jCj4gPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL2NvbnRyb2xsZXJzL2tpbGwva2lsbDAxLmMKPiA+IEBAIC0yNiw3ICsyNiw3IEBA
Cj4gPgo+ID4gICNkZWZpbmUgTUFYX1BJRF9OVU0gMTAwCj4gPiAgI2RlZmluZSBwaWRfbnVtIE1J
TihNQVhfUElEX05VTSwgKHRzdF9uY3B1c19hdmFpbGFibGUoKSArIDEpKQo+ID4gLSNkZWZpbmUg
YnVmX2xlbiAoMjAgKiBwaWRfbnVtKQo+ID4gKyNkZWZpbmUgYnVmX2xlbiAoMTAgKiBNQVhfUElE
X05VTSkKPiA+Cj4gPiAgc3RhdGljIGNoYXIgKmJ1ZjsKPiA+ICBzdGF0aWMgc3RydWN0IHRzdF9j
Z19ncm91cCAqY2dfY2hpbGRfdGVzdF9zaW1wbGU7Cj4gPiBAQCAtNjAsNyArNjAsNiBAQCBzdGF0
aWMgdm9pZCBjaGlsZF9mbih2b2lkKQo+ID4KPiA+ICAgICAgICAgd2hpbGUgKGdldHBwaWQoKSA9
PSBwcGlkKQo+ID4gICAgICAgICAgICAgICAgIHVzbGVlcCgxMDAwKTsKPiA+IC0KPiA+ICB9Cj4g
Pgo+ID4gIHN0YXRpYyBpbnQgY2dfcnVuX25vd2FpdChjb25zdCBzdHJ1Y3QgdHN0X2NnX2dyb3Vw
ICpjb25zdCBjZywKPiA+IEBAIC04Miw2ICs4MSw4IEBAIHN0YXRpYyBpbnQgY2dfd2FpdF9mb3Jf
cHJvY19jb3VudChjb25zdCBzdHJ1Y3QKPiA+IHRzdF9jZ19ncm91cCAqY2csIGludCBjb3VudCkK
PiA+ICAgICAgICAgaW50IGF0dGVtcHRzOwo+ID4gICAgICAgICBjaGFyICpwdHI7Cj4gPgo+ID4g
KyAgICAgICBtZW1zZXQoYnVmLCAwLCBidWZfbGVuKTsKPiA+ICsKPiA+ICAgICAgICAgZm9yIChh
dHRlbXB0cyA9IDEwMDsgYXR0ZW1wdHMgPj0gMDsgYXR0ZW1wdHMtLSkgewo+ID4gICAgICAgICAg
ICAgICAgIGludCBuciA9IDA7Cj4gPgo+ID4gQEAgLTEyMSwyMyArMTIyLDE0IEBAIHN0YXRpYyB2
b2lkIHJ1bih2b2lkKQo+ID4gICAgICAgICBjZ19jaGlsZF90ZXN0X3NpbXBsZSA9IHRzdF9jZ19n
cm91cF9ybShjZ19jaGlsZF90ZXN0X3NpbXBsZSk7Cj4gPiAgfQo+ID4KPiA+IC1zdGF0aWMgdm9p
ZCBzZXR1cCh2b2lkKQo+ID4gLXsKPiA+IC0gICAgICAgYnVmID0gU0FGRV9NQUxMT0MoYnVmX2xl
bik7Cj4gPiAtICAgICAgIG1lbXNldChidWYsIDAsIGJ1Zl9sZW4pOwo+ID4gLX0KPiA+IC0KPiA+
IC1zdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gPiAtewo+ID4gLSAgICAgICBmcmVlKGJ1Zik7
Cj4gPiAtfQo+ID4gLQo+ID4gIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ICAg
ICAgICAgLnRlc3RfYWxsID0gcnVuLAo+ID4gLSAgICAgICAuc2V0dXAgPSBzZXR1cCwKPiA+IC0g
ICAgICAgLmNsZWFudXAgPSBjbGVhbnVwLAo+ID4gICAgICAgICAuZm9ya3NfY2hpbGQgPSAxLAo+
ID4gICAgICAgICAubWF4X3J1bnRpbWUgPSAxNSwKPiA+ICAgICAgICAgLm5lZWRzX2Nncm91cF9j
dHJscyA9IChjb25zdCBjaGFyICpjb25zdCBbXSl7ICJtZW1vcnkiLCBOVUxMIH0sCj4gPiAgICAg
ICAgIC5uZWVkc19jZ3JvdXBfdmVyID0gVFNUX0NHX1YyLAo+ID4gKyAgICAgICAuYnVmcyA9IChz
dHJ1Y3QgdHN0X2J1ZmZlcnMgW10pIHsKPiA+ICsgICAgICAgICAgICAgICB7JmJ1ZiwgLnNpemUg
PSBidWZfbGVufSwKPiA+ICsgICAgICAgICAgICAgICB7fQo+ID4gKyAgICAgICB9Cj4gPiAgfTsK
PiA+Cj4gPiBBbnl3YXkgdGhpcyB2ZXJzaW9uIHlvdSBjb3VsZCBhZGQgbXkgcmV2aWV3ZWQtYnk6
Cj4gPgo+ID4gUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+ID4KPiA+
Cj4gPiAtLQo+ID4gUmVnYXJkcywKPiA+IExpIFdhbmcKPgo+CgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
