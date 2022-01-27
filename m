Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D09AC433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 08:39:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 685C23C9725
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 09:39:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 360F83C9514
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 09:38:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C9AE91000A09
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 09:38:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643272727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMsNDrE2nP3fQ98ODXD1iiUYvtIf7/aKDWfnEBdKDQ4=;
 b=QDDq7hzgb5m+A0qAf0wJqRlm6xTRp8oPGw8B+b3+2kNcDpdfJYpE2ATR3S6GvPW5zpA97E
 k0g/3KUWMvER6uhjx8hXKWJ+2RsbaDIuAPZIQpEGFNtlVzgRAPPDW0cbxNFoq/CYsOSx8s
 Z+gZH3FYya52cJ59EFCKB/pAHAfrgsQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-SoVplGu-P3CC7Gb_jpDClA-1; Thu, 27 Jan 2022 03:38:40 -0500
X-MC-Unique: SoVplGu-P3CC7Gb_jpDClA-1
Received: by mail-oo1-f69.google.com with SMTP id
 u13-20020a4ab5cd000000b002e021ad5bbcso1238080ooo.17
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 00:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hMsNDrE2nP3fQ98ODXD1iiUYvtIf7/aKDWfnEBdKDQ4=;
 b=iGA7gDjSAte0dnjFi7XYfQkreNVhyypFfJ2bqMk/I45dABeJJWNhLAxPpwWPyQeeIn
 FSTl6H5L20bHYwei+Y13+xvXNB0w2ZpwYEpTRO66od6yKn7T9PDIDMlRdF6GDDDz0ugV
 Mpo40FDcc6EDfIAbDyGuoxJjgAMYv6NGYMIFUKpTOU1zZydduU6zXQ4/tIQ0CMAPGCyd
 pdm4IRMlvD2GOoazdJGDpd4dWDduSj9S2z6fflQXgbIMVhxn5Hui+osn5ts/AmKy7H6C
 ln1Ja4cedrBUNAHDgRQGIViPAxa5XlnjMdsf3MmeL+bbe21XlZv/anoIEsLZqt17KPsZ
 xz7g==
X-Gm-Message-State: AOAM533Lah73SNp1jJw3q2la2ggCZzJtHzNVGnhrYv938x9ujAOUYMqj
 8v8Dka55hICxr6+PWbJtt27i8bKvejayjatzFE7BPlM2R/mm67n+VsxZNs2S6nG+HLocic6GoNe
 D4A307oQSKK6GRQPILHrQU5XdIjI=
X-Received: by 2002:a05:6808:15aa:: with SMTP id
 t42mr6144826oiw.227.1643272719325; 
 Thu, 27 Jan 2022 00:38:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdzy+BnQtU9zRdXPnzaGs63mznz/XBxRgI6OcIGORI+CkOAtDlTkp/PsaT5/5Op/Y1dxZC1AKmtNsDcLXjJRI=
X-Received: by 2002:a05:6808:15aa:: with SMTP id
 t42mr6144807oiw.227.1643272718925; 
 Thu, 27 Jan 2022 00:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20220126123547.13298-1-pvorel@suse.cz>
 <20220126123547.13298-2-pvorel@suse.cz>
In-Reply-To: <20220126123547.13298-2-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 27 Jan 2022 09:38:22 +0100
Message-ID: <CAASaF6wfO3aMjxmAr3=hTA4704Gmr8U2oBUi6BAUugaNadbv7g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, maninder1.s@samsung.com,
 weijg.fnst@cn.fujitsu.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v2 1/7] pan: Remove ltp-scanner
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
Cc: automated-testing <automated-testing@yoctoproject.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 26, 2022 at 1:37 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> We believe that nobody uses it.

There were some fixes to it years ago (I was surprised to find one was
mine), but I can't recall last time I used it so I'm OK with dropping
it.

Acked-by: Jan Stancek <jstancek@redhat.com>

>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v2
>
>  .gitignore        |   1 -
>  INSTALL           |   2 -
>  configure.ac      |   1 -
>  pan/Makefile      |   8 -
>  pan/debug.c       |  84 --------
>  pan/debug.h       |  67 -------
>  pan/ltp-scanner.c | 175 -----------------
>  pan/reporter.c    | 270 --------------------------
>  pan/reporter.h    |  80 --------
>  pan/scan.h        |  42 ----
>  pan/scan.l        | 456 -------------------------------------------
>  pan/symbol.c      | 467 --------------------------------------------
>  pan/symbol.h      | 104 ----------
>  pan/tag_report.c  | 478 ----------------------------------------------
>  14 files changed, 2235 deletions(-)
>  delete mode 100644 pan/debug.c
>  delete mode 100644 pan/debug.h
>  delete mode 100644 pan/ltp-scanner.c
>  delete mode 100644 pan/reporter.c
>  delete mode 100644 pan/reporter.h
>  delete mode 100644 pan/scan.h
>  delete mode 100644 pan/scan.l
>  delete mode 100644 pan/symbol.c
>  delete mode 100644 pan/symbol.h
>  delete mode 100644 pan/tag_report.c
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
