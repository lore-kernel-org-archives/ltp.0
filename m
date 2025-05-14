Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785CFC3ABDA
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747214099; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ydPOHVxg8+2XWeQ7FMu/5oYpOsL5A4Xqiu+DKFER04A=;
 b=KoayZVBGWKpHl2rJCN6VPY0R+iT431Ob8Ob/AhnlhBfmwgpDmtC/2FaLSe+F5OWWU+gIl
 krMJi6jzr4JK5pcbY9oLN3TjJXe3VongmJ6D8Juh3L12qgiSJRO+ywi6ic5kLFR1vOyqD4s
 n+q1FusZljRJ5Pqr03Km9XrHEMY2mis=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0F583CC392
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 11:14:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F4EA3C93B8
 for <ltp@lists.linux.it>; Wed, 14 May 2025 11:14:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA493200BC4
 for <ltp@lists.linux.it>; Wed, 14 May 2025 11:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747214074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iL9nh6fDZ2xyQeRL7pJj27yvY3rPYSm403Qxr/Y7f0=;
 b=SZCgMTsErnGYHFf4Km2b8y6D8ipV5D6VfSbxiUpeZMzQQ72dsm9phW1iE2HT5Kg32PMWMT
 qGDEPrvd6DHNjZclaIvsMegg4dbl7/UP45EHzC5vfldIpXV0lsR4YB/dUzZEujYrvbz+aJ
 BN47iJdqioHfR18eww6oTLWfYJJtuYw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-wnI9uyaANmGcofmSmIkO6Q-1; Wed, 14 May 2025 05:14:33 -0400
X-MC-Unique: wnI9uyaANmGcofmSmIkO6Q-1
X-Mimecast-MFC-AGG-ID: wnI9uyaANmGcofmSmIkO6Q_1747214072
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22fd4e7ea48so45744425ad.3
 for <ltp@lists.linux.it>; Wed, 14 May 2025 02:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747214071; x=1747818871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6iL9nh6fDZ2xyQeRL7pJj27yvY3rPYSm403Qxr/Y7f0=;
 b=UJcBb3JbknLb1CgeE86UkvJdkvPXoyK1QNlrV9DBqm74w2x8/tmUNwy1Hw9BAbvbpk
 1ay5xsRJ+yWaMKS8Hb2HMynMzkdiIg1RNd4qQHPo8HtyOernPORm211601dxYo4ENfcZ
 Kyacq7H11PL/JnwSD2ig0Cw90D4dtOXazLdLoFZS1okByKjGiOVGJIKohBcnyozCW1MG
 kwNUexGLtUDMOgl5GxAPPvytQcpPXnzKW52zRpecUbPQj/yoN0Yn4ygSXAIPXUpE6EgZ
 HIuhAtIqWwr3GyHdjCGtGNM/CgpIj2bD5GflZRYZgdGKMmVNkdCS3tFFhZisZa8UpoMg
 apAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUreuFkmZ1IVSpTSmLb7EC/70VuCnigIbZArQpZ9kbI66urWy9WRDyQ41yK3yVSqT2iS2o=@lists.linux.it
X-Gm-Message-State: AOJu0YzMOcQ3+S+mVYq3JK1UFCczb4Uggnn2MBCijXZTxmV3cNUP2rpq
 XHLpPloGDlAr5NznanO8D5Y7iumD8XMRvpkAi1dqqj4EJi53kq4pOkE9/ewHaWgKvbp4icEe1QI
 oZp6TcLchrHMgt2TM4HzQK6AOi1dggtUOklM93WGUAQbxt820FgjkbPzhsxu8rfJzl7qnJcZ9n8
 7dRgn8UL7zb9bn0/Rzf8gwd1U3EgmGvKViwA==
X-Gm-Gg: ASbGnctTc/W1+XRz02LnYWr79psuhcUNlPUdhXOyFaQdUvTOFuGBnOQRLjVQ0C+1vus
 M3RlHdgJK1STKum1f0/Te3625wUxXNSvb7mDBSbR2rk9X9ak85nnD0Rn3vVHsJlKNaFk0Jg==
X-Received: by 2002:a17:902:f60b:b0:224:1935:fb7e with SMTP id
 d9443c01a7336-2319815e3femr49021285ad.24.1747214070666; 
 Wed, 14 May 2025 02:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj67M//1y2uoEOeLLZVYd0X6Czst9RXjiW6oY7B7BqISof20koEXstbTj36PShiX9a9cmtkysoyaRRVQ6bcRo=
X-Received: by 2002:a17:902:f60b:b0:224:1935:fb7e with SMTP id
 d9443c01a7336-2319815e3femr49020855ad.24.1747214070273; Wed, 14 May 2025
 02:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
 <aBt7ck35Dq8GIKHc@yuki.lan>
 <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
 <aCNox5FGkPsLWGf2@MiWiFi-CR6608-srv>
 <CAASaF6yRO-_dX-ktapqAcWyqU-jwf2k8cJ9+Q7XAN7sqkngz8A@mail.gmail.com>
 <CAEemH2dWyGyHXngTSghnAUmyF+DS0GNvKatVR9CuTpMEZc-rPQ@mail.gmail.com>
 <CAASaF6xNg8AeQMRscHY_gsqQGxw=wPhYiwquuHVKLSgZEYDoFA@mail.gmail.com>
In-Reply-To: <CAASaF6xNg8AeQMRscHY_gsqQGxw=wPhYiwquuHVKLSgZEYDoFA@mail.gmail.com>
Date: Wed, 14 May 2025 17:14:17 +0800
X-Gm-Features: AX0GCFspqf-2HZV5qXQMj1xZMWzjFZRNsn4z5td3rmB2_HuOHJT4Yv12n6MeX_Y
Message-ID: <CAEemH2fFUdjmqsNvFBk5mRjn+2xm62HJZx48Qug4jMdVBJNnsA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LD_VaxHUdSikQpbD8oUc6j3kx6wQSMLg4-Pjt7z44kg_1747214072
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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

T24gV2VkLCBNYXkgMTQsIDIwMjUgYXQgNToxMOKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgTWF5IDE0LCAyMDI1IGF0IDExOjA04oCvQU0g
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgTWF5IDE0
LCAyMDI1IGF0IDQ6NTLigK9QTSBKYW4gU3RhbmNlayB2aWEgbHRwIDxsdHBAbGlzdHMubGludXgu
aXQ+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUdWUsIE1heSAxMywgMjAyNSBhdCA1OjQ04oCvQU0g
V2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gTW9uLCBN
YXkgMTIsIDIwMjUgYXQgMTA6NDM6NTVBTSArMDIwMCwgSmFuIFN0YW5jZWsgd3JvdGU6Cj4gPiA+
ID4gPiBJcyBhbnlvbmUgZWxzZSBzZWVpbmcgdGhpcyB0ZXN0IGZhaWxpbmcgb24gcmVjZW50IDYu
MTUtcmM1IGtlcm5lbHM/Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPT09PSBtbWFwMjIgPT09PQo+ID4g
PiA+ID4gY29tbWFuZDogbW1hcDIyCj4gPiA+ID4gPiB0c3RfdG1wZGlyLmM6MzE2OiBUSU5GTzog
VXNpbmcgL3RtcC9MVFBfbW1hekNVTE5OIGFzIHRtcGRpciAodG1wZnMgZmlsZXN5c3RlbSkKPiA+
ID4gPiA+IHRzdF90ZXN0LmM6MTkzODogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDEzMC0yNTMt
ZzRhMGUzYThmYQo+ID4gPiA+ID4gdHN0X3Rlc3QuYzoxOTQyOiBUSU5GTzogVGVzdGVkIGtlcm5l
bDoKPiA+ID4gPiA+IDYuMTUuMC0wLnJjNS4yNTA1MDlnOWM2OWY4ODg0OTA0LjQ3LmVsbjE0OC54
ODZfNjQgIzEgU01QCj4gPiA+ID4gPiBQUkVFTVBUX0RZTkFNSUMgRnJpIE1heSAgOSAxNToxNzoz
MSBVVEMgMjAyNSB4ODZfNjQKPiA+ID4gPiA+IHRzdF9rY29uZmlnLmM6ODg6IFRJTkZPOiBQYXJz
aW5nIGtlcm5lbCBjb25maWcKPiA+ID4gPiA+ICcvbGliL21vZHVsZXMvNi4xNS4wLTAucmM1LjI1
MDUwOWc5YzY5Zjg4ODQ5MDQuNDcuZWxuMTQ4Lng4Nl82NC9idWlsZC8uY29uZmlnJwo+ID4gPiA+
ID4gdHN0X3Rlc3QuYzoxNzU4OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGgg
MDVtIDU0cwo+ID4gPiA+ID4gbW1hcDIyLmM6NTU6IFRGQUlMOiBNQVBfRFJPUFBBQkxFIGRpZCBu
b3QgZHJvcCBtZW1vcnkgd2l0aGluIHRoZSB0aW1lb3V0IHBlcmlvZC4KPiA+ID4gPiA+Cj4gPiA+
ID4KPiA+ID4gPiBJIGhhdmUgdGVzdGVkIHJjNS82IGFuZCBib3RoIGdpdmUgcGFzcyByZXN1bHQu
Cj4gPiA+Cj4gPiA+IEkgZG8gc2VlIGl0IGZhaWwgYWxtb3N0IGRhaWx5IG9uIG11bHRpcGxlIGFy
Y2hlcyAoVk1zIGFuZCBiYXJlbWV0YWwpLAo+ID4gPiBtYXliZSBzb21lIGRpZmZlcmVuY2UgaW4g
b3VyIGNvbmZpZy4KPiA+Cj4gPiBIYXZlIHlvdSB0cmllZCB0aGUgb3JpZ2luYWwgc2VsZi10ZXN0
ICh3aXRob3V0IHVzaW5nIENncm91cCk/Cj4gPiBJZiBpdCBzdGlsbCBmYWlscywgY29uc2lkZXIg
aXQgYSBrZXJuZWwgaXNzdWUuCj4KPiBJJ2xsIGhhdmUgYSBjbG9zZXIgbG9vayBhbmQgdHJ5IG1h
bnVhbGx5LiBBdCBmaXJzdCBnbGFuY2UgYXQgdGVzdCwgSQo+IHN1c3BlY3QgY29tcGlsZXIKPiBk
b2luZyBzb21ldGhpbmcgY2xldmVyIGZvcjoKPiAgICAgICAgICAgICAgICAgZm9yICg7OykKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAqKGNoYXIgKiltYWxsb2MocGFnZV9zaXplKSA9ICdCJzsK
ClByb2JhYmx5LCAgLU8yIGlzIHRoZSBkZWZhdWx0IGluIExUUCBjb21waWxpbmcuCgpPciwgeW91
IGNvdWxkIGFsc28gdHJ5IGRpc2FibGluZyBLU00gd2hlbiB0ZXN0aW5nIG1tYXAyMi5jIHRvIHNl
ZSBpZiBpdCBoZWxwcy4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
