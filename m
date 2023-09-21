Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4B0E706E3
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 08:18:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2445E3CDE97
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 10:18:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAB503CBAB8
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 10:18:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C810114013BD
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 10:18:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695284302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ewd/uEhnacxB/fEDCiuqCdOt463SXL94OutzH1Vao1E=;
 b=f/IN6KopwnWnITWeKOLdqykx+XpAUniV1FubDimOeGgffoQhGAcCgbdmTXy04R2g40Kptw
 Pco9yqUNSiDYcYOUTFMSENWRkvIROff1CPeLxieeNn07XBQG78bHfwvgSBqn98UDUo+kCp
 dREPVkwVT8LJB6oxoSdLa0nhraYmrJQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-3tMQaRmhP6u3yvvP3G4v4w-1; Thu, 21 Sep 2023 04:18:20 -0400
X-MC-Unique: 3tMQaRmhP6u3yvvP3G4v4w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-503269edbb3so914904e87.2
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 01:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695284298; x=1695889098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ewd/uEhnacxB/fEDCiuqCdOt463SXL94OutzH1Vao1E=;
 b=T/RSayYTgoOMOlJp8k7dxdHhLlz072LhVgsisf7TMwcaElziSBFAStJX/YZwEIg0H1
 ZLsQSqSWXK8EDSS82G++PXZtfbQUQ9lwlif1CYKlfm15Xu72+cfB3W16fdsaGSJ3yQgZ
 NDI6p86JzmYB6APVC39efDWWk/c2Hriic9hx7lzOBJ4oTWouFgIdcz2OgzT09l/M1p0Z
 1QNd4BKrAvm7eV5j8XRkodZSwVJUcxwP4N9UwaSEoDglPCiImdqyH+kvMvuXW9/+l503
 Sqy7bi1bRXXAr0fGIvCZXP4YuOwXuERe+23IjxcwTFSd1ZJ/uTnDm2eHM9p5kqz9sIRG
 3hEQ==
X-Gm-Message-State: AOJu0YzqfVP0rO+nmf6numM7jG46V+1LavAAKHEnAPryVdovAOorW83d
 GwtjxghbyFs3/vWN0IG7y07OEL4ZDg4lnGha6Oa3LlmmLf0bu9n4LBZcPMfHR93NgF18KaNU0Sq
 cJEKvOw2+dMnem8pujlGw132cyZw=
X-Received: by 2002:a19:2d07:0:b0:502:d6b2:922e with SMTP id
 k7-20020a192d07000000b00502d6b2922emr3724727lfj.46.1695284298375; 
 Thu, 21 Sep 2023 01:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP6iAE2mW0sVVcJ6w4ZaALCPT1vL2ZjoLAMEHXAXhrzJQubzeFAamK3x7VfRVl4NflYy5tozdW54OCJhh0KJA=
X-Received: by 2002:a19:2d07:0:b0:502:d6b2:922e with SMTP id
 k7-20020a192d07000000b00502d6b2922emr3724718lfj.46.1695284298008; Thu, 21 Sep
 2023 01:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230920095318.340582-1-pvorel@suse.cz>
In-Reply-To: <20230920095318.340582-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Sep 2023 16:18:05 +0800
Message-ID: <CAEemH2fKvKrN_S1j34UpfzDpqob_sasuxGt8Ji81TkzEFpt_UQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/5] Release scripts and docs
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

SGkgUGV0ciwgQWxsLAoKVGhhbmtzIGZvciB3cml0aW5nIGRvd24gdGhlIHJlbGVhc2UgcHJvY2Vk
dXJlLCB2ZXJ5IHVzZWZ1bC4KCkJ1dCBJIGRvdWJ0IHRoYXQgd2UgcmVhbGx5IG5lZWQgdGhlIHNj
cmlwdHMgdG8gZG8gcmVsZWFzZSB3b3JrCmF1dG9tYXRpY2FsbHkgc2luY2Ugd2UgX29ubHlfIGRv
IHRoZSByZWxlYXNlIGV2ZXJ5IGZvdXIgbW9udGhzLgpJdCBzZWVtcyB0byBicmluZyBhZGRpdGlv
bmFsIG1haW50ZW5hbmNlIHdvcmsgdW5uZWNlc3NhcmlseS4KCkkgcGVyc29uYWxseSB0aGluayB0
aGUgbWFudWFsIHN0ZXAgaXMgZGV0YWlsZWQgZW5vdWdoIGZvciB1cy4KQnV0IGFueXdheSwgbm93
IHlvdSBoYXZlIGRvbmUgdGhlIGF1dG9tYXRpb24sIEkgZG9uJ3QgaGF2ZQphbiBvYmplY3Rpb24g
dG8geW91ciBwYXRjaCBzZXQsIGp1c3QgZmVlbCB0aGF0IHdlIGF1dG9tYXRlIGZvciB0aGUKc2Fr
ZSBvZiBhdXRvbWF0aW9uIDopLgoKSSdkIGxpa2UgdG8gaGVhciBtb3JlIG9waW5pb25zLCBidXQg
aWYgbW9zdCBvZiB1cyB0aGluayB0aGUgc2NyaXB0IGlzCm5lY2Vzc2FyeSwgSSdtIGhhcHB5IHRv
IGFjY2VwdCB0aGVtIGFzIHdlbGwuCgoKT24gV2VkLCBTZXAgMjAsIDIwMjMgYXQgNTo1M+KAr1BN
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSGksCj4KPiBjb3B5IHBhc3Rp
bmcgcmVsZWFzZSBpcyBlcnJvciBwcm9uZSwgdGh1cyBJIHdyb3RlIHJlbGVhc2Ugc2NyaXB0cy4K
PiBBbnkgY2hhbmdlIHlvdSB3b3VsZCBoYXZlIGxvb2sgb24gaXQgYmVmb3JlIHJlbGVhc2U/Cj4K
PiAyIGNvbW1pdHMgd2VyZSBhbHJlYWR5IHBvc3RlZCBiZWZvcmUsIExpIGhhZCBzb21lIG5vdGVz
IGFib3V0IHRoZQo+IHByb2NlZHVyZSwgdGh1cyBJIHVwZGF0ZWQgaXQuCj4KPiBLaW5kIHJlZ2Fy
ZHMsCj4gUGV0cgo+Cj4gUGV0ciBWb3JlbCAoNSk6Cj4gICB0b29sczogQWRkIGEgc2NyaXB0IGZv
ciB0YWdnaW5nIHRoZSByZWxlYXNlCj4gICB0b29sczogQWRkIHNjcmlwdCBmb3IgY3JlYXRpbmcg
dGFyYmFsbHMgYW5kIG1ldGFkYXRhCj4gICBkb2M6IFJlbmFtZSBmaWxlcyB0byBuYW1lcyBmcm9t
IGx0cC53aWtpLmdpdAo+ICAgZG9jOiBBZGQgUmVsZWFzZSBwcm9jZWR1cmUKPiAgIGRvYzogVXBk
YXRlIHJlbGVhc2UgcHJvY2VkdXJlCj4KPiAgLmdpdGh1Yi93b3JrZmxvd3Mvd2lraS1taXJyb3Iu
eW1sICAgICAgICAgICAgIHwgIDE2ICstLQo+ICAuLi5pbGQtc3lzdGVtLWd1aWRlLnR4dCA9PiBC
dWlsZC1TeXN0ZW0ucmVzdH0gfCAgIDAKPiAgZG9jL3tjLXRlc3QtYXBpLnR4dCA9PiBDLVRlc3Qt
QVBJLmFzY2lpZG9jfSAgIHwgICAwCj4gIC4uLm1wbGUudHh0ID0+IEMtVGVzdC1DYXNlLVR1dG9y
aWFsLmFzY2lpZG9jfSB8ICAgMAo+ICAuLi4tYy1hcGkudHh0ID0+IEMtVGVzdC1OZXR3b3JrLUFQ
SS5hc2NpaWRvY30gfCAgIDAKPiAgLi4ua3ZtLXRlc3QtYXBpLnR4dCA9PiBLVk0tVGVzdC1BUEku
YXNjaWlkb2N9IHwgICAwCj4gIC4uLlAtTGlicmFyeS1BUEktV3JpdGluZy1HdWlkZWxpbmVzLmFz
Y2lpZG9jfSB8ICAgMAo+ICBkb2MvTFRQLVJlbGVhc2UtUHJvY2VkdXJlLmFzY2lpZG9jICAgICAg
ICAgICAgfCAxMTYgKysrKysrKysrKysrKysrKysrCj4gIC4uLmFpbnRhaW5lci1QYXRjaC1SZXZp
ZXctQ2hlY2tsaXN0LmFzY2lpZG9jfSB8ICAgMAo+ICAuLi5sLXRlc3QtYXBpLnR4dCA9PiBTaGVs
bC1UZXN0LUFQSS5hc2NpaWRvY30gfCAgIDAKPiAgLi4ua2VybmVsLC1saWJjLC10b29sY2hhaW4t
dmVyc2lvbnMuYXNjaWlkb2N9IHwgICAwCj4gIC4uLnMudHh0ID0+IFRlc3QtV3JpdGluZy1HdWlk
ZWxpbmVzLmFzY2lpZG9jfSB8ICAgMAo+ICAuLi5zZXItZ3VpZGUudHh0ID0+IFVzZXItR3VpZGVs
aW5lcy5hc2NpaWRvY30gfCAgIDAKPiAgdG9vbHMvY3JlYXRlLXRhcmJhbGxzLW1ldGFkYXRhLnNo
ICAgICAgICAgICAgIHwgIDUyICsrKysrKysrCj4gIHRvb2xzL2xpYi5zaCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAzMSArKysrKwo+ICB0b29scy90YWctcmVsZWFzZS5zaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgODAgKysrKysrKysrKysrCj4gIDE2IGZpbGVzIGNo
YW5nZWQsIDI4MiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiAgcmVuYW1lIGRvYy97
YnVpbGQtc3lzdGVtLWd1aWRlLnR4dCA9PiBCdWlsZC1TeXN0ZW0ucmVzdH0gKDEwMCUpCj4gIHJl
bmFtZSBkb2Mve2MtdGVzdC1hcGkudHh0ID0+IEMtVGVzdC1BUEkuYXNjaWlkb2N9ICgxMDAlKQo+
ICByZW5hbWUgZG9jL3tjLXRlc3QtdHV0b3JpYWwtc2ltcGxlLnR4dCA9PiBDLVRlc3QtQ2FzZS1U
dXRvcmlhbC5hc2NpaWRvY30KPiAoMTAwJSkKPiAgcmVuYW1lIGRvYy97bmV0d29yay1jLWFwaS50
eHQgPT4gQy1UZXN0LU5ldHdvcmstQVBJLmFzY2lpZG9jfSAoMTAwJSkKPiAgcmVuYW1lIGRvYy97
a3ZtLXRlc3QtYXBpLnR4dCA9PiBLVk0tVGVzdC1BUEkuYXNjaWlkb2N9ICgxMDAlKQo+ICByZW5h
bWUgZG9jL3tsaWJyYXJ5LWFwaS13cml0aW5nLWd1aWRlbGluZXMudHh0ID0+Cj4gTFRQLUxpYnJh
cnktQVBJLVdyaXRpbmctR3VpZGVsaW5lcy5hc2NpaWRvY30gKDEwMCUpCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkb2MvTFRQLVJlbGVhc2UtUHJvY2VkdXJlLmFzY2lpZG9jCj4gIHJlbmFtZSBkb2Mv
e21haW50YWluZXItcGF0Y2gtcmV2aWV3LWNoZWNrbGlzdC50eHQgPT4KPiBNYWludGFpbmVyLVBh
dGNoLVJldmlldy1DaGVja2xpc3QuYXNjaWlkb2N9ICgxMDAlKQo+ICByZW5hbWUgZG9jL3tzaGVs
bC10ZXN0LWFwaS50eHQgPT4gU2hlbGwtVGVzdC1BUEkuYXNjaWlkb2N9ICgxMDAlKQo+ICByZW5h
bWUgZG9jL3tzdXBwb3J0ZWQta2VybmVsLWxpYmMtdmVyc2lvbnMudHh0ID0+Cj4gU3VwcG9ydGVk
LWtlcm5lbCwtbGliYywtdG9vbGNoYWluLXZlcnNpb25zLmFzY2lpZG9jfSAoMTAwJSkKPiAgcmVu
YW1lIGRvYy97dGVzdC13cml0aW5nLWd1aWRlbGluZXMudHh0ID0+Cj4gVGVzdC1Xcml0aW5nLUd1
aWRlbGluZXMuYXNjaWlkb2N9ICgxMDAlKQo+ICByZW5hbWUgZG9jL3t1c2VyLWd1aWRlLnR4dCA9
PiBVc2VyLUd1aWRlbGluZXMuYXNjaWlkb2N9ICgxMDAlKQo+ICBjcmVhdGUgbW9kZSAxMDA3NTUg
dG9vbHMvY3JlYXRlLXRhcmJhbGxzLW1ldGFkYXRhLnNoCj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSB0
b29scy9saWIuc2gKPiAgY3JlYXRlIG1vZGUgMTAwNzU1IHRvb2xzL3RhZy1yZWxlYXNlLnNoCj4K
PiAtLQo+IDIuNDAuMQo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
