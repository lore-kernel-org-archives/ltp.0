Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCD2CD4F35
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762997331; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=i9fh/5ttb++z/DU512x5i4OeHSccpU7DBIYITFTWp6g=;
 b=jvdTBz3EkLu/nM1EbgMO54+lzrCL5BSF+Kfcl2EdzhsngSrxbw2tBBJ6JREqNuD6k7L1n
 5QPBfi/WaSUQoaR+SZkJmkDmnTR22WGHz84h3lzTDOB6NIRsX66QnhJZpaGqWvLpDIaKfMy
 jJRbQYIlZh2YYH1ouoggwcGR6EkfVqI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 734E53CF72D
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 02:28:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7F433CF52D
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:28:28 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6A9A20009B
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 02:28:22 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b7260435287so30531066b.3
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 17:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762997302; x=1763602102; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J8jHsoyYMkaxDOewZLy9ZSTNHM4KjkFQYMEnuHfhvXo=;
 b=cqAsSW4WVvkGwOjVkg/OnnHzaXNKuUKio4Ty0rHCeAP0InwCgqBzNCn0X3C0R5aAa7
 ku+lx7c2xFG49RACgJqcnky4yIlICrpVn3TexouaodoR9P4695XdEIDqDkVUnkyjNgXt
 FHN+A2+la6/lAPOA21F7l7wz1YaeJ8URkYEj9sDDYwCQJxGbiz0WHH5GON0hAknld94n
 fYEZtmI9O28RIivfpwp/WOQ0pTdzd0JhWgRcjizYmueheKYpJoxvrj68lO3hbm+KzZzB
 golUx5DlB/EJUh6UkrKn/j0yOW8e8f786khfFEwv15jUvSNz453ZQUCiVnAQX6PwU0qX
 +Vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762997302; x=1763602102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8jHsoyYMkaxDOewZLy9ZSTNHM4KjkFQYMEnuHfhvXo=;
 b=PVHpbRleWKCIImhXgoh0hwJVCasSZcEiHHypKQMqJnZtLJ6T9FfBGHz7jjMwjTRSq/
 mz/EH/UUaFB5Hnpwfosc73TQBEFLWwbbinxHSyRYGMobqhWyVtJ9uzMMqLk8sHJRM73u
 i5VnSZN3VCTco+aVNxIyE3Pnfk/3Ycy3Th12bXavlIvxWavCs4fimBG03yaQUXoFXTIV
 8/t48hvdkM+sa33wqjE8CTdP/k8Y2CLT9tQpANF1UpHms05K+E1bBpzQeecIFlRGa0Yi
 r5zyxbzXxuegPp2bDhJ6yi3xTP13DZyr43h7EqP9W67j7ZyANsjAL80zFyF4yO72auhu
 jWPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgbw70YgHug+uUgORcFDVtXRQg3r+VKiXlOWflnYR4DcjnUGIfHmYwQdQBQBpPPhl0An0=@lists.linux.it
X-Gm-Message-State: AOJu0YxCv5pEHh5qpnoKI6jiyUdZtcDVANfhG+kKcGPXjHu5s4f3hnjg
 hinWSpH3ev0zEnW0ozlrVJOsoCbAQBnxGQ2zObAnlMF+NQlTVScedRWWMV2hodyw9RasGBxOPXF
 uvl4=
X-Gm-Gg: ASbGncvrgJjn1RTjK5v++zVczQHOBG+SimUB/tvou/3Duwu+SP7rgkMsXD91gKurA3F
 66A2pIu5B9rNbvZEITRUt/KxWGSRKO8c4072UNzhCvSg1eIvMlfPJ1af8D8auh1rymtFopKhELz
 CczeqhRdSShBVgQB2QlqrZtmN9vi7RhuRu2VchVPEkrOByhKL+f30fLY7xZZQgUQHC/ihRbAR0l
 IXkR+Fkl26FRRNoQu/m8VMqZGYi9ceVbGZCghe4FMBGHHpVF6atAB2skPNY4ArtJ5EBjFdm3c4j
 ++jAbHNnwuHOJWIwz/6KFa/hkYdCQPUaTR9YgVYl75MgJmX4X0moqV2UfVAu7C/9RO2vArdKKo2
 0D8zK9W0MgfOs6W+2ISS5agY9EpL/A9GLVfEToJrmoqhu+g5IvBIfa5dEFr8KKESRLtGLts1Wnp
 9YDcW+IF2IDjPWcOOF/A==
X-Google-Smtp-Source: AGHT+IHYoRFqHjkBosicOdSbmKoxSS+E1sH2t00cTVaXjWyTera2JSFXvmYip0ZyfuYX9hWdlvYhIw==
X-Received: by 2002:a17:907:da6:b0:b3f:a960:e057 with SMTP id
 a640c23a62f3a-b7331a6c6e9mr598040966b.31.1762997302146; 
 Wed, 12 Nov 2025 17:28:22 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fd80a20sm45888966b.46.2025.11.12.17.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 17:28:21 -0800 (PST)
Date: Thu, 13 Nov 2025 01:28:20 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRU0I57-BBYD6bzg@autotest-wegao.qe.prg2.suse.org>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
 <20251101012320.24972-2-wegao@suse.com>
 <20251111120600.GA50277@pevik>
 <aRQuc47d3PpTczVB@autotest-wegao.qe.prg2.suse.org>
 <20251112092236.GA80114@pevik> <aRRiLUyES4M5qjOm@yuki.lan>
 <20251112122126.GB80114@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251112122126.GB80114@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_filesystems01.c: Add test for
 .filesystems
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

On Wed, Nov 12, 2025 at 01:21:26PM +0100, Petr Vorel wrote:
> > Hi!
> > > > > > +static void do_test(void)
> > > > > > +{
> > > > > > +	long fs_type;
> > > > > > +
> > > > > > +	fs_type = tst_fs_type(MOUNT_POINT);
> > > > > > +
> > > > > > +	if (fs_type == TST_EXT234_MAGIC) {
> > > > > > +		TST_EXP_PASS((check_inode_size(128)));
> > > > > > +		TST_EXP_PASS((check_mkfs_size_opt(10240)));
> 
> > > > > very nit: I would personally add #define for 128 and 10240, but sure it's ok to
> > > > > keep it hardcoded on 2 places.
> > > > I thought also use #define but i found and can not replace it in
> > > > "mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL}",
> > > > so i keep hardcoded number here.
> 
> > > Thanks for info. Sure, no problem.
> 
> > > Cc Cyril in case it's worth to fix it in metaparse.c.
> 
> > The metaparse tool does macro expansion, that shouldn't be a problem.
> 
> > Also metaparse only scans testcases/ directory during the build. The
> > lib/ directory is not parsed at all.
> 
> @Cyril Ah, I'm sorry I forget it's a library test, not an ordinary test.
> 
> @Wei I thought tested and see the problem, but you probably just suspect it
> would be a problem.
Sorry i have not deep checked, since i put "INODE_SIZE" into mkfs_opts and
error report so i guess it not support it.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
