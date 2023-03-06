Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E55EC61DA4
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 08:52:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A7673CDAF1
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 09:52:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C8823C335C
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 09:52:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 453C9200C62
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 09:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678092736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SdZopYMZk1Hq/p7s8RlsnPpCUNwforBmcVzLHKrUXNo=;
 b=Sl8w53oYIbxHCFg8LXB6w0lnF+Rte50aY3LVuRTT4nrGcnOWTyMpfpzfofhDMKXs0aPYQI
 DzZDmdglUiJ4PqdIXDeMPerpdz5A0/8pefIo4GkscFLjySP3aa6WcekfYsrn2gPekgIFQR
 r6UjF2H4Y3S0caYT/6aMVyNlmzpke0Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-4TJGNmvINkeX2pT8NrOr4Q-1; Mon, 06 Mar 2023 03:52:15 -0500
X-MC-Unique: 4TJGNmvINkeX2pT8NrOr4Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 p22-20020a7bcc96000000b003e2036a1516so6466285wma.7
 for <ltp@lists.linux.it>; Mon, 06 Mar 2023 00:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678092733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdZopYMZk1Hq/p7s8RlsnPpCUNwforBmcVzLHKrUXNo=;
 b=z7x9zsJ0P4l8Qvcd1piA9FxWykCd9sTQN1EBeH+5RulrHut6HndjPo+cmA1f8/f/CL
 JdGj9nfDInGOzcMNdAvbumvVMtjKpmwhBMMROLCC58RZoScZiAKArxWGNlkVTeOzBzdX
 6+9RToTumppszI2sG2KwoivB8akhCacuJ7CWHTKpf5wJXXtm0C9xRSxusblXztZlxNlj
 bKVb246m+vSYB8LG1XQ/EEktBu5lBxisRhwOoVZbjNVB6H0tIUoKjMT6mFl/oMLuP+Du
 lJ07V9qVGWJ1gys8qJguUyBEQDWS0Gq8mT3H21twcEQBfPRiviuBNAKIYlg83XPKbPa5
 ot2A==
X-Gm-Message-State: AO0yUKUNGUtIVFVjMrcKjxYIJw1/bz3Zs48P1Cvm3ri4Tnk6p/DEV/H3
 yX+tv/vJ0bKE173g/TLPQuPVygwdZ2YT6YJ6gLJ8bNEaRkKm56pFLb+2tWpybdfHD1P3nhNAxy4
 KtBZ+/vBSLRI696/eRT8Ro6YpXYRdF09Ld6qbV9T/
X-Received: by 2002:a5d:468f:0:b0:2ce:3426:6304 with SMTP id
 u15-20020a5d468f000000b002ce34266304mr1677133wrq.8.1678092733705; 
 Mon, 06 Mar 2023 00:52:13 -0800 (PST)
X-Google-Smtp-Source: AK7set9KUm7UxHsL4KR7KyvtUO04ExYGEmFOMpZjHu6JYWzvcWCp3j/Px97+joq2cXu47eQvFhOcGEug1iu7Ax17xwE=
X-Received: by 2002:a5d:468f:0:b0:2ce:3426:6304 with SMTP id
 u15-20020a5d468f000000b002ce34266304mr1677129wrq.8.1678092733378; Mon, 06 Mar
 2023 00:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20230301080131.86627-1-gehao@kylinos.cn>
 <20230303092429.103190-1-gehao@kylinos.cn>
In-Reply-To: <20230303092429.103190-1-gehao@kylinos.cn>
From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Mar 2023 16:52:01 +0800
Message-ID: <CAEemH2fENk_T90Mkfvu0=Bf=rLLPTxA-Vh4PyFO80ToXRDEaRQ@mail.gmail.com>
To: Hao Ge <gehao@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] cpuset/cpuset_memory_pressure_test: Fix free
 memory calculate
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

T24gRnJpLCBNYXIgMywgMjAyMyBhdCA1OjI14oCvUE0gSGFvIEdlIHZpYSBsdHAgPGx0cEBsaXN0
cy5saW51eC5pdD4gd3JvdGU6Cgo+IEN1cnJlbnRseSwgZnJlZSBoYXMgdHdvIG91dHB1dCBmb3Jt
YXRzLGFzIGZvbGxvd3MKPgo+IGZyZWUgLW0KPiAgICAgICAgIHRvdGFsICAgICAgICB1c2VkICAg
ICAgICBmcmVlICAgICAgc2hhcmVkICBidWZmL2NhY2hlICAgYXZhaWxhYmxlCj4gTWVtOiAgIDEy
ODEzNSAgICAgICAgMzg1NyAgICAgIDEyMDYzMyAgICAgICAgIDE1OCAgICAgICAgMzY0NCAgICAg
IDEyMzIxOQo+IFN3YXA6ICAgIDgxOTEgICAgICAgICAgODIgICAgICAgIDgxMDkKPgo+IGZyZWUg
LW0KPiAgICAgICAgIHRvdGFsICAgICAgIHVzZWQgICAgICAgZnJlZSAgICAgc2hhcmVkICAgIGJ1
ZmZlcnMgICAgIGNhY2hlZAo+IE1lbTogICA0MTk2OTQgICAgICAgOTQ2NCAgICAgNDEwMjMwICAg
ICAgICAyMzQgICAgICAgIDQzNSAgICAgICA2MDA1Cj4gLS8rIGJ1ZmZlcnMvY2FjaGU6ICAgICAg
IDMwMjIgICAgIDQxNjY3MQo+IFN3YXA6ICAgIDIwNTMgICAgICAgICAgMCAgICAgICAyMDUzCj4K
PiBXZSBuZWVkIHRvIGF2b2lkIHRoZSBlcnJvciBvZiBhZGRpbmcgdGhlIGF2YWlsYWJsZSBpdGVt
IHNvIHRoYXQgcHlfbWVtIGlzCj4gd3JvbmcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBIYW8gR2UgPGdl
aGFvQGt5bGlub3MuY24+Cj4gLS0tCj4gIC4uLi9jcHVzZXRfbWVtb3J5X3ByZXNzdXJlX3Rlc3Rz
ZXQuc2ggICAgICAgICAgICAgICAgICB8IDEwICsrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdAo+IGEvdGVzdGNh
c2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV9wcmVzc3VyZV90ZXN0
L2NwdXNldF9tZW1vcnlfcHJlc3N1cmVfdGVzdHNldC5zaAo+IGIvdGVzdGNhc2VzL2tlcm5lbC9j
b250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV9wcmVzc3VyZV90ZXN0L2NwdXNldF9tZW1v
cnlfcHJlc3N1cmVfdGVzdHNldC5zaAo+IGluZGV4IGVkZGQ3ZjZjNS4uODhkYjAzZmQ5IDEwMDc1
NQo+IC0tLQo+IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21l
bW9yeV9wcmVzc3VyZV90ZXN0L2NwdXNldF9tZW1vcnlfcHJlc3N1cmVfdGVzdHNldC5zaAo+ICsr
Kwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV9w
cmVzc3VyZV90ZXN0L2NwdXNldF9tZW1vcnlfcHJlc3N1cmVfdGVzdHNldC5zaAo+IEBAIC0zMiw4
ICszMiwxNiBAQCBjaGVjawo+Cj4gIGV4aXRfc3RhdHVzPTAKPgo+ICsjcmVhZCBmcmVlIGNtZCBw
cmludCBsYXlvdXQgaXMgYnVmZi9jYWNoZSBvciBidWZmIGNhY2hlCj4gK2JjX3N0cmluZz0kKGZy
ZWUgLW0gfCBhd2sgJ3tpZihOUj09MSkgcHJpbnQgJDV9JykKPiArCj4gICMgdXNhYmxlIHBoeXNp
Y2FsIG1lbW9yeQo+IC1weV9tZW09JChmcmVlIC1tIHwgYXdrICd7aWYoTlI9PTIpIHByaW50ICQ0
ICsgJDYgKyAkN30nKQo+ICtpZiBbICIkYmNfc3RyaW5nIiA9PSAiYnVmZi9jYWNoZSIgXQo+ICt0
aGVuCj4gKyAgICAgICAgcHlfbWVtPSQoZnJlZSAtbSB8IGF3ayAne2lmKE5SPT0yKSBwcmludCAk
NCArICQ2fScpCj4gK2Vsc2UKPiArICAgICAgICBweV9tZW09JChmcmVlIC1tIHwgYXdrICd7aWYo
TlI9PTIpIHByaW50ICQ0ICsgJDYgKyAkN30nKQo+ICtmaQo+Cj4gICMgZnJlZSBzd2FwIHNwYWNl
Cj4gIHN3X21lbT0kKGZyZWUgLW0gfCBhd2sgJ3tpZihOUj09NCkgcHJpbnQgJDR9JykKPgoKQ2Fu
IHdlIGV4dHJhY3QgYWxsIHRoZSBhYm92ZSBzaXplcyBmcm9tICcvcHJvYy9tZW1pbmZvJyBhdCBv
bmNlPwoKIyBjYXQgL3Byb2MvbWVtaW5mbwpNZW1Ub3RhbDogICAgICAgIDc4MzE4NTIga0IKTWVt
RnJlZTogICAgICAgICA0NDU1ODg4IGtCCk1lbUF2YWlsYWJsZTogICAgNzE5MzY2MCBrQgpCdWZm
ZXJzOiAgICAgICAgICAgIDUyNjQga0IKQ2FjaGVkOiAgICAgICAgICAyOTAyNTE2IGtCClN3YXBD
YWNoZWQ6ICAgICAgICAgICAgMCBrQgpBY3RpdmU6ICAgICAgICAgIDEyNDI4NzYga0IKLi4uClN3
YXBUb3RhbDogICAgICAgODIyODg2MCBrQgpTd2FwRnJlZTogICAgICAgIDgyMjg4NjAga0IKCgot
LSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
