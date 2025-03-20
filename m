Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887E7C28B30
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 11:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742469891; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IgQagPx3vMkBpcLZyH/Ek1PevAZ2bcyg8i/1q/3Dy+o=;
 b=nW1mMIq/pOPneKof5XK3T/vZRzJTIXmW39fjaZ5BEWxSZSJmhx7v/PP9Xj0mRm4RT16ME
 BQJzM7zsJqZ3y6Q1q8qQDZNucMqC71M7/tuwGuguNoblrfGrpd6Arqrsex8Al/tX1YAnBX9
 BPXhWusX4tZyoYTsMfkpMZI4FY8cqL8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 827FA3CAE3E
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 12:24:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BACE3CAD4A
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 12:24:30 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 92E016007A4
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 12:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742469867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rqrelvh38r3QpYDT2cJHVtGmzbrrmBmFx0XpnL3cF2Q=;
 b=doH+ZTDqvZnHlZHR7ws5qtX0b1rtlXbqo+cZGk3rOfRdtS8zUtn5/Y7fJ5xecHIyZQ58/u
 ALrNxWIpVtFm0dgrpRLxv0roRcUhEumLU60/Pm5GfRRNyp8vbrW88PvLaugkWYIdEuGB7k
 5ZHLw69Fql1nW8sReJgy8JjeNzzt+qA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-xr7E-XYEPECIsaoHfGaewA-1; Thu, 20 Mar 2025 07:24:26 -0400
X-MC-Unique: xr7E-XYEPECIsaoHfGaewA-1
X-Mimecast-MFC-AGG-ID: xr7E-XYEPECIsaoHfGaewA_1742469866
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-523c33cfea8so818671e0c.1
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 04:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742469866; x=1743074666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rqrelvh38r3QpYDT2cJHVtGmzbrrmBmFx0XpnL3cF2Q=;
 b=jRPXXXufHecOLVjZ70vOOzv4R86GSyDvw3FMZNntfu6Pj4Rv5Qy9VGOnXJXC84P4BH
 jtLGoTUOMlzZme5jIBXWJteLEu+thtZthSuKDlzKuGOb6+UlEpW+2NsgubEjwlekaSAE
 YjXBZCyyT8x4FWa7W7LzJpLpouq4m8ULgtKeujPhJF1Mh0f4csuQIxSzj6UTQ2tG7Bpi
 Hapqc/Av0RIByDfUezEYHVyl3aX1hcvXxgXxqnKt+qobxNEP2oPYmEr1pxhwVCLPkb07
 MAz3I5vxfJwWF8sTRl+JpxX+o5fc12cdXciOPPEzSomTkw5kRxRFqv3HK/K5z0L3HUgT
 H1aw==
X-Gm-Message-State: AOJu0YzCNO1fxj0sbmJh/U1pvr85K+LXguJ4gQGRbvt2mtGlfYPEL1i8
 I/Y3xNk7osFG0MCbUoDOm0pY68gq7kq3Vkk1WkIqImTaY688PcE0rKdn4b6XDS+o4wJev9KrqNz
 sOJGg7gbL4aYnSe8VUhW2SZEOOT1AhYsM70XO8E0KIR8uVcT1ISUX+gUkyVhtV+zaav8oDmZsqJ
 6HkE6PTFg86Q2/bvkk0AAiMik=
X-Gm-Gg: ASbGncuCZyZLN0on34MU+HZ5MXaM9dd+SnY2cec1oFxD27d15/IA0GezKEu/n1bGUwu
 pvfL4qNpMfcpb1gux0OcxmZ/LZgnzTvU/ZbeHP/RKUd2t1BeZO66W4fo34hXjeQozYZHQ/EIJ
X-Received: by 2002:a05:6122:1b8a:b0:520:60c2:3f3 with SMTP id
 71dfb90a1353d-5259627de8amr2205170e0c.4.1742469865802; 
 Thu, 20 Mar 2025 04:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkWPOK7qINsBfgau+R4G+YWkEhsp5qGenF010g/wkPIShvUHAKvX1aH4d2pkKvsF7M49+/mLQ7AoXVw4rC/oY=
X-Received: by 2002:a05:6122:1b8a:b0:520:60c2:3f3 with SMTP id
 71dfb90a1353d-5259627de8amr2205165e0c.4.1742469865456; Thu, 20 Mar 2025
 04:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <d1d830051aea3f077995c30b2183731cd2f04cf2.1742054500.git.jstancek@redhat.com>
 <20250317122351.GA247824@pevik>
In-Reply-To: <20250317122351.GA247824@pevik>
Date: Thu, 20 Mar 2025 12:24:09 +0100
X-Gm-Features: AQ5f1JoaAyMiPd9LjWWPq-Jm585atSm97aowgEpqw2wJgWU7fqMNIz9BcIeeXKI
Message-ID: <CAASaF6yvKn-FN+jZRjMVcPyiW_0TZUOi+OJbXK+QrD1cvZQwOg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vYg3EViukGxu7NBlODr52AeMburUrFy2Vh4yMscc0Wg_1742469866
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tracing/pt_test: TCONF if Intel PT across VMXON
 is not supported
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMTcsIDIwMjUgYXQgMToyNOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+ID4gQXMgbm90ZWQgaW4gMWM1YWMyMWEwZTliICgi
cGVyZi94ODYvaW50ZWwvcHQ6IERvbid0IGRpZSBvbiBWTVhPTiIpLAo+ID4gc29tZSBCcm9hZHdl
bGwgc3lzdGVtcyBkb24ndCBzdXBwb3J0IEludGVsIFBUIGFjcm9zcyBWTVhPTi4KPiArMQo+Cj4g
PiBJZiB0aGUgdGVzdCBmYWlscyB0byBmaW5kIGFueSBldmVudHMsIGNoZWNrIHdoZXRoZXIgdGhl
cmUgaXMgYQo+ID4ga3ZtX2ludGVsIG1vZHVsZSBsb2FkZWQsIGFuZCBpZiBzbyBjaGVjayBmb3Ig
SUEzMl9WTVhfTUlTQ1tiaXQgMTRdLgo+ID4gSWYgdGhpcyBiaXQgaXMgMCwgaXQncyBub3Qgc3Vw
cG9ydGVkLiBGcm9tIGNvbW1pdCBtZW50aW9uZWQgYWJvdmU6Cj4gPiAgICAgSW50ZWwgU0RNLCAz
Ni41ICJUcmFjaW5nIHBvc3QtVk1YT04iIHNheXMgdGhhdAo+ID4gICAgICJJQTMyX1ZNWF9NSVND
W2JpdCAxNF0iIGJlaW5nIDEgbWVhbnMgUFQgY2FuIHRyYWNlCj4gPiAgICAgcG9zdC1WTVhPTi4K
Pgo+IExHVE0uCj4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpQ
dXNoZWQgd2l0aCB0aGUgc3RyaW5nIGpvaW5lZC4KClRoYW5rcywKSmFuCgo+Cj4gLi4uCj4gPiAg
c3RhdGljIHZvaWQgaW50ZWxfcHRfdHJhY2VfY2hlY2sodm9pZCkKPiA+ICB7Cj4gPiAgICAgICB1
aW50NjRfdCBhdXhfaGVhZCA9IDA7Cj4gPiBAQCAtMTE3LDYgKzE1MCwxMiBAQCBzdGF0aWMgdm9p
ZCBpbnRlbF9wdF90cmFjZV9jaGVjayh2b2lkKQo+ID4gICAgICAgcG1wID0gKHN0cnVjdCBwZXJm
X2V2ZW50X21tYXBfcGFnZSAqKWJ1Zm1bMF07Cj4gPiAgICAgICBhdXhfaGVhZCA9ICoodm9sYXRp
bGUgdWludDY0X3QgKikmcG1wLT5hdXhfaGVhZDsKPiA+ICAgICAgIGlmIChhdXhfaGVhZCA9PSAw
KSB7Cj4gPiArICAgICAgICAgICAgIGlmICgoYWNjZXNzKCIvc3lzL21vZHVsZS9rdm1faW50ZWwi
LCBGX09LKSA9PSAwKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICYmICghaXNfc3VwcG9ydGVk
X2Fjcm9zc192bXhvbigpKSkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHRzdF9icmsoVENP
TkYsICJJbnRlbCBQVCBvbiB0aGlzIHN5c3RlbSBjYW4gbm90Igo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIiBydW4gYXQgdGhlIHNhbWUgdGltZSBhcyB2aXJ0dWFsaXphdGlvbiIp
Owo+Cj4gQXMgd2UgZGlzY3Vzc2VkIGF0IHRoZSBpc3N1ZSwgcGxlYXNlIGpvaW4gdGhlIHN0cmlu
ZyBiZWZvcmUgbWVyZ2UuCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+CgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
