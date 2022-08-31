Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E371EECAAD1
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 12:59:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 139863CA70A
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 14:59:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE0EA3C1351
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:59:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6615E600661
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661950760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jRs5HAxB2ZM0L7xmU/o58x2LA+e0GOK3B+sW0SYw38E=;
 b=TM29xnqKJ1cHIynEsZwPal1RfzqytMgxv9tnN27v8QB8p/uiMoCk6f/Z5aR0hSf6rDpEvT
 Qvx2/7+EBziLD27p8v9mTtuLe++Fyp8A35Z/o0fJ536nzbje19ot2tc2SEVPVYua7Sppop
 xcT6rL8IZhp7hZcMVA36vVnHITkjHqk=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-282-e76qogdTPG6qGLatx2XnxQ-1; Wed, 31 Aug 2022 08:59:19 -0400
X-MC-Unique: e76qogdTPG6qGLatx2XnxQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 h12-20020a4ad28c000000b00448bee68970so6831668oos.10
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 05:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=jRs5HAxB2ZM0L7xmU/o58x2LA+e0GOK3B+sW0SYw38E=;
 b=Bl5h2SpzLI6TMZL0ZiqQP6McRJXYkKSBxpFetuzKeRqIjt+28bhobGk3kxqd8yeDI4
 L98EmVoskPONIzS393SOtTHMNo6WnumFP5giiZ8s1A9jPBdQrQ8TaWcKrqNW5vY8cQM+
 5kHxk/lWMzWFMyMoVIImx9Ee+WfmKkYX1CbdEkJMarE9h8AgPDnsiIw3GkOAxrTXXP2i
 /gkRFQo2PbUv7sYyyqYlea2T38/RO89yDtdXPVL5lUSuGYzQYeSgOpAOznLAOp0znYSB
 xvXXTinV2uge9BlhkGwx95eL2lb/BmJAt6X7hWulwm0iQmCUrdFUnW4ILJMtqGEoNpOx
 tdfw==
X-Gm-Message-State: ACgBeo0ZvmdAo8D37ddjNivnGFghbXtrqefP0ebiQezL6NonlMXnTAbg
 G9KCNtieeQ+l64A44F6z3b5NMqFbyV+pOWvhTPri/1nTJ9zWQ6aDIBDlAk8p8Vzk56uY+rqfl1w
 hAj5bsqIsdOeH1sTtTne5PJ28gps=
X-Received: by 2002:a05:6870:a1a5:b0:120:8d35:c8a3 with SMTP id
 a37-20020a056870a1a500b001208d35c8a3mr1305463oaf.237.1661950759196; 
 Wed, 31 Aug 2022 05:59:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4DN3kCCGCFqi48sSNHYo1XbFcOQKFTm5xO1pZkZn6d111yDPIsSORqO8p3aiP3kmQBRUq9Kno9OowYpGPN9Lw=
X-Received: by 2002:a05:6870:a1a5:b0:120:8d35:c8a3 with SMTP id
 a37-20020a056870a1a500b001208d35c8a3mr1305458oaf.237.1661950758991; Wed, 31
 Aug 2022 05:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-11-mdoucha@suse.cz>
In-Reply-To: <20220830135007.16818-11-mdoucha@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 31 Aug 2022 14:59:03 +0200
Message-ID: <CAASaF6y4n0nqWoUi=+rM2=4gcR-XS1Mqc4Dxcv-qHJ_DGy0ebQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 10/10] sendfile09: Add max_runtime
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

On Tue, Aug 30, 2022 at 3:51 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/sendfile/sendfile09.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
> index 320649dcd..353ef07d0 100644
> --- a/testcases/kernel/syscalls/sendfile/sendfile09.c
> +++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
> @@ -97,6 +97,7 @@ static struct tst_test test = {
>         .test = run,
>         .tcnt = ARRAY_SIZE(tc),
>         .min_kver = "2.6.33",
> +       .max_runtime = 20,

I already saw reports of this timing out with 60 second timeout on
bare metal, so I'd go with higher value:

tst_test.c:1526: TINFO: Timeout per run is 0h 01m 00s
Test timeouted, sending SIGKILL!
tst_test.c:1577: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1579: TBROK: Test killed! (timeout?)


>         .tags = (const struct tst_tag[]) {
>                 {"linux-git", "5d73320a96fcc"},
>                 {}
> --
> 2.37.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
