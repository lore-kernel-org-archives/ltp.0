Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43714CF538F
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 14:30:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED4A93C706B
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 16:29:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44BA23C67F5
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 16:29:43 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C65761030909
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 16:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729693780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVICVxyZY6qCV0KY8tpgY80mc9YtLu8MOkpU16x5wqk=;
 b=V+2B4LjVV02uD4/dN/7JnHS/H1De6JZDByWA+S//bpvU5ePTltXLLFujuz2xsoW9U6qfig
 UuzguVPPPSyTrwkHu6eSa5Pm2gMHs8c8iK+wS7PU6ZWj8dCSRW0HK1YbZofjXbaOqzngt7
 Is3+oI5kfSOwL8YGX4jDfdNWC+ouvZc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-eki6iGFsNvW6rVEdffQ8ow-1; Wed, 23 Oct 2024 10:29:37 -0400
X-MC-Unique: eki6iGFsNvW6rVEdffQ8ow-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3e5fef7b247so6471530b6e.0
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 07:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729693776; x=1730298576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVICVxyZY6qCV0KY8tpgY80mc9YtLu8MOkpU16x5wqk=;
 b=ot84XLDLxjHRCTffer/+C+GDj6YWox+JWvPm7sG4GbKu6y0im/56hTCAFt+DVYqHpc
 pEFDNGNdMGmQkiqsOTo6AmDbqo3o0CnJQ8SEWey8KhVD6vTrwQge0SkZMgkwXyzt4fSz
 oIRReCKzidkFx48xbw2FT3yTYiwZxw4Nd1cuUT5SEdVDtUXTHj7fW+WEqzDVPq1WaYUw
 T6QepggqvHsBlgPXMg9fw/LUHt2tg4/kcCkw1fjorZI0huEiOyTfzETCrroCZh3p9vWd
 qsMywVkxho6FHwheU9pRkQEY1wGdn27bg1WuidwqmWLEYXR3TfknY68P+oMxZ71M/op9
 EirA==
X-Gm-Message-State: AOJu0Ywmuu6D1WoW3wj9+u0uOhHDX66vmUasCQewmA6Zzjyf0BBzdJah
 FRpDVjtHgUskm0uBPPDpjDrDBs0apCpa0nqYhjD0pFWeCVysiZ3ZmPQV5/zOId0fxAG2oWLhuCV
 cJKZsqodP+QzZfQQTH4/oRYTdRN2zB7YA0vvkfzrYIG+SPs+xpdopQW9zLxreQOk5WlpIM/ZO8Y
 Xm7gFMSCHLUuxhpaQOfvZkPIM=
X-Received: by 2002:a05:6808:2e44:b0:3e5:d591:c9a9 with SMTP id
 5614622812f47-3e624548e85mr2923169b6e.26.1729693776684; 
 Wed, 23 Oct 2024 07:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmdzIZsg+JKq1ZRSzsFqZ+yiz4qEJhtGeZ0I+Bsr8+YWbZJeABe1KvuoxLH+V2XEiggy2LP1o/bq94U1iWsjw=
X-Received: by 2002:a05:6808:2e44:b0:3e5:d591:c9a9 with SMTP id
 5614622812f47-3e624548e85mr2923143b6e.26.1729693776323; Wed, 23 Oct 2024
 07:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <36c63ee52ce1e7ab1f6ce90bc6a4c58272130bee.1729590080.git.jstancek@redhat.com>
 <20241022155907.GA550111@pevik>
In-Reply-To: <20241022155907.GA550111@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 23 Oct 2024 16:29:20 +0200
Message-ID: <CAASaF6wjX0quo+bjAr6h3CgNthqQ_qXB+kEU5EkF7pvnPdOoqA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] read_all: limit sysfs tpm entries to single worker
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UHVzaGVkLgoKT24gVHVlLCBPY3QgMjIsIDIwMjQgYXQgNTo1OeKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+IExHVE0uCj4gUmV2aWV3ZWQtYnk6
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgoK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
