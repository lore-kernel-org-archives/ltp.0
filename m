Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DAAC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 17:00:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6948E3C937A
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 19:00:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 708B33C920D
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 19:00:01 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BEAE4200279
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 19:00:00 +0200 (CEST)
Received: by mail-vs1-xe31.google.com with SMTP id j6so2938546vsi.0
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AqLdcTyOwARJlxiVMZbtVs6cLsScSWdQklKECh/6Om8=;
 b=k/lHIvOeHiJmTaQ/2fFjyAwHAMq/PGThWv3OfIAsxOjwDsnX382difXIhweKhp8Vln
 pcH66HB/psGV+8I1xDf93u/v+qseXCgpM2xlb/C1ggHrxIVm6EQMb61aN6mjK3tXNxLF
 g/59xXE2hKNDmwOCzNrYO0baXgqHilWFFSuJBfKMN3Msv8bNe0kORXycRFSha67AeA3x
 riwgUIaiTFfHplUfkciDW80WxxD7c4s+ppRXO4q1gqBcaXsMx3Sl7nar0ddu0WZtW8uM
 UMLDZDiYzi/4vDj1OapL5SP2PdVLn6oi75TJxHGrjJzdA6tpEQnr7JuIgEGamcWOFkHK
 3/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AqLdcTyOwARJlxiVMZbtVs6cLsScSWdQklKECh/6Om8=;
 b=lbym86BaWEtIuK/0CciWr2YhdisY/KpJ2R408bXF3TmgGJ4fRCHep85FCVBhRCfIVC
 JARcueObJbDqryFHRmSdyplbSmi4klAk/vau7fYA41GCjbq+5MIE1VvUSaAyZqIDaXSx
 ZPzTHb9uwwiIU66SC66uQwYqr2g4HXPVS/hXpO0XG8AEP2LLxLPo6ARmmgbyvEOMTk2z
 q68CGOPe0OCjQfzYpzM84fpy6HATm4fZN/Jqw/7ZvaDj5pxJE1bgsnw9LLr0csXdMBMc
 +ESrZiZnTgcQR1quHbsuVMieVTZsiQncNM4pqeD5FJhNRs1egc9ZpwlqHQocH1h1Q+Fu
 sTaQ==
X-Gm-Message-State: AJIora9uaWoFx9IkqsEvUBb2zJVBbMd7qt8NzefTjw8Q2kjBWuoVAF4S
 urOurpE1Q3/L2PyiibAGV8CId0tVw1O2brMHLug=
X-Google-Smtp-Source: AGRyM1uPNN+LgJueobcm3Bbf23A/YnwDwVVExHjJUxS+eNCbJsjZoU6S6Q1yAZ+Ex2Gim8JMG5U17PBExnmflW3WEqk=
X-Received: by 2002:a67:cd0f:0:b0:34b:cb17:892c with SMTP id
 u15-20020a67cd0f000000b0034bcb17892cmr9506935vsl.36.1655744399540; Mon, 20
 Jun 2022 09:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220620132737.2015073-1-amir73il@gmail.com>
 <20220620132737.2015073-5-amir73il@gmail.com>
 <20220620152032.jbrhicuscem2f4kd@quack3.lan>
In-Reply-To: <20220620152032.jbrhicuscem2f4kd@quack3.lan>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Jun 2022 19:59:48 +0300
Message-ID: <CAOQ4uxgmuS6qDVLQPqzNAoO2BtqcO55Mokcc70n2BukAhaH_Xw@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

On Mon, Jun 20, 2022 at 6:20 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 20-06-22 16:27:37, Amir Goldstein wrote:
> > 1. Verify that an ignore mask that does not survive modify event,
> >    does survive a modify event on child, if parent is not watching
> >    events on children.
> >
> > 2. Verify that an ignore mask on parent does not ignore close events
> >    sent to mount mark, if parent is not watching events on children.
> >
> > The behavior of these corner cases of ignore mask on parent dir have
> > always been undefined, so do not run the test for kernel < v5.19.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Hum, I was looking into the testcase. What does generate a modify event
> there and checks that ignore mask does not survive it?

I think this does:

        /*
         * generate MODIFY event and no FAN_CLOSE_NOWRITE event.
         */
        SAFE_FILE_PRINTF(fname, "1");

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
