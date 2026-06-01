Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FACDCD6E5D
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780317526; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=YQlJT5KWAAmGl+UFPuDdK8KmUOudiY1GXF6ESaX9KCM=;
 b=eHTgqMjdW44a3oIzE0aw+IgKHDm4327uymuZKnDpg80NGYUTuD6pLceLAmjQx/6lLKjXb
 /0bWpHcIAGGxpSK4V1otNNxov7FS29ppH5ManHIpxAxyHuOldBn1iU9TFNkNRz6Z3Wb3yJh
 Y3Xg7GysG2y7MshyF9PRy2xo39H3bpk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF51F3E56DE
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 14:38:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCB033E2DB7
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 14:38:23 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 37DAE20076C
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 14:38:23 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso716909f8f.1
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780317502; x=1780922302; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ifGTwSJQmiqPINFTeq0tYf+jZ5ycR0sddBYi5fERcbQ=;
 b=PuRALP79JcMAqIF2r9kJVH+XEjvNLz4oYxzV0Uzsg7kjCwgT7RFtrJCXkPbdxsSzYa
 OAC6WVR5FfOvayk8y8lHtOik5iOjP93PAMwY9NsGw1Pjm/uepsHg/od341tGGFsOG/1Z
 rkPV0BW5UAVWs2BO2G2I+RALoJ61GIeNl/ZuNYiXJyUEDiX2eB19doXGnqk0I6U0PWq6
 Eqcr1aH3n49BMv/7lNaOLU8PsksvhOPb3hCpJIv9rwL/YYZt1gJw2Z2xhz+U9MC2d3jK
 Ytmc2JbwawIXbIFNZsGfj7VGUhLfhmE8oQwUuDPMfVUdIWNXlfX51v+ujNVO7lmJ6TTy
 qAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780317502; x=1780922302;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifGTwSJQmiqPINFTeq0tYf+jZ5ycR0sddBYi5fERcbQ=;
 b=rKo7yItMIzgCLIzDicZbyvHIjI/JPtgzC/kL+eUjUa5KCL7LV7mSJwY+rtAzLg80A5
 S5XkbWW6/NQZZ19sV5uR75psD/8QN7NSPQeUAEe9RbkOMA/pL2u9ggE94EmtGuffrEGE
 5c/C5sFpt808kILDdpJoTuXQyEoK3yrHCllngj76gYZQAxUO+QIl7latpnoB/M2az9Yz
 mfdKUTrSTdg49iJq9QS3Hgb8eu4tySKdITnftKm5C8U7uL7ZiiSKJudaeDlZM7TNLpal
 XgTTiManjGGc1Whn6oZSRDYdKf7Rb606xmMUvPbBB+11jP+FU65wQmn+2oi5v4Oioud4
 HMNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+TtJ2mz/aaqdRbfAe/gQHArqJD31U1nZFVvz2i1KjfwOU7rJSq/QjuEN59uBFVNCnbAg=@lists.linux.it
X-Gm-Message-State: AOJu0Yyc74Wif5eG+qElLjalGQK0YOd7WTfmqar6YaWhSs56sGwheJO7
 wA8uSnEePJKCzBQBFRnmCKv9JLkr/EwtUHXX47j3/qDGhS/G1pIZqCnEvABIt9wJAJI=
X-Gm-Gg: Acq92OHY7gDXEuMVqo9Q4sBZozXaMJFws+Z0/Xi0GrtnSdEZQKPWut0hAkWWN4ek/NN
 s+BoXea1oOrobZurVzsAKe/Sl2n6ZlYXf9U3f83HLwrf/styEw5UENppYxZvN2bY2o4mC+1prC8
 kElbEy620Brzxu877F8EPay8B3ED59d5TcVyqUWtuAdTMW89PDEWqfloESW2AAXkZKsy6DBcMb5
 D1fUeh1eweBjRHDeCZPZz/KkjeXER8zVnYjTBt5nYF58kEYiBmfAjjovmbGiwwpP3LQVWcvbDLo
 Ppj3Z32ARxurt2BjFw4fuF8sPNHKSf53tkLCGSKo0i8IVzGGbrq4noismC8wO9iPjfKUtrDME/s
 wbmwG+pfBIAlJrqOpXp3MHYqfQXkWu/YXBeCK3XKeGiAhimbUFzVV9aT88r6bELO6lpsSCpT63E
 NcOVj0W/WFSWHQXMkmGlMqsINH8xPyIQhpjLxetMb9pFuICSev8VuyVWZ83GTkkVHonkxc1h+hs
 npAgc6ZeHg=
X-Received: by 2002:a05:6000:4683:b0:453:9897:76aa with SMTP id
 ffacd0b85a97d-45ef1385c29mr15418549f8f.21.1780317502496; 
 Mon, 01 Jun 2026 05:38:22 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3556f51sm27736198f8f.25.2026.06.01.05.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:38:22 -0700 (PDT)
Message-ID: <6a1d7d3e.ac7a8a87.1d7e7e.332f@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260601123228.GA3383916@pevik>
Date: Mon, 01 Jun 2026 12:38:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] doc: Add missing API references to
 api_c_tests.rst
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

as mentioned inside the cover letter, this patch-set has to be
added on top of the " [PATCH 0/4] Fix documentation issues "
patch-set. Once done that it won't have issues anymore with
warnings etc.

> Hi Andrea,
> 
> > Fix broken kernel-doc reference to renamed tse_numa.h header and add
> Not only this patch but none of the other two actually fixes it. I suppose you
> forget to amend git commit.
> 
> How about to fix this one in a separate commit (which you can merge right now,
> no need to even send it to ML) with the usual tag?
> 
> Fixes: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")
> 
> Specially because Cyril might want to review if all the docs is correct (which
> takes time).
> 
> Also there are still some unresolved problems, but we can fix it afterwards:
> 
> include/tst_test.h:302: WARNING: undefined label: 'struct tst_option'
> include/tst_test.h:325: WARNING: undefined label: 'struct tst_device'
> include/tst_test.h:361: WARNING: undefined label: 'struct tst_device'
> include/tst_test.h:502: WARNING: undefined label: 'struct tst_path_val'
> include/tst_test.h:523: WARNING: undefined label: 'struct tst_buffers'
> include/tst_test.h:528: WARNING: undefined label: 'struct tst_cap'
> include/tst_test.h:531: WARNING: undefined label: 'struct tst_tag'
> include/tst_test.h:533: WARNING: undefined label: 'struct tst_cmd'
> include/tst_kvercmp.h:97: WARNING: undefined label: 'struct tst_kern_exv'
> doc/developers/api_shell_tests.rst:30: WARNING: undefined label: 'struct tst_test'
> doc/developers/test_case_tutorial.rst:140: WARNING: undefined label: 'struct tst_test'
> doc/developers/todo.rst:62: WARNING: undefined label: 'struct tst_test'
> doc/developers/writing_tests.rst:141: WARNING: undefined label: 'struct tst_test'
> doc/developers/writing_tests.rst:364: WARNING: undefined label: 'struct tst_test'
> doc/developers/writing_tests.rst:558: WARNING: undefined label: 'struct tst_device'
> 
> Generally changes are good, thanks for finishing the transition.
> With fixed tse_numa.h (preferably in a separate commit) you may add:
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > kernel-doc directives for 12 headers that were missing from the C API
> > documentation page:
> 
> >   tst_clone.h, tst_device.h, tst_fs.h, tst_fuzzy_sync.h,
> >   tst_hugepage.h, tst_kconfig.h, tst_memutils.h, tst_safe_file_ops.h,
> >   tst_taint.h, tse_numa.h, tse_swap.h, tse_uinput.h
> 
> > Convert plain comments to kernel-doc format in tst_device.h,
> > tst_hugepage.h, tst_clone.h, and tst_taint.h so the documentation
> > builder can extract them.
> 
> > Sort all sections alphabetically under LTP C API.
> 
> FYI I quite liked that Core API was the first, but ok with the move.
> 
> Kind regards,
> Petr

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
