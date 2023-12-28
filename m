Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44700C3DA6E
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 04:49:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B6DA3CEC2D
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 05:48:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4152A3C86E4
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 05:48:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F5DF1000A65
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 05:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703738927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95mxJMG9SnsrmMb8N/wIVFDwkSjDIYJ5rqZmS4/AmRQ=;
 b=SaS7qK5xkw0ec6YbBb8M0pEN8tIeWWc1ZoA/umvHjjjh6yqR8iIjwpmDUAME2WBxe+hazN
 HcqzHm19x8QGmgQJGISNH/oKLzNvHHyUiJxJy2sNqq3P2CgW5Y+z3xGtkZPxgaohalZYwo
 YhB/xoQHlw2mgQ3X3fwBkB3YXJkvv7k=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-Hl-4jbQPNHyLMO2A4UJOxQ-1; Wed, 27 Dec 2023 23:48:45 -0500
X-MC-Unique: Hl-4jbQPNHyLMO2A4UJOxQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2cc2ddf70a1so40546541fa.1
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 20:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703738924; x=1704343724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95mxJMG9SnsrmMb8N/wIVFDwkSjDIYJ5rqZmS4/AmRQ=;
 b=qBS6IO1y8jbugLXIGvf4wUE6Iy9TsFMoHJnf5OXXuBODpyxj60FwDgRC53JFzd79XO
 Pg3gQFjnPB2eoLO2DrTr8csgb2qnYfIS49FuAuP9j9U+5R8olRZzlAcrXU/v7BXfCh4l
 3Hb2SZq/oqdn3/Lv7OwMAcVdHx7ZYKYMwoPDM2dV34f92wsr87II1cp0Y3vNcVm0fY2g
 4uLzb+6Mj14GCXKwqimvNW6BNjZF369hctlhXJthMf6PXrTt95mJMvXP6oAiZ2qh6La4
 sI5LnwNGb+Q+MO9zDOyBspIl6X/Ojhjp1buXDgWNFwWCe3LatkUM+ocFxDz4ARfM6fOS
 131w==
X-Gm-Message-State: AOJu0YwEqe6ceVCCzSYGrj9IaKMlLLTtSvrVvKX5P1g2bP4RObsNA6xv
 rMZ5oe42qj491qok+8Vku9xCNB4j+pq6ussvsX8wod4U50RaJmVxuVVBuGwOzmRazTVjt5catix
 gv4Bqq3rEcJM8Y5HOrf+fkcbEwZAZBdOc/dQ=
X-Received: by 2002:a2e:2d09:0:b0:2cc:6b59:d34a with SMTP id
 t9-20020a2e2d09000000b002cc6b59d34amr4235049ljt.81.1703738923814; 
 Wed, 27 Dec 2023 20:48:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtEmEWH/s2gMq6rgBm8wJ5/KynVab3gnb/x9HHtE2qgJDLOaonDtj9hl1oU8xH/79BAZ3vhpaTr7j58ZDZ268=
X-Received: by 2002:a2e:2d09:0:b0:2cc:6b59:d34a with SMTP id
 t9-20020a2e2d09000000b002cc6b59d34amr4235042ljt.81.1703738923477; Wed, 27 Dec
 2023 20:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20231227065118.209595-1-shichen@redhat.com>
 <20231227091039.GA727588@pevik>
 <CAEemH2fm47fhXBJd_3GBopqZPMCEVhFYM7Wrw-pukOtBn_Jnow@mail.gmail.com>
 <20231227142850.GA757946@pevik>
In-Reply-To: <20231227142850.GA757946@pevik>
From: Shizhao Chen <shichen@redhat.com>
Date: Thu, 28 Dec 2023 12:48:32 +0800
Message-ID: <CADm5pWdtqGO11T=Oiggv+fOZn63BTMbaAN1EaT0yXLzRF9xrHw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tools: Fix syntax error caused by "; ;
 " in create_dmesg_entry awk script
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

VGhhbmtzIGZvciB0aGUgcmV2aWV3ISBJIHdpbGwgc2VuZCBhIHYyIHNob3J0bHkuCgoKT24gV2Vk
LCBEZWMgMjcsIDIwMjMgYXQgMTA6MjnigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4g
d3JvdGU6Cj4KPiA+IEhpIFBldHIsIFNoaXpoYW8sCj4KPiA+IE9uIFdlZCwgRGVjIDI3LCAyMDIz
IGF0IDU6MTDigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4g
SGkgU2hpemhhbywKPgo+ID4gPiA+IFdoZW4gcnVubmluZyBydW5sdHAgd2l0aCBib3RoIC1TIGFu
ZCAtSyBwcm92aWRlZCwgdGVzdHMgdGhhdCBhcmUKPiA+ID4gc3VwcG9zZWQgdG8gYmUKPiA+ID4g
PiAic2tpcHBlZCIgYW5kIHJlcG9ydCBUQ09ORiByZXN1bHRzIHdlcmUgZmFpbGluZyBkdWUgdG8g
YW4gdW5leHBlY3RlZAo+ID4gPiBzZW1pY29sb24KPiA+ID4gPiBhdCB0aGUgZW5kIG9mIHRoZSBj
b25zdHJ1Y3RlZCBjb21tYW5kLgo+Cj4gPiA+ID4gYC1TYCByZXBsYWNlIHRoZSB0ZXN0IGNvbW1h
bmQgd2l0aCBgZXhpdCAzMjtgCj4gPiA+ID4gYC1LYCBhcHBlbmRzIGFub3RoZXIgc2VtaWNvbG9u
IHRvIHRoZSBjb21tYW5kIHRoZW4gd2UgZ2V0IGBleGl0IDMyOztgCj4KPiA+ID4gPiBGb3IgZXhh
bXBsZToKPgo+ID4gPiA+ICAgPj4+IDc4MDptYWR2aXNlMDZfX3dpdGhfZG1lc2dfZW50cnkgQlJP
SyA8PDwKPgo+ID4gPiA+ICAgICAgICAxICAgICAgPDw8dGVzdF9zdGFydD4+Pgo+ID4gPiA+ICAg
ICAgICAyICAgICAgdGFnPW1hZHZpc2UwNl9fd2l0aF9kbWVzZ19lbnRyeSBzdGltZT0xNzAzNTU2
MDYxCj4gPiA+ID4gICAgICAgIDMgICAgICBjbWRsaW5lPSJkbWVzZyAtYyAxPi9kZXYvbnVsbCAy
PiYxOyBleGl0IDMyOzsgZG1lc2cgPgo+ID4gPiAvbW50L3Rlc3RhcmVhL2x0cC9vdXRwdXQvRE1F
U0dfRElSX1JIRUxLVDFMSVRFLkZJTFRFUkVELWRtZXNnLW91dHB1dC01MzEyNy0wODo0ODoyM1BN
L21hZHZpc2UwNi5kbWVzZy5sb2ciCj4gPiA+ID4gICAgICAgIDQgICAgICBjb250YWN0cz0iIgo+
ID4gPiA+ICAgICAgICA1ICAgICAgYW5hbHlzaXM9ZXhpdAo+ID4gPiA+ICAgICAgICA2ICAgICAg
PDw8dGVzdF9vdXRwdXQ+Pj4KPiA+ID4gPiAgICAgICAgNyAgICAgIHNoOiAtYzogbGluZSAxOiBz
eW50YXggZXJyb3IgbmVhciB1bmV4cGVjdGVkIHRva2VuIGA7OycKPiA+ID4gPiAgICAgICAgOCAg
ICAgIHNoOiAtYzogbGluZSAxOiBgZG1lc2cgLWMgMT4vZGV2L251bGwgMj4mMTsgZXhpdCAzMjs7
Cj4gPiA+IGRtZXNnID4KPiA+ID4gL21udC90ZXN0YXJlYS9sdHAvb3V0cHV0L0RNRVNHX0RJUl9S
SEVMS1QxTElURS5GSUxURVJFRC1kbWVzZy1vdXRwdXQtNTMxMjctMDg6NDg6MjNQTS9tYWR2aXNl
MDYuZG1lc2cubG9nJwo+ID4gPiA+ICAgICAgICA5ICAgICAgPDw8ZXhlY3V0aW9uX3N0YXR1cz4+
Pgo+ID4gPiA+ICAgICAgIDEwICAgICAgaW5pdGlhdGlvbl9zdGF0dXM9Im9rIgo+ID4gPiA+ICAg
ICAgIDExICAgICAgZHVyYXRpb249MCB0ZXJtaW5hdGlvbl90eXBlPWV4aXRlZCB0ZXJtaW5hdGlv
bl9pZD0yCj4gPiA+IGNvcmVmaWxlPW5vCj4gPiA+ID4gICAgICAgMTIgICAgICBjdXRpbWU9MCBj
c3RpbWU9MQo+ID4gPiA+ICAgICAgIDEzICAgICAgPDw8dGVzdF9lbmQ+Pj4KPgo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFNoaXpoYW8gQ2hlbiA8c2hpY2hlbkByZWRoYXQuY29tPgo+ID4gPiA+IC0t
LQo+ID4gPiA+ICB0b29scy9jcmVhdGVfZG1lc2dfZW50cmllc19mb3JfZWFjaF90ZXN0LmF3ayB8
IDEgKwo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+ID4gPiA+IGRp
ZmYgLS1naXQgYS90b29scy9jcmVhdGVfZG1lc2dfZW50cmllc19mb3JfZWFjaF90ZXN0LmF3awo+
ID4gPiBiL3Rvb2xzL2NyZWF0ZV9kbWVzZ19lbnRyaWVzX2Zvcl9lYWNoX3Rlc3QuYXdrCj4gPiA+
ID4gaW5kZXggMjVkNzUwYTU1Li43YTIyYmI0YTYgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvdG9vbHMv
Y3JlYXRlX2RtZXNnX2VudHJpZXNfZm9yX2VhY2hfdGVzdC5hd2sKPiA+ID4gPiArKysgYi90b29s
cy9jcmVhdGVfZG1lc2dfZW50cmllc19mb3JfZWFjaF90ZXN0LmF3awo+ID4gPiA+IEBAIC0yNyw2
ICsyNyw3IEBAIE5GICYmICEgL14jLyB7Cj4gPiA+ID4gICAgICAgZm9yIChpID0gMjsgaSA8PSBO
RjsgaSsrKSB7Cj4gPiA+ID4gICAgICAgICAgICAgICBzID0gcyAiICIgJGkKPiA+ID4gPiAgICAg
ICB9Cj4gPiA+ID4gKyAgICAgc3ViKC87JC8sICIiLCBzKQo+Cj4gPiA+IEZyb20gdGhlIGFib3Zl
IGNvbnRleHQgYXJlIHlvdSBzdXJlIHRoYXQgdGhlcmUgd2lsbCBub3QgYmUgbWlzc2luZwo+ID4g
PiBzZW1pY29sb24/Cj4gPiA+IChlLmcuIGJldHdlZW4gZG1lc2cgYW5kIGV4aXQpCj4KPiA+ID4g
V291bGRuJ3QgaXQgYmUgc2FmZSB0byBtYWtlIHN1cmUgdGhlcmUgaXMgb25seSBvbmx5IHNpbmds
ZSBzZW1pY29sb24gYXQKPiA+ID4gdGhlIGVuZD8KPgo+Cj4gPiA+IHN1YigvWztdKyQvLCAiOyIp
Cj4KPgo+ID4gSG1tLCB0aGF0IHdvdWxkIG5vdCB3b3JrIGFzIGV4cGVjdGVkIGJlY2F1c2UgaW4g
dGhlIG5leHQgbGluZQo+ID4gZm9yY2VzIGFkZGluZyBhIHNlbWljb2xvbi4KPgo+ID4gICAgIHMg
PSBzICI7IGRtZXNnID4gIiBETUVTR19ESVIgIi8iICQxICIuZG1lc2cubG9nIgo+Cj4gPiBVbmxl
c3Mgd2UgbWFrZSBhIG1pbm9yIGFkanVzdG1lbnRzIHRvIHlvdXIgdmVyc2lvbjoKPgo+ID4gICAg
IHN1YigvWztdKyQvLCAiIiwgcykKPgo+IEFoLCB0aGFua3MgTGkhCj4KPiBJJ20gb2sgdG8gbWVy
Z2UgeW91ciBzdWdnZXN0aW9uLCBqdXN0IHdhaXQgbGl0dGxlIGxvbmdlciBmb3IgU2hpemhhbywg
aW4gY2FzZSB3ZQo+IG92ZXJsb29rZWQgc29tZXRoaW5nLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBl
dHIKPgo+ID4gT3RoZXJ3aXNlIExHVE06Cj4gPiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5n
QHJlZGhhdC5jb20+Cj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
