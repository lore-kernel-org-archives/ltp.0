Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80FEC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 11:56:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C9EB3CA249
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 13:55:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B2493C1BC6
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 13:55:49 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D8091A00694
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 13:55:48 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id d1so1022284qvs.0
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 04:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=85NezJFMBVXtq4N+YZNNZu+Un4/G1Q4uCCY11kAn1KY=;
 b=ZKYSGsL71qmK+bgK0qgFsWsYT3VRGW3b//hdrvYl9INCA+dNb8fSVGHmmnvbmF7Yms
 X7noes8gPYnsGVLY6GDMijT/bu61nXn2k9/ZFT0BmVDdSQiLE9KNKrU19/x4Dyj6Dbf3
 YOOUdH59QoujJQ1kYiUvUFOPXudKdHiOtOZvd8FM0e8lprcRuK2z/JiUHWgOEpmz3Vfs
 V8I0ZlSrnSqVng1VmO68/6MTYXkLT2qUe9hmGsIr0zRiEPDW58POj+Vc9Y5VHVNOmBjZ
 xhpMfhpcAQd2WBrevTNkVnQwzf+Pnt5hOYUBu5TNpkMDz24YM0aI+9KpEXW5HWl7dNW5
 eG6Q==
X-Gm-Message-State: ACgBeo1Nw9cnxkP5ymNlA5yuunBJsfmpif/XXU2a40r5gZxuflXahh7J
 dG/lP7IdGq50Sd3yWoe28MjzNn7A/pGGhA==
X-Google-Smtp-Source: AA6agR6E3P9eqQvcd2hkPaQTKzfTF13x958n8D6QaYdNa7fbtrDMfXhUWgXm8YjtcqsNYGSktNxSsg==
X-Received: by 2002:a05:6214:20a3:b0:477:155b:74e7 with SMTP id
 3-20020a05621420a300b00477155b74e7mr1949401qvd.70.1660823747142; 
 Thu, 18 Aug 2022 04:55:47 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com.
 [209.85.128.171]) by smtp.gmail.com with ESMTPSA id
 n1-20020ac86741000000b0031eebfcb369sm807453qtp.97.2022.08.18.04.55.46
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Aug 2022 04:55:46 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-31f445bd486so33741707b3.13
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 04:55:46 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr2355446ybq.543.1660823746108; Thu, 18
 Aug 2022 04:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220817204015.31420-1-pvorel@suse.cz> <Yv4MBF79PnJKJbwm@yuki>
 <Yv4eiT5L+M7dMkQ5@pevik> <Yv4i0gWiHTkfWB5m@yuki>
In-Reply-To: <Yv4i0gWiHTkfWB5m@yuki>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Aug 2022 13:55:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUMBjCTwPu7wxrnagXnbyVxxmXN+vHmML0Lr=SyrTw0nQ@mail.gmail.com>
Message-ID: <CAMuHMdUMBjCTwPu7wxrnagXnbyVxxmXN+vHmML0Lr=SyrTw0nQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/1] API: Allow to use xfs
 filesystems < 300 MB
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
Cc: linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 automated-testing@yoctoproject.org, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Thu, Aug 18, 2022 at 1:28 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> > > I'm starting to wonder if we should start tracking minimal FS size per
> > > filesystem since btrfs and xfs will likely to continue to grow and with
> > > that we will end up disabling the whole fs related testing on embedded
> > > boards with a little disk space. If we tracked that per filesystem we
> > > would be able to skip a subset of filesystems when there is not enough
> > > space. The downside is obviously that we would have to add a bit more
> > > complexity to the test library.
> >
> > Maybe I could for start rewrite v2 (I've sent it without Cc kernel devs now it's
> > mainly LTP internal thing) as it just to have 300 MB for XFS and 256 MB for the
> > rest. That would require to specify filesystem when acquiring device (NULL would
> > be for the default filesystem), that's would be worth if embedded folks counter
> > each MB. It'd be nice to hear from them.
>
> The 256MB limit was set previously due to btrfs, I bet that we can
> create smaller images for ext filesytems for example.

Yeah, we used to have ext2 root file systems that fit on 1440 KiB floppies.
IIRC, ext3 does have a minimum size of 32 MiB or so.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
