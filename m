Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35DCC30653
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 13:16:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 853B83D1157
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 15:16:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43E713C1A00
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 15:16:40 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57B796096BA
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 15:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719407797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPYuLA+Lv+WAk3v8aynu+NfUl/efXLub0ubJQ8fVPy4=;
 b=UNoK7dvJtBoLd6i2YW3CISYj8xWMvunj8wIGspzEaNyIAUKb9hI6c+gOn5Md5crKTIe6O1
 S5e42E4FwMTWDyd57qwTavz5ILdR3n4W+EWs3E7VtLqh5kSEeFMSgfAYxccjuVSJ3KvYOL
 MUonVYT0zuPHv7+tU6o+wB8RnW+kE4A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-8RAyJu4tPaW3oquJkigrNg-1; Wed, 26 Jun 2024 09:16:35 -0400
X-MC-Unique: 8RAyJu4tPaW3oquJkigrNg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c7c3401dfdso8509285a91.1
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 06:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719407794; x=1720012594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HPYuLA+Lv+WAk3v8aynu+NfUl/efXLub0ubJQ8fVPy4=;
 b=u7lxLaiqK8llE7Hj5rc/MSFawdGUCNlyt08fr2/ZLjDOmjxXavpSIEETpGECFuHRj0
 UCpMMRO6oyENYlWq8JR1GhiLuWAYrruQG9MfSzQWOlu/6TUOj8NtoADT+ZxGZf/jpi62
 e+3sNDfouNlo3xigU8q3a6KEq8xMY3tIhLjCMJnQCttxjDNDEXkoryu7HU/SgagEuyQ5
 N7Vz2zOFjO5tYg973ecCI9uCykxEzHmPTmsKHR+z6jUOfZGV9DGsdOV7tMVNr1t7ZYIK
 OMRCO9M8ZsgMkiG1kAxPvFZLza/5FW38V18zfuPFG3TZzjKuE7tJbty9jJINi+dhy1wH
 PyXg==
X-Gm-Message-State: AOJu0YyiYiDFgUOf3ox5pMRBz/6HzKiDPoxKlAC/2pbhBA9fzAm7aMAV
 JYJ2iPD3cxkiO+kMW3v5qOnAJ2pLxDn0cXe5rmsd4ACfQkzCZSavonpcLrSU/xwTVt1j2FnXrMA
 KrVL5TdqnlvV7MVqBr3xcWH5IO8infihbiwqVO6ZCqFnJ0aYNKMtHWoxmwzBasN3rGS0Z6EVXmF
 lmAEg5OQWXDmFCGJHkvT4e5de1fqYrcHL4zB7w
X-Received: by 2002:a17:90b:4a86:b0:2b1:b1a1:1310 with SMTP id
 98e67ed59e1d1-2c861436110mr9045933a91.29.1719407793405; 
 Wed, 26 Jun 2024 06:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHndjAZisvlnqIHpTFBesCA0lYJ1p/eW6i2ri0IhKV8NvB9np8ZNkmyPr0n0aZ4Pnha117P85ihDeicnQGbuik=
X-Received: by 2002:a17:90b:4a86:b0:2b1:b1a1:1310 with SMTP id
 98e67ed59e1d1-2c861436110mr9045906a91.29.1719407792906; Wed, 26 Jun 2024
 06:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240626105431.746411-1-liwang@redhat.com> <ZnwBQRs6bLYkqoYx@yuki>
In-Reply-To: <ZnwBQRs6bLYkqoYx@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 26 Jun 2024 21:16:21 +0800
Message-ID: <CAEemH2c3esPyuvK6THxKmq_WgeZmMXjAUVkjFg5VYWmT1MaZkQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <acervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/2] lib: add TST_RES_ serious macros
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

Hi Cyril and Andrea,

Cyril Hrubis <chrubis@suse.cz> wrote:


>
> > The macros handle various scenarios including simple messages and
> messages
> > with error flags, ensuring consistent logging of file and line
> information.
> >
> > Additionally, a new test case in tst_res_macros.c demonstrates the usage
> > of these macros.
>
> I actually like the function better. It makes sense to add macros when
> they do something more complicated e.g. the TST_EXP_ macros save a lot
> of code, but in this case I do not think that they add any value, the
> change is only cosmetic.
>

Thanks for the feedback, I admit that those macros are a bit redundant.

But back to the starting point [1], my original intention was just to mask
TWARN
as a failure in the test log. It keeps boring our engineers when reviewing
the warnings
in the automation job.

What about just adding one macro to save energy on TWARN review?

 #define TST_RES_TWARN(MESSAGE, ...) \
        tst_res(TINFO, "WARNING: "MESSAGE, ##__VA_ARGS__)

[1] https://lists.linux.it/pipermail/ltp/2024-May/038561.html

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
