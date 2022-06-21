Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CD0C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 03:02:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D3B33C93BA
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 05:02:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F9653C8D43
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 05:02:30 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5E85C1400973
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 05:02:30 +0200 (CEST)
Received: by mail-vs1-xe2e.google.com with SMTP id r12so12482350vsg.8
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 20:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NJerPTq078DJLa1/5hyKjJHRkGPlUs6wW4pK67FiTLA=;
 b=RaK8QBKRfA+OMUUU3hJlDkW39Rk7zpkxVerF6JCYsjbrXhViF7EXjqlumtMNQXJ3CO
 dmQtPiLwYkfZc3ueP3wGTYn3zqoCgjAgMZt+en6vOE0yk1YS87bAZtlMKg7u9pxHnXmV
 7LHxfHvaSsrPe6G70cFIEoulPjDeUunP8VnGQtFxw+q73HdxXHGV+hKaS5U4xj2gD9Hv
 Qtucbe8J4sL+AYf0sVuK8piCF60HndOHX+biVYCLYeJF+KCZ1VMcyT06QMOFeJX3vEQw
 82uTERHja2jSRAtnSYqRvofICE1uZURQUjnF+6DkFqemR2BQ5RQBkFQhgBZLdeXYWJkf
 VabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NJerPTq078DJLa1/5hyKjJHRkGPlUs6wW4pK67FiTLA=;
 b=ZbL61H5YeSH+rWIc7lEze6hIM3aPd8HwHUE9UIEa47aSbmR9q1UBW2/odoiPdPldGh
 Dcfvr3AUXtw0jRk3rtsqKbvCsGBeF0I85JE7ANxV/X4P2juyCPTFt1RMg15+Puvq1J8p
 9d1/gVWmZaSzHk499DvlG6lhth2GleEk53SazZpXC+JnFcGyL8s63F/rCpCjV8AJK2RF
 MvphdCMYFWKv8eFDxcdR3rnzK61drTNN3MgRQq6PtnGLF90xViMJSOZ/J4wfES0AOgOA
 Y2kVoauDdCFgdhctr9lwlwJex0vrDwB8Nc7TA1Kl2QQZ2kqulfWeXheylPh5q+AQambK
 cwHg==
X-Gm-Message-State: AJIora+Ya8rCwRdedMOmZZ89mUSX8coCrTpU9s2Dwq3PdRngRKWouEw9
 3czAq3Z+6lhQiGdzF//lduHhzcDaUxwsO21BRJ8=
X-Google-Smtp-Source: AGRyM1ueoDXdSFk7Ales17n2LjoqsyVK4Qmlu9oKl7cxZYZBnnpvqBJMitf9RCfl/hPXTXD8Jauxo5Z782lLLKapMyg=
X-Received: by 2002:a05:6102:c50:b0:34c:2063:ae5e with SMTP id
 y16-20020a0561020c5000b0034c2063ae5emr10343058vss.71.1655780549203; Mon, 20
 Jun 2022 20:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220620132737.2015073-1-amir73il@gmail.com>
 <20220620132737.2015073-5-amir73il@gmail.com>
 <20220620152032.jbrhicuscem2f4kd@quack3.lan>
 <CAOQ4uxgmuS6qDVLQPqzNAoO2BtqcO55Mokcc70n2BukAhaH_Xw@mail.gmail.com>
 <20220620203545.hejk7faw3liw2kxw@quack3.lan>
In-Reply-To: <20220620203545.hejk7faw3liw2kxw@quack3.lan>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Jun 2022 06:02:24 +0300
Message-ID: <CAOQ4uxg_F+BeuYou1CTM-UMURiFpW362=f7-FJD5MKXDJpw=4A@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] syscalls/fanotify09: Add test cases for merge
 of ignore mask
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
Cc: LTP List <ltp@lists.linux.it>, Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 20, 2022 at 11:35 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 20-06-22 19:59:48, Amir Goldstein wrote:
> > On Mon, Jun 20, 2022 at 6:20 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 20-06-22 16:27:37, Amir Goldstein wrote:
> > > > 1. Verify that an ignore mask that does not survive modify event,
> > > >    does survive a modify event on child, if parent is not watching
> > > >    events on children.
> > > >
> > > > 2. Verify that an ignore mask on parent does not ignore close events
> > > >    sent to mount mark, if parent is not watching events on children.
> > > >
> > > > The behavior of these corner cases of ignore mask on parent dir have
> > > > always been undefined, so do not run the test for kernel < v5.19.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Hum, I was looking into the testcase. What does generate a modify event
> > > there and checks that ignore mask does not survive it?
> >
> > I think this does:
> >
> >         /*
> >          * generate MODIFY event and no FAN_CLOSE_NOWRITE event.
> >          */
> >         SAFE_FILE_PRINTF(fname, "1");
>
> Yeah, I was looking at that but then I'm somewhat confused because this
> gets called in .setup() hook while the notification groups get created only
> in .test() hook that gets called later. What am I missing?

There is one in setup().
The one with the comment above is from test_fanotify().

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
