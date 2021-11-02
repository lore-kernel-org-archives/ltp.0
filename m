Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB578C433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:12:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507CF60F24
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 507CF60F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3A6D3C71BC
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 13:12:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 311553C697C
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 13:12:00 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8FCB0100143D
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 13:11:59 +0100 (CET)
Received: by mail-io1-xd34.google.com with SMTP id i143so912759ioa.13
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fn6VCWJKrMzaFmQK8GLB33tUNtwhxadTYh4FOgZm2Ag=;
 b=UPijd0mKp+LahYTijRQLOZN/BxmOiojYbfQtMVV1Us/9/kx6VB9m19G+q5eLZOf5dQ
 KDIoDItTGMwE7q+glhhQ4LrlHueit5VaYZWn9ZWds3tuJrcxpNoaCEJGlirthTwuhLW2
 lgsCfbuYkY10xX2c8WI0mIb7LTq3ILxiw1Z+QIq4XdikTPUyKxIIreU2kzfmxo9W/eHf
 l5PF8FZz9R1ekislHMJKlpJe5qDP1fFJazCFTottw5MrcTyL7B8M8v+XzMMYb32By/Jr
 upPg4lDpw9ePOd04Eh3tRJhtU8aFubPwh7h7YfB5PAz8BsAw7574NhYzsADrqB5HwpCQ
 NJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fn6VCWJKrMzaFmQK8GLB33tUNtwhxadTYh4FOgZm2Ag=;
 b=4Yi+C7XmuuBahSziX7nPocfoXtFuu6QbKLAtC4RrYSrRYXfCwAqKsoaUxwc0fAs4oC
 6DmD4xz2LpZcfHyf+0FT03TuXUzJ4+HvE0KTZ3/zPC7VhpFXSLHAB0tETQcRwF9kxvyP
 4haK6VGc0vwY1tVLvOVXNW9uwDOWts6pWdqavNZt0zXp2RpBkviQO/fiR6pT79ue72zw
 9iTelOPViYUDwrRrb5WAvD7U3I3z/KzZ50hLMD1KEou5lD8pfFunwXd2eo0PvexSjMVp
 p+cw8wKASTGDJUYpqqykoJkcP1qzrTF9lZY0TXy1ys3TGKaySq7ThfXWicFcbTUPuJfr
 c7Ww==
X-Gm-Message-State: AOAM531+oD7foTmFsoXW1O74naNntTISD8wwWU1rvUJ0a6Ph016i5xYw
 B41nmbBNBL4rGxvMbG40puSMJo/0pDv4S8dwqh5edHThbX4=
X-Google-Smtp-Source: ABdhPJxa2GjFYbDA6gWIogLfCR8jiI7YRd2StQaWfjDYqvBDNyeW+8ADxMDPNPl8R0EvCYs67H6Jv0zMQT1Ffft+mUI=
X-Received: by 2002:a5d:804a:: with SMTP id b10mr23505059ior.197.1635855118330; 
 Tue, 02 Nov 2021 05:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-3-krisman@collabora.com> <YYEoAr743j3IO3ol@google.com>
In-Reply-To: <YYEoAr743j3IO3ol@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Nov 2021 14:11:47 +0200
Message-ID: <CAOQ4uxiSKNcxWBu+MdhOzhYWmLC9Aj2zoquUhTVn0q2x2SbxCw@mail.gmail.com>
To: Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/9] syscalls: fanotify: Add macro to require
 specific events
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 2, 2021 at 1:59 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Fri, Oct 29, 2021 at 06:17:25PM -0300, Gabriel Krisman Bertazi wrote:
> > Add a helper for tests to fail if an event is not available in the
> > kernel.  Since some events only work with REPORT_FID or a specific
> > class, update the verifier to allow those to be specified.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> Made a single comment, otherwise this looks OK to me.
>
> Reviewed-by: Matthew Bobrowski <repnop@google.com>
>
> > ---
> > Changes since v1:
> >   - Use SAFE_FANOTIFY_INIT instead of open coding. (Amir)
> >   - Use FAN_CLASS_NOTIF for fanotify12 testcase. (Amir)
> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify.h   | 17 ++++++++++++++---
> >  testcases/kernel/syscalls/fanotify/fanotify03.c |  4 ++--
> >  testcases/kernel/syscalls/fanotify/fanotify10.c |  3 ++-
> >  testcases/kernel/syscalls/fanotify/fanotify12.c |  3 ++-
> >  4 files changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index c67db3117e29..820073709571 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -266,14 +266,16 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
> >       SAFE_CLOSE(fd);
> >  }
> >
> > -static inline int fanotify_events_supported_by_kernel(uint64_t mask)
> > +static inline int fanotify_events_supported_by_kernel(uint64_t mask,
> > +                                                   unsigned int init_flags,
> > +                                                   unsigned int mark_flags)
> >  {
> >       int fd;
> >       int rval = 0;
> >
> > -     fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> > +     fd = SAFE_FANOTIFY_INIT(init_flags, O_RDONLY);
> >
> > -     if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
> > +     if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
> >               if (errno == EINVAL) {
> >                       rval = -1;
> >               } else {
> > @@ -378,4 +380,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
> >                                   fanotify_mark_supported_by_kernel(mark_type)); \
> >  } while (0)
> >
> > +#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
> > +     if (mark_type)                                                  \
> > +             REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type);       \
> > +     if (init_flags)                                                 \
> > +             REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
> > +     fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
> > +             fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
> > +} while (0)
> > +
> >  #endif /* __FANOTIFY_H__ */
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> > index 26d17e64d1f5..2081f0bd1b57 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> > @@ -323,8 +323,8 @@ static void setup(void)
> >       require_fanotify_access_permissions_supported_by_kernel();
> >
> >       filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> > -     exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
> > -
> > +     exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM,
> > +                                                                   FAN_CLASS_CONTENT, 0);
> >       sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
> >       SAFE_FILE_PRINTF(fname, "1");
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > index 92e4d3ff3054..0fa9d1f4f7e4 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > @@ -509,7 +509,8 @@ cleanup:
> >
> >  static void setup(void)
> >  {
> > -     exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> > +     exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> > +                                                                   FAN_CLASS_CONTENT, 0);
>
> I'm wondering whether this is the best combination of mask and
> init_flags to use in this particular case? Maybe not to confuse future
> readers, using FAN_CLASS_NOTIF explicitly here would be better, WDYT?
> It doesn't make a difference, but it's something that caught my eye
> while parsing this patch.
>

Wow.
I think you are right in that this test does not use the combination
FAN_OPEN_EXEC with FAN_CLASS_CONTENT group, but it is quite hard
figure this out.

It will also be quite hard to figure out if this ever changes if ever new
test cases are added, so it will be hard to catch a change like that in review.
Given all that I would not change the requirement.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
