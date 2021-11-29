Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA468C433FE
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 14:24:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A47F83C555B
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 15:24:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 323AF3C042E
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 15:24:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9DDD114010F4
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 15:24:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638195841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TytBv0crBiL073hg+wYWG9FnZx+H4WxDitS1zmGmXgs=;
 b=CiwklFgsbA9+l2NEM1g+tEBlCZoGW33cRr/IyN/g33WGQPOZxNnMKDGEPNRtqOh8/LWLfR
 /CNsM50LZiSI065kmyVF8z90weEgi1PDLbd+m0EHU3JwTv5zhgl9BwDZ69VIVZ3LVXXbkU
 uygv+2QY63sCM9eXknTgBuv8eHZcHI8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-N1CrFHn4PtatN9QKjuiRlA-1; Mon, 29 Nov 2021 09:24:00 -0500
X-MC-Unique: N1CrFHn4PtatN9QKjuiRlA-1
Received: by mail-oi1-f199.google.com with SMTP id
 r65-20020aca4444000000b002bce52a8122so11571069oia.14
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 06:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TytBv0crBiL073hg+wYWG9FnZx+H4WxDitS1zmGmXgs=;
 b=ReAOtna+GkhqaZlaZV3mfDQtw8CVHEgBrOjrUF7QANLanUa4m8ww/1xlRa2zJ2RZh+
 g6KuapFj7VWv9VNeo5FYrbT2ea4rPvJffSxJq9Y18rfv/4f1EDiGLazBcS6/2BUFeuOx
 bsbI2vC7YVjlWrHs8AWXrwBrnMzy99UgsLwz3t+fbnWSIVIatOfy34+re74uhP/dxm3p
 k/os2FpgkEtOwrELbaYjnP44sWGqr0+aknE+q6L7xJYe9fr8zdWfEp7MZaYEHBYpQe0b
 0gU8n+6w1ecqCEdhnw/YklDy08dD7Yb2WRzGelPc/q652F26hgVPqOEDluxGu/IXcOOh
 FVLw==
X-Gm-Message-State: AOAM53207rp5rPqqBHHT78JhOeri1K3bSCh4OCIUsnbjmSkFJ/SliDum
 rAY924DD2kA8HCDTU9/MNL5Y1+ilbX0qVjM6B7wfl6QAc+pRW9Il4v1aBkNnprH1BK5DIKuKTBL
 0ko6s+gXFEnofz1TgCAFvlg+FC68=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr44434919otl.85.1638195839396; 
 Mon, 29 Nov 2021 06:23:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1oX/hcsMWi+HdlPBKUBRZOFDbeHKfO/AddGYyHh1ZHZDXAnW6DF7vdI/apbG8xnFIyxxqC/TvtFuPKjizwUg=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr44434883otl.85.1638195839084; 
 Mon, 29 Nov 2021 06:23:59 -0800 (PST)
MIME-Version: 1.0
References: <bd1156e573b0ea8bbf1feeee2cc2b5f84953c1ae.1638192701.git.jstancek@redhat.com>
 <YaTghxZ06GNiNaY1@yuki> <YaTiRIANkIEdZ6zL@yuki>
In-Reply-To: <YaTiRIANkIEdZ6zL@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 29 Nov 2021 15:23:41 +0100
Message-ID: <CAASaF6xD2VjiyE6p3MVxjjY_Cdm1t=JMA-t7f08wuDDvp7=4wg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix_testsuite/lio_listio/2-1: increase
 number of requests
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

On Mon, Nov 29, 2021 at 3:21 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > >  static volatile int received_selected;
> > > @@ -98,7 +98,7 @@ int main(void)
> > >             memset(aiocbs[i], 0, sizeof(struct aiocb));
> > >
> > >             aiocbs[i]->aio_fildes = fd;
> > > -           aiocbs[i]->aio_offset = 0;
> > > +           aiocbs[i]->aio_offset = i * BUF_SIZE;
> >
> > The only concern I have is that if the filesystem does not support
> > sparse files this will eat up 256MB right?
>
> Ah, it's the same file, that means that it will be just 256kB, that is
> fine. Well it would be better to unlink() the file at the end of the
> test, but regardless:

Yes, should be only 256kB.

>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks, pushed.

>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
