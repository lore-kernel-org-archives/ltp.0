Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47956CD128A
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 11:08:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65EDC3CF822
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 13:08:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D23423C60FA
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 13:08:12 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7280720EB45
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 13:08:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712833689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Pztz6M4Tva6BrKIQ7W9h0z0dqnaBOfoFsaEJHQ2p8w=;
 b=ZsBxznWYAIyJVu9EXziedDqfjMLqkdEKlWfTRexiM9tjoFM4ZkV4iMq2t1jDYqnCbEocuK
 CKA666S7Bzkof/XIvw9icQgo1QNdufk9ggUZ4Tq/jEpSpkVxNPFOrRrBvdwIhvgI3NGhf7
 r6g8rqSWSWEQ2qqx+K2O+YdO8np3R6Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-mAfkmX5xPPKVZ4ofsU1QHg-1; Thu, 11 Apr 2024 07:08:07 -0400
X-MC-Unique: mAfkmX5xPPKVZ4ofsU1QHg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a4e9ac44d37so475748566b.0
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 04:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712833686; x=1713438486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Pztz6M4Tva6BrKIQ7W9h0z0dqnaBOfoFsaEJHQ2p8w=;
 b=UjF+wWO0vMQ9Uyekb4XEo3iGdsYydd5lATOFGC6ULqzJH/atJ2zv3QSSL+hrq/4qGk
 febz5tob6qHlDp/gyzVu8cT4djtBzlzWhWzDZ1yrTgUwgfwDwRASuFioigqIGZ/tLvFK
 Y8/yhzpF3ioOJL3hE/INtZnDoW2vEN1wYbM7NEonNp1faQ6fgkDhB8bRG0pfnjLDHb3Z
 nhJcvdPk+qnoQxCDXHqMeDLlcDJ8oQRNE7bjJdAmCyM3Dy76m57hKW1a+xpQcFj1fpOx
 Y8S+JT1N8ChY8TnpApIEqLlgK97g9c/QJUcH5cczNxZaPU3P7SbwruNDziHcsPD9rDUM
 jasQ==
X-Gm-Message-State: AOJu0YzagZ2f0tYoP2MAWva376905yvZ8tHZP1IGjyKrxgN05tVDwT05
 U0saZKlaDpNbwUETVOKKIJ9wnRgwgEX861hW0r5arLWZiEH4zhB6hcmNArSDQFpo8CsZkAh8wej
 gFuXV6EvK3ZJHIlmAw2SID92zVuXBGT3RQ6/NMMxiOWYvBGTDeaNYYpmWwk06P62ISY5yWvJ0VO
 0a+nlzKomP+s8GRsDHfLDyilY=
X-Received: by 2002:a17:907:25ca:b0:a51:a329:cd76 with SMTP id
 ae10-20020a17090725ca00b00a51a329cd76mr4171116ejc.13.1712833686164; 
 Thu, 11 Apr 2024 04:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKXKhJcnLrsgsHNs5Gu2mvhqlXpZ2NbFtmsDhHag6weImMEv/POy9RwTdC0ZnNMK6tnxX/jBrtuUwrqgTwFMQ=
X-Received: by 2002:a17:907:25ca:b0:a51:a329:cd76 with SMTP id
 ae10-20020a17090725ca00b00a51a329cd76mr4171092ejc.13.1712833685795; Thu, 11
 Apr 2024 04:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240320095927.19973-1-chrubis@suse.cz>
 <20240320095927.19973-2-chrubis@suse.cz>
 <CAASaF6zEUC6D6zGcgKXorcrOFEXeMxvuDXUcgC7VX6L978Lshw@mail.gmail.com>
 <Zhe-thtEEMC1Qwc3@yuki>
In-Reply-To: <Zhe-thtEEMC1Qwc3@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 11 Apr 2024 13:08:38 +0200
Message-ID: <CAASaF6zS1gPdDTOhCR-08Ut76GWZWPyX-XP4d53ohM2dMJUitw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls: Add test for splicing from
 /dev/zero and /dev/full
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

T24gVGh1LCBBcHIgMTEsIDIwMjQgYXQgMTI6NDTigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKPiA+IEJvdGggbG9vayBnb29kIHRvIG1lLCBqdXN0IGN1
cmlvdXMgaWYgeW91IG1lYW50IHRvIGNoZWNrIFRTVF9SRVQKPgo+IElzIHRoYXQgQWNrZWQtYnkg
b3IgUmV2aWV3ZWQtYnk/Cj4KPiA+IGFnYWluc3Qgc2l6ZW9mKGJ1ZikgaGVyZQo+ID4gYXMgeW91
IGRpZCBpbiBzcGxpY2UwOS4KPgo+IFdpbGwgZml4LgoKRmVlbCBmcmVlIHRvIGFkZCB0byBuZXh0
IHZlcnNpb246ClJldmlld2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4K
Cj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+CgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
