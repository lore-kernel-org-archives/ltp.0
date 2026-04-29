Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A16FF885A
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 02:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777429403; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=UnbzBzpVpCeAhHsFEV1j6ZzZYRmwqEpzpTjj5vMDCkM=;
 b=FwVPS0qkdmpqJgMqpB4pOiEIuu+684SFgGTuVvUYpBews0sKjCqeAHG12liSJxIt+6DJE
 JWlFFN6/XybFDc7r0MikznrCC4+aWL14nbTnSC4YlxxE7uuVcbMFllaT/pYmsyUD5PyHmH5
 JNqDGrfM2whgBH7dFTCNR5v2nRvNkGA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B19E3E28C1
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 04:23:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA4E13CFB7E
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 04:22:58 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BB98B1000977
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 04:22:57 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44261378651so221184f8f.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777429377; x=1778034177; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7/6q9P6YJp4RUo9LNJ60H41YG7O7J6VDDpuLLT8cZ9U=;
 b=YwKVniKRK3UJ1qbdFAYUuFAutY5Jn0XFcfys7g4ZpyShFNGXegDUbJ1H5ZrbZpSfxA
 4K9lG4roqFZ0E/cr260uLP7XD/Gxt3/7gOmmZtLs5MWEaxDsDgWg8Xa2eEXJXT7gsMHZ
 JQOuHEeIyqYzMvDLwaGAfZaW+OWVkbbqwnrSTutdga1Fa5i2APE01peVxUqIiLEzrlbv
 vpvebm7Zzfs/9z3wlpEC1zbj8nvnK7e3OrUKeIlE45MML1BcX2NqJv12zQd8u73OOa4M
 Bxm6h0BTLZFiz6w2tLbKLewjDgdHyMxgdsVG/7KTs77tCPtGGRJy0cD/LYQb9YD0dXPF
 zpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777429377; x=1778034177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/6q9P6YJp4RUo9LNJ60H41YG7O7J6VDDpuLLT8cZ9U=;
 b=XODyNS/n/o+1jmHIyog2WOlxj8TsMMVcEssA0S5PdAUR1Zdb2M5EVNgOzxAEK+hIK4
 KsgMVYfqh8c6TA3csGCqXD2NBFgexmEQ/NX3WNko/jDoGH4FY/rGU4oLTXO11xhctArG
 6XIzHV45AXIo72pi2IRaya4GuLMJixIanXnkDLcjqS02LJeu7OqBZXsUPjRmOIFzuui3
 DjUMB8VUcjeFvKNbUHq58WelYNKrln93myeGzl00nEUHSOjE0E6zPMmP+BTJoOZcGe1Q
 CCJBwaQzZF1HJbgPJOfr1RtaYLFbvubADXuDYqFXKKGJbC2KXJgUVpX7XspoHXi7Cru0
 vlug==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SOxulhKklkyLo4MXRR4zUqcOsNRHBf4iFf5Q2COOVQ99NWWUoYBI919eD0WT9jYpjaa0=@lists.linux.it
X-Gm-Message-State: AOJu0YzfhjI8oKulorwORmc4EpFyq31ChUDPemA+jNwZS+A8gAq0ewU9
 4XCNjL0pk7nZeLMdtpwiYJN34ql/Aub+UQSeNTAL3YAr/4HdAS8X2lXnVluH6v806Q==
X-Gm-Gg: AeBDietpSAwp/VMXe+4FRlcoUX8RY1jQ4EcoQtnftwB98TfUojh96E/KJhnyC2PRyQA
 4CcepLv5/BuJRP7WaLFMrv4y6ipJK6RNLqBxmA+3d8SzoUYLVYnLPgb2nagEugOGCuDO38MXkcy
 ejhAAs/1+Jwu5QPOCV1XWt86fxCTsOQi9Pbq3fozQlSUeJ4K95OLmiMIb+2PvSOF4OHEksLvuoY
 20VBpoPmEPIf6W34mayW14jYQ1udnLILMt4f15KqJ2RcwWyl5LV5bem5aagHmCim6eVYYpDS+Tg
 pNYuBKae+vYBAuJBM0NVLegLP5aKPm6rnrTJLn2RYUcfb1AW2pxdqBvg3JLeEdLmDylvopeRErP
 Sy4sxYKxTsyeeq137anY+posatXR4sUvXBQyjHo1DsGUXtG6N1NchxJ07q3mQyHp0i43UUM8Re7
 sfy74HuHrcLRuSlI0cvbZLZSFySsoXLL9GyzJ/MWRI0rRq5sGTQOQ=
X-Received: by 2002:a05:6000:2704:b0:441:30d8:f023 with SMTP id
 ffacd0b85a97d-447a3516993mr1445545f8f.6.1777429377142; 
 Tue, 28 Apr 2026 19:22:57 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7217cb3sm1750096f8f.18.2026.04.28.19.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 19:22:56 -0700 (PDT)
Date: Wed, 29 Apr 2026 02:22:55 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <afFrf9OtAUkcOjLT@autotest-wegao.qe.prg2.suse.org>
References: <20260427115941.31945-1-wegao@suse.com>
 <20260428125804.GA921372@pevik> <20260428163415.GB921372@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260428163415.GB921372@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: TCONF on systems without swap
 space
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
Cc: Li Wang <liwang@linux.dev>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Apr 28, 2026 at 06:34:15PM +0200, Petr Vorel wrote:
> Hi all,
> 
> > Hi all,
> 
> > > mmapstress06 is designed to stress the mfile_swap kernel primitive, which
> Uh, I overlooked "mfile_swap kernel primitive". Then the approach would make
> sense, but is it really true? mfile_swap does not exist any more, not even in a
> git log. Test was added in January 2003, e.g. even before 2.6.
> 
> > > manages shared anonymous memory. On architectures with large pages (like
> > > 64KB on ppc64le), the test's hardcoded request for 32769 pages results
> > > in a ~2GB mapping. So in suse test system configured with 2GB of RAM and
> > > no swap space, the test will fails with following information:
> 
> I'm not really sure. if that's caused by missing swap or would it work on
> machine with RAM big enough which has swap disabled (I guess you retest with
> e.g. 8 GB RAM). Otherwise I'd prefer prefer to deal with errno ENOMEM (12)
> instead (as I pointed out previously).
> 

Base description/implementation of test case, The original test is "passive," merely creating a 
mapping and relying on external processes to trigger swapping(case has sleep_time parameter).
Further more, this case is "ghost test" for current kernel, it do mmap but never 
writes to it, so kernel never actually allocated memory, 
Together with current obsolete logic(test targets legcy mfile_swap) i suggest just delete 
it instead of wasting time patching(refactor) it. What do you think? @Petr @wang li?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
