Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9937C4828D
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 07:48:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B4C43CC6AB
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 08:48:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAA123C8E42
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 08:48:36 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93C61601B19
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 08:48:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DV5BSLtMC8E02RwYjBTZsuBGICZBsNX1QG4RIa5iMUg=;
 b=iAz9oYdnnFrRkfDEBykIj1/aIH/W9Sld+YsaKY5iZyVkS2BO9ttFXKH3PMaXoRv2vRJYir
 L2X8uvWLUtAmIEJoOYmG42IM9Ql2iZfRUqhY4I6h4rVCftwINGrHjvfiVmIsowIv9RDkFW
 eNpfCFz6Z+45PT0yNh3+26SgDyQ6Xt4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-YW-aEqTZMiaO58rg3iM-Tg-1; Mon, 05 Feb 2024 02:48:32 -0500
X-MC-Unique: YW-aEqTZMiaO58rg3iM-Tg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d9a6ce802cso7103135ad.0
 for <ltp@lists.linux.it>; Sun, 04 Feb 2024 23:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707119310; x=1707724110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DV5BSLtMC8E02RwYjBTZsuBGICZBsNX1QG4RIa5iMUg=;
 b=c3RI3KjcLluS0gnhqxBOGh+x8s+mqIZGU/9zccKLg2ePXRKvUky+zubOvC4Zodq6N3
 AGXD1NY4ugaHoZ9JBpXp2OMpmjH3rBxMitB64GFdtlRoTbnakc6ZirJzksz9HnMB5Ith
 miPMxpqdXkojpG6QPXkYaPpH+1W+PX/oJuMfTHpp4Vv+7E+4c/7BuiSnO4UfZG4fKfdf
 J93gYhAXKyCKIco5HEA/JOcecpug7YPJeiyOFEEY5jT7tgOka6YHlo/4iBhofTWqycH/
 0g01FBtiPVn3MolaJ7WAlS80S/o05dAPbXhnW+pmZwRhupxTymLoa/ijKk1jmg69Px3U
 0xdQ==
X-Gm-Message-State: AOJu0Yyl2JRSGvJmgKjoHrHBRKDAdMysTDSHcDmjgp7eXRu1CDHffa/k
 BYWTN/IBcw4aWRh/t+/+ziMEFrn3cr1B233RUbAtioUeTL359wJV9XH2SHGib4oxqle8l8KSOg9
 7gfuLRbDYMewkNWMcMVRS41z0Uo3W1WoaUJWbj2IJR58yahswNrUdrq/CalJ6fcyyDtDRYQhbSO
 AWqEZa0tl5P4qIj2LxSR1L1YA0FWhZeqwosQ==
X-Received: by 2002:a17:90a:bc81:b0:296:321c:9bdc with SMTP id
 x1-20020a17090abc8100b00296321c9bdcmr7309392pjr.13.1707119310366; 
 Sun, 04 Feb 2024 23:48:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHh7J3f8vy1yNrq/WehXp03tacI5XFhd72GrOEmffZRoG0teZ509PHoKXFV9Ujkdh0r9W2N3TPDiYMhg4st8c=
X-Received: by 2002:a17:90a:bc81:b0:296:321c:9bdc with SMTP id
 x1-20020a17090abc8100b00296321c9bdcmr7309382pjr.13.1707119309997; Sun, 04 Feb
 2024 23:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20240205022857.191692-1-pvorel@suse.cz>
 <20240205022857.191692-2-pvorel@suse.cz>
In-Reply-To: <20240205022857.191692-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 5 Feb 2024 15:48:17 +0800
Message-ID: <CAEemH2dZn4jRjQbEX492uhb4DMHCOMq+C4zvYeq_0N1x8X_mPA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] swapon03: Swap is not supported on TMPFS on
 tmpfs
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBGZWIgNSwgMjAyNCBhdCAxMDoyOeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gdHN0X3Rlc3QuYzoxNzAxOiBUSU5GTzogPT09IFRlc3Rpbmcgb24gZXh0
NCA9PT0KPiB0c3RfdGVzdC5jOjExMTc6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDAgd2l0
aCBleHQ0IG9wdHM9JycgZXh0cmEKPiBvcHRzPScnCj4gbWtlMmZzIDEuNDcuMCAoNS1GZWItMjAy
MykKPiB0c3RfdGVzdC5jOjExMzE6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvIC90bXAv
TFRQX3N3YW5JenRxNy9tbnRwb2ludAo+IGZzdHlwPWV4dDQgZmxhZ3M9MAo+IHRzdF9pb2N0bC5j
OjI2OiBUSU5GTzogRklCTUFQIGlvY3RsIGlzIHN1cHBvcnRlZAo+IHN3YXBvbjAzLmM6MTY0OiBU
V0FSTjogRmFpbGVkIHRvIGNyZWF0ZSBzd2FwZmlsZTogc3dhcGZpbGUwMjogRUlOVkFMICgyMikK
PiBzd2Fwb24wMy5jOjE3NTogVEZBSUw6IEZhaWxlZCB0byBzZXR1cCBzd2Fwcwo+Cj4gQXQgbGVh
c3Qgb24ga2VybmVsIDYuNy4KPgo+IEZpeGVzOiAwMDlhNDA3YTAgKCJzd2Fwb24vb2ZmOiBlbmFi
bGUgYWxsX2ZpbGVzeXN0ZW0gaW4gc3dhcCB0ZXN0IikKPiBSZXBvcnRlZC1ieTogRG9taW5pcXVl
IExldWVuYmVyZ2VyIDxkaW1zdGFyQG9wZW5zdXNlLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9zd2Fwb24vc3dhcG9uMDMuYyB8IDMgKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9z
d2Fwb24wMy5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMy5j
Cj4gaW5kZXggM2RiY2Q1YmZkLi4zNzMxNGNjNjUgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAzLmMKPiBAQCAtMjQ3LDYgKzI0Nyw5IEBAIHN0YXRpYyB2
b2lkIHNldHVwKHZvaWQpCj4gICAgICAgICBpZiAoYWNjZXNzKCIvcHJvYy9zd2FwcyIsIEZfT0sp
KQo+ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAic3dhcCBub3Qgc3VwcG9ydGVkIGJ5
IGtlcm5lbCIpOwo+Cj4gKyAgICAgICBpZiAodHN0X2ZzX3R5cGUoIi4iKSA9PSBUU1RfVE1QRlNf
TUFHSUMpCj4gKyAgICAgICAgICAgICAgIHRzdF9icmsoVENPTkYsICJzd2FwIG5vdCBzdXBwb3J0
ZWQgb24gdG1wZnMiKTsKPgoKSSBkaWRuJ3QgY2F0Y2ggdGhlIHBhdGNoIHBvaW50LCBpc24ndCB0
aGUgZmFpbHVyZSBvbiBFWFQ0LCB3aHkgaGVyZSBza2lwCnRtcGZzPwpBbmQsIHNob3VsZG4ndCB0
aGUgRlMgY2hlY2sgY29tcGxldGVkIGluIGlzX3N3YXBfc3VwcG9ydGVkKCk/CgoKCj4gKwo+ICAg
ICAgICAgaXNfc3dhcF9zdXBwb3J0ZWQoVEVTVF9GSUxFKTsKPiAgfQo+Cj4gLS0KPiAyLjQzLjAK
Pgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
