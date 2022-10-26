Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72CCC38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 11:30:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED4633CA804
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 13:30:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0912A3C0475
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 13:30:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3ACA21A00A3C
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 13:30:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666783801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIfhefcaI3x6Pa4grueC+sZIFSD3EnglhppE41A8u4k=;
 b=YwKFJWmjKdYJFDLCxdpW9AeNawz6hS2omWoOweUug02z5KjmSwkNugEKU11k1XDjZpxWO5
 LByaQ6YCblhfc9sgynqhqDMUoxia2md5NtEUkfFotFIwZvnaSktFIGJRYVR+li8t8ErnAr
 DyKd3B8isDwhIiFH+EC9OX72Ijw7eUE=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-SyY9dsDiPlqwB-K5XsacnA-1; Wed, 26 Oct 2022 07:30:00 -0400
X-MC-Unique: SyY9dsDiPlqwB-K5XsacnA-1
Received: by mail-vk1-f199.google.com with SMTP id
 f206-20020a1f1fd7000000b003ab9e0192edso4269537vkf.1
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 04:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fIfhefcaI3x6Pa4grueC+sZIFSD3EnglhppE41A8u4k=;
 b=p9Ho4Py+/b2A7DPbE9D+ivI8TKklMS+Du85+P42ssgASOl9ltnMqRQNHEqwo00i6GZ
 8eWeBUQgWEIs3boozqSLgNbAKEm8u7VAy69Zzuq5iHymlv761ma8XTRDcy6dFoGOd/zq
 hrYnyxs4yHCXGbYAg8Hth450vEk1MkkBLRp9sSp+NwRg8vMotVXizV9Xf0z3dStcDZAY
 wJBWhsx7bwEWOzY7T7D55MUS6ud96vZ27TVrSgne26eQAbqEaMdg7olrfUjzKX5C62BE
 AhySFQmk4DjP9sHyQNe0hbVwg50DDd3VjXrLX3AC1itfxW0lVSb5nNq3Hdz0c7FYgKMu
 oUgQ==
X-Gm-Message-State: ACrzQf2sHVx4nZCNKi6zjNDdRzWaVZn/NIr7neq1XEAzGzyU6WfTyYE9
 aZLmL2AwlPcTK69zuChWhjnKdwC3SRtQF7EXaRYfpCylo5ZmTWfdnsSybzRcISko8QYHXHFEOPE
 TUaFuZ5EhslqP1BOxCIbtOgKqbks=
X-Received: by 2002:a67:e189:0:b0:3aa:309c:7ce5 with SMTP id
 e9-20020a67e189000000b003aa309c7ce5mr5999674vsl.26.1666783799993; 
 Wed, 26 Oct 2022 04:29:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6/eejzjxTi4t3gEqrzDD28Sj//Zr1UOyejD7JtfhPThM44TjyuJwTyO6KE/OnOIUCWs7g3BbS6/wRMR0nieE8=
X-Received: by 2002:a67:e189:0:b0:3aa:309c:7ce5 with SMTP id
 e9-20020a67e189000000b003aa309c7ce5mr5999662vsl.26.1666783799665; Wed, 26 Oct
 2022 04:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221021155740.8339-1-mdoucha@suse.cz> <Y1MCbP1yjLOuoPLb@pevik>
 <CAASaF6ySEcVE=b-7nGy+FeLyg_6dNMjL6J_bivjZ6JYzSx5b=w@mail.gmail.com>
 <3f3dca4e-79d9-9e5b-293f-f27c6644dec8@suse.cz>
In-Reply-To: <3f3dca4e-79d9-9e5b-293f-f27c6644dec8@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 26 Oct 2022 13:29:43 +0200
Message-ID: <CAASaF6xHrcko8Wcq_UAaLY9hscYZAGrSSJe=P07HYoOFXaoTyw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Check whether path is writable
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 25, 2022 at 6:13 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
> On 24. 10. 22 9:16, Jan Stancek wrote:
> > On Fri, Oct 21, 2022 at 10:35 PM Petr Vorel <pvorel@suse.cz> wrote:
> > Problem description makes it sound like this issue affects all 3 types
> > of config options. Isn't the problem affecting only optional config paths?
> >
> > Having entry with "(no prefix)" or "!" in save_restore implies that
> > test wants to write to that path - if we TCONF on root privileges or
> > read/write access probably doesn't make much difference - we can't
> > continue.
> >
> > For "?" prefix, I agree that since its optional, test should be able
> > to run cleanly without root privileges.
>
> It does affect all 3 but slightly differently, depending on the "val"
> field of the respective .save_restore item. The current implementation
> behaves like this without root privileges:
> - (no prefix): If val is NULL, the test will save the data, run the test
> and trigger TWARN at the end.

Is this real scenario? Why is test saving sysfs value, which is then
never changed?
I would expect that in this case, you could drop save_restore entirely.

> If val is not NULL, the test will fail
> immediately after saving sysfile data because it'll try to write into a
> read-only file.

> We'd want TCONF instead in the latter case.
> - '!': Same behavior as with no prefix but we want to keep it.
> - '?': Same behavior as with no prefix. We want either TCONF or to
> ignore the sysfile entirely with a TINFO message.
>
> > For optional path, if test can't read/write it (b/o of no root privileges),
> > I think library shouldn't try to save it - then that would also skip
> > attempt to restore it.
>
> There are be two different kinds of optional paths, though:
> 1) paths that sometimes don't exist but must be written to if they do
> 2) paths that may be left alone if they exist and already contain the
> right value (otherwise TCONF)
>
> So the question is whether I should steal the '?' prefix for type #2 and
> we'll introduce a new prefix later if needed, or whether we'll reserve
> the '?' prefix for type #1 according to current behavior and introduce
> the new prefix now.

The case 2) looks like it could apply to non-optional paths too. So maybe
best option would be to drop "!" and "?" prefixes and turn them into flags/enums
which can be then combined together.

"/proc/sys/kernel/pid_max", 0, val // TCONF if path doesn't exist
"/proc/sys/kernel/pid_max", SR_MUST_EXIST, val // TBROK if path doesn't exist
"/proc/sys/kernel/pid_max", SR_MAY_EXIST, val // if exists, save it
"/proc/sys/kernel/pid_max", SR_CONST_VAL, val // if already has val,
skip saving it
"/proc/sys/kernel/pid_max", SR_MAY_EXIST | SR_CONST_VAL, val // if
exists check it already has val, otherwise save it

What do you think? Would that make it easier to represent/implement all cases?

>
> On 21. 10. 22 22:34, Petr Vorel wrote:
> > Looking at files which use '?', some of them (mostly network related, I guess
> > written/rewritten by Martin) use SAFE_TRY_FILE_PRINTF() on
> > /proc/sys/user/max_user_namespaces. It looks to me these need to to skip
> > read-only files, i.e. define new flag with this behavior.
>
> All those SAFE_TRY_FILE_PRINTF() calls are writing a constant so they
> can be eliminated by filling the second field of the .save_restore
> struct. I'll do that in the follow-up patchset when we agree how to
> implement this part.
>
> --
> Martin Doucha   mdoucha@suse.cz
> QA Engineer for Software Maintenance
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
