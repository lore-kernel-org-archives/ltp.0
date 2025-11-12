Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B47CCF9F8
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762947281; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=DgFau9FrAgt6C8Dv6jafw19+akLepUvYVh5Gq5Iv1oU=;
 b=h2dGycB6XtmH/zuwGLzl9PEKWfKMsmQ6xurrg/kM24xPMyjovTC/UAuOaKAZG2vq+1FiP
 Q/AXo1dkEBO4uZl7fwqlF746bt4Us+TNmQWVP43GRV/ojG76vX/AhfbnFaxmdzr97Opx4XF
 +4nIW8KWyDB4nASpMQmNOw7jbIMcP0o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1516C3CF745
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 12:34:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6601C3CF6EF
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 12:34:19 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 79C12600BB5
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 12:34:19 +0100 (CET)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b7277324204so137174766b.0
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 03:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762947259; x=1763552059; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dAYvQWY2IHc6qI0NzYn7g8dQTTS00fxfxLUfhJBGnyg=;
 b=CQI0xbHYXOWasSSnxD69euB5lZnIT/qE8xqYtCT6g5L99MfBVSN/iYylIKDLrQvsRq
 qX8zy9PZx93xxAggIFIbT+vyyC/KFq7K4a7x8JmdPuEwFHLBMduhqv07NCi30ZUJKoSr
 Y9PLaewLkLb6t4oa8lBmdQJFkzouOTPx5CVeWbYjcW2iJUPvt/NIunLMB0wdpHndo0Ny
 YwpprPbZNBJFoWlJuK4Lp3HQiaiIuy3gt8P/cOwWmu9NZfEn5/JyRfJzUBJn6cMPgyY3
 prlfOz5ODB8LRf38gP0FXPUhnchXkN0DrWjvB1csoyRh5joMl469Jz1Iz2cwZzugiW1+
 UApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762947259; x=1763552059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAYvQWY2IHc6qI0NzYn7g8dQTTS00fxfxLUfhJBGnyg=;
 b=UZxcNMBshHQ3ngaD9U9Q7jOd7lEvSSBw46YZrDShKPaz4DxHWOkt43geokJfrky/rX
 J0YVGe7+OKGVM0toghin7cDGXWGeNYTpW6Q2ECS5BPO4hwDR0VRyylZClQpD4XhZ6qGT
 fEdk63GtPbRqx5uhjYZau2SZDjwN2KAGY0GeOWlSUHEup24FPo7K5QlTsWU2s9Bzu6pY
 GYKCboj7qNTu9sk+Wm0fI9EYY8lIFY1B2N0dIZ2kHJVOoPzmQdnCO/E2EaJFiJ48tXKG
 t2fi9tK2iar3cpBRlw49jaQ96JITIl0Wt9viuvmdGVBb3Q9AUQrNhFMMDoGljzpUT2Tu
 Ko0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4CztlhEWDRKCGulyhBrB4RvLWZ552/JJ7OmPStGNBemudz9VP07KkAPlSMBuCqrrJKnY=@lists.linux.it
X-Gm-Message-State: AOJu0YzeOU/qr5/IY9EOSTinx1axzdJhNLRxAABKpxq/5yYfVIPvKLW7
 4DB+3IkxUMNE1FUJ8OHE4gTSXjnWgazy3JeoWkMTyrqyeIpfpB2DXJZKCOrKIaduyA==
X-Gm-Gg: ASbGncvlMFpX2C6/Ntgkigu3fcaTPm4a0srezR2apqs8oycA0Swc3Pu+3yjMBeyC5HW
 gzxzPfWe6AlpDsuDb6aH28e8y4vZ8jKwueuSbkOEqIbyU+eptS9rXFRearlEjRkekyqXCvCBk7I
 pkB/4TY+z1e/1VzuJKs7Zw6ljJ3tseX1m3/VaQYQccbymRGIwC8r6Qkg5Cf5++DGIURVT6w4L9L
 bnOlIYiGESL6wz0tQhvK+qlqAYT1OYkMlQa6+OMhDxOua4UdNa3IxCmHiKKR6NBU45X32yEMc4/
 Clcj/vRkWA/kmnRoCXBQOrtg0oomeksHaUPUckX0h1wF0tCsPHesJ7NO2O0psOS8/bZTFNHZnxG
 h1/L3DPMrvmgCxGVMni7y1mIAtr2YOBNdk0bbWCI9sYk+7RkXIsNVjMRXsnGq0H/FQRGCb0AQHI
 LsVnRHc8OBiFHQhC4uBg==
X-Google-Smtp-Source: AGHT+IEUr3MPfrdgalaXGjqUDAnVY9CrawTCaRLaglAVrhFge5EyrU6zKVW5uVqxYOudFHm7RH8Dlw==
X-Received: by 2002:a17:907:6ea6:b0:b72:c103:88db with SMTP id
 a640c23a62f3a-b7331960ea3mr254446966b.9.1762947258810; 
 Wed, 12 Nov 2025 03:34:18 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bfa24d14sm1574080466b.74.2025.11.12.03.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 03:34:18 -0800 (PST)
Date: Wed, 12 Nov 2025 11:34:16 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aRRwuF-KGB4AqXS5@autotest-wegao.qe.prg2.suse.org>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
 <20251101012320.24972-2-wegao@suse.com>
 <20251111120600.GA50277@pevik>
 <aRQuc47d3PpTczVB@autotest-wegao.qe.prg2.suse.org>
 <20251112092236.GA80114@pevik> <aRRiLUyES4M5qjOm@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRRiLUyES4M5qjOm@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

On Wed, Nov 12, 2025 at 11:32:13AM +0100, Cyril Hrubis wrote:
> Hi!
> > > > > +static void do_test(void)
> > > > > +{
> > > > > +	long fs_type;
> > > > > +
> > > > > +	fs_type = tst_fs_type(MOUNT_POINT);
> > > > > +
> > > > > +	if (fs_type == TST_EXT234_MAGIC) {
> > > > > +		TST_EXP_PASS((check_inode_size(128)));
> > > > > +		TST_EXP_PASS((check_mkfs_size_opt(10240)));
> > 
> > > > very nit: I would personally add #define for 128 and 10240, but sure it's ok to
> > > > keep it hardcoded on 2 places.
> > > I thought also use #define but i found and can not replace it in
> > > "mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL}",
> > > so i keep hardcoded number here.
> > 
> > Thanks for info. Sure, no problem.
> > 
> > Cc Cyril in case it's worth to fix it in metaparse.c.
> 
> The metaparse tool does macro expansion, that shouldn't be a problem.
> 
> Also metaparse only scans testcases/ directory during the build. The
> lib/ directory is not parsed at all.

@Cyril 
Could you help confirm following is the correct way use ?

diff --git a/lib/newlib_tests/tst_filesystems01.c b/lib/newlib_tests/tst_filesystems01.c
index 4eca0af0e..b2a2ce050 100644
--- a/lib/newlib_tests/tst_filesystems01.c
+++ b/lib/newlib_tests/tst_filesystems01.c
@@ -6,6 +6,12 @@
 #include "tst_test.h"
 #include "tst_safe_stdio.h"

+#define INODE_SIZE 128
+#define MKFS_SIZE_VAL 10240
+
+#define __STR(x) #x
+#define STR(x) __STR(x)
+
 #define MOUNT_POINT "mount_test_filesystems"

 static int check_inode_size(unsigned int size)
@@ -91,8 +97,8 @@ static struct tst_test test = {
        .filesystems = (struct tst_fs []) {
                {
                        .type = "ext3",
-                       .mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL},
-                       .mkfs_size_opt = "10240",
+                       .mkfs_opts = (const char *const []){"-I", STR(INODE_SIZE), "-b", "1024", NULL},
+                       .mkfs_size_opt = STR(MKFS_SIZE_VAL),
                },
                {
                        .type = "xfs",

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
