Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52C2C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:13:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4ADCA3C9266
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:13:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 152D43C0E02
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:12:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CC6C51400535
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:12:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640081567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4HmJVj+D8rKYFxeNKWujQ2oMiArUKj+iC4CwqCXC1lk=;
 b=Hid+vW28c9Rm7LlWRMP5akztkCiUH46dZYIH4yrwYlMSShhKXZWr+iWMT1c4Q4Ea5shJld
 LDmiT9BHytgzAHuwTzLutUN2yhRjIt/AuEJp3icAeIbDEXCzH3WatG11Rn7xHhCgvuGqY+
 VvpHlnZhO9Jys2QLiEHEXA+22varGM0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-p8sEJ3F5OUaNsk8orgMxBw-1; Tue, 21 Dec 2021 05:12:46 -0500
X-MC-Unique: p8sEJ3F5OUaNsk8orgMxBw-1
Received: by mail-yb1-f200.google.com with SMTP id
 i187-20020a2522c4000000b006093b616e65so23166446ybi.17
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 02:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4HmJVj+D8rKYFxeNKWujQ2oMiArUKj+iC4CwqCXC1lk=;
 b=4Q1YUzgiriNe9dsMXCtU2MjCFnx2/EsHOvwIDHuqqnok+8/hNzCicxuXmM9Yru5AyK
 zNTutpM9Q/od5uqRwJUyDOAkhJt1Cth9aoJGWQlbUZTFw4Wp2e10vbSqOPNde583muhr
 23KL2jhPm4m1ccrLG2u5hCHvro69sw62lph0tyWRSXk/bL7Rw1LiKMp5kM7taJBGTRlI
 H5j12CL+8cM6WZQgTzx3RDbrTjDc/QN1R/2hvVLz9CvlbmF1GGtujwfSi6WWGgNj9tbS
 Opgm6rDAB9hYe+g2T+4AjkBiMXTlzWellmi7xaqtKAye/+fhvdc+1gLdAVIwjCh3thzd
 AZLQ==
X-Gm-Message-State: AOAM533h3l5Vh5Q0g4A3JKf2AVWC86CC351XWzinrwHoslZ6+utKRZje
 2LMWJPT2lMJD1X5AgTM53+hJ5PjXOkbFLZpIdkC2/JNlC6gYYvRnfnULrye6ShD95YSijolzoyV
 TMkw5T5xEXbf9rH3+oX0/wKhe9uc=
X-Received: by 2002:a25:8c9:: with SMTP id 192mr3531548ybi.102.1640081565605; 
 Tue, 21 Dec 2021 02:12:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiNFpiWHIfhL9Wm+ncvdMrWTJfMWeLCpV6u59W8ydsqLwSp4jfAD2FYysHi56mrN0LfKt0fyrX5pXybrOPZ0Y=
X-Received: by 2002:a25:8c9:: with SMTP id 192mr3531524ybi.102.1640081565399; 
 Tue, 21 Dec 2021 02:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
 <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
 <YcGb5abUqe8PNKoM@yuki>
 <CAEemH2dDEM30-fM89LDZq1E7YN8rf44doGgnkPXuce0ttP67OA@mail.gmail.com>
 <YcGlb4NoDGSP4ZkU@yuki>
In-Reply-To: <YcGlb4NoDGSP4ZkU@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Dec 2021 18:12:33 +0800
Message-ID: <CAEemH2fFY_TuCEqoR9ogqUBA5mFjY-FX+tDufYs39uN0JJ9gvQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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

On Tue, Dec 21, 2021 at 5:57 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Not exactly, if someone gives a wrong PID, that also cannot find
> > the score_path. So we shouldn't skip OOM adjustment only
> > with printing the TFINO.
>
> Right, we would have to check if the /proc/$PID/ directory exists
> first.

Not necessary, because we did check /proc/self/oom_score_adj
already, otherwise, we have no chance to get here.

> > +       if (access(score_path, F_OK) == -1)
> > +               tst_brk(TBROK, "%s does not exist, please check if PID is
> > valid");
>
> Maybe we should print the pid in the message here as well.

Yes, and the score_path will include the pid, here I forget in the sentence.

> > +       if (val != value) {
> > +               if (value < 0) {
> > +                       tst_res(TINFO, "Warning: %s cannot be set to
> > negative value,
> > +                               please check if test run with root user.",
>
> I would say that we TBROK here, otherwise it could be silently ignored.
> Also I would shorten the message to something as:

Hmm, maybe tst_res(TWARN, ...), is enough, I don't want to
let people who run LTP in ordinary users get TBROK here
since they might even don't need the oom protection.

So, I will push (the improved) code like below, after getting
Petr and you ack again:

+static void set_oom_score_adj(pid_t pid, int value)
+{
+       int val;
+       char score_path[64];
+
+       if (access("/proc/self/oom_score_adj", F_OK) == -1) {
+               tst_res(TINFO, "Warning: oom_score_adj does not exist,
+                               skipping the adjustement");
+               return;
+       }
+
+       if (pid == 0) {
+               sprintf(score_path, "/proc/self/oom_score_adj");
+       } else {
+               sprintf(score_path, "/proc/%d/oom_score_adj", pid);
+               if (access(score_path, F_OK) == -1)
+                       tst_brk(TBROK, "%s does not exist, please
check if PID is valid", score_path);
+       }
+
+       FILE_PRINTF(score_path, "%d", value);
+       FILE_SCANF(score_path, "%d", &val);
+
+       if (val != value) {
+               if (value < 0) {
+                       tst_res(TWARN, "'%s' cannot be set to %i, are
you root?",
+                               score_path, value);
+                       return
+               }
+               tst_brk(TBROK, "oom_score_adj = %d, but expect %d.",
val, value);
+       }
+}


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
