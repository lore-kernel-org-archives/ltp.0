Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8BBD59D99
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765796424; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=O6NVY2eX8jr7bdlB+GWUgBt+d7sQJ3IcmHCTSqbDL6A=;
 b=MJ5wkTpgumicFPYRy/Dne98gCFK6aA0v2WYP+c3vs8lQC+4hU9unrtK2rdybXubTdII54
 XnyzBLkk6GCByBrRsPz3Xcb+Bgq8Emt5CtmPifnjzFElVRwcKFdiYcVeShrnmiVrHIUiLH5
 t3CQhNNa80mJyB76v/vmkmj5L2CnVd8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3A3B3D00D8
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 12:00:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 009EC3CF55B
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 11:59:58 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C80FF10005DE
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 11:59:54 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42f9ece6387so1308149f8f.0
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 02:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765796394; x=1766401194; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lCos3moOFD+nauiFzttlcH+p8qH4TS0BMlErTbtXbuA=;
 b=Qxl9YTWPRo0OzghZvfq1yeE1wuuQU7K/F6syR9GhzsZh+y2SXlZ4eEuojOSFGVXt5u
 h3EjWkUz1PtlZYgPSBfYiP9VMYxJZ0IPDe0vSq6NG/ddQqXChl1FtNavYgzUfo5nTncT
 bguvtJuW2sRUEcOHdWyspTkPpZEZMQb/tdP4llgoj2jsm+84k6t+Ar1XUH/FfhxCNhLR
 ZH8+Rb7XDXVAvPvYslsVI5HrVL1mYY3zGLnBt/fg9HWnNcJYisT+jfwOgCa6qEz9xYyd
 bPh6PcOa56CuJdJrRZkNZIRRmJ6L1fgNh2e/IEuLkxgnL3MUNNjNHH20zQM7ymvfkfJO
 mHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765796394; x=1766401194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCos3moOFD+nauiFzttlcH+p8qH4TS0BMlErTbtXbuA=;
 b=sbXjkMi4aekMDctcT5vBoTGaYzzu5VKk8aKtkohwlkcrVRBxmLYppEnV3tiniyGX60
 oQqJR20wwQ4sXAiYMMczk9OoC3ghTox0bC3+8e3aB/fy6GiYP5gQ8ieYGmm0GW7WuX60
 aX7eBskrOGtPmi8PXtzrhlTwYn74vJN78g0AN8t0T1cXHOHZjyhSD7RcEHxRl5fkuy2c
 9Xzcfy97c21Q67ZCJcsID7NbzHAAj0pSVAYsjInUHyfemjHRTV7qxaVtN5f5W5KyV8o2
 ZwsNnONncGOInDxrvdlr+CjV2STAuKKmF+vPxR6kguGJ7phHTaoZIjPBsXflIEUao0Qo
 nF1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzHRS7xBtKZfrNaXCHMEauqreR3qBGLRCDJ2pAzDQwUhlFW3/nX873e6Eb+EXLnHSU1qg=@lists.linux.it
X-Gm-Message-State: AOJu0YzFvVamqxmMdNWCPPrFFrHvq+p7Ux8qIdbhtjmj6Vgitrys9JCx
 WGxZ37b2Gz1RGscnk1yrcTsnBxFXopzDJRQlE5XpatLvjLbJxNXAQWv87sHrnQBGSDhGxEDXIIa
 S/d8=
X-Gm-Gg: AY/fxX4m+vCoVVRISMPnzu1amt/BzIaS5ar9WuuP7Mv8jxV7s2xeF1i9yTu/RlfsgbR
 jh7xQ7kLL25qlO/tuadtC+73IeDRZK5PaNvRGNDnLxk0EzePabbdI9utS+HhqI95VcuZnVqi8he
 /eh2CRHT1exw1V9OpCVpTEpabM6yasTaOjsgRFZXrICKm9kCKGQCyRtg34SGBTIZQ2t7ygmRSvj
 f9uoN1l8Byanbvo9C59v+qSu5weGj4mzX+9jphcMilVHIjH9pwM8ZIO3Qgj268gUogDsNLgGkvo
 rLNCRyiG9ONXHCw9xK04/Yhq6TBKeN2ulFkwZ0Ry/xUzEcq7Cb21/L/JdhuoXjPQhzMBsAX5Bsg
 bEONH/nZ9nvYbwC9jh0pnTjwjwZIYhydPtOdRD+BnFZgudx+VV1I/cSwNfR9HsQlRpovnnSpZ7z
 nmW/6DAhuQj1jZy0joSpdhNDAjyzu9
X-Google-Smtp-Source: AGHT+IG8lWbyvJcD447F3y1V9ZaIuuzNTJLoL2FIMTQ94KZMiKbMseo96xqC1O6rN17o+pf+2+aLTg==
X-Received: by 2002:a05:6000:2083:b0:430:fc3a:fbce with SMTP id
 ffacd0b85a97d-430fc3afd23mr4441983f8f.15.1765796394006; 
 Mon, 15 Dec 2025 02:59:54 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b26fsm30904945f8f.40.2025.12.15.02.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 02:59:53 -0800 (PST)
Date: Mon, 15 Dec 2025 10:59:52 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aT_qF7YR65J9PbEg@autotest-wegao.qe.prg2.suse.org>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-2-wegao@suse.com> <aTvu4GJBC_G5kSNi@yuki.lan>
 <20251212111618.GA125889@pevik>
 <aT-5tkQkM_g2VZ35@autotest-wegao.qe.prg2.suse.org>
 <20251215093639.GA236929@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251215093639.GA236929@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: Add support option for .needs_cmds
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Dec 15, 2025 at 10:36:39AM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > > Also, strictly speaking tst_cmd_present() is only defined, not used. The commit
> > > is about changing .needs_cmds from char array (string) to struct tst_cmd.
> > > Therefore it could be in a separate commit. We don't have to be too strict, but
> > > given how many tests needed to be adapted adding tst_cmd_present() is somehow
> > > buried with other changes.
> 
> > Thanks all for detail feedback. Let's me give some explaination why skip
> > tst_brk in above function:
> > tst_cmd_present will be used in latest ioctl_loop01.c and it should not
> > use tst_brk otherwise we will brk out of test in setup() too early.
> > The new support needs_cmds.optional in current patch is used for support 
> > tst_cmd_present scenario in ioctl_loop01.c.
> > Correct me if any mistake.
> 
> Sure, I noticed tst_cmd_present() usage in a later commit :).
> 
> My point was (while this patchset is also about ideal feature change split into
> commits) that if you touch many files with struct tst_cmd change, adding
> unrelated change (tst_cmd_present()) will hide this change. I would personally
> move adding tst_cmd_present() to a separate commit. It's not that important,
> just to make review easier.
Thanks, i get your point now.
@Petr @Cyril
If we have are agree with following changes then i can sent next patch:
1) Just move the declaration and definition of tst_cmd_present to a separate commit without any functional content changes.
2) Modify function comments such as add ref:`...`
> 
> The rules (which I've tried to explain on this patchset) are
> * each commit must compile (even temporarily break build is not acceptable)
> * split changes into small logical parts
> 
> People talk about atomic changes: "As small as possible, but complete" so that
> they don't break CI.
> https://dev.to/samuelfaure/how-atomic-git-commits-dramatically-increased-my-productivity-and-will-increase-yours-too-4a84
Nice link:)
> 
> Kind regards,
> Petr
> 
> > ioctl_loop01.c code:
> > static void setup(void)
> > {
> >         parted_sup = tst_cmd_present("parted");  <=====
> 
> > .....
> >         if (parted_sup)
> >                 SAFE_CMD(cmd_parted, NULL, NULL);  <===
> 
> >         sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
> > }
> 
> > > Kind regards,
> > > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
