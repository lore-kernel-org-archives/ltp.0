Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB047C3ABC5
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 04:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747195468; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BlwdHmt9LrGfLO5Sxg4kBtVvclf+HWCdZtQWZyUutqA=;
 b=EvvY8ag0zRpL4xYUEuFWNSoL6BNukvlqpRLW5jhtFXcJ+ZklLSw8L8wMjsT64bxhqDME+
 /Sle90bBs8qJx2JgOUHKUXZWLoFIibfeDMtep4Ab7ER14s6DMkdu72TUrIIqyh9zHezRFfB
 GvFk3q8kOkUByoX8EePpUZLYJe06Hzo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABFAC3CC363
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 06:04:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1408A3C99DD
 for <ltp@lists.linux.it>; Wed, 14 May 2025 06:04:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CF4561000B41
 for <ltp@lists.linux.it>; Wed, 14 May 2025 06:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747195442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gmPJeqQnhkm4jXmiyci3i8t6Dpry24qCwFPYW6tWhHc=;
 b=HB/0A1MYeSpiEXJB6sKITJuXCY0+i1wewvxCffzyVgwRbvfq5U/rnhJRHcFTeLwn7HZc36
 py1oOl4E8dYU3BBf6yZm5hmAW9MplZL3G6f4tNJ2zAFdvKZJqfI0H2+ex38XTS+artD5kC
 X2kGFcfAnPNH2PcPvZIFHIZ3ZiKbiGs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-jS0iaKMYM8iCYpeYQxZd1w-1; Wed, 14 May 2025 00:04:01 -0400
X-MC-Unique: jS0iaKMYM8iCYpeYQxZd1w-1
X-Mimecast-MFC-AGG-ID: jS0iaKMYM8iCYpeYQxZd1w_1747195440
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22fafbbe51fso90886845ad.0
 for <ltp@lists.linux.it>; Tue, 13 May 2025 21:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747195440; x=1747800240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gmPJeqQnhkm4jXmiyci3i8t6Dpry24qCwFPYW6tWhHc=;
 b=JFa1UTTpbOqrfJQ9+uXEEok/2YVbof3wwnStTFUpHf1JYi5RfpOE2B8wCUZ41K65GT
 O+Dr9JDpZeek7On3YZcjrcieGcS0S/RGhrcM/0XG4LhmLFdcOKlQ6ztZR1DEnih1sGGG
 HzZi/nqMk5YrOwIbHMsyAvKwTlrKjYxrmpsEqJ//esKVWdJyvrQOMM3Z1xCCR5agFTsR
 +RqKuYLwwoDsMFXFdD8Vqql3x6OZA2z/cbt/MJXCHD9IX4y2ObekONHB/Dp49zNon0jH
 GDBdDhGbb12zymXIyRsa3JIjvbUaIEcyOPYJEng+6wlK0UtC8HKzojiiuj3zBLeThaFz
 6H5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX94P5SzvO4ShcxVEJ3IlAL3sxos2ksomTp+C4yyyKiww7tHD0et0pk4en0UZr2agC2kvE=@lists.linux.it
X-Gm-Message-State: AOJu0Ywr4EatdwEwZXt0tdukhB3VitEJ3tLB46fyaKHRK5bMUL8cSQHi
 yQOxV1oes48RPSfWtiWz+s8iY5MgKwR2UymiKSts216rIT0cFwWigRf6LTUQ+pUwFw4VptN+RXL
 EQAwFJfu50keMN0QVM9we8UxVuanOInuGe4n+1qBfeHLlKOyxWJWe2fBhWV8vhNXYlnG9W3CWYm
 frU67coTavxa9wGh9iQ0vxIoU=
X-Gm-Gg: ASbGncvDooFUCTl9AyfFcq4MdoILFi1ZeZ0MhAmonpkPt+yNdbH7pxEbsTlAYUxi+AO
 GS3QbclmcoJUvKn3qqNZUe0FmBvT8Y/cVk6SV34FQU+MOVFgyJpSgfvBvjriARdDbyNPDwA==
X-Received: by 2002:a17:902:d4cc:b0:22e:3c2:d477 with SMTP id
 d9443c01a7336-2319815c4f8mr27151055ad.25.1747195440080; 
 Tue, 13 May 2025 21:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5SyatsarEw5EcwJCQsZECllqw2EiiT06hEr4Eff6cg+//rOK7DFZVmTEZ2fuFhF+MqdQRnL3qMV/g5yPYJkc=
X-Received: by 2002:a17:902:d4cc:b0:22e:3c2:d477 with SMTP id
 d9443c01a7336-2319815c4f8mr27150815ad.25.1747195439783; Tue, 13 May 2025
 21:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250510205326.1353857-1-wegao@suse.com>
 <CAEemH2cJHz3aLRi0HeSvJWy=XvPMfJ_nv0F7=L7P2ubn8-zv5A@mail.gmail.com>
 <20250512063346.GA290759@pevik>
 <CAEemH2d3_0Ep--e7yrMPihPWTU9Akgyxch5BdMJoNa8Aghkjdg@mail.gmail.com>
In-Reply-To: <CAEemH2d3_0Ep--e7yrMPihPWTU9Akgyxch5BdMJoNa8Aghkjdg@mail.gmail.com>
Date: Wed, 14 May 2025 12:03:47 +0800
X-Gm-Features: AX0GCFtquTo40vp97q_Pl5scTsu8-xMgilT_2VU2WpGQ6_kSCJSgxC7jitxE5Ok
Message-ID: <CAEemH2dxYMaOEscXTcG91uA9u_NVkaFXJuiqri_xDccf9C3Tfw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jnNHyuYprGCkDbXh855F9f0mZaW5TlDgHlYv1NPjhbA_1747195440
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix: dirtyc0w_shmem child process exit with
 error due to uninitialized lib_pid
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It is worth mentioning that our kernel CI report shows that
this commit also introduced an issue that incorrectly identified
TCONF as TFAIL. This caused quite a few test cases (TCONF)
to be reported as failures.

I confirmed that the below patch can fix this as well.
https://lists.linux.it/pipermail/ltp/2025-May/043493.html


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
