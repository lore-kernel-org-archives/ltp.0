Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24E0CAC5A5
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 02:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758680804; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GDaccOnI1RJ0LkzX/tcfCIlNUQbc56HP+O9a3hGWk5w=;
 b=k5ZxWgl23H6uR4YCk6JB974SkoICnziW0CaWG0+N4r5V1MnOSyFNI3pNucqHOs/oU5OvJ
 wHJ+HqkUqsuRcezkvHuk2muPFQr8Omn6mxOu3zVZpH1+QojyeM29yyfK4oZDKfqkrG4+CZn
 VFAw+pqi5WbH17958x8+67nmXMJ7YHM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0776D3CDEFD
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 04:26:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CFE93CCDC3
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 04:26:23 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3222E100040B
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 04:26:23 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b3194020e86so146434166b.1
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 19:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758680782; x=1759285582; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2EFVVzgjAuTqUIDaYwEOmrqAsMhXb8go4t/fhKkQ8GM=;
 b=TNiaQWF6ejZooxdyZ7pd3ANYt4Xv6fZGgbmZnxQ5n4kRCssm+C66PYGYf4ppw07DNP
 DB3WVOKfuc7Yxkte2Cl8IrvvirpO9OFTphFjqR/wSyReGW0Vc011iusMBbV14Kj+Upxz
 q6iTV8AT5HuS7oiCz5Ul4rfuBnQcLph5Y+PgUDiVmVRRDi3AeTpgpN7Ghq1a7oJUIcPP
 NwgBAymQjoqY/ekFy6Ux75XptX42Q0F7GAQ4OCeynq334xus990dc56D9ArvAzdzEGiQ
 DhKdInNVSPDJga23fbDAlPhgNVdMIx0SQHM8VobM0VWuKkpc89w/Scu1iJLG/azUWG9k
 FIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758680782; x=1759285582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EFVVzgjAuTqUIDaYwEOmrqAsMhXb8go4t/fhKkQ8GM=;
 b=GKEbRW1VoFcbMC1lac02DylkR8Muy4w2UlpDMNG64l9ZzCY0jhn6N8oMPt60mLvntB
 N9BXmhGrLX2iEji9NBDYpjCI88Y174TxNf2ec9GhMRNO1xJIolZUWAf3wLlEysylfsd2
 PgMv44sZ3c+ApXzLBhMNfbfUtkRr5NClzKiTkQT9mMYO3sdg0GogOOjm+yD9t+PgQyvB
 7tuy84v7RHWxIficLNs3aWFVUkxO8wqT22bU3354iUqCBzMMq6PI314hv+qDUAjbaFQs
 CxI/hMAbtJeWdPOukHk8CgExJxHKYb4ts5AtPlQmCer0me/iPCQwDtSNxHWuM2H+hL5E
 UvKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhyQbKPkW/b7D1CuEg6qWKVGAGvGhsOJ6rGED1GqwKcRwk681CPAq+lrDUCKcCkGHMrcU=@lists.linux.it
X-Gm-Message-State: AOJu0YytgC3bC1pOiV6PTOjlMWrwZra6MBwgteUnQAQ25MaA6lddgA1J
 oxThgV/8P3/axt+izawaLGCJ4iIhMp/ZTsNPvfgmAiJSX1teQ/zSoKGh6KIbGWmwVg==
X-Gm-Gg: ASbGncucyymHlWud+y4kLZKddwyMPZR+I8JCUlg/+KwMGsrshW/JbbHIt2PntWYz7QD
 jEXFherCaM47sR1THGeTOMZ5etD6qBF8HIomybWy3c6ewDm3/2Rcm4IwsInxGs95FaSY3W+1Ays
 d7lb4iRKABFLcUfhr/2+aoHJg7xT1o/zsbSLktXGGWOZaF8gB0qAqKADzWBWs6TbIJeAluecXpG
 LjrazM6It6loWmDoOeky4e9Tc418SAAtq5s8XlRYGbaOlctCR6SfKtZtVYiD61VjGvfoq813Qo+
 nnBPfHH6a6vTm5lSYJE+6mKfJHl/8+zrOtcT2a4I6HNWr6sSFVTO+F2sKy3KU29lYUffVBmQ164
 cCzEVYa7U0ShX0dk01iGmJUN6OgNgdQ/CiKV7oYOEt6Q=
X-Google-Smtp-Source: AGHT+IH6CzFMxKb4XbSZkF3qJC30r7tJ5OL+jU5Zb/s3wv/uyC+2Phr6UV6H5VyYOYyKxaesvaHu9g==
X-Received: by 2002:a17:907:d2a:b0:ae0:cadc:e745 with SMTP id
 a640c23a62f3a-b302ab3307fmr524625366b.40.1758680782523; 
 Tue, 23 Sep 2025 19:26:22 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2dd7bab2e6sm493719066b.41.2025.09.23.19.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 19:26:22 -0700 (PDT)
Date: Wed, 24 Sep 2025 02:26:20 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aNNWzGWH56SLSXza@localhost>
References: <20250902031236.5719-1-wegao@suse.com>
 <20250902111809.6071-1-wegao@suse.com> <aMAUhpxi1GaDBfGF@yuki.lan>
 <aMDV1aTCZ--ElqfY@localhost> <20250918145335.GA432906@pevik>
 <aMwms-DHHeF5U7PG@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aMwms-DHHeF5U7PG@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_loop01.c: Use proper device for
 partitioning
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Sep 18, 2025 at 05:35:15PM +0200, Cyril Hrubis wrote:
> Hi!
> > > > The test should have needs_cmds set to parted (we do that properly in
> > > > ioctl09.c) then we do not have to handle the 255 exit code here since
> > > > the test would be skipped if it's missing.
> > 
> > > If we use needs_cmds all the check will be skipped in this case.
> > 
> > @Cyril: only single test require 'parted' as I reported in v1 [1].
> > Yeah, code gets slightly more complicated just because single test requires
> > parted. Or you would not care? IMHO it does not make sense to split test into
> > two (too much duplicity).
> 
> The problem here is how to handle the metadata. One posible solution is
> to add a notion of optional dependencies so that we would have
> 'needs_foo' and 'wants_foo'. Or turn the needs_foo into a structure with
> an .optional boolean flag.

What's difference between needs_foo and wants_foo? wants_foo means we do
not do brk if not exist foo?
I guess we need wants_parted support for .needs_cmds like following
change? Could you give me more guidance

--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -147,6 +147,10 @@ static struct tst_test test = {
                "loop",
                NULL
        },
+       .needs_cmds= (const char *const []) {
+               "wants_parted",
+               NULL
+       },


> 
> > But TINFO message should be turned in TCONF so that people notice.
> > tst_res(TINFO, "Current environment doesn't have parted disk, skip it");
> 
> Yes please.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
