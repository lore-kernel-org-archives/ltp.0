Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED961C47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 10:52:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 492CD3CE200
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 11:52:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58FDC3C8AD1
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:52:27 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C616C1000DA3
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:52:26 +0100 (CET)
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dc372245aefso2775851276.2
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 02:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706179945; x=1706784745; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x9EafNjBfKuWEryoKZTD9LJGCybe6U13YoAy8on0DhI=;
 b=DFsYkirXR0+T1p9G2/MTPAlLOZ8lYnADdG2IIsNsDmek1d0zl/QhxW7R5uiMnFnNy3
 RInGhZ8ju0X1tphfbsNEZ8nPLYwqc9AmPnmgwmn93semcjNjYJUiDOrTgBIjTLgEfUll
 UllNiAY/HiwTnc31GQBFfT6pyuZtkmQV3jHgusqXoj5s2JMhuyRfYCgZnMDLvkEfj1fU
 vEZzfl/TYo15cOuabrTJJTNPtcE3H6JkYCvPrJPag0DuK7PV8kLSDJpm1Ds5M3jM8EHi
 G2xcImOfAEkh5iEntz33bQcrwg9xi295byVu3wWYDqrcnihwV5NSbjazTbTfFHnjGUbD
 +CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706179945; x=1706784745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x9EafNjBfKuWEryoKZTD9LJGCybe6U13YoAy8on0DhI=;
 b=i+aiJ05nWYZuqEuvuL+dMeqZj8/9sin0RyQ6Vt+kbfZnlwnN4v60x4ZuUltFOQHWj0
 cfQF2NZgqVbHdXH+GiTc8Gx5kZ7dNq/Z/uwbl5l24lBu8TC++POnR5l7VqGp4QjYL0Yc
 Z5Xteh1CnJx2FG1speS5R1MMOh0nZYWb9ixtVrj24TB/tbykJwPAj/QvekZrOGn4Gotw
 JscotJFOgttm8CD+a4Bk0sNoCn5WQ7+IC7lLFJplDXzE0Qot8nNNmjOUvhAOS2eapriT
 S5GjJ6Cwi/kECo9hNO18Ih4Nz+dkQhPPcfrjHNSYsCiOmsSbkS9+CJp3ajE6/yAg7kYb
 HuCg==
X-Gm-Message-State: AOJu0YyOn0kDNKu/3faebH5wt0ZnIgBHlyLKAsclJPyFEc3AtVn3XVhr
 aUPioEwzHaujlA/v5XQtky0/5m7PywlwIxvrLPQFnAIMRJecjOkAJgt/UQuJk73zsbQKiRjICAu
 rFBCiKugxa7qaD6JcozKbOP/W6Gk=
X-Google-Smtp-Source: AGHT+IFveHghFRPxqRyXwILW8xx1fut5/qFjHNViCmJgKuLgCmLwmN38u0Dz+LEkkAedNEczoh21lQAgZ6zWzw7LtLc=
X-Received: by 2002:a25:b045:0:b0:dc3:6ec3:e9bb with SMTP id
 e5-20020a25b045000000b00dc36ec3e9bbmr495673ybj.91.1706179945634; Thu, 25 Jan
 2024 02:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20240124122130.288374-1-pvorel@suse.cz>
 <CAOQ4uxjtJg7iprcOAizXOUdw=6PouBDtiyL8R3CfqGr6yyR9vw@mail.gmail.com>
 <20240124153347.GA309254@pevik>
 <CAOQ4uxhumyknSgX3=kTt9sqPkxNwzHnQwFMfahj8tX98LQWPVw@mail.gmail.com>
 <20240124194248.GA342745@pevik> <20240124205104.GA352102@pevik>
In-Reply-To: <20240124205104.GA352102@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 25 Jan 2024 12:52:14 +0200
Message-ID: <CAOQ4uxhs28RE81CrSX5iYccMpT68SRM-Wuea3F6TDKSpBm8c3w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fanotify: Handle EOPNOTSUPP as TCONF
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
Cc: Jan Kara <jack@suse.cz>, Dominique Leuenberger <dleuenberger@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > > But note that you need the rest of the fixes to avoid test failures with
> > > fuse (e.g. fuse-ntfs3g) on v6.8-rc1 - if you care about LTP results on
> > > latest rc kernel.
>
> > NOTE: I would do care but the 2nd commit ("fanotify01: Test setting two marks on
> > different filesystems") fails at least on 6.7.0 (see below). I'm testing whole
> > patchset and just commit fixing "fanotify{14,15,16}" and report if more
> > failures. I'll probably merge now just that single fixing commit.
>
> Due these problems I merged the other patches (all but these 2 which touched
> fanotify01).

I think this was the right choice for code freeze, because the fanotify01 commit
is for testing new functionality.

However, if I am not mistaken, regardless of the new addition in fanotify01,
you will also get test failures on v6.8-rc1 when running with
LTP_DEV_FS_TYPE=exfat.

I pushed another fix to fanotify_fsid branch:

 3cc948c92 fanotify{01,09,10}: Check for report fid support with mount mark

Similar to the fix for tests fanotify{14,15,16} which are run on
all_filesystems.

I also fixed the problem you reported with exfat on fanotify01 in the
commit introducing the extra check.

I will post it for review, since I now tested it on v6.8-rc1.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
