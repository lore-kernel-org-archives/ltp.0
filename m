Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91894EB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 05:24:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 542473CE973
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 07:24:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0ABD63C95DA
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 07:23:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE780100114B
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 07:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689830629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xFvHqkNOMHNyRh2tQr3L5zOo4rPjv7zGlYe7yXfbd5M=;
 b=IsxsopmFobtYt4T9nDBd71nc3+f5kvP4ZwRvc9Fx+4cwOfa+1HkWLHfM/Qr09AtrRrRqU3
 PuocD2CQEEBJLNPx1yvbDhZXQi2LE/kfBwXtSgq0y8OK88J81ZC0Nyc2uIrftmFGl+MC4N
 lw8XR/KIMxCoNJP6wUiZEkUsIfJE+EI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-F_2fp4x4P1ybJzgYrdn73Q-1; Thu, 20 Jul 2023 01:23:47 -0400
X-MC-Unique: F_2fp4x4P1ybJzgYrdn73Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b8405aace3so2910521fa.3
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 22:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689830625; x=1692422625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xFvHqkNOMHNyRh2tQr3L5zOo4rPjv7zGlYe7yXfbd5M=;
 b=IOLWtljzsDQ0yMNLhEXA7RC9wWriiNPbKTue3QHttiy2X64KuWEyppU9oyG/zF7yZE
 lOB5yzcu69xZzc3BOXON+ITfwp1/HcKP61moHmpW51uxTmeBL0mX+vPx6zNAnXB71/J0
 SInj0LsWF4+YLkG33xGyQIQBzSd+tSnlcKp9KMxMDV/PNEuQHJtM4OGskprNhUxRAIcV
 WIZjxtT4fulQnuwzTFhaLpWiQ7lofW/rgkk3VXAkQgVITHLstYRJ7uGvJgdTb+LHDevW
 rV4NlHoDMNf9gw3ehN8/nCfFuB9yOURWwYig2KDVTkLph1juKDom2necvUFG9mpiV5vc
 BExw==
X-Gm-Message-State: ABy/qLZ3VdxrthtJ1WOCci9PGpwszlCj3hNwChPqxixhOSsFMuk5DpED
 B20FRiixIG6y+Irgwdc6SSTZdysVCIjRVt9OXW1b+uPCWUem/Si/dv7tU1mYAroE1BwH/eVW72P
 yncoX5iSsZQuRfbzrcI87OtgUvXDeZDMSnl/VBK4B
X-Received: by 2002:a2e:9e54:0:b0:2b7:31a:9d7c with SMTP id
 g20-20020a2e9e54000000b002b7031a9d7cmr790549ljk.33.1689830624813; 
 Wed, 19 Jul 2023 22:23:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFuTFgrFWa3MVLmhNrU7igTgC6BoLfyj1eBlKsLTZdDVeVYnFvo+t4ayYO3CN083rt6CSN4BBhSfh9l/UNbjC8=
X-Received: by 2002:a2e:9e54:0:b0:2b7:31a:9d7c with SMTP id
 g20-20020a2e9e54000000b002b7031a9d7cmr790537ljk.33.1689830624516; Wed, 19 Jul
 2023 22:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230719110051.1237775-1-pvorel@suse.cz>
 <20230719110051.1237775-2-pvorel@suse.cz>
In-Reply-To: <20230719110051.1237775-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jul 2023 13:23:32 +0800
Message-ID: <CAEemH2fta-HHcB=rCPjxB_7PwQMN_SQ=SrSqag+d=39uC+xtqA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/4] Makefile: Add C header with generated LTP
 version
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

SGkgUGV0ciwKCk9uIFdlZCwgSnVsIDE5LCAyMDIzIGF0IDc6MDHigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEZyb206IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNl
LmN6Pgo+Cj4gSXQgd2lsbCBiZSB1c2VkIGZvciBwcmludGluZyBMVFAgdmVyc2lvbiBpbiBDIEFQ
SS4KPgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiBTaWduZWQt
b2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiBTaWduZWQtb2ZmLWJ5OiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiAgbGliLy5naXRpZ25vcmUgICAgIHwg
IDIgKysKPiAgbGliL01ha2VmaWxlICAgICAgIHwgMTMgKysrKysrKysrKysrKwo+ICBsaWIvZ2Vu
X3ZlcnNpb24uc2ggfCAxNiArKysrKysrKysrKysrKysrCj4gIDMgZmlsZXMgY2hhbmdlZCwgMzEg
aW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgbGliLy5naXRpZ25vcmUKPiAgY3Jl
YXRlIG1vZGUgMTAwNzU1IGxpYi9nZW5fdmVyc2lvbi5zaAo+Cj4gZGlmZiAtLWdpdCBhL2xpYi8u
Z2l0aWdub3JlIGIvbGliLy5naXRpZ25vcmUKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4
IDAwMDAwMDAwMC4uMWJkOTY3ZTJmCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2xpYi8uZ2l0aWdu
b3JlCj4gQEAgLTAsMCArMSwyIEBACj4gKy9sdHAtdmVyc2lvbi5oCj4gKy9jYWNoZWQtdmVyc2lv
bgo+IGRpZmYgLS1naXQgYS9saWIvTWFrZWZpbGUgYi9saWIvTWFrZWZpbGUKPiBpbmRleCA5Yjk5
MDZmMjUuLmFjMWY2MjA0OCAxMDA2NDQKPiAtLS0gYS9saWIvTWFrZWZpbGUKPiArKysgYi9saWIv
TWFrZWZpbGUKPiBAQCAtMjAsNiArMjAsMTkgQEAgcGNfZmlsZSAgICAgICAgICAgICAgICAgICAg
ICA6PQo+ICQoREVTVERJUikvJChkYXRhcm9vdGRpcikvcGtnY29uZmlnL2x0cC5wYwo+Cj4gIElO
U1RBTExfVEFSR0VUUyAgICAgICAgICAgICAgICA6PSAkKHBjX2ZpbGUpCj4KPiArdHN0X3Rlc3Qu
bzogbHRwLXZlcnNpb24uaAo+ICsKPiArbHRwLXZlcnNpb24uaDogZ2VuX3ZlcnNpb24KPiArCj4g
K01BS0VfVEFSR0VUUyArPSBnZW5fdmVyc2lvbgo+ICsKPiArLlBIT05ZOiBnZW5fdmVyc2lvbgo+
ICtnZW5fdmVyc2lvbjoKPiArICAgICAgIEBlY2hvIEdFTiBsdHAtdmVyc2lvbi5oCj4gKyAgICAg
ICBALi9nZW5fdmVyc2lvbi5zaAo+CgpJZiB3ZSBidWlsZCBMVFAgb3V0IG9mIHRoZSBzb3VyY2Ug
dHJlZSwgaXQgZmFpbGVkIHdpdGggbm8Kc3VjaCBmaWxlIGdlbl92ZXJzaW9uLnNoLgoKQnkgYWRk
aW5nIHRoZSBhYnNvbHV0ZSBwYXRoIHRoZW4gd29ya3MuCgotLS0gYS9saWIvTWFrZWZpbGUKKysr
IGIvbGliL01ha2VmaWxlCkBAIC0yOSw3ICsyOSw3IEBAIE1BS0VfVEFSR0VUUyArPSBnZW5fdmVy
c2lvbgogLlBIT05ZOiBnZW5fdmVyc2lvbgogZ2VuX3ZlcnNpb246CiAgICAgICAgQGVjaG8gR0VO
IGx0cC12ZXJzaW9uLmgKLSAgICAgICBALi9nZW5fdmVyc2lvbi5zaAorICAgICAgIEAkKHRvcF9z
cmNkaXIpL2xpYi9nZW5fdmVyc2lvbi5zaAoKIENMRUFOX1RBUkdFVFMgKz0gbHRwLXZlcnNpb24u
aCBjYWNoZWQtdmVyc2lvbgoKCkZvciBwYXRjaCBzZXJpZXM6ClJldmlld2VkLWJ5OiBMaSBXYW5n
IDxsaXdhbmdAcmVkaGF0LmNvbT4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
