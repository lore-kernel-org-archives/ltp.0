Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8AB60A2600
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=jeMZ8iGP;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OAeIBPhL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792765865; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0h66IyhN973cL+ORAomqLBLEzw7B+5Knp62GxAtMkUk=;
 b=jeMZ8iGPlsvA5PHYzAJAqWvHUMjJ4H0yI+3CgdIEWBFr97CsnR6RmoSjs1dsMCCc4s9HX
 yLQHWc6smUiQfWuu0/LPtZvURDhzyzA6m31+27+7LoUX7BHnPQLMXjryrOZI0AdGnGexTjq
 epGsbWFJr32ilHhctJEqycKnjypi1e8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 107973E9BE8
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 16:31:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFAB73C6F6E
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 16:30:45 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A18A11002057
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 16:30:44 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so601955f8f.3
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792765844; x=1793370644; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X4ki8me0AKdG5BMPkwD/GiFUlOruUUAScdVwergT3wU=;
 b=OAeIBPhLiJN7wUaazPxmMwoKhzEtUdEbRTvBsXPJuADkFyoe9YRCC7+jYqEIKndh2L
 Bcp/d3hLTby5BVwJYbZbxUpLvKmqZMTCcWQPK/MKdws4TyS5NrhIkNRxkJQLvb/lX/GZ
 MUiC3Lm5X+9C5LC2c7xRgy1Hn4oiUMG0Hv/sut00SgK4cfoWXJskRrbEKYpsSJe7TErW
 dxFCDrIrNdmEugs/xmNqBl+ZF0NeKRdSOW/BhnmaxRY+5CIR6k78DlPeRb4ODvqRLEk0
 LrzcT34wsaiQXUjklHo3lAUnL7k+yZSv7zvsBlTO2Y4DaVYVkM30fFXWHPeVLDCUP4Ut
 9cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792765844; x=1793370644;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X4ki8me0AKdG5BMPkwD/GiFUlOruUUAScdVwergT3wU=;
 b=fBYmJNWJ5I1YWrkXTnqH1ybViEr/dFE6XlOQSm9gFCG66otGmW9KgSeBTMG2DmfP2S
 NSSWSm8mIlAyjrBVb8jbUUu4+yaCTZEmAELEzQ9ZunwLR8FpszZcuzVin8Tvejbe4ouW
 mmwS5YppBoZY+OQAwj84iSQtDVBoA9/MHB6/xjZQtndd815dfNe8DVyY469B/LC8/ED4
 feAcv0FvNxQ7h846FB2NRK8V+KeHk1HjajGPmv9IBujADv8/fKHq+CQjzf+RzbOLBlmm
 WeiK3LtQT6MVoffIYRTjhWsQPpYE6Js5UMUbAmZZrx8GQqKV20geECuwMgiDZvn361x8
 axcw==
X-Gm-Message-State: AFq9FYKHxQh+g5406aIY30mgQRPL4tYsN2QA3a16deYc9RCPvo7E9Xy0
 pHxL7+ANPOfITPfy/YTFgtW7YlLMTUQQRkaCm9waJha8dxLYRQBD0kUvCTH/6WxLTKztl8Jyf8f
 kyZQ=
X-Gm-Gg: AYBFou15r5I91BO5gMm1918Mjud4utDSiL8i5A+kGhLunkDtdTPQJoHA3eWOqcbKQiP
 RjKHtBmVnYt3eE/dZ5GZMTs3dNc4lYWJM4CZTeuP2sv/VrjDyyEB/wYbr0TMNAaqSl2Dabcm3gt
 g1l3a/EU9XQthuw5nDmsUCO6IUtuWfL8I0kUsHuu7r3bJyoMuF2HgbqLjiM9A3O8jyaaUC5bGsj
 6Raf+WidbA7C+5gabtDFXz3wb+i9ZVazjz7LfDp3F3EGOhNBKc/FBOIWVcrcBCrQuqsQHdRaeE0
 wrhVnB8xsW8TQlAiScpWpp8H2iH1/KS55EO7+Eocv01TcCFpH7+/HCDQmlvFJpoZlquhVZCIHtY
 UTA7y6V8DSnkQG94YdIBQnnN4LYIdiXE29hXBtm4PziVrl4bQJIdhxa1+8OejTdxmOF3EA3uYwv
 eFtIVibriW7N2wrqGLGwSJg2AKs3FErlgGCBgvu8ik4rpTHbbcWIpNYVMGPWpj/10D+2E7yccrw
 nPhd/fdY/w30+UuZs5823/k9/OscH3uxGcnwePcDfkFgnoj/anGIrkS4+nAkJKyNPhd0O7QarjE
 2WG66rpmQG6f19gV38/mT8RkHpCZk/uj4hc7Xkw3NV/k55E2gH1akw==
X-Received: by 2002:a5d:67c8:0:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e38594defmr2903062f8f.20.1792765843955; 
 Fri, 23 Oct 2026 07:30:43 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d412a04sm139661f8f.39.2026.10.23.07.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:30:43 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:30:41 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <attvkSUq_rqcpu6C@autotest-wegao.qe.prg2.suse.org>
References: <20261022022824.19735-3-wegao@suse.com>
 <nyxmYT58cq0uOlU7fpl6RzXmIEKsQXtL83EA@localhost.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <nyxmYT58cq0uOlU7fpl6RzXmIEKsQXtL83EA@localhost.localdomain>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

On Fri, Oct 23, 2026 at 10:49:58AM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> > diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
> > index 1a60028d3..2995150be 100644
> > --- a/include/tst_path_defs.h
> > +++ b/include/tst_path_defs.h
> > @@ -47,6 +47,8 @@
> >  #define PATH_FS_PIPE_MAX_PAGES			"/proc/sys/fs/pipe-max-pages"
> >  #define PATH_FS_MAX_USER_GROUPS			"/proc/sys/fs/fanotify/max_user_groups"
> >  #define PATH_FS_MAX_USER_MARKS			"/proc/sys/fs/fanotify/max_user_marks"
> > +#define PATH_FS_PROTECTED_REGULAR		"/proc/sys/fs/protected_regular"
> > +#define PATH_FS_PROTECTED_FIFOS			"/proc/sys/fs/protected_fifos"
> 
> I just figured out that these were added in the same commit that is
> modifying open16. They should be inside an another commit.
Thanks for point this , will update in next patch :)
> 
> Kind Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
