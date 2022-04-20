Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC6AC433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 06:20:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17BDB3CA685
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 08:20:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7B83C9C34
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 08:19:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 254961000371
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 08:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650435593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OoXtAsPItp0uEJTSztEwJqjE2Zek6yvzKH5riPThj7I=;
 b=T1mNLUuvKzHBcjsVR2jxRVZyW9ZSU/bAqX2A/VaoZt9i9RdVOa5GRgYNGuLh1LY+lVBfC9
 x5wf8StcTx9HKcrCX/cG86HxoIpkj5CvrG0041vMAJEgo40iaLTr9gv05Z20OCGsXq6dDi
 b+mXUopgacGSiBTmwxpgMIsJ/RzOI9s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-3DJ4SNYhPXGFD0QpteS1ig-1; Wed, 20 Apr 2022 02:19:52 -0400
X-MC-Unique: 3DJ4SNYhPXGFD0QpteS1ig-1
Received: by mail-lf1-f69.google.com with SMTP id
 w34-20020a0565120b2200b0044adfdd1570so195334lfu.23
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 23:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OoXtAsPItp0uEJTSztEwJqjE2Zek6yvzKH5riPThj7I=;
 b=S1IpD3OrxZht9nBWWZxQLbnq7D2vxXXBYiWf/e/LFTacv4eBPhZUcFuoP2JbH/tts0
 F/opT+hDrWLfcDWqJmA5RhRRDZJz0tyT6ExInPVe40BBB9SIVAOBCOfaBcb3t+kVU4o6
 w110eMVDjh7em7Q5SnJot+aIr61ZPAi/RcpJpEWu7A29PNCGT5WExeepnkf2lIoJZNVa
 W0Y/buUGVULEmOAC2fZO9+NV9WWu9sx0nA72WHSKupKAsH9/KPXIEe5Ko6YyeZ6NDrwp
 K3fasnCBKVK7RQ/bd6cS1pkCTBjpfR5Oe5pUXISTF//jX/1SaAHKHJyBDftz2ZhpG1ms
 X7Wg==
X-Gm-Message-State: AOAM533BmF++zAhMqx6/8Hn0SFb6/ti8yyGRRnBOwB0t8VWVyJzGQocu
 LOf7nhF/oVdRJU7XMQZ2BEMLA0+OdW9WwHgY/lMsA6lWMiQk1exQxaafQ4BJFRvpLyapGGebD+a
 xqQXiWO5FakP84jKF6ZfPCle2zro=
X-Received: by 2002:ac2:5b41:0:b0:46e:2ad:72d0 with SMTP id
 i1-20020ac25b41000000b0046e02ad72d0mr13818790lfp.110.1650435590522; 
 Tue, 19 Apr 2022 23:19:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHm7O/OCQvw5IxZpbmcYpYgxJ76vz3GJftpws44bKA84DThlvp490otPzyu3LdARK24XhXLxXqMISsWKpl7I4=
X-Received: by 2002:ac2:5b41:0:b0:46e:2ad:72d0 with SMTP id
 i1-20020ac25b41000000b0046e02ad72d0mr13818781lfp.110.1650435590319; Tue, 19
 Apr 2022 23:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <2539516b566aca2a2f419131c7ad28fcdd7a8fcd.1650365029.git.jstancek@redhat.com>
 <Yl6ewN3bpJPuzDN8@yuki>
In-Reply-To: <Yl6ewN3bpJPuzDN8@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Apr 2022 08:19:33 +0200
Message-ID: <CAASaF6xL8GGJbdX=ex2cw7jtSYNa6sx4DPzdGdnP+oq-qY+zMg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix_testsuite/lio_listio/2-1: remove check
 for individual completion
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

Thanks, pushed.

On Tue, Apr 19, 2022 at 1:34 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Agree.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
