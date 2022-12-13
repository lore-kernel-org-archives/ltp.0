Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84023C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 08:56:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E925A3CBDCE
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 09:56:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01A973CBD7E
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 09:56:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1587B60015F
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 09:56:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670921768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WDxdthp+JM6mL+nnA79ZYWqQJe7Siug7L2SXnZpO+zk=;
 b=cc4wZCYG6f2IBF7ZeiIrYk7CtF0OFsUd/te6LVtXURCbDFUFGK+Rh83FuHUT+als7sFlKY
 DcSmbTIvhzjEih+KyjjDOjLn46Ap8ct+WisdkGhmCoyMDBIfq7oxMxdHoOMQ+3RUATN9nL
 yv7nj0KnkAb0FTtwYoFKOsoaLXB1muU=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-lfgumLpLPqqwmEor2GoueQ-1; Tue, 13 Dec 2022 03:56:07 -0500
X-MC-Unique: lfgumLpLPqqwmEor2GoueQ-1
Received: by mail-ua1-f71.google.com with SMTP id
 h41-20020ab0136c000000b00419beaab4a3so6430155uae.5
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 00:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WDxdthp+JM6mL+nnA79ZYWqQJe7Siug7L2SXnZpO+zk=;
 b=clNHQjEUPU0vpYfs2J2bNc/RvkSKM8ALhD17AoIe7+L6jpDkOUC2hWeD6xQHdmZm2H
 LzBe/nEMj9giKo13dYGreJfoIq17jC077ehsnDum4gCy7yHpcHVD6SR+aAL5q+4JiZtf
 vSRDTX0bxlm9+ejkAvJ8sbFmmEF4kUKc8k+sYbliFQ95IbjNROYH9h039Y4BBMuSCG0X
 AacPbYA/Lvi3V+g8slQ9eShK1f86AHvkam7PDWpnmlDDQKLWXw+zjWJfs/hwGv/eQ7E5
 b7Nz9S2reV8YnkKUIieTFZnzjhBLk71lQEi/j3kCMyZ1v+W2DofpiwFU+LQBQjL6NJvo
 Te8A==
X-Gm-Message-State: ANoB5plCujBx1krjFR9ACDztjRc3GVI+rmCumnr85/lmUfnJURwOIEVv
 dbBUYlb7XXiN1KzPSsxd5MOa+Z5pFKRllH1NUvbsDBS47zESstaVSO8n/t/UfcDmj8Vp2E2anpO
 oUBZI1+ylSTeZ6/ayidwZ/A578YA=
X-Received: by 2002:a1f:f2c9:0:b0:3bd:81b2:a561 with SMTP id
 q192-20020a1ff2c9000000b003bd81b2a561mr13017437vkh.8.1670921766847; 
 Tue, 13 Dec 2022 00:56:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5QWeQuIlKhtnVw/lcu18EWRpUP4BtAJzCDXMu7siYyX+XbhO1eH/SZWieSnAgxXlD10yZeknTxbd2CcIuss2k=
X-Received: by 2002:a1f:f2c9:0:b0:3bd:81b2:a561 with SMTP id
 q192-20020a1ff2c9000000b003bd81b2a561mr13017430vkh.8.1670921766501; Tue, 13
 Dec 2022 00:56:06 -0800 (PST)
MIME-Version: 1.0
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5dJDFk5DpAhTKDV@pevik>
 <CAASaF6wrx+0bkVa2_sSViOYHE25O08GbW_Jy2MQBfWKuJWtZkw@mail.gmail.com>
 <b4b93a47-d106-3a65-939d-230fee359f13@fujitsu.com>
In-Reply-To: <b4b93a47-d106-3a65-939d-230fee359f13@fujitsu.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 13 Dec 2022 09:55:49 +0100
Message-ID: <CAASaF6wpj3YcJ1gX4g6n7koXL0WnX=9td5RqSjNumrCB+ncmhw@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
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
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Dec 13, 2022 at 3:31 AM xuyang2018.jy@fujitsu.com
<xuyang2018.jy@fujitsu.com> wrote:
>
> Hi Jan, Petr
>
> > On Mon, Dec 12, 2022 at 4:30 PM Petr Vorel <pvorel@suse.cz> wrote:
> >>
> >> Hi,
> >>
> >>> Our travis-ci has dropped or never used them, they are useless.
> >>> So delete.
> >> They were here before CI. They were meant for using by tests
> >> (no CI related at all).
> >
> > Right, it's not just CI. RHEL5 is EOL, presumably Oracle as well, so
> > those likely won't be missed.
> > RHEL6 has 2 more years - Isn't this removal going to break tst_kvercmp2()?
>
> I have removed tst_kvercmp2 usage for RHEL6 in
> testcases/kernel/syscalls/inotify/inotify04.c and
> ../kernel/tracing/dynamic_debug/dynamic_debug01.sh, so it should not
> break tst_kvercmp2.

OK, you convinced me it's OK to drop it.

>
> Also, the current lastest ltp can't ensure that can be compile
> successfully on rhel6 because of lack of ci, so I think we don't need to
> still maintain the old version check.  If people want to use old kernel
> ie RHEL6, why not use the old ltp release?

They can, but they also likely want fixes to tests. I know there have been
some workarounds, such as using pre-configured LTP to workaround
autotools issue.

>
> ps: @Jan, if you want to keep RHEL6, I will keep it. But two more years,
> we still need to drop it.

You showed this isn't significant change for those few users that still might
exist (and EOL is coming), so:

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
