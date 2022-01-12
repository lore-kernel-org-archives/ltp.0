Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24431C433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 10:47:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3DE63C9483
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 11:47:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4E173C0345
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 11:47:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 34F1E200274
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 11:47:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641984423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8nciUc8CZatwsIcO9/4eEiZ8bMkuaFivBC0TXZp8IU=;
 b=VHpZykGhBuZKHTuSKgr+TCdS/r0fjHNelgzxKcakWjpjRAgwJ2aBAhY1kzD3r/a3pp6prB
 79EIpjOFJesOTtGFzUK7tNRB6TWqNin4bAKPvpi3QByMMAErN9pv6tgqqbEnCNxwo+kjb1
 im4M9hH0I0EFnuoUpW47norhG3JVAzo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-b0ADMBB1MtK_lTPICCYiFg-1; Wed, 12 Jan 2022 05:47:00 -0500
X-MC-Unique: b0ADMBB1MtK_lTPICCYiFg-1
Received: by mail-yb1-f197.google.com with SMTP id
 q185-20020a25d9c2000000b00611ae9c8773so252270ybg.18
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 02:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T8nciUc8CZatwsIcO9/4eEiZ8bMkuaFivBC0TXZp8IU=;
 b=H2hUEbuajiZGqGj5XZV/ImO+l50DM0pBZrjuRz2tbnN5yPDiQgshqDsHEXkh7sWV1m
 yu5Gvm88lLXhMDgzPM+iJ/eHpDh7GryK3QxvbVjoJd8Oe/mnfKLT1mSAfjdgBfq47NhM
 4wlmB3npaldWHKr7ZjSna20r7bxJ+8ZxU2Ob+VyGJpESZwiHVRvi40l4fSEqszBjI7nS
 1GfFIdraL5UslHpD2ioeuCpI1BIb69QIiIV5B5IU6lGeF9pYfxecMCgmiEPv5cVn24Ew
 y11+NRtf5lsiMZpHYxmfWXStYUNtdcwJ+Mat4naWdIi32BfXk+1EOJOIaybmdd83dohx
 UJOg==
X-Gm-Message-State: AOAM531xPvSXbhmxGZ1E1sxyXujLoIzsZgteqmBPt6F/Nozvq4zsgg38
 sl5LSZ81xKEKLA12erz0MYf9Q7+AGVC4h/r1b/xGa6+NtxRXETNtxv+qebelovrMqxt+3A3/h8R
 qu7tli3PKD7SfIuWrgPlIhp77TmQ=
X-Received: by 2002:a25:15c3:: with SMTP id 186mr1885139ybv.71.1641984419912; 
 Wed, 12 Jan 2022 02:46:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeArkLCwvolQn4FehujpcQ6V/VmpHGQapIwtBIHx5ITDzTAEKv/cwwt5C/CwQnYcC1WSk3ujq3MFWOk1ciR4Y=
X-Received: by 2002:a25:15c3:: with SMTP id 186mr1885121ybv.71.1641984419698; 
 Wed, 12 Jan 2022 02:46:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <f69cdd6ec3cffc8d2bd5990feb131eb6be73a33e.1641376050.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <f69cdd6ec3cffc8d2bd5990feb131eb6be73a33e.1641376050.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 12 Jan 2022 18:46:44 +0800
Message-ID: <CAEemH2fdx8cf_w6-BxJP0vHuveBuo0Eqjh5swqj4t60_hz7OYQ@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] API/cgroup: Add cgroup_find_root helper
 function
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

On Wed, Jan 5, 2022 at 6:00 PM Luke Nowakowski-Krijger
<luke.nowakowskikrijger@canonical.com> wrote:
>
> Add a helper function similar to cgroup_find_ctrl to make matching paths
> to roots more convenient.
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  lib/tst_cgroup.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 166d0f97e..b06ae6ab7 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -365,6 +365,19 @@ static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
>         return ctrl;
>  }
>
> +static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
> +{
> +       struct cgroup_root *root = roots;
> +
> +       while (root->ver && strcmp(root->mnt_path, mnt_path))
> +               root++;
> +
> +       if (!root->ver)
> +               root = NULL;
> +
> +       return root;
> +}

I suggest using for_each_root() macro here, otherwise as I commented
it can't parse root in V1.

static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
{
        struct cgroup_root *root;

        for_each_root(root) {
                if (!strcmp(root->mnt_path, mnt_path))
                        return root;
        }

        return NULL;
}



> +
>  /* Determine if a mounted cgroup hierarchy is unique and record it if so.
>   *
>   * For CGroups V2 this is very simple as there is only one
> --
> 2.32.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
