Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBE7C19F32
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 02:52:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D4FC3C9DEB
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 03:52:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F07F23C4C88
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 03:52:04 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0C1AE21839F
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 03:52:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740711121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=77A52sbTXF1pLIJ0DeboYlMyW74YB+hw5AZuN7XG2xw=;
 b=LzQQcixnmkx2YXAcWD+Nvg2pGa6hdjPP5wS3e4UQXj+0zOuKZSkVqLjjN619MMcdrZHC7G
 21UkJ0Foy15oSFCZLAQIT0QaWMz7Tv5EblFdL0S5i51WYSCpfKINScxdXg8uurWjVSNf0k
 6bFsZ8ZFJnYcSGAoVhftdFKfWPo7UD8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-chCuHHarPzeyTmoRrozvBA-1; Thu, 27 Feb 2025 21:51:58 -0500
X-MC-Unique: chCuHHarPzeyTmoRrozvBA-1
X-Mimecast-MFC-AGG-ID: chCuHHarPzeyTmoRrozvBA_1740711118
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fc45101191so3696743a91.1
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 18:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740711118; x=1741315918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77A52sbTXF1pLIJ0DeboYlMyW74YB+hw5AZuN7XG2xw=;
 b=neXwuLPdvCMKNJlBjfEgecr5rF3f7mUW/3mmVxWab9b87bUH5eZVlcVArSo3oP9jt7
 f5EnO6xSv3zdCCFGfn6A3mZ58hq5oKP0fZ4kJ3NkbVKeOKZeL3gDcnLQzBze8KyRK6Qj
 puWrTVAnmjPp2CkoNW5FpEwFXxsYy1+6Z2oSOPvozrSN4OIPxgb9fLsvXZAKKyQgDF/S
 NNaV34750rovebWKrebNuxb6rDfk9NFwRDP6k57QjlzlkBv3dIIqyFFRtuuHKmQAdMMT
 PYq6qm/IfPRL23jC/xf5aiHuLLSqG/CnTGjgCK9iu4Cc8e8krR+QUEDSaB/UCUtygs/+
 yfJA==
X-Gm-Message-State: AOJu0YzuNIPOyzyLDW2u+ZLF4/dPTl1LVRSxZ0MRQfeSeWvtOcO1OEjM
 wkD1BlZFOLuu8RewqIizVQje8ACXpdbt1FyO8sM6MZM+kw1IoHP95OLvVbPUm04C4z0czbIszxf
 L9MDqqfuEfsgdgnUnT6LlOu2ZGnMHrUdk6y2JJVa8YqtQhDhZjtILh3xveQj1YhsW8dynWdGH4t
 u/ZiFaNK4Z9GcsRoCVkLnp5hg=
X-Gm-Gg: ASbGncsTvM6CTQE+K7zGyNPzmZ81Ifjcf/4c4ZuZIdomePYUdBrsbSpm5y54hi7POAW
 edzRg/cHqo/8uwA5wox5ZZWvHFWwmpAE1/0SRtTTk7c4+gN446cCAO4Cq/ATnya4ZnQPRlqi/mA
 ==
X-Received: by 2002:a17:90b:2689:b0:2f4:49d8:e6f6 with SMTP id
 98e67ed59e1d1-2febab1f2d4mr2540881a91.3.1740711117725; 
 Thu, 27 Feb 2025 18:51:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3/bMX3kogTFkT3LZRlGvLNj4jETzT1qsNnqGDdbhjqFjLi94QLNqtelrtJazzKKDzwVObHmavbmT0/U5eBrM=
X-Received: by 2002:a17:90b:2689:b0:2f4:49d8:e6f6 with SMTP id
 98e67ed59e1d1-2febab1f2d4mr2540862a91.3.1740711117403; Thu, 27 Feb 2025
 18:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20250227170524.3168535-1-pvorel@suse.cz>
In-Reply-To: <20250227170524.3168535-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 28 Feb 2025 10:51:45 +0800
X-Gm-Features: AQ5f1JqhzTOh5K4EIDeMTqwSK7xA2dJnS_gh08VkmSSvJAT_Ae_v-ric5RGRAsU
Message-ID: <CAEemH2dR3XpK0a1C=QZ--1tj12jOUVofDAaUdaAyDeNQT6_HXg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y_s-JhJP55R67K60PaT-2VIEg9vJyOcupBoe15GxP5E_1740711118
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] include: Move safe_mmap into
 tst_safe_macros_inline.h
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

T24gRnJpLCBGZWIgMjgsIDIwMjUgYXQgMTowNeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gdHN0X3NhZmVfbWFjcm9zX2lubGluZS5oIGNvbnRhaW5zIGZ1bmN0aW9u
cyB3aGljaCBhcmUgZm9yY2VkIHRvIGJlCj4gJ2lubGluZScgYmVjYXVzZSB0aGUgYmVoYXZpb3Vy
IG1heSBkZXBlbmQgb24gLURfRklMRV9PRkZTRVRfQklUUz02NAo+IGNvbXBpbGUgZmxhZyAodHlw
ZSBvZmZfdCBvciBzdHJ1Y3R1cmVzIGNvbnRhaW5pbmcgb2ZmX3QgZmllbGRzKS4KPiBzYWZlX21t
YXAoKSB3YXMgbGVmdCBmcm9tIHRoaXMgY29udmVyc2lvbi4KPgo+IEZpeGVzOiAzZjU3MWRhMjhk
ICgiaW5jbHVkZTogTW92ZSBpbmxpbmUgZnVuY3Rpb25zIHRvIHNwZWNpYWwgaGVhZGVyIikKPiBT
aWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKUmV2aWV3ZWQtYnk6
IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
