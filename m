Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4D3CD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778139873; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=WjiBmgsBPn/kSZp6sBpcJwmmOgf/i2IodIr9nb3MP4A=;
 b=BhMHVkzuNgo3Ijl2K1IGCY8XmztJoMhM+uyyExkwQFcrUv7H4hZaMC9ZwBI3UreJR56n3
 1pYlOIG6n1V/lq3lSSgE8wnDJkFY2TPfGSwpETbqk4g489Gy3XRuoPuWrKk/LmceygVf8qR
 kM1dO6uCoogM4yx8845mfj/2PFZJshs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65DB33E2876
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:44:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 771743C1E1C
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:44:10 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 89973140035E
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:44:09 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so6133985e9.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778139849; x=1778744649; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EzOsTk65Js/ijr4vV9nw9UIVMSCRxOMouyRed5RfLtU=;
 b=ONFLNYYRJtEaqupinjhquPfMhWZgYdp3mRD6xy8pGyDaoUF7ZDLKHKLtzVIEGsBIyi
 JsD19dd/rRbc7AyPWQe3kcb0gdrVxVb+ltuxhJUtJsblqJFt3iBwD/XmrBS1QB8SFRRf
 XYw/e+RowI1xCHPTwPkfN/p52DdCm+6V4YTfKzMz/JTAXqo+y3OwgIko5qr6QMrjLEC0
 3ovZzXT4Ix+xv8ct+RVd2O99RT4PYOQwEwphAk2wjx8ugUc4xw3RTQq3fJ5kFZhx2XEY
 5gY+woB/1pDQxiZ0eepzuSQG52HFgwMmoAW+aOK3gi4LuuCsZ8UtM4FMuF0g1crSLaq7
 skMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778139849; x=1778744649;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzOsTk65Js/ijr4vV9nw9UIVMSCRxOMouyRed5RfLtU=;
 b=hnCg+uTs9uaZxisdISs/8ctemwQ7NICioOLY5eMtJB4xrBOj14sL8yKewqe93TDLiO
 c9CQyxTqB6vVtFZtIwrpHoLOedetdoWibrp0O7Lt+Ye0+JCKBU6IU36qB+1Rgn4F1eGW
 ZBLMl6yTv9W6osBn5cwtMa1WwGBAFjQGxidJYe3gjas1OcNGofsRByFxQeHFjMg2bctB
 gC52xaCP2IpdCbPntQ4DlBTKbU9KnSZBKJaK9UcRexUnvXCaWEmD5bdbuYb6Lv0PgQbM
 IpUCumkSp1DfUJbufpioF8Ha8uSVXJ0VxqbVVA8aKIUxKk6v/4eFi3EAQewlbDGmjltP
 rv6w==
X-Gm-Message-State: AOJu0YzygiT1m1VPe+fwZYEcV8lnQjIOBQ4Wdob41CEuyoJbZHNa7GMt
 LSz1SLTJZYF9hl6lQKm75pcb4pxI9rLmsEYXOgUhvj8YlP48xyQmYxTFi7XBt3rpZigWRpa78a+
 XzoPUt+vctA==
X-Gm-Gg: AeBDies4F+5owRM7wqv9n1pEd9s9ob3kfc43tHKPSjCclJSnj4CyH73ZkDffIWRN64g
 FTUItO8vE2O3xWyZNtFm/eKZTZK8dsPZzMtLPD7jYa132BKt1X2lDNnA+tGINa6TgPOL74yZaGf
 6EU4b53NXwwajrDMO7QjvardLt0Czqht1fYA9fxhX3lrX1DdBH7DY7KcPyobeKNc+iYthXfeh7R
 2pxkhD4xUqqhLWx4gkEkdaYDnbboZbKj3JPhJyJARkWSbIXtuWe3qiy8rIdgER0/WJPLY70cwaP
 gpMva3RPnAGWy5XAFe94B8kexl8WxkcS39YsLqjVfW8sQyIKnrvbyDZ0j+Bviqq4TBT8VF84d/O
 AOmYargSPNokR/BLU/bRnfpvLDBMWsOKoNCqDwc5H7LFa3Zp2mh5oIrkSomw30Ka7DJApScO0Lh
 TfKmlUSIjLbFRacwI/tX0RM7Oah7yN+kHbX3ycuwiAEe121f7d0ah+4p5Z529VqUhoHSk/ZhtbW
 5QrRa/HrHjjDcbmpXGJfzY/GvBawmMtJg7JFfirMfazhg==
X-Received: by 2002:a05:600c:3b96:b0:48a:66a8:9981 with SMTP id
 5b1f17b1804b1-48e51f55272mr117502625e9.27.1778139848846; 
 Thu, 07 May 2026 00:44:08 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b213asm34380255e9.2.2026.05.07.00.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 00:44:08 -0700 (PDT)
Message-ID: <69fc42c8.050a0220.275b3.f9b1@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <afxBKVidvR96iTTP@yuki.lan>
Date: Thu, 07 May 2026 07:44:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Fix proc parsing in newuname01
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgo+IEhpIQo+ID4gPiArCWYgPSBmb3BlbihwYXRoLCAiciIpOwo+ID4gPiArCWlm
ICghZikgewo+ID4gPiArCQl0c3RfYnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywg
TlVMTCwKPiA+ID4gKwkJICAgICAgICAgICJGYWlsZWQgdG8gb3BlbiBGSUxFICclcycgZm9yIHJl
YWRpbmciLCBwYXRoKTsKPiA+ID4gKwl9Cj4gPiA+ICsKPiA+ID4gKwlpZiAoIWZnZXRzKGJ1Ziwg
YnVmX3NpemUsIGYpKQo+ID4gCj4gPiBNaXNzaW5nIHJldHVybjsgYWZ0ZXIgdHN0X2Jya21fKCkg
4oCUIGYgaXMgTlVMTCBpZiBmb3BlbiBmYWlsZWQsIHNvIGZnZXRzKCkKPiA+IGRlcmVmZXJlbmNl
cyBOVUxMLiBFdmVyeSBvdGhlciBlcnJvciBwYXRoIGluIHRoaXMgZmlsZSBoYXMgcmV0dXJuOyBh
ZnRlcgo+ID4gdHN0X2Jya21fKCkuCj4gCj4gWWVzIEknbSBhd2FyZSwgdGhhbmtzIGZvciByZW1p
bmRpbmcgbWUgdGhvdWdoLgo+IAo+ID4gPiArCXNpemVfdCBsZW4gPSBzdHJsZW4oYnVmKTsKPiA+
IAo+ID4gVmFyaWFibGUgZGVjbGFyYXRpb24gYWZ0ZXIgYSBzdGF0ZW1lbnQuIE1vdmUgbGVuIHRv
IHRoZSB0b3Agb2YgdGhlIGZ1bmN0aW9uCj4gPiB3aXRoIEZJTEUgKmYuCj4gCj4gRG8gd2Ugc3Rp
bCBmb2xsb3cgdGhlIEM4OSBpbiB0aGlzIHJlZ2FyZD8gV2UgYWxyZWFkeSBmb3JjZSBnbnU5OSBp
bgo+IHRoZSBjb25maWcubWsuCgpJdCBkb2Vzbid0IG1ha2UgYW55IHNlbnNlIGluZGVlZC4gSSBh
ZGRlZCB0aGUgYzk5IGFnZW50IHJ1bGUsIGJ1dCB3ZSB0b2xkCml0IHRvIGZvbGxvdyBrZXJuZWwg
bGludXggY29udmVudGlvbnMsIHdoaWNoIGFyZSBzcGVjaWZpYywgaW5jbHVkaW5nIHRoaXMKb25l
LgoKV2UgY2FuIHNhZmVseSBpZ25vcmUgYW5kIHNlZSBpZiBpdCBoYXBwZW5zIGFnYWluIHdpdGgg
b3RoZXIgcmV2aWV3cywgYW5kCmV2ZW50dWFsbHkgdXBkYXRlIHRoZSBjb25maWd1cmF0aW9uLgoK
UmVnYXJkcywKLS0KQW5kcmVhIENlcnZlc2F0bwpTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5lZXIg
TGludXgKYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
