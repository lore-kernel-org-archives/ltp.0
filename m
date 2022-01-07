Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416A5C433EF
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 03:55:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A20CA3C75D6
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 04:55:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E12643C0596
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 04:55:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6980F1000EA7
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 04:55:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641527712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LB/l0zf9rgu5Qh4eq0JcKMluMo3H27Ve/IySFYKPIGU=;
 b=IX/UmWg0eyNEJafqxBUGH43bbEDNrQAPR8pN69h/5pYg7U8GgeKmpPXTeD/DGM1sEwT1dl
 7TNnwzqxbAgBboVkysfu4z0bVvfGF8I6XI/QTN/okp3ZhkFbkg8NuDkWZSLeImxZh61XEv
 uLPkMZ68Ox6ILtrBYLd0hPJjLxP+7bU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-WiPT1-XEMl-YruHv6-tIsg-1; Thu, 06 Jan 2022 22:55:09 -0500
X-MC-Unique: WiPT1-XEMl-YruHv6-tIsg-1
Received: by mail-yb1-f197.google.com with SMTP id
 i129-20020a255487000000b006107b38b495so348557ybb.16
 for <ltp@lists.linux.it>; Thu, 06 Jan 2022 19:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LB/l0zf9rgu5Qh4eq0JcKMluMo3H27Ve/IySFYKPIGU=;
 b=HV61gp2OBIs98ixZoUsVB8cL2QoiXfbz9FzGYwoNv01aozA3X1lGN7FTHz6NPTZIeC
 RuXLwJWvE8F7bUn0q/b+fqkJ0gDje61U136yV5/VJnaAfW3qMIZNu4jBBOzo0m0pxBf7
 RzFswi1ppDFTwZB2/6w9G53upXkHONblrm1AAA+9yEt4xbhv4etiM4pne2p/XIBJ/H5Z
 86jlWIyR6ENqX/mlt29fJVZWJwzwG95NFseBIAn2q6VxLw0N/Jsf2kTc4grSQ6L7IicB
 J/RrDTly6aoTAgFEbufLXhcRQqG54poWXx6PcCmbsw5wEd9FcI1GYVsdJgSvGfSsMlYL
 5hiw==
X-Gm-Message-State: AOAM532aKhsECPcguAs6IBtPieCTS5q63cmYXqCtpD0t2yUo8XqrkYFs
 jqIHJwq/tIeFsxu4YyhPA0JXUWPRtimU4u65Ara4iJPFKRQBENNlj0F6kJ6qKwYibGDMA0xI4PM
 QoTVs2pCGDykaiKrS4191tF7CiuE=
X-Received: by 2002:a25:452:: with SMTP id 79mr64032328ybe.421.1641527709081; 
 Thu, 06 Jan 2022 19:55:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDZqkwoypp23psGwBdRjkmGpqHX7D7m9+ZB8XNbiTb/CDXSym5xIrYq8Mcw2s537eC72AjJdp+afmdFzLMSnI=
X-Received: by 2002:a25:452:: with SMTP id 79mr64032308ybe.421.1641527708808; 
 Thu, 06 Jan 2022 19:55:08 -0800 (PST)
MIME-Version: 1.0
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
In-Reply-To: <YdbQLuuSAiN+d+Cs@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 7 Jan 2022 11:54:53 +0800
Message-ID: <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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

Hi all,

On Thu, Jan 6, 2022 at 7:17 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> > +| 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).

> > +| 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
> > +                             default value is comma.


> > +     for kconfig_i in $(seq $kconfig_max); do
> > +             eval "local kconfig$kconfig_i"
> > +             eval "kconfig$kconfig_i='$(echo "$kconfigs" | cut -d"$TST_NEEDS_KCONFIGS_IFS" -f$kconfig_i)'"
> > +     done
>
> This part is a bit ugly, I guess that it may as well be easier to
> process in C. A long as we pass it as:
>
> tst_check_kconfigs "$TST_NEEDS_KCONFIGS_IFS" "$TST_NEEDS_KCONFIGS"
>
> We can easily split the TST_NEEDS_KCONFIGS with strchr() and single
> loop.

+1

I even don't think we need that 'TST_NEEDS_KCONFIGS_IFS'
variable for users. More flexible means more complicated to some
degree, if achieve a C process,  we can handle that by accepting
whatever the delimiter.

But strictly usage with a comma is enough for current kernel configs
parsing I guess.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
