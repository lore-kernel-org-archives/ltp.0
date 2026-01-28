Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EA8D35664
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769565589; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LkNooTh/RpWqPoAS7ASozXrn9LPctiyqMXy0wacY4XI=;
 b=oPx+4O3UNR6XWG9dLCt5My0ri1VQ5uY+dOXT9dWVAb4mkNlV7T9K3Hcxsk3bbYRJYVAdx
 BbJkld9w6Dterps/vvDoNvTxpQ1LovtoGosLpXe4Fwmqg+Yh0jxRrzJt3KhjBiC01rZ9Nm1
 Irt4qrdpbblFwJmy5juHbACqpVlQXt8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E42B3CA4D2
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 02:59:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB96D3C98AB
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 02:59:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 641C5200250
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 02:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769565560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=daPc1LRlHUbtIkDgv6BnOl2XuCb601ZyJdX0xHxljk0=;
 b=U+5dabiikHwaaIRdjvFolJATNXUx4hRtvfMR3EeuPzQK6ytiSadyNuDOGldWzha/pKRGYE
 QU5P4nb2fp+AG2YU0SNT0UpXM3uT2GrlXzfn9z1avDCIQrMI4rVqWcv0qimSzNcIn6SLa6
 7dsat2UpuqoxbaC1QYo+ztHFf7eisjk=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-AOvP6-n2O2G09BmeNgNaTA-1; Tue, 27 Jan 2026 20:59:18 -0500
X-MC-Unique: AOvP6-n2O2G09BmeNgNaTA-1
X-Mimecast-MFC-AGG-ID: AOvP6-n2O2G09BmeNgNaTA_1769565558
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b7155ca88cso6212983eec.1
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 17:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769565558; x=1770170358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=daPc1LRlHUbtIkDgv6BnOl2XuCb601ZyJdX0xHxljk0=;
 b=WD+hlo6mTAO2DPCCqLPVRInGkxKds3iHj9sOVK5uGITqApjpyXX+qYa90IEd5n9/uO
 sFmNTZuuYkNDQO7Cqz6JRNKX7lVkUWkkDA5GyDCQrJnCIfOHiGPSTgPl1IMSoN/FSscL
 f6+9AGuf1uUZQ82EWY+fajNPWn0F+FYzgUP/Q47SWUKCY4zLN/lRtTanPt2iFf/2qKYd
 98nhTrlL1sXsBwfRR5xsjj/AJxw/DAyJ+T1LCxu40EtbcYRR28ywvsHTSoQPTT8BXbNj
 30BWsdZfv+wDU3nNb4Snpe4+WRrkUfQPqxmX4cO/bco3XrRfuJykOUMZd3VQazfQMhh7
 e2SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgP6dNOpJZtoaNHqhu4580K6PUqfCRmRDvlLEhN3k86tnkEuw9M/ZY85JtO12R33wNhXI=@lists.linux.it
X-Gm-Message-State: AOJu0YzUDFk/BWwMj2xDWZuFlRUsvndXtMrnB0KiRzMvQ3WuaDzv7+4v
 L/kiGMKS2zaMgnQYWcVEUHcNFZYj281CMATl6KxmgXS8O+NjEo4WBh4HFZ6Msl7kdDRVEZhJuA/
 b410oMtDsvbKqdiQO+brCzjb+vU2wfnZI+7jQjvAIIDwGjR9ILw93ddBGCqovHHTNwFGFvNVShI
 PeepXpwinbin1X2CpwoAN8/Sv08jQ=
X-Gm-Gg: AZuq6aLLRTgIsa84QgnBWQFah2zNo7JHVIxA0KNS0r8bnG/a/MpHI1tqoCeDqvjbMtq
 P6rfz6DUoaz2nJP9dJYiDIGBpqS+Xy1hM0gA4UPMJGWSLZh1iplL87hT6/Z3Zynm8hsvshvEGY1
 X+H4zwW1rItCM13P+og0Y6CGHd5xxp2rox7zHShfrGVi0fR2VUctVMO2Pk3OQSKNmMcLw=
X-Received: by 2002:a05:7300:5714:b0:2b0:4c33:8e41 with SMTP id
 5a478bee46e88-2b78d98e096mr2289769eec.20.1769565557652; 
 Tue, 27 Jan 2026 17:59:17 -0800 (PST)
X-Received: by 2002:a05:7300:5714:b0:2b0:4c33:8e41 with SMTP id
 5a478bee46e88-2b78d98e096mr2289760eec.20.1769565557256; Tue, 27 Jan 2026
 17:59:17 -0800 (PST)
MIME-Version: 1.0
References: <aWjZX0fsrTJMqq49@yuki.lan> <aXi4P0YdKx5rFZ8C@yuki.lan>
 <20260127132514.GB146899@pevik>
In-Reply-To: <20260127132514.GB146899@pevik>
Date: Wed, 28 Jan 2026 09:59:04 +0800
X-Gm-Features: AZwV_QiUoLUGWP-0cPafcj35DZX8BKoWFc7x1sYfWejKgYT3uhXNEC8d0s5bk8E
Message-ID: <CAEemH2cK2BFnJJ-6M+=RBKDYcHuH-_TxKDAabYj5KcmOkgHQ6g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FBwiLBXBq3cedvb18nz_WFEs0Eh2TEriwJXOwBpFvA4_1769565558
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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

UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiAqIGlvY3RsX3BpZGZkMDItMDY6
IEFkZCBDT05GSUdfVVNFUl9OUyBhbmQgQ09ORklHX1BJRF9OUyB0byBuZWVkc19rY29uZmlncwo+
IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAyNTEyMDky
MTE2MjkuOTU0MzYtMS10ZXJyeS50cml0dG9uQGxpbmFyby5vcmcvCj4gKE9yIEkgY2FuIHByZXBh
cmUgYW4gYWx0ZXJuYXRpdmUgZml4IHRvIGRvIGEgcnVudGltZSBjaGVjaywgSSBhbHNvIHBsYW4g
dG8gc2VuZAo+IGEgcGF0Y2ggd2l0aCBmb3JtYWxpc2luZyB0aGUgcnVsZXMpCgpUaGUgb3JpZ2lu
YWwgcGF0Y2ggc2hvdWxkIGJlIHNhZmUgdG8gYmUgbWVyZ2VkLgoKQmVjYXVzZSB3ZSBjYW4gZGlz
YWJsZSBvciBsaW1pdCB0aGUgY3JlYXRpb24gb2YgbmV3IG5hbWVzcGFjZXMgb25seQpieSB0dXJu
aW5nIG9mZiB0aGUgS2NvbmZpZyBvcHRpb25zOgoKICAtIENPTkZJR19VU0VSX05TCiAgLSBDT05G
SUdfUElEX05TCgpJZiB0aG9zZSBvcHRpb25zIGFyZSB1bnNldCwgdGhlIG5hbWVzcGFjZSB0eXBl
IHNpbXBseSBkb2VzbuKAmXQgZXhpc3QKKG5vIC9wcm9jL3NlbGYvbnMvdXNlcikuCgpJZiB0aGV5
4oCZcmUgc2V0LCB0aGVyZSBpc27igJl0IGEgcnVudGltZSBrbm9iIChzeXNjdGwsIHByb2MsIG9y
IHN5c2ZzKSB0aGF0IGNhbgpkaXNhYmxlcyB0aGVtIGluIGdlbmVyYWwtcHVycG9zZSBrZXJuZWxz
LgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
