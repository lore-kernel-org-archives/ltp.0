Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C4BE67497
	for <ltp@archiver.kernel.org>; Sat,  2 Nov 2024 03:18:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 328443CE718
	for <ltp@archiver.kernel.org>; Sat,  2 Nov 2024 04:18:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62C0C3CC665
 for <ltp@lists.linux.it>; Sat,  2 Nov 2024 04:18:22 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89705656FE8
 for <ltp@lists.linux.it>; Sat,  2 Nov 2024 04:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730517497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TaP1RJpAtUtazuOR2enZfGiUhGk4VsAbCVg2mXYn3lo=;
 b=bqoxgjzy5YazL1jzpAX0fpaW2UqB4kbtOvUPbGBPPES8HZsE1N0UrEOrceaE4ZnSHMYe7p
 f0jCW4uwrw65/LDISqrTVOWmHRh95r9R1MnZwQ0gPb46zD0Ke4senTCZalg7/6RX79qVcQ
 SL0y64vVQ9fWf5atrh0ITbZf7Ai2iSk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-EvXNcWM2PJCHlYqitj0HIA-1; Fri, 01 Nov 2024 23:18:15 -0400
X-MC-Unique: EvXNcWM2PJCHlYqitj0HIA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e2eb765285so3150178a91.1
 for <ltp@lists.linux.it>; Fri, 01 Nov 2024 20:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730517495; x=1731122295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TaP1RJpAtUtazuOR2enZfGiUhGk4VsAbCVg2mXYn3lo=;
 b=ubTDTGDnfS4jlPwCpK1JdzxVzdCdacx0C8KR9bkO0JQve7YyYi851cdXz/Qb0p/I4m
 n1mW0q6qlSbH4jQNDaAh2xXVb/2MRW4A8m0nqWXfPvv9W80vLGXMXSU5zgEjxx+/DUgp
 waCUwXQDM+bKkjgDCYOTBk3l6/wUTLw0jqZQGB9HiAQm+ER8YR9Qwfcuaii7zYk/ChsT
 3B8KXTcmko5oEQg1oFx1IXxDgklN7fjBljENdhtTsB+fQYqDejQfJ4KJDlfNaOb9yLps
 mzWi2HOaWeUpu4LFGlMGriYJk8krxLfZBDqZkI/9EGjx30ahw+5m1z3MG2mcFdorcx4Y
 Zw+g==
X-Gm-Message-State: AOJu0Ywos+bRx6OwrZuCspTpdcPNrSgGq6wbQzGzmMR6HcxSnI0kKhu3
 gS6qnfEHX1oa9ABVRHbWVW5pxoFaAZ4/+gSMOpkE57ZHCj5kj7c1kiH9B4od9Qggo12MjPXAwBV
 S1xHusuNtXIVKxfKVOWXUebPPguu/SOstiJXw5f9hok4ao3VwEKKtRbCytJC1Fig1S/lRskm8y1
 nmOh2QW6xow9mXIvL1EUhR0zU=
X-Received: by 2002:a17:90b:5244:b0:2e7:6a44:daff with SMTP id
 98e67ed59e1d1-2e94c2bfe1fmr8548618a91.10.1730517494686; 
 Fri, 01 Nov 2024 20:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvrDeygy/gABKtQtADIIRFVHaVqY77buZ2ryucpajFwNjuh2fyQnH/uYoHWHvf/jwQ9Leb5qQOTRSvV7BEzQw=
X-Received: by 2002:a17:90b:5244:b0:2e7:6a44:daff with SMTP id
 98e67ed59e1d1-2e94c2bfe1fmr8548575a91.10.1730517494168; Fri, 01 Nov 2024
 20:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <5be090bd107e8cff5823fc35d9c0b9c8ee082ec6.1730466072.git.jstancek@redhat.com>
In-Reply-To: <5be090bd107e8cff5823fc35d9c0b9c8ee082ec6.1730466072.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 2 Nov 2024 11:18:02 +0800
Message-ID: <CAEemH2fp41P8f1_BG=3uTgCo3eG49Bq8_kntz0+oj=pDS5DxPA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/sched_getattr02: use a fixed size for
 EINVAL test
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

Jan Stancek <jstancek@redhat.com> wrote:


> -       {&pid, &attr_copy, sizeof(struct sched_attr) - 1, 0, EINVAL},
> +       {&pid, &attr_copy, 47, 0, EINVAL},
>

"EINVAL size is invalid; that is, it is smaller than the initial version of
the sched_attr structure (48 bytes) or larger than the system page size."

Or we could add one more item for testing 'page_size + 1'.

Anyway, this workaround looks good.
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
