Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56582EB64DA
	for <ltp@archiver.kernel.org>; Wed,  5 Jul 2023 13:24:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56DD43CE055
	for <ltp@archiver.kernel.org>; Wed,  5 Jul 2023 15:24:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5B923CBFCA
 for <ltp@lists.linux.it>; Wed,  5 Jul 2023 15:23:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A924B600231
 for <ltp@lists.linux.it>; Wed,  5 Jul 2023 15:23:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688563435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/DdVieXgp321AnP9MC3JuC/fGVLxQna4FNuiXw9KfM=;
 b=NALqxRYD/MXTrL7L3eGRGslxcHXCWJ4wb6uKGPnweUqtD0xg2ROFOrNKnsn2xvhFGoU00i
 +djXxZ+VVMDFOtCkN2vgIFIKqkZPtvaiIGeXimsM1vymAs5mHQk7/XjJPqnoD+XWFl1biL
 Uj6+xHQmky6yGQS+kWTFFj4m+hsBvi0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-dBT30TJDMjycYVwl_ywHMw-1; Wed, 05 Jul 2023 09:23:54 -0400
X-MC-Unique: dBT30TJDMjycYVwl_ywHMw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-564fb1018bcso67396097b3.0
 for <ltp@lists.linux.it>; Wed, 05 Jul 2023 06:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688563433; x=1691155433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/DdVieXgp321AnP9MC3JuC/fGVLxQna4FNuiXw9KfM=;
 b=JFptAsG8cw18y4i0SZtmV+AN1mv9eyCRgfsT7NWHkRDAuRPKcn7B9bPcMinVW1/hd7
 6r/rEgnV0zO8pi8o+dexA86Ggtkq4BljREP7eaQ9krHDb1QIfiowOR28KbSKxzlaUyAb
 Ge6pwyGD00+H7VIOyziBG5JjD+SEqpNJ31/qRFq5TTGiAQDml+OkGpmQPDZ5xfmyipMH
 LsPl+rE5lNBYK2a8mp3+dzODjDB5OenHPH84hMqvKTlxSgzeX9ERas6p6TnXJe8YaTnd
 HF+qgSLLv/rbZkJFArEwepM+lvcYrBVJo3ylXI4pZ8kaJAPA0T2R8GRaU9Zj9Im+YK2g
 j3/A==
X-Gm-Message-State: ABy/qLa4gEPcXZKIVXPoES/+5ZQLPobnXKfWFjZ/Li+hGalFruaiiPfw
 OjboN/znB2K/JqnS6VxdcRProYTiCPmonbbFbd+09twjrf5oUlVoPpClRCNK+4CUJ8MEAPeagS4
 ZvIYaKBj1Jd88nf3bXIUm7ZaLQRtUzog69Ovflw==
X-Received: by 2002:a0d:eac1:0:b0:577:64d4:edc with SMTP id
 t184-20020a0deac1000000b0057764d40edcmr13085769ywe.31.1688563433123; 
 Wed, 05 Jul 2023 06:23:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHF/BoCjSgL+LDdz1rQaxB4i9VxAQ/7cSdjNqarjJgrV93SLWoBsCxmn0nUV+4YeDbu7avfvLurWKpcJdZKX3g=
X-Received: by 2002:a0d:eac1:0:b0:577:64d4:edc with SMTP id
 t184-20020a0deac1000000b0057764d40edcmr13085717ywe.31.1688563432201; Wed, 05
 Jul 2023 06:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230530203707.2965684-1-aahringo@redhat.com>
 <20230530203707.2965684-2-aahringo@redhat.com>
 <20230621090331.GA365741@pevik>
 <CAK-6q+jVapf==Sg_BqWr0KTGA+uKgaaSZQwO=5tWzve9=Dok2Q@mail.gmail.com>
 <20230702191813.GB360317@pevik>
In-Reply-To: <20230702191813.GB360317@pevik>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 5 Jul 2023 09:23:41 -0400
Message-ID: <CAK-6q+hsZxurnnd2snKr12R5UwieCnWhvgr5_OoDKAXorHNhTA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fcntl40: test for owner values on classic
 posix lock
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

SGksCgpPbiBTdW4sIEp1bCAyLCAyMDIzIGF0IDM6MTjigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSBBbGV4LAo+Cj4gLi4uCj4gPiA+ID4gKyAqIFtEZXNjcmlw
dGlvbl0KPiA+ID4gPiArICogVGVzdHMgZ2ZzMiBkbG0gcG9zaXggb3AgcXVldWUgaGFuZGxpbmcg
aW4gdGhlIGtlcm5lbC4KPiA+ID4gPiArICogSXQgaXMgcmVjb21tZW5kZWQgdG8gcnVuIHdhdGNo
IC1uIDAuMSAiZGxtX3Rvb2wgcGxvY2tzICRMUyIKPiA+ID4gPiArICogYXNpZGUgdG8gbW9uaXRv
ciBkbG0gcGxvY2sgaGFuZGxpbmcuCj4gPiA+ID4gKyAqCj4gPiA+ID4gKyAqIFtIb3cgdG8gdXNl
IGl0XQo+ID4gPiA+ICsgKiBDYWxsIGl0IHdpdGggVE1QRElSPS9tbnQgLi9mY250bDQwIHdoZXJl
IFRNUERJUiBpcyBhIGdmczIgbW91bnRwb2ludC4KPiA+ID4gSSB3b25kZXIgaWYgd2UgY291bGQg
Y2hlY2sgZm9yIEdGUzJfTUFHSUMgKHdlJ2QgbmVlZCB0byBhZGQgaXQgdG8KPiA+ID4gaW5jbHVk
ZS90c3RfZnMuaCA9PiAweDAxMTYxOTcwKSBhbmQgcXVpdCB0aGUgdGVzdCB3aXRoIHRzdF9icmso
VENPTkYpIGlmIFRNUERJUgo+ID4gPiBpcyBub3Qgb24gZ2ZzMi4KPgo+ID4gPiBBVE0gd2UgZG9u
J3QgaGF2ZSBhbnkgaGVscGVyIGluIHN0cnVjdCB0c3RfdGVzdCwgd2hpY2ggd291bGQgZG8gaXQu
Cj4KPgo+ID4gSSB3aWxsIG1lbnRpb24gdGhhdCBnZnMyIGlzIG9ubHkgYW4gZXhhbXBsZSBoZXJl
LiBJdCBiZWNvbWVzCj4gPiBpbnRlcmVzdGluZyB3aGVuIGEgZmlsZSBzeXN0ZW0gaW1wbGVtZW50
cyBpdHMgb3duIC5sb2NrKCkgY2FsbGJhY2sgT1IKPiA+IGlmIHNvbWVib2R5IHdhbnRzIHRvIHRl
c3QgZmlsZSBzeXN0ZW0gY29yZSwgd2hlbiBhIGZpbGVzeXN0ZW0gZG9lcyBub3QKPiA+IGltcGxl
bWVudCBpdHMgb3duIC5sb2NrKCkuCj4KPiBJIHNlZSAubG9jayBpcyBpbXBsZW1lbnRlZCBpbiA5
cCwgYWZzLCBjZXBoLCBjaWZzLCBvY2ZzMiwgb3JhbmdlZnMsIGV2ZW4gTkZTLgo+ICJmaWxlIHN5
c3RlbSBjb3JlIjogZG8geW91IG1lYW4gVkZTPyBCZWNhdXNlIHRoYXQgd291bGQgYmUgbW9yZSB1
c2FibGUgdGhhbiB0aGUKPiBmaWxlc3lzdGVtcyBhYm92ZSAod2hpY2ggYXJlIHF1aXRlIGV4b3Rp
YykuCj4KCkl0IGRlcGVuZHMgaGVyZSB3aGF0IHRoZXkgYXJlIGRvaW5nIGluIC5sb2NrKCkgLSBJ
ZiB0aGV5IGp1c3QgY2FsbApsb2Nrc19sb2NrX2ZpbGVfd2FpdCgpIG9yIHNpbWlsYXIgaGVscGVy
cyBkZXBlbmRpbmcgb24gdGhlIGNhbGwsIHRoZW4KdGhleSBkb24ndCBkbyBtdWNoIGRpZmZlcmVu
dCB0aGFuIHdoYXQgdmZzIGlzIGRvaW5nLgpJbiBjYXNlIG9mIGdmczIvb2NmcyBpdCBpcyB2ZXJ5
IHNwZWNpYWwsIGl0IHJlZGlyZWN0cyB0aGVpciBjYWxscyB0bwpETE0gYW5kIERMTSBoYXMgaXRz
IG93biB3aG9sZSBwb3NpeCBpbXBsZW1lbnRhdGlvbiBiZWhpbmQgaXQuIFdlIG9ubHkKY2FsbCBs
b2Nrc19sb2NrX2ZpbGVfd2FpdCgpIHRvIGtlZXAgdGhlIExpbnV4IGJvb2trZWVwaW5nIGluCi9w
cm9jL2xvY2tzLgoKV2hhdCBJIGFtIGRvaW5nIGhlcmUgaXMgbW9zdGx5IHRydXN0aW5nIHRoZSBM
aW51eCBpbXBsZW1lbnRhdGlvbiBhbmQKY29tcGFyaW5nIHJlc3VsdHMgZnJvbSBlLmcuIHRtcGZz
IHdpdGggR0ZTMiBhbmQgSSBmb3VuZCBpc3N1ZXMuCgpGb3Igbm93IEkgdHJ1c3QgdGhlIExpbnV4
IGltcGxlbWVudGF0aW9uIGFuZCBjaGVjayBpZiB3ZSBoYXZlIGEKZGlmZmVyZW50IHJlc3VsdCBo
ZXJlLiBJIG5lZWQgdG8gYmUgdmVyeSBjYXJlZnVsIGhlcmUgYmVjYXVzZQpHRlMyL09DRlMyIGFy
ZSBjbHVzdGVyIGZpbGVzeXN0ZW1zIGFuZCB0aGUgZmNudGwoKSBpbnRlcmZhY2Ugd2FzIG5ldmVy
Cm1hZGUgZm9yIGNsdXN0ZXIgZmlsZXN5c3RlbXMuIEhvd2V2ZXIgSSBjdXJyZW50bHkgb25seSB0
ZXN0ICJvbmUgbm9kZSIKbG9ja2luZyBhbmQgdGhpcyBzaG91bGQgZGVsaXZlciB0aGUgc2FtZSBy
ZXN1bHRzIGFzIHRtcGZzLCBldGMuCgotIEFsZXgKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
