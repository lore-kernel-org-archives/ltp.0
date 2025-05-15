Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF89DC3ABDA
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 02:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747275427; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=G0NH4Q0MCd+WPMnzqr9cooh6obbb/8kgnw2OW8kj6zg=;
 b=mPe0fFOiNvcS5mZI5UGwv1WV5974XTgI17JJeOv/QOvh2GGvJNHJos1GRUemJFyrVnpxf
 w2E3zXw+fh191KOUDAlIdDQ8FFhONI1aEjl6cXQrXcnLTb6k7EMTwfmm/4JNKhoWSbksRb4
 Ww//j4/lOorGq2T4/VxJPLsR2xjk94Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AB163CC2F1
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 04:17:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B776A3CA312
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:16:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9F62E2002A1
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747275401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xuMKcRCvB5tHnerPYgIEyxAxD7qu7P1WlIxutjYnAM=;
 b=PU9JySRFvPHylriy3WGNWFmmjUBbG69o3P+h1sDmZsSK8kaU2tjPSM2qCvFANqmYqZsG6B
 0G4WZwxJ0TRjX2IErV3iU5Junykn4IUEiC8xhKELGsRhfDBpNksMtW2iP/bO7ACIkT+OcU
 rO2uHv0qjG0qowDVuiBsv6TsC/PNU6U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-rIR1bQq4NBu9aOp1M5hQOQ-1; Wed, 14 May 2025 22:16:40 -0400
X-MC-Unique: rIR1bQq4NBu9aOp1M5hQOQ-1
X-Mimecast-MFC-AGG-ID: rIR1bQq4NBu9aOp1M5hQOQ_1747275399
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22e50d4f49bso6210105ad.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 19:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747275399; x=1747880199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7xuMKcRCvB5tHnerPYgIEyxAxD7qu7P1WlIxutjYnAM=;
 b=Npt6Z+zPf+Wk2AtpEKTmta66+UVTFGp41rOVJdPe3CAKhDgA3tlUgsyo5IKTlVNtH3
 qXpg9mZ962Ra9GAGzJyZnEQYgd++6UCmxVeHcJH0j1CloPXRMQSbmRzf4BDeSBb3+mVr
 I8uEtAjXUp8TKr37GiXI6GyJLTgZXLYg7zGAS0YqYEatg8tvLBT9xziEslo3Rk/xR33p
 TLHyJANQfEExPmnVGtKHDTZbGuSPcM92NyrP26DgcFUC0VKCwx8NlaKGNk7cYxSep20U
 fZR2Qymv/E6Wzy4Ek9V2KW1UCtFbxJWVhC2mK5nFqck5v9pY9A0STpyPbopIAKMUZOAG
 v6pA==
X-Gm-Message-State: AOJu0YylSmFgbNb20dIxqhCJ3vFOZepxmAFVryPJPSXezlR6SWg7NrWh
 cnKsFhgnvdb55G3gI95nOmxXlGHIoTbBHA32IMMnPeus+U1AKXJrheQeeuqrajF2tFwP/IJ/szh
 loOZ1EMcHDqTioAUKeFIMLXYonJ5bd5QHmDaCjMLqS01XQsoWxoR+yC9UUJYet3hQCGVEItLJHy
 e7s/isEFtFwKR/mp5qXVgLj/Y=
X-Gm-Gg: ASbGncs7SDu6+S1hhFk9WuXfXVfOMY0qAyqJQJE+tEeGEeWO3bp6+YYuX2Wiy5nJVd7
 mOPaz0bSqaecczfYmFycZoUt14i+ympYr93/X+zVmNJtgoZCT6DpDONPhWCqMIiiG17D1Mw==
X-Received: by 2002:a17:903:1b4d:b0:224:1935:d9a3 with SMTP id
 d9443c01a7336-231980d7453mr94125545ad.21.1747275399407; 
 Wed, 14 May 2025 19:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzWJtsEdBb/CsEKiaD6x7FCoEIPW5dBnFEWmKlg23HWPiDzxtNMj0xmjmjZWlbYJ7JpSjAC+R8M6Zdr8B13iI=
X-Received: by 2002:a17:903:1b4d:b0:224:1935:d9a3 with SMTP id
 d9443c01a7336-231980d7453mr94125365ad.21.1747275399101; Wed, 14 May 2025
 19:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
Date: Thu, 15 May 2025 10:16:26 +0800
X-Gm-Features: AX0GCFvRxc9hjPIODVKwowePmfSLribKm6PB-CveltrFpllakWrlDS33_9N3Rhg
Message-ID: <CAEemH2d5AbVe0O9o928V2iDT6=2-z8BPAH58MUTbGrYdQFVmMw@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iwM7-JjC1d37jDDEekDvgh08Vtat6J34Zzq8c9CpDBo_1747275399
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/6] syscalls/kill: Small cleanup
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
Cc: Linux Test Project <ltp@lists.linux.it>
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
