Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C530AE77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 06:36:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 348833E2D20
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 07:36:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94A713E2D16
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 07:36:19 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D104F633F84
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 07:36:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733726177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uewnERKu4qxiyhFycB4RanZFPIAHwlt/EjZhckdDT1g=;
 b=Y77alyv14rVzU2wkvBEnhoOe3JQrxOVhqf9rc/0oXP50LTxfeinqkeh0aTwdSy+anF5fwC
 E2JCyZ7lLzYApj/JH1NEbMdCrTg6dEefQmSrzVUU2/zcPTlPN9YWQe0LgR5XAGJvDTJ/8T
 D+ssQg90QmwAFuRCzyRNgnlcoLOazoQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-dFtAwg8cPCKRku08p0MWnA-1; Mon, 09 Dec 2024 01:36:14 -0500
X-MC-Unique: dFtAwg8cPCKRku08p0MWnA-1
X-Mimecast-MFC-AGG-ID: dFtAwg8cPCKRku08p0MWnA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef775ec883so1848492a91.1
 for <ltp@lists.linux.it>; Sun, 08 Dec 2024 22:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733726174; x=1734330974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uewnERKu4qxiyhFycB4RanZFPIAHwlt/EjZhckdDT1g=;
 b=rxzL0c8hRbHmZy+POue2xzs+QFeSRQiP3RL4jM0DgX17GZtGM/eYzyT1Pqobfy8wqI
 1wptTUmp+S61EtF7OYacWAy8nWSiJPnT9UcGhS4FPLWXhP35Y/crgKbmJWvEJb2yyOwo
 UjCwonIsmIrVmALJRM63FZqow2MMUk2XNCdZxhN4ejdYSOaaFcF3ZX5pfRjgM50B4RNY
 5hOV49VbS9N3Jjj/R1UeXeppkzNie7am7uNpxbjH4qPANC+F9+ReJuYNH7iT8QP/xENP
 QxApKMjQ5qrhogUoB4ZUM27csupPBKIwOJ6ukokJDGO9UbdEV63GZcdLJi1JY6+5elXG
 P8QA==
X-Gm-Message-State: AOJu0YyYJv1eid5Xkd2Ix6S+WUJcnaX67DNgqE/QDPM4FY661WlTWqSq
 /kinBfscs+NHpicLJMTffzfY8Xb5zkzNmHm82035nA1wSE4A5RjnhpBnLjPZreDmIn5B9JcXDDE
 GT80MbFJdZP69ZLcFCGDzyYXjv0A+2SxkGRzFsJjjqn0DPamKJ1KIp2xlVO2DDW0uX1zeHpmE19
 UtaeYGWtM/9iNzMfOjxRVONEo=
X-Gm-Gg: ASbGncuIj8g0lDSUi0W3lNpjFVPQGmhXTPfgQ3xuw2+YBB+DgMsnhbZvXDMuneGZl56
 kjsHlFa9NBHtSIKFdHcnV7uU1hwuRmakX
X-Received: by 2002:a17:90b:3944:b0:2ee:f80c:688d with SMTP id
 98e67ed59e1d1-2ef6ab093demr17308729a91.25.1733726173735; 
 Sun, 08 Dec 2024 22:36:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRWU/egSk0qDNx3qeWbrfXuBqtPlcOxpdnUdLlc08x6ufqzi1tBYmVQzgEgVm/A7iseRP6TvmMWQH0PPZZrAg=
X-Received: by 2002:a17:90b:3944:b0:2ee:f80c:688d with SMTP id
 98e67ed59e1d1-2ef6ab093demr17308717a91.25.1733726173419; Sun, 08 Dec 2024
 22:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20241207085754.159597-1-liwang@redhat.com>
 <20241209044318.GA180329@pevik>
In-Reply-To: <20241209044318.GA180329@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Dec 2024 14:36:00 +0800
Message-ID: <CAEemH2fSJP8Y8-CLbtKFq+PUcmP_3=aF8Wszom-bDfP6=HOCjg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ktudqpsdbQS-7k9CJc6wSQkym7oxYpsLGOFX6Q1wj_U_1733726174
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [Patch V2] lib: multiply the max_runtime if detect kernel
 debug options
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

SGkgUGV0ciwKCk9uIE1vbiwgRGVjIDksIDIwMjQgYXQgMTI6NDPigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLCBDeXJpbCwKPgo+ID4gVGhlIG1ldGhvZCBh
ZGp1c3RzIHRoZSBtYXhfcnVudGltZSBmb3IgdGVzdCBjYXNlcyBieSBtdWx0aXBseWluZwo+ID4g
aXQgYnkgYSBmYWN0b3IgKDR4KSBpZiBhbnkgZGVidWcga2VybmVsIG9wdGlvbnMgYXJlIGRldGVj
dGVkLgo+ID4gRGVidWcga2VybmVsIGNvbmZpZ3VyYXRpb25zIChzdWNoIGFzIENPTkZJR19LQVNB
TiwgQ09ORklHX1BST1ZFX0xPQ0tJTkcsCj4gZXRjLikKPiA+IGFyZSBrbm93biB0byBkZWdyYWRl
IHBlcmZvcm1hbmNlLCBhbmQgdGhpcyBhZGp1c3RtZW50IGVuc3VyZXMKPiA+IHRoYXQgdGVzdHMg
ZG8gbm90IGZhaWwgcHJlbWF0dXJlbHkgZHVlIHRvIHRpbWVvdXRzLgo+Cj4gPiBBcyBDeXJpbCBw
b2ludGVkIG91dCB0aGF0IGEgZGVidWcga2VybmVsIHdpbGwgdHlwaWNhbGx5IHJ1bgo+ID4gc2xv
d2VyIGJ5IGEgZmFjdG9yIG9mIE4sIGFuZCB3aGlsZSBkZXRlcm1pbmluZyB0aGUgZXhhY3QgdmFs
dWUKPiA+IG9mIE4gaXMgY2hhbGxlbmdpbmcsIHNvIGEgcmVhc29uYWJsZSB1cHBlciBib3VuZCBp
cyBzdWZmaWNpZW50Cj4gPiBmb3IgcHJhY3RpY2FsIHB1cnBvc2VzLgo+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+IC0tLQo+Cj4gPiBOb3RlczoKPiA+
ICAgICBIaSwgQEN5cmlsLCBAUGV0ciwgSSBoYXZlIG5vIG9wZW5TVVNFIGFuZCBVYnVudHUgYXQg
bXkgaGFuZHMsIGNvdWxkCj4geW91Cj4gPiAgICAgaGVscCBjaGVjayBpZiB0aGUgZGVidWcgY29u
ZmlndXJlcyBhcmUgdXNlZnVsIHRvIHRoZSBvdGhlciB0d28KPiBwbGF0Zm9ybXM/Cj4gPiAgICAg
T3IsIHNob3VsZCB3ZSBhZGQgYW55IG1vcmUgb3B0aW9ucyB0aGVyZT8gVGhhbmtzLgo+Cj4gb3Bl
blNVU0UgZGVidWcga2VybmVsOgo+Cj4gJCBncmVwIF5DT05GSUdfREVCVUcgL2Jvb3QvY29uZmln
LTYuMTMuMC1yYzEtMS5nNDkyZjk0NC1kZWJ1ZyAjIG9wZW5TVVNFCj4gVHVtYmxld2VlZAo+IENP
TkZJR19ERUJVR19SU0VRPXkKPiBDT05GSUdfREVCVUdfR1BJTz15Cj4gQ09ORklHX0RFQlVHX0JV
R1ZFUkJPU0U9eQo+IENPTkZJR19ERUJVR19LRVJORUw9eQo+IENPTkZJR19ERUJVR19NSVNDPXkK
PiBDT05GSUdfREVCVUdfSU5GTz15Cj4gQ09ORklHX0RFQlVHX0lORk9fRFdBUkY1PXkKPiBDT05G
SUdfREVCVUdfSU5GT19DT01QUkVTU0VEX05PTkU9eQo+IENPTkZJR19ERUJVR19JTkZPX0JURj15
Cj4gQ09ORklHX0RFQlVHX0lORk9fQlRGX01PRFVMRVM9eQo+IENPTkZJR19ERUJVR19GT1JDRV9X
RUFLX1BFUl9DUFU9eQo+IENPTkZJR19ERUJVR19GUz15Cj4gQ09ORklHX0RFQlVHX0ZTX0FMTE9X
X0FMTD15Cj4gQ09ORklHX0RFQlVHX05FVD15Cj4gQ09ORklHX0RFQlVHX1BBR0VBTExPQz15Cj4g
Q09ORklHX0RFQlVHX1JPREFUQV9URVNUPXkKPiBDT05GSUdfREVCVUdfTUVNT1JZX0lOSVQ9eQo+
IENPTkZJR19ERUJVR19TSElSUT15Cj4gQ09ORklHX0RFQlVHX1JUX01VVEVYRVM9eQo+IENPTkZJ
R19ERUJVR19TUElOTE9DSz15Cj4gQ09ORklHX0RFQlVHX01VVEVYRVM9eQo+Cj4gPT4gb3BlblNV
U0UgZGVidWcga2VybmVsIHdvdWxkIGJlIGRldGVjdGVkIGJ5Ogo+IENPTkZJR19ERUJVR19ORVQ9
eQo+IENPTkZJR19ERUJVR19QQUdFQUxMT0M9eQo+IENPTkZJR19ERUJVR19SVF9NVVRFWEVTPXkK
PiBDT05GSUdfREVCVUdfU1BJTkxPQ0s9eQo+IENPTkZJR19ERUJVR19NVVRFWEVTPXkKPgo+ClRo
YW5rcyBmb3IgbXVjaCBmb3IgcHJvdmlkaW5nIHRoZXNlLgoKCj0+IGlmIHlvdSB3YW50IHRvIGFk
ZCBtb3JlOgo+IENPTkZJR19ERUJVR19SU0VRPXkKPiBDT05GSUdfREVCVUdfR1BJTz15Cj4gQ09O
RklHX0RFQlVHX1JPREFUQV9URVNUPXkKPiBDT05GSUdfREVCVUdfU0hJUlE9eQo+CgpUaG9zZSBr
ZXJuZWwgZGVidWcgb3B0aW9ucyBvbiBwZXJmb3JtYW5jZSBhcmUgZ2VuZXJhbGx5IGxlc3Mgc2V2
ZXJlCmNvbXBhcmVkIHRvIG9wdGlvbnMgbGlrZSBDT05GSUdfS0FTQU4gb3IgQ09ORklHX1BST1ZF
X0xPQ0tJTkcuCgpXZSB3b3VsZCBsaWtlIHRvIHJlY29nbml6ZSBzb21lIGNvbmZpZ3MgdGhhdCBv
YnZpb3VzbHkgbG93ZXIgdGhlIHN5c3RlbQpzcGVlZC4KCgoKPgo+IEFsc28gRllJIHNvbWUgb3B0
aW9ucyBmcm9tIGRlZmF1bHQga2VybmVsICh0byBzZWUgd2hpY2ggY2Fubm90IGJlIHVzZWQpOgo+
Cj4gJCBncmVwIF5DT05GSUdfREVCVUcgL2Jvb3QvY29uZmlnLTYuMTMuMC1yYzEtMS5nNDkyZjk0
NC1kZWZhdWx0ICMgb3BlblNVU0UKPiBUdW1ibGV3ZWVkCj4gQ09ORklHX0RFQlVHX0JVR1ZFUkJP
U0U9eQo+IENPTkZJR19ERUJVR19LRVJORUw9eQo+IENPTkZJR19ERUJVR19NSVNDPXkKPiBDT05G
SUdfREVCVUdfSU5GTz15Cj4gQ09ORklHX0RFQlVHX0lORk9fRFdBUkY1PXkKPiBDT05GSUdfREVC
VUdfSU5GT19DT01QUkVTU0VEX05PTkU9eQo+IENPTkZJR19ERUJVR19JTkZPX0JURj15Cj4gQ09O
RklHX0RFQlVHX0lORk9fQlRGX01PRFVMRVM9eQo+IENPTkZJR19ERUJVR19GT1JDRV9XRUFLX1BF
Ul9DUFU9eQo+IENPTkZJR19ERUJVR19GUz15Cj4gQ09ORklHX0RFQlVHX0ZTX0FMTE9XX0FMTD15
Cj4gQ09ORklHX0RFQlVHX1BBR0VBTExPQz15Cj4gQ09ORklHX0RFQlVHX01FTU9SWV9JTklUPXkK
Pgo+ICQgZ3JlcCBeQ09ORklHX0RFQlVHIC9ib290L2NvbmZpZy02LjExLjEwLWFtZDY0ICMgRGVi
aWFuCj4gQ09ORklHX0RFQlVHX0JVR1ZFUkJPU0U9eQo+IENPTkZJR19ERUJVR19LRVJORUw9eQo+
IENPTkZJR19ERUJVR19NSVNDPXkKPiBDT05GSUdfREVCVUdfSU5GTz15Cj4gQ09ORklHX0RFQlVH
X0lORk9fRFdBUkZfVE9PTENIQUlOX0RFRkFVTFQ9eQo+IENPTkZJR19ERUJVR19JTkZPX0NPTVBS
RVNTRURfTk9ORT15Cj4gQ09ORklHX0RFQlVHX0lORk9fQlRGPXkKPiBDT05GSUdfREVCVUdfSU5G
T19CVEZfTU9EVUxFUz15Cj4gQ09ORklHX0RFQlVHX0ZTPXkKPiBDT05GSUdfREVCVUdfRlNfQUxM
T1dfQUxMPXkKPiBDT05GSUdfREVCVUdfV1g9eQo+IENPTkZJR19ERUJVR19NRU1PUllfSU5JVD15
Cj4gQ09ORklHX0RFQlVHX0xJU1Q9eQo+Cj4gRG8gRGViaWFuL1VidW50dSBldmVuIGhhdmUgZGVi
dWcga2VybmVsPyBJIGtub3cgb25seSBhYm91dAo+IGxpbnV4LWltYWdlLWFtZDY0LWRiZwo+IFsx
XSwgYnV0IHRoYXQgcGFja2FnZSBoYXMganVzdCBkZWJ1Z2dpbmcgc3ltYm9scy4KPgoKTWF5YmUg
d2Ugc2hvdWxkbid0IGRlY2xhcmUgdGhhdCB0aGUgcHVycG9zZSBpcyB0byBkZWJ1ZyBrZXJuZWws
CmFueSBrZXJuZWwgYnVpbGQgd2l0aCB0aGUgc2xvd2VyIGNvbmZpZ3Mgc2hvdWxkIGltcGFjdGVk
LgoKCgo+Cj4gV2hpY2ggdGVzdHMgc2hvdWxkIEkgcnVuIG9uIHRoZSBrZXJuZWwgdG8gc2VlIGlm
IHRpbWVvdXQgaXMgb2s/Cj4KCkFueSB0ZXN0IHdpdGggc2V0IC5tYXhfcnVudGltZSB5b3UgY2Fu
IHRyeSwgZm9yIHRoaXMgcGF0Y2ggb3VyIG9yaWdpbmFsCndvcmsgaXMgZm9yIHN0YXJ2YXRpb24u
YyBidXQgbm93IGl0IGlzIGdlbmVyaWMuCgoKCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4g
WzFdIGh0dHBzOi8vcGFja2FnZXMuZGViaWFuLm9yZy9zaWQvbGludXgtaW1hZ2UtYW1kNjQtZGJn
Cj4KPiAuLi4KPiA+ICsvKgo+ID4gKyAqIExpc3Qgb2YgZGVidWcta2VybmVsIGNvbmZpZyBvcHRp
b25zIHRoYXQgbWF5IGRlZ3JhZGUgcGVyZm9ybWFuY2UKPiB3aGVuIGVuYWJsZWQuCj4gPiArICov
Cj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCB0c3Rfa2NvbmZfZGVidWdfb3B0aW9uc1td
WzJdID0gewo+ID4gKyAgICAgeyJDT05GSUdfUFJPVkVfTE9DS0lORz15IiwgTlVMTH0sCj4gPiAr
ICAgICB7IkNPTkZJR19MT0NLREVQPXkiLCBOVUxMfSwKPiA+ICsgICAgIHsiQ09ORklHX0RFQlVH
X1NQSU5MT0NLPXkiLCBOVUxMfSwKPiA+ICsgICAgIHsiQ09ORklHX0RFQlVHX1JUX01VVEVYRVM9
eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfREVCVUdfTVVURVhFUz15IiwgTlVMTH0sCj4g
PiArICAgICB7IkNPTkZJR19ERUJVR19QQUdFQUxMT0M9eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJD
T05GSUdfS0FTQU49eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfU0xVQl9SQ1VfREVCVUc9
eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfVFJBQ0VfSVJRRkxBR1M9eSIsIE5VTEx9LAo+
ID4gKyAgICAgeyJDT05GSUdfTEFURU5DWVRPUD15IiwgTlVMTH0sCj4gPiArICAgICB7IkNPTkZJ
R19ERUJVR19ORVQ9eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfRVhUNF9ERUJVRz15Iiwg
TlVMTH0sCj4gPiArICAgICB7IkNPTkZJR19RVU9UQV9ERUJVRz15IiwgTlVMTH0sCj4gPiArICAg
ICB7IkNPTkZJR19GQVVMVF9JTkpFQ1RJT049eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdf
REVCVUdfT0JKRUNUUz15IiwgTlVMTH0sCj4gPiArICAgICB7TlVMTCwgTlVMTH0KPiAuLi4KPgo+
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
