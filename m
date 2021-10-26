Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B67C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 11:57:43 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F2260F24
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 11:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38F2260F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93EE83C6873
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 13:57:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E57B83C675A
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 13:57:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 402D0200AC8
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 13:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635249448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vNPu+MmuEK8mhfJzjuxQnY0BZybLgoZRgR2oBAIhRQ0=;
 b=hmETaLvoOC0DzquAeWMYO9RO9C8SEp3r8DpOP505SpbPGVu+nsuUxF6FHmPMb69cb9/Nod
 rEW0AGcUwCHneVtbD/y6c/EFCXvHWDV3C1snPZTdoLP0bLDfM3q9okxliMbRY0Ba4Lp0u0
 A2G/ZDkX4wfVi6pOtsG2HZPt67lYhyE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-85bhC2qcOSOVu02gWG-ehg-1; Tue, 26 Oct 2021 07:57:27 -0400
X-MC-Unique: 85bhC2qcOSOVu02gWG-ehg-1
Received: by mail-oi1-f198.google.com with SMTP id
 u9-20020a056808000900b0029888aec6fbso2405233oic.6
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 04:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vNPu+MmuEK8mhfJzjuxQnY0BZybLgoZRgR2oBAIhRQ0=;
 b=w68BwOkno5yFY8++d/0Utj5LXYXwj0WWTUf8AGxoGSZsS0/kDRpZSolXEA+HiGwRym
 xZa20L3wguD6e75xmzY/W2by48t3RCEd4C4OmAG6rPbV6qAeQS7JEgJGiZ604UskWVFh
 uV4Ll0a8KhUMpawOeSGWVlYK8LKAe6rRt3+G3dS33fXL7W5iAx5LSrRyOIrc/EDro0Il
 zPeguxUlLMegXaA6EjurVocy82XZFieCv4kAJNwaOs/3WpC++w1X0Ht2wb22D9oM2ElW
 UCsGLm2hINZXUyxJGQhpmjCEHNW8cZUtPrKCUtvA1+lixR494eUmtbceA0Ku6ngPEUVz
 l7/w==
X-Gm-Message-State: AOAM532vdB3y3yYl7Iu9EUwMRPr3tJ9kh5e2v6+b7QyxFQuz6sS49UsM
 qNXFzKvKGIBA5wmE0x6tRBmBhwjhhAEpRt81/OUYIXgfEjvExalYn+uZ0oldWdq5/5c9fJOF6+B
 UsvgEi4wKJ+f56GuA2q81N+pr+6I=
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr16799479oot.18.1635249447071; 
 Tue, 26 Oct 2021 04:57:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdYmWNYhjaPM4J+Emy3UBIrgJJ/voh19PdTlkKXycwddgvY7YZdxx5QOoYWGzQPtonOvToznbeoQSvYXjdtLs=
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr16799457oot.18.1635249446754; 
 Tue, 26 Oct 2021 04:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
 <b987a73550937e5d5652e4a86e591d72334d8fda.1635244875.git.jstancek@redhat.com>
 <YXfeAnRORHareVtn@yuki>
In-Reply-To: <YXfeAnRORHareVtn@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Oct 2021 13:57:11 +0200
Message-ID: <CAASaF6wZEaQjUy8RU9TCp6GpWKN6FkQSWtOb2iLDNY_1KCmE8g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] finit_module02: fix exp. errno for O_WRONLY
 testcase
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 26, 2021 at 12:52 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > commit 032146cda855 ("vfs: check fd has read access in
> > kernel_read_file_from_fd()") changed errno back to EBADF,
> > which is correct value according to man page. Drop the
> > workaround and always expect EBADF for O_WRONLY testcase.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Pushed.

>
> Also I'm starting to wonder if the errno from dir_setup() should be
> fixed in the kernel as well. I guess that EISDIR sounds much better
> error than EINVAL.

It does.

> But in this case the manual page seems to be silent
> on what is going to happen if you pass a directory fd to the
> finit_module().
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
