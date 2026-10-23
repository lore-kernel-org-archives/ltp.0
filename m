Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD6606A31D
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=j0DO45hV;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UAsL+GL9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792765405; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Yfp0y6Q+bQuupoweoJVFepHhaJj7eRsTH3APHmSDm0k=;
 b=j0DO45hVTP0QnEXkaywdW1tC2DS79yFL+a+Ex8cjxzWHlUMgwLDLGgfD2FVhpNbJCKqzD
 y1aV7LPhKdQtPrW/UQpFVYhNEFTOJ2ktDI19/bg1tSE0AGUdKZTK8ZuAms4cRYniFDaAsjK
 7EXRhI2gPI3rS/p9CzQUsxugw+AM9BQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62BF83E9BDB
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E76FD3C6F6E
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 16:23:05 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5BD82605649
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 16:23:05 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a218b13c4bso3626365e9.0
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792765385; x=1793370185; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ny1GKU7lQ0mqcyL3STgECLjO7ztsp2Lx9W/vrszapHk=;
 b=UAsL+GL9Rm09Hv7/z8VoFKX3OfabGsV42M67J3T1NfKVTYHGStbmeFO4wdU+Hxjws1
 I23W9/0qvbYxWqIEYe3koNRjfAyRr+RpDNfkcVDiRlsh3qtaDLtExtCO5LLXjtsy9p0E
 w32raP+a34WffdCNA+Mxb9tcsarA9jqbPDilMXYWAjhcR24XE7K7ZCNfklozEsNrQ+va
 le7K1zhM9dErmEchmaf6Vocjt7Tnb8vPZPn7r1W073yzBL2Qq54icpKlQIh1aTZ+fu5L
 SBpeKXEjwoToKNRi5x9sZGrijmBgcLZDOMBSEGTzPzTPyxAZTi2qqR1nKk/xDPHibxE2
 N5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792765385; x=1793370185;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ny1GKU7lQ0mqcyL3STgECLjO7ztsp2Lx9W/vrszapHk=;
 b=Pvxj569icpL/sdflcGelEhcYN4R6aCLEBkj/DTZ1JtZG8yJsUZ66xDSbAtl5iU3enO
 9+uFX6dcRntzQXKYn9Oon+HEGyRtgo6KD2LrU138Gx/z+I2PLcP1PHNvAw4E11wRJo28
 gM+5qswHK8agYvejv0vXOJHbsTV0zPQbTa+XYbt/pkWfj1pJMATwMzP00AjseQG6w5k5
 i7idi47y+vVCkgRFYRj3dSbQBe8ZAQj1qLJxeie6lGevS43LKvny6VpkPVRKSip379FA
 IdqJEen0AkKOJeWCoQXt2JytN+pxOfP7bylSAs/BWh1ImcBQHWYtMSyyhVcRFcEMP+cZ
 k+/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByfol2CuY5xU3JfsCl9lKIGHkYOpSiY1B3L3ifHB9gIWD60lE6rZR7c4+XsuRQQrrIfnAU=@lists.linux.it
X-Gm-Message-State: AFq9FYLchKgeYNCjSKvrpf8lfDpdu46cg4dTDZSz2n0fftMWT6xyyV6l
 10TwdmuTZTL9lsOvMiDqoOrZaTnU1etCRvQLGW/F52wQddHhug4LqSz1tYQr+rU9SwVBZ7J2jJc
 a8UI=
X-Gm-Gg: AYBFou0m5WxxdoooB+wxuk5dEZ/VFutlonBoiUgb5SOiWnTFAe5Rz9RvT7NsxGOSEgv
 hPMxXevU6KvqhYz1OnMPGcUPrO/N4FtTFR4zgoHQHACjA8yGztFGhhLvAoYkaAhgbR+4HyKJnAC
 9gmHGdKooFRCAb7CYCr05BILmJphC01A5FWPQg318Fst9XMyvYht/KA0bHKXdF/TL8lkTvqzeyE
 ReMPmxe+cxom6CzzDZZNuJ7MCXAT53udRd8jbrfV51pRFvRGONZCDNbKO0O1PbRuXAyoCbYOlqb
 iWI0pyWewUjc2jVD1Xz05L8QoTzYG7//73YrbQBISwVb7UWrhXkTZiyWaapYdADg2azSCtuP0bl
 p9OW70j512y5FDwOTifEd1dDyhbv7a20RAo1xs5EgJcVKDlCIXUOQ2ltfpxADQAp9NWh3ZkQcnC
 Hrcoc05IdfUcQ3AO088nucmSgm9NEIW9ya/pXYjr4w7z3z8jzf2nl+3wJyGL2IbG8YHgaCvtUMO
 h6ErrjNSP390TZlkRMPsa7W3qgZBFzO0k2ebAZugHY3iJnzPPIaBB+LM6o0AZfcKKxgYOEuEbZJ
 WvXDcBGL49kQ1jULHrjmqp3l0zWoaayXLuoUmM3vZ2f/grxNPM9/fQ==
X-Received: by 2002:a05:600c:1c09:b0:4a2:397:73f7 with SMTP id
 5b1f17b1804b1-4a211cd5b7bmr39573225e9.27.1792765384572; 
 Fri, 23 Oct 2026 07:23:04 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cdc0d1dsm8498505e9.12.2026.10.23.07.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:23:04 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:23:02 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <atttxiDuoelkKaCo@autotest-wegao.qe.prg2.suse.org>
References: <20261022022824.19735-1-wegao@suse.com>
 <20261022022824.19735-3-wegao@suse.com>
 <20261022154436.GA419745@pevik>
 <atrKnXXqaislOimV@autotest-wegao.qe.prg2.suse.org>
 <atsvLxoiVM-panPC@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <atsvLxoiVM-panPC@yuki.lan>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 2/2] open16: allow restricted O_CREAT of FIFOs
 and regular files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
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
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Oct 23, 2026 at 11:55:59AM +0200, Cyril Hrubis wrote:
> Hi!
> > > > +	exit(0);
> > > 
> > > Do we need this explicit exit?
> > Yes i think exit(0) is necessary because only the child process reaches this point.
> 
> Any child that returns to the test library calls exit(0).
Thanks Cyril and Petr for pointing this out, and sorry for the oversight on my part.
For above case SAFE_FORK() returns early in the parent process, only the child reaches this
last point and we do not need duplicate exit(0) since child will encounter
run_tests check if (tst_getpid() != context->main_pid) and do exit(0).

Will update it in next patch.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
