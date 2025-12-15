Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471BAD5B16C
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765814410; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=S++nzrdeM9gMavp9a8gkOxsTCxXXDioQRJmdKgUEWIQ=;
 b=ZegP031Wxmao4xrHzZXQSsHT9de1oggq00R9+37ZP8HLos/5xQIQnUuadgtutF7EDFLJh
 xEOQuagqGKqR6EEzn8knAyPU5O/Jcj9NcgiBqhfBt9coYA0SxtsRGEQywN/6h19LUQJTGHD
 luAcxk6Jk1saudMiaZ3EJMunk3JOVLg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9C13D00FA
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 17:00:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D1813D00A7
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:59:46 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A0115140051A
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:59:45 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso15850505e9.0
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765814385; x=1766419185; darn=lists.linux.it;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsHFwCWRJqQSeWoxT9QLZQj4pyyCh8SvOjnM2NsJtwU=;
 b=QCo+j7Ny7jiQ3Z0rn/D5Z6Mt7qQvZyAHfXPenUH8xv/XbN+k+qTgX/CrDb3GcM0eW3
 X/bzlj2EFoUhp8MxtGI/mK6i2Zm+yvPhRos28dTJisbKnU6d8P2sSbWDeGYlIRayKLuQ
 cchglXk9arRCiJwBKfUm6YNUkpJWVD/MhAaj1lIv0PuhkFkVBCQH4bdbHogcPA27cqdN
 qBfIjn0ilLU+KCSVrELb3zeOyxY6P2cW0NOgzvf3viKtIRZ8ihENJvkzdCk8PYEq8KUK
 w/lugkEQfoWPhDc8XhIBnH5OdRoGgXPijhj9BiR1mgcMyuph9naBatu9HLbhp9sSsQhJ
 6ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765814385; x=1766419185;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fsHFwCWRJqQSeWoxT9QLZQj4pyyCh8SvOjnM2NsJtwU=;
 b=wSlRUEvI/Utdbi3sWf6jvwBvtlRHazZ26PVF8qtaGrQRy+CwvuYuZlA8l7yPczKMun
 /oAPWreqRjf7O5iMACIaNd00sCWtpDOJysij//vjyqM/cNoLpJqILSFpBTXrWAhP2Qai
 WwBJqVVJyfx+S1kLXW5LetOg3bS2WGrp/pbjEmoPq43OQqThpUxgL73gZoP9/W1UH57J
 0uM75GutYJJLphryrEnzWRG8ox3r0rrjQWb7oNcVjpCaU1wq4f1a6xe5n451kniAoV5U
 p1ZR1kIhGBmqc8ch0NLIX1asju4gSr0xXJNIGcl0EW2lj42nY8OBD9JDrIVJZp0403Fv
 EE2w==
X-Gm-Message-State: AOJu0Yxp7m8qr8rzRGoa34BJ1/Ya2S1tSMmt8YgX3RKNyVXYPMnvOSC3
 DthdU0qoa3htNXSaTenxVmrTLykwCcvxNS2T7PLX+X6LN6hNhXXxfRnQSObVXpX/8w9BtZyl0aT
 fBSpDUVI=
X-Gm-Gg: AY/fxX54kNio40k3ebPr9yLGyD3oZBV9o+vA7gl8seSMbZ65dY7quEKYxwy5B0rdhxg
 4dXh9JP6flgvemzVVHQQ+b8mX46w7GhI2lV98uPUUQMfA3SJA01pFJiQpKqgOADulTc+n99Dkjw
 oX955XsuLw9h/qiwHAA4FTkVIlgAoROqgV9xa1vy/WxuML2I56fICAdgyZDLaI7eTZW+gyy9eJM
 JrPx2r1x1UjrFNQcydHb0uBWQFSvMSH//XtNmE4g6isHslRjgewqpI7u2gB8Iy9TKXV3R37bU9X
 Azfa/KRvB+eduehvdSeFFSpkCWeP1HqEQIvnNxYQaf1YtiEALV70izYrBNFdb7VZVUubTeq9ow3
 TVB6QL+jItnAhjjgRSn6amr3QngPADml0OW5CUpKNj5CZm0pAUEf2nGj53P2HVWcFtKbBwNw0tY
 PfH4aAfE3Is8TBJpvt/nk=
X-Google-Smtp-Source: AGHT+IEpeA86lY0iNOYkJsZWQmpBZcHb4G92OS4YOdBwxYXmTaHph7aKLz5rr8fbY91GzL5Rxj9Rlg==
X-Received: by 2002:a05:600c:c101:b0:477:7588:c8cc with SMTP id
 5b1f17b1804b1-47a89da461emr130807025e9.7.1765814384881; 
 Mon, 15 Dec 2025 07:59:44 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ff626b591sm17732200f8f.15.2025.12.15.07.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 07:59:44 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 15 Dec 2025 16:59:43 +0100
Message-Id: <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Terry Tritton" <terry.tritton@linaro.org>
X-Mailer: aerc 0.18.2
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik>
In-Reply-To: <20251215155330.GC272695@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Mon Dec 15, 2025 at 4:53 PM CET, Petr Vorel wrote:
> Hi all,
>
> > The flags CLONE_NEWUSER and CLONE_NEWPID require specific namespace support.
> > Add CONFIG_USER_NS and CONFIG_PID_NS to needs_kconfigs so these tests return
> > TCONF instead of failing.
>
> > Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
> > ---
> >  testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 5 +++++
> >  testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 5 +++++
> >  testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 5 +++++
> >  testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 5 +++++
> >  testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 5 +++++
> >  5 files changed, 25 insertions(+)
>
> > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> > index 7eb60e7fc..6983259e4 100644
> > --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> > @@ -81,5 +81,10 @@ static struct tst_test test = {
> >  		{&info0, .size = sizeof(*info0)},
> >  		{&info1, .size = sizeof(*info1)},
> >  		{}
> > +	},
> > +	.needs_kconfigs = (const char *[]) {
> > +		"CONFIG_USER_NS",
> > +		"CONFIG_PID_NS",
>
> How about to check /proc/self/ns/user and /proc/self/ns/pid as ioctl_ns06.c
> does?
>
>     int exists = access("/proc/self/ns/user", F_OK);
>
>     if (exists < 0)
>         tst_res(TCONF, "namespace not available");
>
> Long time ago we tried to avoid forcing config. Is it now considered as better?
> (maybe more readable?) Or we would keep checking /proc (or /sys) but add a
> comment for required functions?

This case is specific to the CONFIG_PID_NS/CONFIG_USER_NS configurations
and the feature can't be tested if kernel is not configured with them.
Manual is clear about it: https://www.man7.org/linux/man-pages/man7/pid_namespaces.7.html

>
> Kind regards,
> Petr
>
> > +		NULL




-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
