Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91876EB64D7
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 09:23:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C588A3CBBFF
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 11:23:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 106883CBAF3
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 11:23:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E38F71A009AE
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 11:23:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686907400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=af356s1A1fML+hjsfl/hF7DN/WwK9wtt5gV+n+/qp/Y=;
 b=hPKrTCdsnmTdHqCkS8QU8jc3xmDucAw+NTo0nlP57loe+XXYQhP/AxMWw93r6Rx8Z5AV+s
 RSSHlT3WF1Dk7E1tGJjTJQ0aTJBM0VDIBYA01R53NVpHuAgjDLY5iOwIHqa4qt0wwh7oq0
 yWG57rFzSpNz+iqHwPeKCkav574AARc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-KSJtw3ojO3qhx743_he9ww-1; Fri, 16 Jun 2023 05:23:17 -0400
X-MC-Unique: KSJtw3ojO3qhx743_he9ww-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b1bbe83720so3576441fa.0
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 02:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686907395; x=1689499395;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=af356s1A1fML+hjsfl/hF7DN/WwK9wtt5gV+n+/qp/Y=;
 b=fqGELb3jcwtA2xT03d6F1Q+ACpHwTfXcEfHrL79cUnll8nfWDlhs7+LQwfuupCATCu
 Mfs6NblweTmYLw21LkK6/DOTLPrTxSqqo61WrC5tYUuf6QOwT5i9IVsEBpry4b6PkiJV
 5307KD0+fqh3pIfi7n1ioYsZetF8ifdRTZN+i277mkHN6Cc7ssFw6YDnwf+/kEmlnBQK
 rTXyC3XbcAVF6CHKgyYcGWBJ5w9Kni6SPPpICopeaOWdLWPZ017ZZTwJRQTajJS0dmXj
 oIniJeXx+8RY62+7gv63Mvp/ia86oPvA9WXok/fvF1k4QCT8ZKxhWBVi3HnYhQnCuQoo
 a5eQ==
X-Gm-Message-State: AC+VfDz7GC9LdZBeklib49VGbUEQKF6IyqTBF1ifp3OGFi2httXb4jVT
 7j4q8IxS2ay97pXoM1qGaKK683zmYm9NnmenKwH24il5HenkCzhcHFUuQp1kJd9IyvmD3Bwwzac
 4EabcSf8+YBkmpnNx+rvOl93W3HQ=
X-Received: by 2002:a2e:9297:0:b0:2b3:451c:5998 with SMTP id
 d23-20020a2e9297000000b002b3451c5998mr1304198ljh.18.1686907395807; 
 Fri, 16 Jun 2023 02:23:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DVFsSpWcaVkzSQQCaMJ/THtrKPRupX2Wn+Xs8OFoD45/0lR6DOlsDEcirqopLTF+MOfIXLrc4w+6GXRr2uU8=
X-Received: by 2002:a2e:9297:0:b0:2b3:451c:5998 with SMTP id
 d23-20020a2e9297000000b002b3451c5998mr1304179ljh.18.1686907395439; Fri, 16
 Jun 2023 02:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230615012445.4184243-1-jencce.kernel@gmail.com>
 <CAEemH2f2Rrco5fSMsmezY5sUJtM2vZpm619d5+v6Kjyhwcm1CQ@mail.gmail.com>
 <2ee08acc-2b36-99ca-b891-0928a92ed4df@suse.cz>
In-Reply-To: <2ee08acc-2b36-99ca-b891-0928a92ed4df@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Jun 2023 17:23:03 +0800
Message-ID: <CAEemH2fy7gOBTB+idU051oQ1xR6vG=JH-L3a+wscXAJdMiZcTQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] safe_mount: safe_umount: print debug info
 about the operation
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

T24gRnJpLCBKdW4gMTYsIDIwMjMgYXQgNDozOOKAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cgo+IE9uIDE2LiAwNi4gMjMgNDo1MCwgTGkgV2FuZyB3cm90ZToKPiA+
IE9uIFRodSwgSnVuIDE1LCAyMDIzIGF0IDk6MjTigK9BTSBNdXJwaHkgWmhvdSA8amVuY2NlLmtl
cm5lbEBnbWFpbC5jb20+Cj4gd3JvdGU6Cj4gPgo+ID4+IE1ha2UgdGhlIHNvdXJjZSBhbmQgdGhl
IHRhcmdldCB0byBtb3VudC91bW91bnQgdmlzaWJsZS4gSXQncwo+ID4+IGdvb2QgZm9yIGRlYnVn
Z2luZy4KPiA+Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IE11cnBoeSBaaG91IDxqZW5jY2Uua2VybmVs
QGdtYWlsLmNvbT4KPiA+PiAtLS0KPiA+PiB2MzoKPiA+PiAgICBBcHBseSBzdWdnZXN0aW9ucyBm
cm9tIExpIGFuZCBNYXJ0aW4uIFRoYW5rcyB2ZXJ5IG11Y2ghCj4gPj4KPiA+PiAgIGxpYi9zYWZl
X21hY3Jvcy5jIHwgMTcgKysrKysrKysrKysrKysrKysKPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAx
NyBpbnNlcnRpb25zKCspCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvbGliL3NhZmVfbWFjcm9zLmMg
Yi9saWIvc2FmZV9tYWNyb3MuYwo+ID4+IGluZGV4IGFmNmRkMDcxNi4uMjZmOTEzNmFmIDEwMDY0
NAo+ID4+IC0tLSBhL2xpYi9zYWZlX21hY3Jvcy5jCj4gPj4gKysrIGIvbGliL3NhZmVfbWFjcm9z
LmMKPiA+PiBAQCAtODk4LDcgKzg5OCwxNiBAQCBpbnQgc2FmZV9tb3VudChjb25zdCBjaGFyICpm
aWxlLCBjb25zdCBpbnQgbGluZW5vLAo+ID4+IHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwKPiA+
PiAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqZGF0YSkKPiA+PiAgIHsKPiA+PiAgICAgICAg
ICBpbnQgcnZhbCA9IC0xOwo+ID4+ICsgICAgICAgY2hhciBtcGF0aFtQQVRIX01BWF07Cj4gPj4K
PiA+PiArICAgICAgIGlmIChyZWFscGF0aCh0YXJnZXQsIG1wYXRoKSkgewo+ID4+ICsgICAgICAg
ICAgICAgICB0c3RfcmVzbV8oZmlsZSwgbGluZW5vLCBUSU5GTywKPiA+PiArICAgICAgICAgICAg
ICAgICAgICAgICAiTW91bnRpbmcgJXMgdG8gJXMgZnN0eXA9JXMgZmxhZ3M9JWx4IiwKPiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBzb3VyY2UsIG1wYXRoLCBmaWxlc3lzdGVtdHlwZSwgbW91
bnRmbGFncyk7Cj4gPj4gKyAgICAgICB9IGVsc2Ugewo+ID4+ICsgICAgICAgICAgICAgICB0c3Rf
cmVzbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywgY2xlYW51cF9mbiwKPiA+Pgo+ID4K
PiA+IEZvcmdldCB0byBtZW50aW9uIHRoYXQsIHRoaXMgc2hvdWxkIGJlIHRzdF9icmttXyguLiwg
VEJST0sgfCBURVJSTk8sCj4gLi4uKSwKPiA+IEkgbWFudWFsbHkgZml4IGl0IGFuZCBwdXNoZWQu
Cj4KPiBJIHRob3VnaHQgbXkgcmV2aWV3IG9mIHRoZSB2MiBwYXRjaCB3YXMgY2xlYXIgZW5vdWdo
IHRoYXQgYm90aCBicmFuY2hlcwo+IG9mIHRoaXMgY29uZGl0aW9uIHNob3VsZCBjYWxsIHRzdF9y
ZXNtXyguLi4gVElORk8gLi4uKS4gVGhlcmUgaXMgbm8KPiByZWFzb24gdG8gZmFpbCB0aGUgdGVz
dCBoZXJlLgo+CgpBaCwgc29ycnkgZm9yIG92ZXJsb29raW5nIHRoYXQuIEkgc2F3IGhlcmUgdGhh
dCB1c2VkIHRzdF9yZXNtXyggLi4uVEJSSyAuLi4pCndoaWNoIGlzIG5vdCB0aGUgY29ycmVjdCB1
c2FnZS4gU28gSSBndWVzcyBoZSBtaWdodCB3YW50IHRzdF9icmttXygpLApidXQgYW55d2F5IHlv
dSBhcmUgcmlnaHQuIExldCdzIGZpeCBpdCBpbiBhIHNlcGFyYXRlIHBhdGNoLgoKCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
