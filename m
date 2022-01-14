Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5135C433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 06:57:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1503B3C952C
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 07:57:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B27F33C19EF
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 07:57:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E03BE600C26
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 07:57:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642143441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OiSFbJuB/GvB72UyAkdShZrGKJkYr/vcU7qRo3K5eYg=;
 b=POTt6LpdcZ8y3gSeW7/yz5K7174Kb5gs0rXAZSBpbXAAesp2j4xfWX8MWUcZdVc4ZUVNf3
 FeNm3QwpKUT5N1L3ZAr9GE7L9O7Qq9wq4+pBjjbmkAtBWDFOmz1O2KDxQQ+JUslBDtNKlU
 0L3PKXhPRXv+0Fruht8gxWivnBdNRW8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-OUg-ePgUMfCjNlhP8i9vGQ-1; Fri, 14 Jan 2022 01:57:19 -0500
X-MC-Unique: OUg-ePgUMfCjNlhP8i9vGQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 q185-20020a25d9c2000000b00611ae9c8773so12702702ybg.18
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 22:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OiSFbJuB/GvB72UyAkdShZrGKJkYr/vcU7qRo3K5eYg=;
 b=z6KKBiahmMWQZab5x7g9ngcHq2pfhl72no6968Q5v/OWSM/YhD+TpuzC6VFZ+d3ROd
 DdwhtxKlb09oYvD8rj7FF9/jjMrv331wH1Er3PufdauuEJ7pewDsCDS1ysBUrQ2lpR46
 6bbOgCGvjGcoEq1r4l3TJV0+4oQu/RYHwhjAwRdv/jHDEJQ1gPnMil5ArvldOCXyfYRx
 re3RnGBC1ol3wD7+rilKdR3Ar4OF28X3DDxX7bxsLJTSwRDL6RJ5mnbcnDJtPwGlRetv
 +kAbv02gehaNIpuRmrNf3TANfqXMj0ofG3Pe9MDNK3fGrgw5RzaWrwn0xP15xPL2UjwD
 xS1g==
X-Gm-Message-State: AOAM5330UVZXbRsbbTgq2oECYf+i4Nr3HyrHGtYva/zPr0JeG5xGl3pk
 zeTu0my4QP0tYU5yk3NWVL18xAyER68V2Ta5s9K8GJUi+Rtyv9v01CYi1tNY4lGaaV3Wnv8N6Ga
 b0qqiSTBLHzHq4BV/biMutAz3Z4U=
X-Received: by 2002:a25:388a:: with SMTP id
 f132mr11012693yba.102.1642143439360; 
 Thu, 13 Jan 2022 22:57:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgdw8S+mqa9gsFI/4EIh2IZv+iLb4Q+a4l3w2eMY1jzXNr53Pcy9JPzRoPYFB2aA4J/bufby0KthFAIDaDsbE=
X-Received: by 2002:a25:388a:: with SMTP id
 f132mr11012679yba.102.1642143439099; 
 Thu, 13 Jan 2022 22:57:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <39c482de2c75e393fa53c31d06620995dabc5284.1641376050.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <39c482de2c75e393fa53c31d06620995dabc5284.1641376050.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Jan 2022 14:57:04 +0800
Message-ID: <CAEemH2dhHo7nPWG7EKsRa055et6eAWGpD_8uLP3VG89nhNNuJw@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/6] API/cgroup: Implement tst_cgroup_load_config()
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

 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:

> +static int parse_root_config(char *config_entry)
> +{
> +       char *key;
> +       char *value;
> +       struct cgroup_root *root;
> +
> +       for (key = strtok(config_entry, " "); key; key = strtok(NULL, " ")) {
> +               if (!(value = strchr(key, '='))) {
> +                       if (!(root = cgroup_find_root(key)))
> +                               tst_brk(TBROK, "Could not find root from config. Roots changing between calls?");
> +
> +                       continue;
> +               }
> +
> +               *value = '\0';
> +               value = value + 1;
> +
> +               if (!strcmp(key, CONFIG_MOUNTROOT_KEY) && !strcmp(value, "yes")) {
> +                       root->we_mounted_it = 1;
> +

> +               } else if (!strcmp(key, CONFIG_LTPDIR_KEY) && !root->ltp_dir.dir_name) {
> +                       cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir, &root->ltp_dir);
> +                       if (!strcmp(value, "yes"))
> +                               root->ltp_dir.we_created_it = 1;
> +
> +               } else if (!strcmp(key, CONFIG_DRAINDIR_KEY) && !root->drain_dir.dir_name) {
> +                       cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
> +                       if (!strcmp(value, "yes"))
> +                               root->ltp_dir.we_created_it = 1;

I think that parsing the  CONFIG_DRAINDIR_KEY from '$_cgroup_state'
is superfluous. Because from the tst_cgroup_cleanup, if
root->ltp_dir.we_created_it
is 1 then both of the two directories will be removed, so just using
CONFIG_LTPDIR_KE
to track the status is enough.

And maybe it is not necessary to print "Created_Drain_Dir=xx" in
tst_cgroup_print_config at all.

Then, the code snippet could be as:

                } else if (!strcmp(key, CONFIG_LTPDIR_KEY) &&
!root->ltp_dir.dir_name) {
                        cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir,
&root->ltp_dir);
                        cgroup_dir_mk(&root->ltp_dir,
cgroup_ltp_drain_dir, &root->drain_dir);
                        if (!strcmp(value, "yes"))
                                root->ltp_dir.we_created_it = 1;


> +
> +               } else if (!strcmp(key, CONFIG_TESTID_KEY) && strcmp(value, "NULL") &&
> +                                  !root->test_dir.dir_name) {
> +                       cgroup_dir_mk(&root->ltp_dir, value, &root->test_dir);
> +                       root->test_dir.we_created_it = 1;
> +               }
> +       }
> +
> +       return 0;
> +}




--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
