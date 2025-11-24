Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A331DCFA466
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763990486; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pRTRvZ/rWsVDJz4645/76Ei3C+qJLQ9vGpGdc8KssjQ=;
 b=mSSG9p/iiFga0puSTfPl/Iyac+zlhZvW3AuGIXYMFSHqBRn3fYjO1lhu/+3ZDjzZWKiUg
 HED6rD7jIDGTUSUuYH6b/K0TlTOYVk/mAsSPwiPu9K8KezMkDbAlDSQYYhavoFXVrbZnAH+
 DghD4Lg4qkfk9qXMOyjXsObI2INmqhI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3185A3C890B
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 14:21:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DB463C0125
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 14:21:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 94EEE600799
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 14:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763990463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CHdQ9ix+cnbBQC/SJJBfcdMdqhW2tQSnH5wdUnKOyas=;
 b=Lr2ht9ExgvM6DQgsBTE9A5MFhbf4WUL47vIqK4pgYSWmkK5pfMc7dHaYDGnt4HQ0U5fTQY
 4dhBeJ0HS1LJVpAS9B1TAnUkWe3DLXd20bjPeWjocEgMR6lz4Hy62cKa9aT8Y5tf1QQ7F4
 FrcLNXxTzFIK/ZZ69soRA1J78aOJZiM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-9UJi7JDSNNKMHdu15LQSdQ-1; Mon, 24 Nov 2025 08:21:01 -0500
X-MC-Unique: 9UJi7JDSNNKMHdu15LQSdQ-1
X-Mimecast-MFC-AGG-ID: 9UJi7JDSNNKMHdu15LQSdQ_1763990461
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b9ceccbd7e8so1393388a12.0
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 05:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763990461; x=1764595261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHdQ9ix+cnbBQC/SJJBfcdMdqhW2tQSnH5wdUnKOyas=;
 b=ROKwh1ytedHrQwmRK8+zKsyFeFhHtnyOd6LynLTx2jVXj7MK9NK4IN5bXi5jd1ndo0
 mjLp4PBazJTl8FrC5ZD8Mxkqq7EdushxnUG34jPmVpQQ4vGRQcfURKO6lCyGUsjiNZdf
 EqFxpIOFLrX8Ut+AIAhMpOHoqk5WXQ4o8J6bfR4oUcYb3MspawIkZ919xBVBmMfPL0jK
 9hSMCCCQJobtcDDr/Te+/2t3FfF8iNuoYQqUyuJtpsRCBccB8lGmmwcYpFyJhhP4HGkZ
 gEDGGY7I2iTLuQQIPeveMkS96hmWu2GK2hVkPMizTR37uSfpdXqC9I1e7R5UhBVvHMgV
 74ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJYZZsKx8ClQTMOTCwc2tbx7PbW6qhxjBubooU3r7bUmrGukRxeUeepoo1bxnRJqa8j5k=@lists.linux.it
X-Gm-Message-State: AOJu0Yz+Xb6xoVUvpoyComljddT6vaPLXTuxjYKE48jeE9b91jmL6twU
 Nu1xgaMNpSkOi7gZVrCUJ0i4UeVohrssO+pc9Ct63bjMizWbwfBZu22HZUi1ZPJXi/tSkMJrGK/
 l4ih9L5t79/9+RXenPyToisgWLW10umgB6eCuqDriUb25R2h1ycEMHM+d6khbAdlsKtxGNnk5qm
 y4+2G/qzFsWB4Hfo+fLRHHYWmgbuE=
X-Gm-Gg: ASbGnctjMM1HPo3ExTOldpO1QNLDVh8lA+/qkpRQheq1Hi6tiL3B5IUIGEvtfLs6UzP
 OlGl3Jx2K5ztvGU0Gy6Ja83CKsRE8kYLysOLoqHs1d5jTNFKpwGO5hphcQ0+irZB+JgsB8/KA53
 yW6h8NAVnvrX5sRzZflBqtMW5DK0g7guOGbuEE/8GesEVPqArNzgRlrLR/xvQs3HC+LLw=
X-Received: by 2002:a05:7301:dc3:b0:2a4:3593:9696 with SMTP id
 5a478bee46e88-2a71927a2cdmr5268349eec.19.1763990460659; 
 Mon, 24 Nov 2025 05:21:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaBGH6GVt73d1SqwZ58USvU7Pof9LgkLqrY7FpTH8gx8UlkUMb72ShLKLfqL1udfvdVS5SFPmhw1QKRGZQpcQ=
X-Received: by 2002:a05:7301:dc3:b0:2a4:3593:9696 with SMTP id
 5a478bee46e88-2a71927a2cdmr5268333eec.19.1763990460222; Mon, 24 Nov 2025
 05:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20251120163550.333241-1-pvorel@suse.cz>
 <aSBBzVaq4gJ6JfrK@yuki.lan>
 <20251121104506.GA25561@pevik> <aSBQDg8PRXFK8GxB@yuki.lan>
 <CAEemH2fN=byf4dKvCk82KKuA9fRk0M6uh1GmMfiY2EPOk=X_Zg@mail.gmail.com>
 <aSRbG5o-lTPtG7wB@yuki.lan>
In-Reply-To: <aSRbG5o-lTPtG7wB@yuki.lan>
Date: Mon, 24 Nov 2025 21:20:46 +0800
X-Gm-Features: AWmQ_bkYBlnX5siIRbZF_iPGFYmFiuQX2BUqR1fg11mJoZV4QMq457y7d0vme_Q
Message-ID: <CAEemH2ec-o1+yPD-huYCwfroLHt3wDzSpag2Kyndvbp1ywZiMA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TgkBY00PjmVx5EVumb0YB8n2JgRUqt1uvkKvdcJu_qo_1763990461
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] readahead02: Sleep 1.5 msec to fix problem on
 bare metal
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

T24gTW9uLCBOb3YgMjQsIDIwMjUgYXQgOToxN+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBUaGlzIGlzIGEgbmljZSBpbXByb3ZlbWVudCwgYnV0
IG9uZSB0aGluZyBjb21lcyB0byBteSBtaW5kIHRoYXQKPiA+IGdldF9jYWNoZWRfc2l6ZSgpIHJl
YWRzIHRoZSBzeXN0ZW0gd2lkZSDigJxDYWNoZWTigJ0gc2l6ZSBmcm9tCj4gPiAnL3Byb2MvbWVt
aW5mbycgbWlnaHQgbm90IGJlIHJlbGlhYmxlIGluIHRoZSB0ZXN0IChwcm9iYmFseSBpbXBhY3QK
PiA+IGZyb20gb3RoZXIgcHJvZ3Jlc3MpLgo+ID4KPiA+IFNvLCBob3cgYWJvdXQgdXNpbmcgbWlu
Y29yZSgpIHdvcmtzIG9uIHRoZSBjdXJyZW50bHkgbWFwcGVkIHBhZ2VzCj4gPiB0byBjb3VudCB0
aGUgcmVzaWRlbnQgYnl0ZXMgaW4gbWVtb3J5Pwo+Cj4gSSBndWVzcyB0aGF0IHdlIGNhbiBkbyB0
aGF0IGluIGEgc3Vic2VxdWVudCBwYXRjaC4gSSd2ZSBqdXN0IHNlbnQKPiBzbGlnaHRseSBtb2Rp
ZmllZCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2guCj4KCk5vIHByb2JsZW0sIEkgd2lsbCB0cnkgdGhl
IG1pbmNvcmUoKSBtZXRob2Qgc2VwYXJhdGVseSAoYmFzZWQgb24geW91ciBWMgpjaGFuZ2UpLgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
