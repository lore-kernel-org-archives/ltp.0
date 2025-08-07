Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B60C87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754562136; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=j+L1mfR1TthSChfzQ0D//NfZY5A8JB7NWSFkBq2n9Ek=;
 b=XgHcr8YusCnFARoTCPLrS0DyvOBF2LPg1XPFmldlpMjHi0JzoJPxF1NZ18ksSN9YCw0nG
 655xP3g19sWIoS03iTKjanfUrTLVNuklhlj/AuQXqMAzjtFarG9FTUgZCuxlrbfT4u/6YjP
 S3/7afAPSYYqk8sYA7W2kTPzwg1+6iE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0A7D3C9780
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 12:22:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D53D3C7386
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 12:21:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F1A471400990
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 12:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754562112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yh3qedtBZh6sTbCBXfcMAbQ5dZVWL9CmO2d0H63jsQ4=;
 b=H8DMCgIOZtU/mVS2P18QyTe7yTUW0GaHQ/JL6GmQmKDA3vkF2CpEKqH7TXZkFWkGT8YX8v
 hvUdC3ZBrcGcaKseiwrxOMR37SkpXnwrCQSzD0nICshQgeKXV8AXovssL/sOuPRPDbME8E
 v7q++4E3QawwwIbebeCqb40jcQBjBJI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-LHo64EeVPUiw1OBK5pBibA-1; Thu, 07 Aug 2025 06:21:51 -0400
X-MC-Unique: LHo64EeVPUiw1OBK5pBibA-1
X-Mimecast-MFC-AGG-ID: LHo64EeVPUiw1OBK5pBibA_1754562110
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b2c37558eccso774387a12.1
 for <ltp@lists.linux.it>; Thu, 07 Aug 2025 03:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754562110; x=1755166910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yh3qedtBZh6sTbCBXfcMAbQ5dZVWL9CmO2d0H63jsQ4=;
 b=ASMrDi9GTmFdIYba9LZa4QCw2CARhLNrh1R5EPTDhnFULlgZJyaWrzwFI+VNRAaDt/
 b/adrvAZvKB7vIEpq1ovPNNcBxkW/HIBLirL6VOJMlj794WPsxtjwjTYNc/wU/y+CPLE
 Y5oLC5mwJEyAQII2jCmgKGVR1O60cWa4nv70X7U20e3DdZjs6vJVGRdDOdSn/v/v/RG/
 fj0IBjYgupDwlMTqUnUgHHSiLE0fEuhONAi/Kcm8xD+0ZOvc6YNSkPm6Bo2ySeZcMajo
 zhEbbYlAXCOIIhfKv0YhvoT3cyjXXSAVr5Vmasl8ID5p/0afXUNLSeBdWEz/Gj/Na/1C
 amWQ==
X-Gm-Message-State: AOJu0Yx0O2TysktZsZnlgy72FU1QRcTK6oqgSLAdKoURtMhJ9fVkGiL0
 zKwb6G48AfS9mzomb6hREyv0cgOqKIZYoYm2TmfjlHZQCw7xax+qJDI/CIYORANXvzrphOK5pz7
 /vJEfZhG9sFMbJhgpgvRndsA5jQS/+ScEOuGuQqhdSUFZkjfxkt+viY03a3lLnyVKmQqXYX9OBl
 c/6k1CH6DYmNeTU1NTBszwGkjSVPs=
X-Gm-Gg: ASbGncuQQ/W1GWSdyRCIRRb7op8FPVVULBLT7aXHDqIOGulwxa1NC7T36SWYSbJhMQl
 /ATfsYux8SJGfOu4HlEPOvub1KYxtujqlUUlNiqeuFMPDJYMi75ba0jnqvjcSyltGy1aY8eqOON
 0dCtX9hjek3BUdarANAOhCbg==
X-Received: by 2002:a17:902:cec8:b0:242:abac:30f0 with SMTP id
 d9443c01a7336-242abac3c63mr62337935ad.42.1754562109820; 
 Thu, 07 Aug 2025 03:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwUpgo7F20EyqFcO1Dair2gj6/ReXMlZtwVnwxXv8zW7HuZJr7pSV9QiOZmieKp5I6ug7j/crk0byYBZK9aE4=
X-Received: by 2002:a17:902:cec8:b0:242:abac:30f0 with SMTP id
 d9443c01a7336-242abac3c63mr62337645ad.42.1754562109407; Thu, 07 Aug 2025
 03:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250807062941.348971-1-pvorel@suse.cz>
 <20250807062941.348971-2-pvorel@suse.cz>
In-Reply-To: <20250807062941.348971-2-pvorel@suse.cz>
Date: Thu, 7 Aug 2025 18:21:36 +0800
X-Gm-Features: Ac12FXwbu9yAmSuR9NwJdCpd2oAiAQvFL8nfghixKuW0_jXvy4I0Ghe3LqPEZKE
Message-ID: <CAEemH2e1CbqCv8Bq4dJgBoRU2hJ72fPTsHJDYV8oLXRgs7SdAw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xI1vLb-zllwns1jkNRIdJ41mSUqf3u5LxOBsa1djn84_1754562110
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
 error
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

SGkgUGV0ciwKCkkgYW0gc3RpbGwgdHJ5aW5nIHRvIG1ha2Ugc3VyZSBteSB1bmRlcnN0YW5kaW5n
IGlzIGNvcnJlY3Qgb24KJ0ZPUkNFX01PRFVMRVM9MScsCndoaWNoIG9uZSBiZWxvdyBkbyB5b3Ug
bWVhbjoKCiAgMS4gSWYgYSBzdWJkaXJlY3RvcnkgZmFpbHMsIGl0IHN0b3BzIGZvciB0aGF0IHN1
YmRpcmVjdG9yeSBidXQgdGhlCnRvcC1sZXZlbCBtYWtlCiAgICAgIGNvbnRpbnVlcyB3aXRoIHRo
ZSBuZXh0IGRpcmVjdG9yeSBpbiB0aGUgbGlzdC4KCiAgMi4gVGhlIHRvcC1sZXZlbCBidWlsZCBz
aG91bGQgc3RvcCBpbW1lZGlhdGVseSB3aGVuIGFueSBzdWJkaXJlY3RvcnkKZmFpbHMuCgpJZiB0
aGUgYW5zd2VyIGlzICgxKSwgSSBiZWxpZXZlIG91ciBjdXJyZW50IHBhdGNoIGlzIGNvcnJlY3Qg
KGZlZWwgZnJlZSB0bwphZGQgbXkgUkJUKS4KSG93ZXZlciwgaWYgdGhlIGludGVuZGVkIGJlaGF2
aW9yIGlzICgyKSwgd2Ugd2lsbCBuZWVkIHRvIGFtZW5kIHRoZQp0b3AtbGV2ZWwgTWFrZWZpbGUK
dG8gZW5zdXJlIHRoZSBidWlsZCBzdG9wcyBhdCB0aGUgZmlyc3QgZmFpbHVyZS4KCgpPbiBUaHUs
IEF1ZyA3LCAyMDI1IGF0IDI6MjnigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3Jv
dGU6Cgo+IEtlcm5lbCBtb2R1bGVzIGRlbGliZXJhdGVseSBub3QgZmFpbCBvbiBlcnJvciBkdWUg
a0FCSQo+IChMaW51eCBLZXJuZWwgRHJpdmVyIEludGVyZmFjZSkgbm90IGJlaW5nIHN0YWJsZSBb
MV0uCj4KPiBCdXQgdGhhdCBhbHNvIHNpbGVudGx5IGhpZGVzIG1vZHVsZXMgbm90IGJlaW5nIGJ1
aWxkIGR1ZSBjaGFuZ2UKPiAoTFRQIG1vZHVsZSBuZWVkcyB0byBiZSB1cGRhdGVkKSBvciBkaXN0
cm8gYnVnLgo+Cj4gSW50cm9kdWNlIEZPUkNFX01PRFVMRVM9MSB2YXJpYWJsZSBmb3IgbWFrZSB0
byBmb3JjZSBmYWlsIG9uIGVycm9yLgo+IFRoaXMgY2FuIGhhcHBlbiBpZgo+ICogcGFja2FnZSBm
b3IgYnVpbGRpbmcga2VybmVsIG1vZHVsZXMgaXMgbm90IGluc3RhbGxlZAo+ICogTFRQIGtlcm5l
bCBtb2R1bGUgZXJyb3IgbWVudGlvbmVkIGFib3ZlCj4KPiAkIG1ha2UgbW9kdWxlcyBGT1JDRV9N
T0RVTEVTPTEKPiBCdWlsZCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zpbml0X21vZHVsZQo+
ICBDaGVjayB0aGF0IHBhY2thZ2UgZm9yIGJ1aWxkaW5nIGtlcm5lbCBtb2R1bGVzIGZvciA2LjYu
MTUtYW1kNjQgaXMKPiBpbnN0YWxsZWQgYW5kIHRyeSBhZ2Fpbi4KPiAgKiBvcGVuU1VTRS9TTEVT
OiBrZXJuZWwtZGVmYXVsdC1kZXZlbAo+ICAqIEZlZG9yYS9SSEVMOiBrZXJuZWwtZGV2ZWwva2Vy
bmVsLWhlYWRlcnMKPiAgKiBEZWJpYW4vVWJ1bnR1OiBsaW51eC1rYnVpbGQKPiAgWW91IGNhbiBi
dWlsZCBhbnl3YXkgYnkgb21pdHRpbmcgRk9SQ0VfTU9EVUxFUz0xLiAgU3RvcC4KPiAuLi4KPgo+
IE5PVEU6IHByZXZpb3VzbHkgYWRkZWQgJ21vZHVsZXMnIG1ha2UgdGFyZ2V0IGtlZXBzIHRyeWlu
ZyB0byBidWlsZCBhbGwKPiBtb2R1bGVzIChkb24ndCBzdG9wIG9uIGZpcnN0IGVycm9yKS4KPgo+
IFsxXSBodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL3N0YWJsZS1hcGktbm9uc2Vuc2Uu
aHRtbAo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0t
Cj4gQ2hhbmdlcyB2My0+djQ6Cj4gKiBGaXggYnVpbGQgb24gYG1ha2UgbW9kdWxlcyBGT1JDRV9N
T0RVTEVTPTFgIChMaSkKPgo+IExpbmsgdG8gdjM6Cj4KPiBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvbHRwL3BhdGNoLzIwMjUwODA2MjExNDIwLjQ0NTQ1Mi0yLXB2b3JlbEBz
dXNlLmN6Lwo+Cj4gIElOU1RBTEwgICAgICAgICAgICAgIHwgIDYgKysrKysrCj4gIGluY2x1ZGUv
bWsvbW9kdWxlLm1rIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKystCj4gIDIgZmlsZXMgY2hh
bmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL0lO
U1RBTEwgYi9JTlNUQUxMCj4gaW5kZXggMTBjMTlkNDEwNS4uN2MyNWMyMzM0NyAxMDA2NDQKPiAt
LS0gYS9JTlNUQUxMCj4gKysrIGIvSU5TVEFMTAo+IEBAIC0xNzIsOSArMTcyLDE1IEBAIExUUCBj
b250YWlucyBmZXcga2VybmVsIG1vZHVsZXMgYW5kIHRlc3RzIHdoaWNoIGFyZQo+IHVzaW5nIHRo
ZW0uCj4gIFRoZXNlIHJlcXVpcmUgdG8gYmUgYnVpbHQgd2l0aCB0aGUgc2FtZSBrZXJuZWwgaGVh
ZGVycyBhcyB0aGUgcnVubmluZwo+IGtlcm5lbCAoU1VUKS4KPiAgU29tZXRpbWVzIHRoZSBiZXN0
IHdheSB0byBhY2hpZXZlIHRoaXMgaXMgdG8gY29tcGlsZSB0aGVtIG9uIHRoZSBTVVQuCj4KPiAr
RHVlIExpbnV4IEtlcm5lbCBEcml2ZXIgSW50ZXJmYWNlIHVuc3RhYmlsaXR5IFsxXSwgZXJyb3Ig
ZHVyaW5nIGJ1aWxkaW5nCj4ga2VybmVsCj4gK21vZHVsZXMgZG9lcyBub3QgYnJlYWsgdGhlIGJ1
aWxkLiBNYWtlIGVycm9ycyBmYXRhbCBjYW4gYmUgZG9uZSBieQo+IEZPUkNFX01PRFVMRVM9MQo+
ICttYWtlIHZhcmlhYmxlLgo+ICsKPiAgJ21vZHVsZXMnLCAnbW9kdWxlcy1jbGVhbicgYW5kICdt
b2R1bGVzLWluc3RhbGwnIG1ha2UgdGFyZ2V0cyBhcmUKPiBzaG9ydGN1dHMKPiAgdG8gYnVpbGQg
anVzdCB0aGVzZSBtb2R1bGVzIGFuZCB0ZXN0cy4KPgo+ICtbMV0gaHR0cHM6Ly9kb2NzLmtlcm5l
bC5vcmcvcHJvY2Vzcy9zdGFibGUtYXBpLW5vbnNlbnNlLmh0bWwpCj4gKwo+ICBBbmRyb2lkIFVz
ZXJzCj4gIC0tLS0tLS0tLS0tLS0KPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL21rL21vZHVsZS5t
ayBiL2luY2x1ZGUvbWsvbW9kdWxlLm1rCj4gaW5kZXggYzNjYmY5YzIxZi4uM2U5N2YwMTI4OSAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL21rL21vZHVsZS5tawo+ICsrKyBiL2luY2x1ZGUvbWsvbW9k
dWxlLm1rCj4gQEAgLTEsMTQgKzEsMjIgQEAKPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcgo+ICAjIENvcHlyaWdodCAoYykgMjAxMyBPcmFjbGUgYW5kL29yIGl0
cyBhZmZpbGlhdGVzLiBBbGwgUmlnaHRzIFJlc2VydmVkLgo+IC0jIENvcHlyaWdodCAoYykgTGlu
dXggVGVzdCBQcm9qZWN0LCAyMDE0LTIwMjEKPiArIyBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3Qg
UHJvamVjdCwgMjAxNC0yMDI1Cj4gICMgQXV0aG9yOiBBbGV4ZXkgS29kYW5ldiA8YWxleGV5Lmtv
ZGFuZXZAb3JhY2xlLmNvbT4KPiAgIwo+ICAjIEluY2x1ZGUgaXQgdG8gYnVpbGQga2VybmVsIG1v
ZHVsZXMuCj4gICMgUkVRX1ZFUlNJT05fTUFKT1IgYW5kIFJFUV9WRVJTSU9OX1BBVENIIG11c3Qg
YmUgZGVmaW5lZCBiZWZvcmVoYW5kLgo+ICsjCj4gKyMgRk9SQ0VfTU9EVUxFUz0xOiBGb3JjaW5n
IHRvIGZhaWwgb24gZXJyb3Igb3IgbWlzc2luZyBrZXJuZWwgaGVhZGVycwo+IChlLmcuIGZvciBD
SSkpLgo+Cj4gICQoaWYgJChSRVFfVkVSU0lPTl9NQUpPUiksLCQoZXJyb3IgWW91IG11c3QgZGVm
aW5lIFJFUV9WRVJTSU9OX01BSk9SKSkKPiAgJChpZiAkKFJFUV9WRVJTSU9OX1BBVENIKSwsJChl
cnJvciBZb3UgbXVzdCBkZWZpbmUgUkVRX1ZFUlNJT05fUEFUQ0gpKQo+Cj4gK2RlZmluZSBuZXds
aW5lCj4gKwo+ICsKPiArZW5kZWYKPiArbiA6PSAkKG5ld2xpbmUpCj4gKwo+ICBpZmVxICgkKFdJ
VEhfTU9EVUxFUyksbm8pCj4gIFNLSVAgOj0gMQo+ICBlbHNlCj4gQEAgLTIyLDggKzMwLDE4IEBA
IFNLSVAgPz0gJChzaGVsbCBcCj4gIGVuZGlmCj4gIGVuZGlmCj4KPiArJChpbmZvIHNraXA6ICQo
U0tJUCksIEZPUkNFX01PRFVMRVM6ICQoRk9SQ0VfTU9EVUxFUykpCj4gIGlmbmVxICgkKFNLSVAp
LDApCj4gIE1BS0VfVEFSR0VUUyA6PSAkKGZpbHRlci1vdXQgJS5rbywgJChNQUtFX1RBUkdFVFMp
KQo+ICtpZmVxICgkKEZPUkNFX01PRFVMRVMpLDEpCj4gKyQoZXJyb3IgS2VybmVsIG1vZHVsZXMg
bm90IGJ1aWx0ISQobilcCj4gK0NoZWNrIHRoYXQgcGFja2FnZSBmb3IgYnVpbGRpbmcga2VybmVs
IG1vZHVsZXMgZm9yICQoTElOVVhfVkVSU0lPTilcCj4gK2lzIGluc3RhbGxlZCBhbmQgdHJ5IGFn
YWluLiQobilcCj4gKyogb3BlblNVU0UvU0xFUzoga2VybmVsLWRlZmF1bHQtZGV2ZWwkKG4pXAo+
ICsqIEZlZG9yYS9SSEVMOiBrZXJuZWwtZGV2ZWwva2VybmVsLWhlYWRlcnMkKG4pXAo+ICsqIERl
Ymlhbi9VYnVudHU6IGxpbnV4LWtidWlsZCQobilcCj4gK1lvdSBjYW4gYnVpbGQgYW55d2F5IGJ5
IG9taXR0aW5nIEZPUkNFX01PRFVMRVM9MSkKPiArZW5kaWYKPiAgZW5kaWYKPgo+ICBpZm5lcSAo
JChmaWx0ZXIgaW5zdGFsbCBjbGVhbiwkKE1BS0VDTURHT0FMUykpLCkKPiBAQCAtNDUsNiArNjMs
MTAgQEAgTU9EVUxFX1NPVVJDRVMgOj0gJChwYXRzdWJzdCAlLmtvLCUuYywkKGZpbHRlciAlLmtv
LAo+ICQoTUFLRV9UQVJHRVRTKSkpCj4KPiAgLmRlcF9tb2R1bGVzOiAkKE1PRFVMRV9TT1VSQ0VT
KQo+ICAgICAgICAgQGVjaG8gIkJ1aWxkaW5nIG1vZHVsZXM6ICQoTU9EVUxFX1NPVVJDRVMpIgo+
ICtpZm5lcSAoJChGT1JDRV9NT0RVTEVTKSwxKQo+ICAgICAgICAgLSQoTUFLRSkgLUMgJChMSU5V
WF9ESVIpIE09JChhYnNfc3JjZGlyKQo+ICtlbHNlCj4gKyAgICAgICAkKE1BS0UpIC1DICQoTElO
VVhfRElSKSBNPSQoYWJzX3NyY2RpcikKPiArZW5kaWYKPiAgICAgICAgIHJtIC1yZiAqLm1vZC5j
ICoubyAqLmtvLnVuc2lnbmVkIG1vZHVsZXMub3JkZXIgLnRtcCogLioua28gLiouY21kCj4gTW9k
dWxlLnN5bXZlcnMKPiAgICAgICAgIEB0b3VjaCAuZGVwX21vZHVsZXMKPiAtLQo+IDIuNTAuMQo+
Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
