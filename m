Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21552CAC5A5
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758710477; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WUcIcgnv95edUUMWDLR19X6U+JXdTwwsnI27hIuznR4=;
 b=Z1XOxvNwtcvNEWmDWu1JOkllGKPWD7uHQcYGx+DaWJwSF0a+n18tM6d1uRaKbhmqzxTSg
 yasFb5f2Nlw25FuPypsV++fiOkdHoOpHp/JIFuGTH1wmNJCtxjtbTITZPXErvBvYG+yfKKB
 AO4FtkmzizMPDt4cjPuY2+gznMFtSwk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE3FA3CDF9A
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 12:41:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 474E63CDF14
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 12:40:56 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85823600842
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 12:40:55 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b2e168f0a75so454260366b.0
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758710455; x=1759315255; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v3gffggR5hG1J3vNKGChywuk7f+SXbEUhm+imEBCjuQ=;
 b=bqWkVldgAJXz3G2rEPJF2Tep5tnhAZ1I2WwKphTdkudSqjnGQEhZrTrfNmw+pm2QIN
 kBFswJxC045X/MI6NdOeEs60PDrC66HX6Yive7kNqJaueHSyUroENcaRpgmfOR+ERFBV
 qKcfS/Tmc6kVzvF9aTnM8VMVHE0j8a6k9xCgIC6UMy8D9m2o6h4wPFpRjBB8XEddhsQD
 XQSPEBCyRBCqJQ8E/FCyDgw+8ES+a4CYQsicT4pkxXWWY78mC+2hryFPxOUP50/Cbm6M
 xcoqbAN0O/gcEl7iHlZXO8l7x9zU5EqLYdkSLrMOCQap+BgpBwMov1UOOI/5UoaAfCj9
 7sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758710455; x=1759315255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3gffggR5hG1J3vNKGChywuk7f+SXbEUhm+imEBCjuQ=;
 b=Rg21zaZ11nBGSyPZmbGOAYk6M3hj1hyvFLPOaW+Mg2Em+dHM+L7I03hbAb3kRp3gHK
 xyycYv3LYhCFq8aHcdFP/6NT9iYX6oNmVdPODdfVxVX8hMj5fCqKZ6ccnDTBUnasDhVL
 e3MSba1YEHVY+X5hbbBkPZNdh9rGNY2DhTUgS3Xw2W3fdllJLYMlfMOATKe9/EZxKySB
 I5x1fn/cuzP57hLI1XRU7BG3fw9v3+Yq641mGROypsWd314iv5N2Jm87stiLJmZurhrs
 sKEvgpVevfyodpC67VW5wvY7fc9/TQUXI0+qxtNVu5fSkFGfdTiFPAAVhNwZzMxL/zJS
 byyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSyIXfkXNtONK0CfixWJ/d0V2cHQjUo1/4k8MSMv7+n6t7Pr5JwMQhGVdXKiR7dkXE8JU=@lists.linux.it
X-Gm-Message-State: AOJu0YzpHEIISgQcHmGsvyMw0DetAWwnqg4C/+O0X0QfxB/QawPQmyKm
 lFb0HYEfaxdpjDNNdY7fhmCUa57dG+sYdrXfJRtzWeHESRSsTqRvm07cei4/ZYT7hA==
X-Gm-Gg: ASbGncvfOcC+CUGyJr81IFbPMMIAj6lTDtfP93it+RYcUO8AXSNVgCHyYwgtOKGBcC4
 VPQvTrDLVVHzsvMIGUQnhDTX4QucmbUBEXTSgpnaNBe6TRktj/0WYECp31QAZD8x/AVTrs65I+t
 F8ZQ9bRGvAHCXAFzGMUeap1QQG/D1Z0Dp+Pu/BMlwYJcBwibEUDZu2c/lwCl7bvXrbCSUixBDoV
 HM5SxxANyNzG8Y/YUXOgNfeIWF5Zuuiv4IMYcqMGgx04nzESN9pj0XTbY+tLh211uHEY8+sKgFl
 h+vlKY4j2PLUwxn4H/DfhxLNkaRbAHsiUsnZkJZjXZ5lanKKDXBYU4tP4uY88HuWyG6CqzAd6C9
 Pna+QPdphK2fKMo59K7EQBdgjXcecD6Hi4a4yl3Ypzl8=
X-Google-Smtp-Source: AGHT+IEQhUYFKoSoTtPz47afD9ummNLk9uvFrzTUsHyQL2nigFY158NAMPkIQXrvMrmMw7JPuzCs+w==
X-Received: by 2002:a17:907:72ca:b0:b04:3b97:f965 with SMTP id
 a640c23a62f3a-b302b50c0b7mr598573866b.49.1758710454869; 
 Wed, 24 Sep 2025 03:40:54 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b296627ef6esm899104966b.23.2025.09.24.03.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 03:40:54 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:40:53 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aNPKtagFqkL_dIZ-@localhost>
References: <20250902031236.5719-1-wegao@suse.com>
 <20250902111809.6071-1-wegao@suse.com> <aMAUhpxi1GaDBfGF@yuki.lan>
 <aMDV1aTCZ--ElqfY@localhost> <20250918145335.GA432906@pevik>
 <aMwms-DHHeF5U7PG@yuki.lan> <aNNWzGWH56SLSXza@localhost>
 <aNO_uJvhPaZUSR1s@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aNO_uJvhPaZUSR1s@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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

On Wed, Sep 24, 2025 at 11:54:00AM +0200, Cyril Hrubis wrote:
> Hi!
> > What's difference between needs_foo and wants_foo? wants_foo means we do
> > not do brk if not exist foo?
> > I guess we need wants_parted support for .needs_cmds like following
> > change? Could you give me more guidance
> > 
> > --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > @@ -147,6 +147,10 @@ static struct tst_test test = {
> >                 "loop",
> >                 NULL
> >         },
> > +       .needs_cmds= (const char *const []) {
> > +               "wants_parted",
> > +               NULL
> > +       },
> 
> As Peter explained support for this is not in the test library yet.
> 
> My proposal was either of:
> 
> 1. Add .wants_cmd key to the tst_test structure
>   - pros: easy to add, easy to handle
>   - cons: the number of tst_test structure members will eventually
>     double
> 
> 2. Add a flag to the needs_cmd, i.e. convert needs_cmd into an array of
>    structures, we do that for other cases like saving and restoring
>    proc/sys files
>    - pros: we will keep the number of members of tst_test
>            this is easily expandable, e.g. adding support for
> 	   minimal version
>    - cons: all tests that have needs cmds will need to be adjusted
> 
> This would look like:
> 
> struct tst_cmd {
> 	const char *cmd;
> 	unsigned int required:1;
> };
> 
> 
> After thinking about this I've started to lean towards option 2.
If we select option 2 then we have following setting for all related
test cases.
+       .needs_cmds = (const struct tst_cmd[]) {
+               {"parted", "0"},
+               {}
+       },

But how to get "parted" command support status? In ioctl_loop01.c there
is a local var "parted_sup" which flag parted command support or not, and
use this flag to decide which sub test needed. 
If we do this logic in test lib then we need create another
flag in tst_cmd used for give status of command support or not.
During test lib logic will set tst_cmd.support flag.

 struct tst_cmd {
 	const char *cmd;
 	unsigned int required:1;
 	unsigned int support:1;
 };

Correct me if any misunderstanding, many thanks.

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
