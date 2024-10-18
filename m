Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321BDD2FFE6
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 10:25:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE0E53C6884
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 12:25:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45E483C67F4
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 12:25:33 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 15C19600FE3
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 12:25:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729247131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZ74b9NDcQ4v/uKUBRoxBiBfTmCzJmssXY1KK9Y5zqg=;
 b=aORIz6+CshDTFgcNlgtErcdFlfGRAoSWBFZoBQoMP0GoCNpkGXVPgxX/ekkmeYKaWW7CF0
 Jb0RZFRraq2NrllQHe/l4L6/DJnS3Z5XkvPB4kwb4LaWJ1RG+g6cVNAJiwgTEDsD1mGMnW
 F9XCbtBq5NbDECF2xgue/uTj84gLwqA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-rJ_vqk2KPg2NxLc1h0C1nA-1; Fri, 18 Oct 2024 06:25:29 -0400
X-MC-Unique: rJ_vqk2KPg2NxLc1h0C1nA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-288c0ddb462so1209552fac.0
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 03:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729247129; x=1729851929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZ74b9NDcQ4v/uKUBRoxBiBfTmCzJmssXY1KK9Y5zqg=;
 b=wg5EZ/byITufsJuOh/GyNmqqnOMGoN9tFAmnxvobgetQiy1lwvHdrZvusQKdND1Ozb
 nE/84BQwmeWdx6rpPGv6qdmsNIjqcuKkYlhAuBYdQvWmdteme3Vez6rOxLCL+hRskl1W
 EpCYyci6M0edpk9mQmlYFYeCxCahqV0xnvVg3mHBFN/Q54aWUggH5sAUJxKBNo4ueq+y
 5OdDObKjp9TU+KRCtwMUdDwYr1U+ASa55kdTZOhZq0iWf3amxnAhime3azCT782oOuL6
 o919jCnoQEBuNtQTNq2walAKZ9J+2sBs6ClFhZDJkzZPf7z+DQ/YysHRwpWt7uEnGO6b
 KqOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXtlmvCuwyhhyiWUIrw4pnmUtDy93YabhjW9jjPceJhMfrc+CPU+x9u9eoBxHuWPBhgb8=@lists.linux.it
X-Gm-Message-State: AOJu0YxxZEG0o2owX5Y3DxsEUAcg6i10dsfVii8N6ZtyZCNQTyAkKPWa
 y/CZetLrURoozR+3yePgN11JYrAC5rtNxMNRAnM7/+wkpTQMc9QF83b3ntek386TmL7ZKaSbVO5
 sNwV5YB4FaB/7SvFVdlZuAW9uUiuJzLILoZHsq7yQo33GgZeq/ZvaozxEEfjukRmx6Vd9H21JIG
 ok9CoFLdzWSOSpt+m2AlvPvWgylXtQFtY=
X-Received: by 2002:a05:6871:808:b0:261:16da:decb with SMTP id
 586e51a60fabf-2892c310411mr1364249fac.11.1729247129065; 
 Fri, 18 Oct 2024 03:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqIRTWTfcV/1YUsT17k6fTa9FsqQ8dDDYzk5dHC+jIi5n/vxTQdb+tez9xd/10wXeCmRihZrVImm1QF8HVYp8=
X-Received: by 2002:a05:6871:808:b0:261:16da:decb with SMTP id
 586e51a60fabf-2892c310411mr1364240fac.11.1729247128824; Fri, 18 Oct 2024
 03:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
 <d53bcc8476d4c2ef37b92543b2f7fe8338420f0b.1728992854.git.jstancek@redhat.com>
 <Zw5bCxNMuCz4aKWC@yuki.lan>
 <CAASaF6w0Smez5e=hn8UGU2DC3Fi2zrqYX2PwKKE4r23RQ0BM4Q@mail.gmail.com>
 <Zw5xhhvjNkvAwKU0@yuki.lan>
 <CAASaF6xTYOCooJ4FsyfScn1HJY-1SKugbM6yZJ3QdxfoJ=QWEQ@mail.gmail.com>
 <20241018102315.GA286253@pevik>
In-Reply-To: <20241018102315.GA286253@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 18 Oct 2024 12:25:03 +0200
Message-ID: <CAASaF6w43r0z4teiyjMKyqUmk9MV9docwu6fSQ=waX_pGZ5xPg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statmount07: change "invalid buffer
 size" test
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

T24gRnJpLCBPY3QgMTgsIDIwMjQgYXQgMTI6MjPigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSBKYW4sCj4KPiBJIGRhcmVkIHRvIG1lcmdlIHlvdXIgcGF0Y2gu
IFRoYW5rIGZvciB0aGUgZml4IQoKVGhhbmtzLCBJIGdvdCBzaWRldHJhY2tlZCBhbmQgaXQgc2xp
cHBlZCBteSBtaW5kLgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
