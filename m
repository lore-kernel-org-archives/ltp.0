Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9EDCD4F4A
	for <ltp@archiver.kernel.org>; Mon, 18 May 2026 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779128748; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=BASqNYz3C3D5G+0ouMRM7VoxdfeslRcniHdAOz6LRRc=;
 b=JqTzcVzx7aYo+WiNWubwiPxpgjOIJBAFHnBHKyJo6uhVZY0Dbl8qBNC4oKO+qtEwQGc5y
 tNLa02XhIXIjjQiA4iqdl+kqfbqrVTgk5ZBq3JvBxCNZUH3Uzc5yKevxbrojeeZt33nwjG2
 DW7vpmWeEwR17pn+Betz9vJMa5ScNsI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD7863C5AF0
	for <ltp@archiver.kernel.org>; Mon, 18 May 2026 20:25:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77C3B3C311C
 for <ltp@lists.linux.it>; Mon, 18 May 2026 20:25:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6CA1410006A2
 for <ltp@lists.linux.it>; Mon, 18 May 2026 20:25:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779128723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T3IsTNbOdUdglNqG7OkmyRVYaWjFuDMpUo2IZOvB8AI=;
 b=X4IwSZmeb4Y30hHDfcdUiUIJ1TLk/luC3GfqkiB6QX4WjknizTuhaCiQjB9ZITgjxkNrhF
 Dzt+HFBp7r/5woWtvheCnNEQK0s/AjLgkHcz4HmZqg9UP7TavVqi7vSEVk4MX4sDc2c2iz
 q182TwbzHZ0Z3CkOtXltAlnqyL0eNNs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-5ePx_H5TNICBLmb3Gcoi1A-1; Mon, 18 May 2026 14:25:20 -0400
X-MC-Unique: 5ePx_H5TNICBLmb3Gcoi1A-1
X-Mimecast-MFC-AGG-ID: 5ePx_H5TNICBLmb3Gcoi1A_1779128719
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a894c2d57cso2766758e87.0
 for <ltp@lists.linux.it>; Mon, 18 May 2026 11:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779128719; x=1779733519;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3IsTNbOdUdglNqG7OkmyRVYaWjFuDMpUo2IZOvB8AI=;
 b=mSI7wPJwsmk3rzqOaTzN1+EhmaT2WlmfNeYdP49Ho/WpkXBC36H2f3UtqhTxIeXChN
 zh4fpJ/X1lszEjqLaT8xSt6Lhv7lUJr9usIiP6jJbFJ74pSOmGvgr7UAIEv6ePP7Dl3V
 QX2RdK0VdqNmxWCZvqdoPMaG8tJQC18zcw3Z1UcAlzlFVDaCoOpCNWTLb7pA+RhjRgag
 014l7YjzuhlU8egW1u5ExQO1ZUSGKbdhQvkXQ8Z353J9ezLk7yycUBGp1nQVl9iXLOaX
 FT2FBCeXqUpmy/HJBfcZsKt6ncxVUg5wTW3ymFHw/AsSsJCUPPJvjdTgFmV+/vj/nPxC
 v0xg==
X-Gm-Message-State: AOJu0YwH5BkwqZTXrlDeLRxAkp3mbx/61bk/a5/OdoHhNWgc+oErWfSJ
 S4mS2ZA970CElzP91cG6IEDLSzYGcGeRDWPPSbxGubPjn+iD+QDcEMw5R9MAur9xAU0d/kG5ZlS
 3gzAruXAW4O8itSRmnEU4i0pZq0CfgmuKi678wwl9JGwlZ8oUloWAIZThXd7uU4p0X69hI2BwH5
 ejXZm5o90OwysQERfvaQwmi5N9HRuZdmeChhI+gQ==
X-Gm-Gg: Acq92OGgcFl8jzkL2UtKmQfYuRtB7OTgv7hljoJ1qQR4zWlsciZA2b470SvzHQy8DV6
 JD6tE2XkXR7554/tX4joFLQX08kRY/2LGCRndRmdZUST5wRSqMl0loLZj+9kJEIVLgY1j7VdEZa
 wT0PQQi/2+cNOUn8NCUMyMNU43cVHCQ7bnN6NkfGL8lOBXd7l7ymimjXJmTgSK9P3PC1GUrs+kr
 aiulA==
X-Received: by 2002:a05:6512:3e14:b0:5a2:b3dd:7a74 with SMTP id
 2adb3069b0e04-5aa0e73edcbmr5220902e87.33.1779128718902; 
 Mon, 18 May 2026 11:25:18 -0700 (PDT)
X-Received: by 2002:a05:6512:3e14:b0:5a2:b3dd:7a74 with SMTP id
 2adb3069b0e04-5aa0e73edcbmr5220885e87.33.1779128718384; Mon, 18 May 2026
 11:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260507111809.28934-1-mmenashe@redhat.com>
 <20260507111809.28934-5-mmenashe@redhat.com>
In-Reply-To: <20260507111809.28934-5-mmenashe@redhat.com>
Date: Mon, 18 May 2026 21:25:01 +0300
X-Gm-Features: AVHnY4K6sK6ckYxxjggsOZfgmqLsLQF8a6e5EhZ_HvsdXo6A8blIrIJH4gYhg5I
Message-ID: <CAHGiOXd4BT1AZn2DFdegQk42fem_GfQN3VuRRnOaXjMbCiNbTg@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J60Mmr-sfvk5e2mmd8tsnx1SCV5zkwrm7ZlB9CorB9c_1779128719
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 4/4] futex_cmp_requeue03: Add EFAULT error
 coverage test
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ICBIaSwKCiAgRm9sbG93aW5nIHVwIGFnYWluIG9uIHRoaXMgcGF0Y2ggc2VyaWVzIG9yaWdpbmFs
bHkgc2VudCBvbiBNYXkgN3RoLgogIFRoZSBMVFAgQUkgUmV2aWV3ZXIgaGFzIGFscmVhZHkgYXBw
cm92ZWQgYWxsIGZvdXIgcGF0Y2hlcyB3aXRoIG5vIGlzc3Vlcwpmb3VuZC4KCiAgUGF0Y2ggc2Vy
aWVzOgogICAgW0xUUF0gW1BBVENIIHY0IDEvNF0gZnV0ZXhfd2FpdDA2OiBBZGQgRUZBVUxUIGVy
cm9yIGNvdmVyYWdlIHRlc3QKICAgIFtMVFBdIFtQQVRDSCB2NCAyLzRdIGZ1dGV4X3dhaXQwNzog
QWRkIEVJTlRSIGVycm9yIGNvdmVyYWdlIHRlc3QKICAgIFtMVFBdIFtQQVRDSCB2NCAzLzRdIGZ1
dGV4X3dha2UwNTogQWRkIEVGQVVMVCBlcnJvciBjb3ZlcmFnZSB0ZXN0CiAgICBbTFRQXSBbUEFU
Q0ggdjQgNC80XSBmdXRleF9jbXBfcmVxdWV1ZTAzOiBBZGQgRUZBVUxUIGVycm9yIGNvdmVyYWdl
IHRlc3QKCiAgR2l0SHViIFBSOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0
L2x0cC9wdWxsLzEzMDEKCiAgSXMgdGhlcmUgYW55dGhpbmcgbWlzc2luZyBvciBhbnl0aGluZyBJ
IGNhbiBpbXByb3ZlIHRvIGhlbHAgbW92ZSB0aGlzCmZvcndhcmQ/CgogIFRoYW5rcy4gUmVnYXJk
cy4KCk9uIFRodSwgTWF5IDcsIDIwMjYgYXQgMjoxOOKAr1BNIE1pY2hhZWwgTWVuYXNoZXJvdiA8
bW1lbmFzaGVAcmVkaGF0LmNvbT4Kd3JvdGU6Cgo+IGZ1dGV4KEZVVEVYX0NNUF9SRVFVRVVFKSBo
YXMgbm8gZXhpc3RpbmcgdGVzdCBmb3IgRUZBVUxULiBBZGQgY292ZXJhZ2UKPiBmb3IgdGhlIGNh
c2VzIHdoZXJlIHVhZGRyIG9yIHVhZGRyMiBwb2ludHMgdG8gdW5tYXBwZWQgb3IgaW5hY2Nlc3Np
YmxlCj4gKFBST1RfTk9ORSkgbWVtb3J5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBNZW5h
c2hlcm92IDxtbWVuYXNoZUByZWRoYXQuY29tPgo+IC0tLQo+ICBydW50ZXN0L3N5c2NhbGxzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZnV0ZXgvLmdpdGlnbm9yZSAgICB8ICAxICsKPiAgLi4uL3N5c2NhbGxzL2Z1dGV4L2Z1
dGV4X2NtcF9yZXF1ZXVlMDMuYyAgICAgIHwgOTQgKysrKysrKysrKysrKysrKysrKwo+ICAzIGZp
bGVzIGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKykKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZnV0ZXgvZnV0ZXhfY21wX3JlcXVldWUwMy5jCj4KPiBkaWZm
IC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBpbmRleCA0ZDg1
YTFkMjYuLjY1YmFhNDRkYyAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gKysrIGIv
cnVudGVzdC9zeXNjYWxscwo+IEBAIC0xOTA4LDMgKzE5MDgsNCBAQCBwZXJmX2V2ZW50X29wZW4w
MyBwZXJmX2V2ZW50X29wZW4wMwo+ICBmdXRleF93YWl0MDYgZnV0ZXhfd2FpdDA2Cj4gIGZ1dGV4
X3dhaXQwNyBmdXRleF93YWl0MDcKPiAgZnV0ZXhfd2FrZTA1IGZ1dGV4X3dha2UwNQo+ICtmdXRl
eF9jbXBfcmVxdWV1ZTAzIGZ1dGV4X2NtcF9yZXF1ZXVlMDMKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mdXRleC8uZ2l0aWdub3JlCj4gYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2Z1dGV4Ly5naXRpZ25vcmUKPiBpbmRleCBjMTE1NDZlMDcuLjIzMWI2YmQyNSAx
MDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4Ly5naXRpZ25vcmUK
PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4Ly5naXRpZ25vcmUKPiBAQCAt
MTYsMyArMTYsNCBAQAo+ICAvZnV0ZXhfd2FpdDA2Cj4gIC9mdXRleF93YWl0MDcKPiAgL2Z1dGV4
X3dha2UwNQo+ICsvZnV0ZXhfY21wX3JlcXVldWUwMwo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4X2NtcF9yZXF1ZXVlMDMuYwo+IGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRleF9jbXBfcmVxdWV1ZTAzLmMKPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uNGMzYzZlMzU4Cj4gLS0tIC9kZXYvbnVsbAo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnV0ZXgvZnV0ZXhfY21wX3JlcXVldWUw
My5jCj4gQEAgLTAsMCArMSw5NCBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjYgUmVkIEhhdCwgSW5j
Lgo+ICsgKi8KPiArCj4gKy8qXAo+ICsgKiBDaGVjayB0aGF0IGZ1dGV4KEZVVEVYX0NNUF9SRVFV
RVVFKSByZXR1cm5zIEVGQVVMVCB3aGVuIHVhZGRyIG9yCj4gKyAqIHVhZGRyMiBwb2ludHMgdG8g
dW5tYXBwZWQgbWVtb3J5LCBvciB3aGVuIHVhZGRyIHBvaW50cyB0byBtZW1vcnkKPiArICogd2l0
aG91dCByZWFkIHBlcm1pc3Npb24gKFBST1RfTk9ORSkuCj4gKyAqLwo+ICsKPiArI2luY2x1ZGUg
PGVycm5vLmg+Cj4gKyNpbmNsdWRlIDxzeXMvbW1hbi5oPgo+ICsKPiArI2luY2x1ZGUgImZ1dGV4
dGVzdC5oIgo+ICsKPiArc3RhdGljIGZ1dGV4X3QgZnV0ZXhfdmFyID0gRlVURVhfSU5JVElBTEla
RVI7Cj4gK3N0YXRpYyBmdXRleF90ICpwcm90X25vbmVfYWRkcjsKPiArCj4gK3N0YXRpYyBzdHJ1
Y3QgZnV0ZXhfdGVzdF92YXJpYW50cyB2YXJpYW50c1tdID0gewo+ICsjaWYgKF9fTlJfZnV0ZXgg
IT0gX19MVFBfX05SX0lOVkFMSURfU1lTQ0FMTCkKPiArICAgICAgIHsgLmZudHlwZSA9IEZVVEVY
X0ZOX0ZVVEVYLCAuZGVzYyA9ICJzeXNjYWxsIHdpdGggb2xkIGtlcm5lbAo+IHNwZWMifSwKPiAr
I2VuZGlmCj4gKwo+ICsjaWYgKF9fTlJfZnV0ZXhfdGltZTY0ICE9IF9fTFRQX19OUl9JTlZBTElE
X1NZU0NBTEwpCj4gKyAgICAgICB7IC5mbnR5cGUgPSBGVVRFWF9GTl9GVVRFWDY0LCAuZGVzYyA9
ICJzeXNjYWxsIHRpbWU2NCB3aXRoIGtlcm5lbAo+IHNwZWMifSwKPiArI2VuZGlmCj4gK307Cj4g
Kwo+ICtzdGF0aWMgc3RydWN0IHRlc3RjYXNlIHsKPiArICAgICAgIGNvbnN0IGNoYXIgKmRlc2M7
Cj4gKyAgICAgICBmdXRleF90ICp1YWRkcjsKPiArICAgICAgIGZ1dGV4X3QgKnVhZGRyMjsKPiAr
ICAgICAgIGludCBleHBfZXJybm87Cj4gK30gdGVzdGNhc2VzWzNdOwo+ICsKPiArc3RhdGljIHZv
aWQgcnVuKHVuc2lnbmVkIGludCBuKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgZnV0ZXhfdGVzdF92
YXJpYW50cyAqdHYgPSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRdOwo+ICsgICAgICAgc3RydWN0IHRl
c3RjYXNlICp0YyA9ICZ0ZXN0Y2FzZXNbbl07Cj4gKwo+ICsgICAgICAgVFNUX0VYUF9GQUlMKGZ1
dGV4X2NtcF9yZXF1ZXVlKHR2LT5mbnR5cGUsIHRjLT51YWRkciwgZnV0ZXhfdmFyLAo+ICsgICAg
ICAgICAgICAgICB0Yy0+dWFkZHIyLCAxLCAxLCAwKSwgdGMtPmV4cF9lcnJubywgIiVzIiwgdGMt
PmRlc2MpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICt7Cj4gKyAgICAg
ICBzdHJ1Y3QgZnV0ZXhfdGVzdF92YXJpYW50cyAqdHYgPSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRd
Owo+ICsgICAgICAgc2l6ZV90IHBhZ2VzaXplID0gZ2V0cGFnZXNpemUoKTsKPiArICAgICAgIGZ1
dGV4X3QgKnVubWFwcGVkOwo+ICsKPiArICAgICAgIHRzdF9yZXMoVElORk8sICJUZXN0aW5nIHZh
cmlhbnQ6ICVzIiwgdHYtPmRlc2MpOwo+ICsgICAgICAgZnV0ZXhfc3VwcG9ydGVkX2J5X2tlcm5l
bCh0di0+Zm50eXBlKTsKPiArCj4gKyAgICAgICB1bm1hcHBlZCA9IFNBRkVfTU1BUChOVUxMLCBw
YWdlc2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKPiArICAgICAgICAgICAgICAgTUFQX1BS
SVZBVEUgfCBNQVBfQU5PTllNT1VTLCAtMSwgMCk7Cj4gKyAgICAgICBTQUZFX01VTk1BUCh1bm1h
cHBlZCwgcGFnZXNpemUpOwo+ICsKPiArICAgICAgIHByb3Rfbm9uZV9hZGRyID0gU0FGRV9NTUFQ
KE5VTEwsIHBhZ2VzaXplLCBQUk9UX05PTkUsCj4gKyAgICAgICAgICAgICAgIE1BUF9QUklWQVRF
IHwgTUFQX0FOT05ZTU9VUywgLTEsIDApOwo+ICsKPiArICAgICAgIHRlc3RjYXNlc1swXSA9IChz
dHJ1Y3QgdGVzdGNhc2Upewo+ICsgICAgICAgICAgICAgICAuZGVzYyA9ICJ1YWRkciB1bm1hcHBl
ZCIsCj4gKyAgICAgICAgICAgICAgIC51YWRkciA9IHVubWFwcGVkLAo+ICsgICAgICAgICAgICAg
ICAudWFkZHIyID0gJmZ1dGV4X3ZhciwKPiArICAgICAgICAgICAgICAgLmV4cF9lcnJubyA9IEVG
QVVMVCwKPiArICAgICAgIH07Cj4gKyAgICAgICB0ZXN0Y2FzZXNbMV0gPSAoc3RydWN0IHRlc3Rj
YXNlKXsKPiArICAgICAgICAgICAgICAgLmRlc2MgPSAidWFkZHIyIHVubWFwcGVkIiwKPiArICAg
ICAgICAgICAgICAgLnVhZGRyID0gJmZ1dGV4X3ZhciwKPiArICAgICAgICAgICAgICAgLnVhZGRy
MiA9IHVubWFwcGVkLAo+ICsgICAgICAgICAgICAgICAuZXhwX2Vycm5vID0gRUZBVUxULAo+ICsg
ICAgICAgfTsKPiArICAgICAgIHRlc3RjYXNlc1syXSA9IChzdHJ1Y3QgdGVzdGNhc2Upewo+ICsg
ICAgICAgICAgICAgICAuZGVzYyA9ICJ1YWRkciBQUk9UX05PTkUiLAo+ICsgICAgICAgICAgICAg
ICAudWFkZHIgPSBwcm90X25vbmVfYWRkciwKPiArICAgICAgICAgICAgICAgLnVhZGRyMiA9ICZm
dXRleF92YXIsCj4gKyAgICAgICAgICAgICAgIC5leHBfZXJybm8gPSBFRkFVTFQsCj4gKyAgICAg
ICB9Owo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gK3sKPiArICAgICAg
IGlmIChwcm90X25vbmVfYWRkcikKPiArICAgICAgICAgICAgICAgU0FGRV9NVU5NQVAocHJvdF9u
b25lX2FkZHIsIGdldHBhZ2VzaXplKCkpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgc3RydWN0IHRzdF90
ZXN0IHRlc3QgPSB7Cj4gKyAgICAgICAuc2V0dXAgPSBzZXR1cCwKPiArICAgICAgIC5jbGVhbnVw
ID0gY2xlYW51cCwKPiArICAgICAgIC50ZXN0ID0gcnVuLAo+ICsgICAgICAgLnRjbnQgPSBBUlJB
WV9TSVpFKHRlc3RjYXNlcyksCj4gKyAgICAgICAudGVzdF92YXJpYW50cyA9IEFSUkFZX1NJWkUo
dmFyaWFudHMpLAo+ICt9Owo+IC0tCj4gMi41My4wCj4KPgoKLS0gCgpNaWNoYWVsIE1lbmFzaGVy
b3YKClNvZnR3YXJlIFF1YWxpdHkgRW5naW5lZXIgLSBBdXRvbW90aXZlIEtlcm5lbAoKUmVkIEhh
dCA8aHR0cHM6Ly93d3cucmVkaGF0LmNvbS8+CjxodHRwczovL3d3dy5yZWRoYXQuY29tLz4KCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
