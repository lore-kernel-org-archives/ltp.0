Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C8AC79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788508565; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=h6sSMLx7+JeZWrEtO6R1HhWxBcU0v9uLlVijKGR+Y7Q=;
 b=mUGrzHLmEwF1iZxjrhYNfbN1UluRSyusDFHGCD7oNVGPH+h6L0konE4jAHyTNzojDdPQp
 +/IGdwOUcJxAH0OEFMt4fyGASNn6cLJNuGcUbHiLAfKSnu9eYYRvRHBbcaL57EdPiL/Hunn
 u5Z5pYQLiA8IJ3xIAOBKkv5196tBRa0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43A173E1CFD
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:56:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9A2B3E1CFD
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:55:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AEB0D600792
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:55:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788508542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8juESIOn8P3TNsCSpcbSgJAmh8usxoCB/vYNfpgPLc=;
 b=EIwc0FmeuiXfeNWsTmgIPEopejUKr+NFad8Q9+YkSAYL5wZYy2Wf7hws7FFNG6jyy1iti8
 15FGI6VYoaqlqGSpXlsf249ouYc5zGbmCHvvtOdiJ7eKcB+hrmwD/uljRdQW2/9Y2ZTgU2
 625NN2Rb8IwLS6KUzB2tk36dBAxLCUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-BdZNuCWPM6OHPl6iuVJf4w-1; Fri, 04 Sep 2026 03:55:40 -0400
X-MC-Unique: BdZNuCWPM6OHPl6iuVJf4w-1
X-Mimecast-MFC-AGG-ID: BdZNuCWPM6OHPl6iuVJf4w_1788508539
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccfbe060aso5231695e9.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 00:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788508539; x=1789113339;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l8juESIOn8P3TNsCSpcbSgJAmh8usxoCB/vYNfpgPLc=;
 b=V10WtYDAlmGo7vVBCa5VW3sYDzeU326s5SyPSAGpXe4h69snupeIeTmYH5tgW0prTg
 0Cy0jssXZ1/rYzkaWk2qD+pjkI5X723NmAPaid4DeEaEh/CMwOwxmkKhW86MFK2YNGeC
 9tD76tAffjKyV8d+zf1dGDRATSbURM9PLVzSCG9+06XMb0AGdOycKNEO5mhAR2XLIYmx
 qRyDc2ScMTPYES2oTyHQKMT/x6VoY5RRFNHHeKEJ3zEDfC7hhccwaLFovqqCwgUh4A0a
 onJpG8TOkWCQ9Okf3oviqi/uhviZEn4FD51SiBSsOFG5GFZqrGsB/+FMQrfg2dtnRvEZ
 +R+Q==
X-Gm-Message-State: AFuF++m/MKhAB2nv3CB/U0gTTMXrITgasX6L+XI8C6sW9oEyjI5n2VFx
 pG7PWKuNFfmDFkQbEY7RlJcXFVaUduTtgCcScJepdWKC8y0guWeMJtNWe/iSmT8KN39IMOqK06A
 Nf2q2exDy1DYvhda8tUOuwgLO72zHzi3zSHKveIZViBVOSUzVE0G0q4VNGbIw1OZu0bw0ZGIk8c
 vY4MHVDhgAiq5kdXuMX3InXPzZxbA=
X-Gm-Gg: AYBFou3G9POLH039WxG18H+v77Z0I2lzOR3BEJz11wWzj+G5KYBO9hyas3+pwlnw11X
 ZquzCixFiUFznDzzKPIgpDZbcWgFlDBQxOLstyyne6c9ibokWW+I51aVfpYiZICltschTLDuzmH
 2M3zWVP4x5oOt3k+BWKuY9cehy870o/MRcrG7dz6EI3HVmvMK64Zs6HJQ=
X-Received: by 2002:a05:600c:4515:b0:49c:c0d4:53d9 with SMTP id
 5b1f17b1804b1-49cf8273002mr34948125e9.14.1788508539185; 
 Fri, 04 Sep 2026 00:55:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4515:b0:49c:c0d4:53d9 with SMTP id
 5b1f17b1804b1-49cf8273002mr34947845e9.14.1788508538809; Fri, 04 Sep 2026
 00:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260903124631.1100746-1-pvorel@suse.cz>
In-Reply-To: <20260903124631.1100746-1-pvorel@suse.cz>
Date: Fri, 4 Sep 2026 09:55:21 +0200
X-Gm-Features: AcwNN1XsTNUESU7mWFV8b6FlfcrOmA5oPjWvpwx7RMKWC0KBn5eZipNs8rdk-4o
Message-ID: <CAASaF6zN=mkstMcyh1T_o32UzjgfE9gnLSo34nCj6geAtZ_=9w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wBgy3u25sVScwJRYRjRyjIeJKhJz7VgpqvyqHRA1kwo_1788508539
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/4] testscripts: Remove outdated scripts
 (ltp-pan)
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: Tim Bird <tim.bird@sony.com>, Steffen Jaeckel <sjaeckel@suse.de>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBTZXAgMywgMjAyNiBhdCAyOjQ34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gSGkgYWxsLAo+Cj4gU3RlZmZlbiByZXBvcnRlZCB3ZSBzdGlsbCBoYXZl
IHNjcmlwdHMgYW5kIGRvYyBtZW50aW9uaW5nIGx0cC1wYW4uCj4KPiBUaGVzZSB0ZXN0cyBzY3Jp
cHRzIHNob3VsZCBub3QgYmUgdXNlZCBieSBhbnlib2R5IGFzIHdlIGhhdmUga2lyay4KPiBBbHNv
LCB0aGV5IGFyZSBub3Qgd29ya2luZyBzaW5jZSBsdHAtcGFuIHJlbW92YWwgYW55d2F5Lgo+Cj4g
SSBhbHNvIHdvbmRlciBpZiB0aGVzZSBjb250cm9sbGVycyBzY3JpcHRzIHNob3VsZCBzdGlsbCBo
YXZlIHRoYXQgZW5kaW5nCj4gcGFydCwgd2hpY2ggd2FpdCBmb3IgcGlkLiAoSSdtIG5vdCBldmVu
IGNvbW1lbnRpbmcgImVjaG8gaGVsbG93b3JsZCA+Cj4gbXlmaWZvIikuCj4KPiBJJ2QgYWxzbyBw
cmVmZXIgdG8gcmVtb3ZlIHJlYWx0aW1lIHNjcmlwdHM6Cj4KPiB0ZXN0Y2FzZXMvcmVhbHRpbWUv
TWFrZWZpbGUKPiB0ZXN0Y2FzZXMvcmVhbHRpbWUvcnVuLnNoCj4gdGVzdGNhc2VzL3JlYWx0aW1l
L3NjcmlwdHMvTWFrZWZpbGUKPiB0ZXN0Y2FzZXMvcmVhbHRpbWUvc2NyaXB0cy9fX2luaXRfXy5w
eQo+IHRlc3RjYXNlcy9yZWFsdGltZS9zY3JpcHRzL3BhcnNlci5weQo+IHRlc3RjYXNlcy9yZWFs
dGltZS9zY3JpcHRzL3J1bl9jX2ZpbGVzLnNoCj4gdGVzdGNhc2VzL3JlYWx0aW1lL3NjcmlwdHMv
c2V0ZW52LnNoCj4gdGVzdHNjcmlwdHMvdGVzdF9yZWFsdGltZS5zaAo+Cj4gV2VsbCBJJ2QgcHJl
ZmVyIHRvIGNvbnZlcnQgcG9ydCBwaV9wZXJmLCBwcmlvLXdha2UgdG8gcnQtdGVzdHMgYW5kCj4g
ZGVsZXRlIHRoZSB3aG9sZSB0ZXN0c3VpdGUuCgpUaGVyZSBtaWdodCBiZSBzb21lIHVzZXJzLCBz
aW5jZSB0aGVyZSBoYXMgYmVlbiBhY3Rpdml0eSBpbiB0aGF0IGFyZWEsCjEyIHBhdGNoZXMgc2lu
Y2UgMjAyNSwKbW9zdGx5IHNjaGVkX2Zvb3RiYWxsLiAoQExpKQoKPgo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy8xMDc4I2lzc3VlY29tbWVudC0yMjEy
OTEzODE4Cj4KPiBOT1RFOiBJIGFscmVhZHkgZGFyZWQgdG8gcmVtb3ZlIG91dGRhdGVkIGRvYyB3
aXRob3V0IGEgcmV2aWV3Ogo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3Qv
bHRwL2NvbW1pdC9lMmEzNWY3NDZlNmM3ODkzMTI5ZjFkMTllYjIwZDE1ZGUwZjMzZDc1Cj4gaHR0
cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvY29tbWl0LzI1MmY1NmRjZjM3
MWJlNTlhYmQ5MDY2NTRkOWU3NzE4NGE5MjM5ZTQKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4K
Pgo+IFBldHIgVm9yZWwgKDQpOgo+ICAgUmVtb3ZlIHRlc3RzY3JpcHRzL25ldHdvcmsuc2gKPiAg
IFJlbW92ZSB0ZXN0c2NyaXB0cy90cG1fdG9vbHMuc2gKPiAgIFJlbW92ZSB0ZXN0c2NyaXB0cy9s
dHAtYWlvZGlvLnNoCj4gICBjb250cm9sbGVyczogUmVtb3ZlIG9ic29sZXRlIHJlZmVyZW5jZXMg
dG8gbHRwLXBhbgo+Cj4gIC4uLi9jcHVjdGwvcnVuX2NwdWN0bF9zdHJlc3NfdGVzdC5zaCAgICAg
ICAgICB8ICAgMiArLQo+ICAuLi4vY29udHJvbGxlcnMvY3B1Y3RsL3J1bl9jcHVjdGxfdGVzdC5z
aCAgICAgfCAgIDQgKy0KPiAgdGVzdHNjcmlwdHMvbHRwLWFpb2Rpby5zaCAgICAgICAgICAgICAg
ICAgICAgIHwgMzI3IC0tLS0tLS0tLS0tLS0tLS0tLQo+ICB0ZXN0c2NyaXB0cy9uZXR3b3JrLnNo
ICAgICAgICAgICAgICAgICAgICAgICAgfCAxMTggLS0tLS0tLQo+ICB0ZXN0c2NyaXB0cy90cG1f
dG9vbHMuc2ggICAgICAgICAgICAgICAgICAgICAgfCAxNzMgLS0tLS0tLS0tCj4gIHRlc3RzY3Jp
cHRzL3llc2VudGVyLnR4dCAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAtCj4gIDYgZmlsZXMg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2MjMgZGVsZXRpb25zKC0pCj4gIGRlbGV0ZSBtb2Rl
IDEwMDc1NSB0ZXN0c2NyaXB0cy9sdHAtYWlvZGlvLnNoCj4gIGRlbGV0ZSBtb2RlIDEwMDc1NSB0
ZXN0c2NyaXB0cy9uZXR3b3JrLnNoCj4gIGRlbGV0ZSBtb2RlIDEwMDc1NSB0ZXN0c2NyaXB0cy90
cG1fdG9vbHMuc2gKPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IHRlc3RzY3JpcHRzL3llc2VudGVyLnR4
dAoKQWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
