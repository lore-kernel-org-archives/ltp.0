Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E642C433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Apr 2022 12:56:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5FC33CA49D
	for <ltp@archiver.kernel.org>; Wed,  6 Apr 2022 14:56:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0E593CA453
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 14:56:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6D2E71A00CBC
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 14:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649249781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elRO2HN9cCHKp7/tZDive8TJ1zfe2EjYYWqUtLLnVaE=;
 b=eO6WQ/OLLq9xFKxbW2vlAyJWtW1p9nEBNj7xZgp3V4ib+UR5sZlZswcox7NvOGuegc1Hch
 JfWcN6s7u7qQfOSmo0DHlvTPlCxInNn0aGCNOlIc+GEsYREshVQIMmlsgFoiFZRyv92M2Y
 7qVD+QJTpMezaAbcZ5raYumDzDQCGws=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-yO2cRiqRM8C8xzJ6Pu2q8A-1; Wed, 06 Apr 2022 08:56:20 -0400
X-MC-Unique: yO2cRiqRM8C8xzJ6Pu2q8A-1
Received: by mail-lf1-f71.google.com with SMTP id
 d41-20020a0565123d2900b0044a10c21f39so810085lfv.22
 for <ltp@lists.linux.it>; Wed, 06 Apr 2022 05:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=elRO2HN9cCHKp7/tZDive8TJ1zfe2EjYYWqUtLLnVaE=;
 b=4Cp62XTAYYGCfXzFgW5AZ21SStWGW2wDgMFTwl0LIHRZ7/V/3nFY5tbenF2Fwg/bLN
 YPt1bjqsqR8Ae0BBeWbPyYTDd+qRZEsbSbtjJqI0bdgZi6a9JVIuTO2GvNKbYw7s3pFz
 Rma9M7p6SfFd2x5vB1/kC5pDVPk8wm3wI4p2rup1h0J/7FSmuwVYjD71wCEuafKEMtEO
 C4c0FIsiS4ijZNJW4w6iSOB0I6HJZSyyi+SJ0GzQSGYfwAkDGEroOFLiriBkLy9TeEIj
 t3qBea/ZeLjJ/Drz8hmTx2nNCUrUr2rpIp5SlCQLRss+3hgYxTjAiJWcKD5B0+5lpGqN
 0QDw==
X-Gm-Message-State: AOAM532VqF4vcogOps9NPlGPZsSwiX2hUFLe40HPgl7TS2Jy9COtkzTB
 pOlZnpwvuhxxYBbLQgo3adMZQBFPkCLj/ycjJL1EnzF6Xr0w4TY9f2JCR4gkKQlYIJ3K3sRWEYZ
 0u673LkEST4OE89jNy+D6OrbfDWA=
X-Received: by 2002:a05:6512:250:b0:44a:47c6:96a7 with SMTP id
 b16-20020a056512025000b0044a47c696a7mr5709084lfo.46.1649249778574; 
 Wed, 06 Apr 2022 05:56:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5LatDm5BRW3geCHIpKrfKPB9AWYPsxfxwheLhkbIdAtj/AmgyajxEtcazHsaxz4hJcgLOVdxPBhc4vowc7nM=
X-Received: by 2002:a05:6512:250:b0:44a:47c6:96a7 with SMTP id
 b16-20020a056512025000b0044a47c696a7mr5709041lfo.46.1649249777779; Wed, 06
 Apr 2022 05:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <1645492786-67242-1-git-send-email-mafeng.ma@huawei.com>
 <YkwdJDzkr3sjt2Ic@pevik>
In-Reply-To: <YkwdJDzkr3sjt2Ic@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 Apr 2022 14:56:01 +0200
Message-ID: <CAASaF6yWtBRY32ZudfS+ktwBY=fwepxM7PUFWGZkiZ5+gVVk7g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syslog: Add TPASS log
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

On Tue, Apr 5, 2022 at 12:42 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Ma, Li, Cyril,
>
> > Add TPASS log to facilitate the analysis of cases.
> nit: in some tests you added both TPASS/TFAIL.
>
> > Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
> > ---
> >  testcases/kernel/syscalls/syslog/syslog01 | 7 +++++--
> >  testcases/kernel/syscalls/syslog/syslog03 | 3 +++
> >  testcases/kernel/syscalls/syslog/syslog04 | 5 ++++-
> >  testcases/kernel/syscalls/syslog/syslog05 | 5 ++++-
> >  testcases/kernel/syscalls/syslog/syslog06 | 5 ++++-
> >  testcases/kernel/syscalls/syslog/syslog07 | 5 ++++-
> >  testcases/kernel/syscalls/syslog/syslog09 | 4 ++++
> >  testcases/kernel/syscalls/syslog/syslog10 | 6 +++++-
> >  8 files changed, 33 insertions(+), 7 deletions(-)
>
> > diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
> > index 2f3aea0bb..f99c44914 100755
> > --- a/testcases/kernel/syscalls/syslog/syslog01
> > +++ b/testcases/kernel/syscalls/syslog/syslog01
> > @@ -88,8 +88,11 @@ syslog_case1()
>
> >               newvalue1=`grep -c "syslogtst: mail info test" $MAILLOG`
> >               if [ "x$(( $newvalue1 - $oldvalue1 ))" != "x1" ]; then
> > -                     status_flag=1
> > -             fi
> > +                        tst_resm TFAIL "mail info test: messages are not logged to $MAILLOG"
> > +                        status_flag=1
> > +                else
> > +                        tst_resm TPASS "mail info test: messages are logged to $MAILLOG"
> > +                fi
>
> I'm going to merge this fix, thus I'll fix wrong indentation myself before merge
> (it's in more tests). But please next time pay attention to the whitespace.
>
> ...
>
> > index 573ab755e..97f7c54cc 100755
> > --- a/testcases/kernel/syscalls/syslog/syslog10
> > +++ b/testcases/kernel/syscalls/syslog/syslog10
> > @@ -85,12 +85,16 @@ syslog_case10()
> >               tst_resm TFAIL "Expected message was not logged...."
> >               status_flag=1
> >               return
> > -     fi
> > +        else
> > +                tst_resm TPASS "Expected message was logged..."
> > +        fi
>
> Here I'm going to remove useless '...' in newly added TPASS and the original
> TFAIL (and in other tests).
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> @Cyril, Li: do we want to still keep syslog0[1-9] and syslog10 which tests syslogd?
> I suppose so, but I'm asking because they are not using even legacy shell API
> (test.sh) and use several other legacy libraries (syslog-lib.sh, cmdlib.sh, daemonlib.sh).

I wouldn't miss these tests, they always had sporadic failures that
were related to
configuration (rsyslog config, journald rate-limiting, etc.) and lot
of sleep to restart
daemon dozens of times. One sanity test calling syslog() would probably do.

We already cover kernel functionality with kmsg01 and on recent distros
syslog() (or write to /dev/log) is write to /run/systemd/journal/dev-log anyway.

>
> Kind regards,
> Petr
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
