Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAFFC83F33
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 09:45:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 125353CDF4C
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 11:45:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 164183CB78F
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:45:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A634C10006CA
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693907136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ia8UfJlw6N+toNfiffA4Qyh/sbMzutM1EYkPHb9Fers=;
 b=H0N4nX0Hd/Fn6G3tmSADZDkW850AIresNMJVxWdAHXRGJAEnPlsXv/ZOWxwiWEFmjYKFv7
 Uj42e6gd7s/SwXNlGZibZ8JOGaBition8R2DgRX3FdW5xZN1/6RjGQcAaZLC+0XXGQUdJe
 1TL+5ZT5Ko7Wg9THxYeG8XITA/rwSPw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-eemBrEgQP3W11H1bjzpo5w-1; Tue, 05 Sep 2023 05:45:35 -0400
X-MC-Unique: eemBrEgQP3W11H1bjzpo5w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bb9bcac581so25107441fa.3
 for <ltp@lists.linux.it>; Tue, 05 Sep 2023 02:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693907132; x=1694511932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ia8UfJlw6N+toNfiffA4Qyh/sbMzutM1EYkPHb9Fers=;
 b=iVxbB3kZOYima/0WIyjwuF1gmYq8uB5SoylfK7qh+5Ydd313u8cqsrbOkcAd5IGlMe
 mzEpEufIMnkCZLFSXphlMT7zfxa99Sf+y4Na8TAsrDX3Dy+X4bm7n07E2VIKzZTiRxgJ
 zNhVSPLxr3kohl6GT1QEKqA+UEvWistyxFXIxq+zJYisFesHtaVjD+ht6eXMcwoqJd0D
 RrI/tJkVRo+VA2horObAOeLJWW2y/lv5sQNr0mkp5tUIGvqVSbUuhYBXfJHZJJHNTbwW
 cj2wJ38LDC6IMxbF7e94xGDLZODXsAv620WAcLPdDKNBh3hyFEwvUb8CBS32293Z+juU
 GAig==
X-Gm-Message-State: AOJu0YwjXBPyndkTKWq93AQ4XQQ2k1dYDDxHqMp5npcpQyLy2JzXaMab
 9+TDX2vhtYkr0qwy258z1+zpNl+fcHSiKiqS5jV/amrz4moIJPmPevPiShgopD2ZsMWLHiQ4Uhb
 9HiZn1g4EaFsDwQdIaMPW9v009uFdc4X+JgDeIeiD
X-Received: by 2002:a2e:8342:0:b0:2bc:b75e:b88 with SMTP id
 l2-20020a2e8342000000b002bcb75e0b88mr8679725ljh.18.1693907132686; 
 Tue, 05 Sep 2023 02:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYSCQks7J9lY2GOE8u8ofvAHMhWCO06ZRiAMfqEHJr+ynNikq5SZlt35nyhEPqsF5Tqtt/3QrU/8pPM6NwfTM=
X-Received: by 2002:a2e:8342:0:b0:2bc:b75e:b88 with SMTP id
 l2-20020a2e8342000000b002bcb75e0b88mr8679711ljh.18.1693907132398; Tue, 05 Sep
 2023 02:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230905085726.11038-1-chrubis@suse.cz>
In-Reply-To: <20230905085726.11038-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Sep 2023 17:45:20 +0800
Message-ID: <CAEemH2eTB4xbGbxXcJ0xvGJWo+KGcceV4vm_gnf0QKP76qy3cQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] doc: Add .min_swap_avail
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
