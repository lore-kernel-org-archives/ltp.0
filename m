Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95868F433C7
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 04:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776312956; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lQpMiFJu3Djn7En1z9CNmEXD4da7dCpeos8yqmbaHlQ=;
 b=eKnTLM0GlO/FP0iezK9JX+fSP6hKVxNYwxf2JFiZiO+RvuS6kKi6z5CsAMKVQ/wW+FmAR
 UGLuF7SinpyO+QCnpexaPeP06TB74CkS9QPv2acY/KA9C4ZT0QViWzyl0dfu0/hsdzF6po/
 BroYjYm7g1WjEJ6/2wbla0LLgWNesgc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04E7A3E5DED
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 06:15:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 310E83C6FD7
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:15:30 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6087D600708
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:15:30 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ba840146so73826935e9.1
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 21:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776312930; x=1776917730; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8q44evWtTri6+8R14EiHngj8x2AyDffWx+Xb2SC1edI=;
 b=WMMys7zVSrHt5aoWjYSWE8sImRSqkf5VPKYkkuW19D+uMXUjit4+a7CZgHzxD2+eof
 T2beuAIHCafeX0xPrlr1rupLMfi3eBrj/efQG1SvLmhLdHouIo7ynsatn+RjP6rxGTiD
 jRalvHpcmfGFfREc4AMbYbSthfSKRq2z00lAPjtOZQDNHwvBtmbqWq6kzQuXENLEmZlN
 V6o0L+Edm/+Yk731pby09+w5/+GwCKo9fSNNrLyuldfxmI6/GrdsTXdBKsZLRFtAY+Tq
 r3B4rk1Y2d2HcPhwqoez3+MnGYjxGBj90+1tqrZmuhELfa3OW/Gwbdjs1/viFT+DHD0r
 Eyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776312930; x=1776917730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8q44evWtTri6+8R14EiHngj8x2AyDffWx+Xb2SC1edI=;
 b=i6SeoYNmXq1ZMRnHsM6ZHouH7/sqlFToC9Akvk/loy48NX4pElG/+Oa7U8onbpWVwT
 Enpjc4TSN/zSBVd6t43ZKpNRqHZaSohvjFJzfrFyiiThuq/hWT3UR+ZNuGrkHiN6s65X
 yfIH4qvwNBejPemho9KnCKS93yksgFsVHElH+7X7USXuXhYiR0vpO+i7SaQrdGhP5ifr
 zdFZBhgF5fBIIbOwDSyzsZvWJoSzl6ElCMrzK3qntGsf69VnhOnswCNZCXB2EFrxW22W
 LRLckM+FqebQnv/VtoOmhp5B3v9eLwUcW1HCCUXU+yM+wtBRmMRPBSAV8g1Ax8jQ/6JO
 WDFg==
X-Gm-Message-State: AOJu0Yy996Mwn6+7dqfYZ84Z1DgJIR94bkyxnw2UP5J9dnuSPMY/3NCN
 Tl+VGM4SQ5/vLQsavLKI1ySAp4pIjEre8Ne9ZYLp3SQ2VMkFRrNTKrNhsoIZTKzGdg==
X-Gm-Gg: AeBDieuj3SAAB71wrPOOY/zgOgtRIvoDlVGLLgDQe5IPj8qVFLcWYJpPdWrAB8onXnO
 MvfQoox6Z7LD0JfOlcePwHjtyRW7dFSB0cQXpXjH5B4EbAR3/8mSdDyksuVsxr99M3HNLMxCS8D
 IychtJC1O6whGa0fzJXe5iuZAJKuqo6b6B1hx+mSlsqr7WQnQ0/TPNydCaSe+tkLZ8owWN0A8TW
 cR0ZyDDjpxw0iiZ9qhOkBFZZ777IqXLH8rf6xKtUR7IRyuwvgiJYW02P7CbM4tlY2mgtpmv6e+A
 o875kXTR5Rltse6fhhpEEXGwPZ1sb3Hm7QMBw/MV2jOoDS3EcPPMlLdOhUjegFtHvLxeC3kRFmG
 cTBYdNSaBkV4rIojQRrdDzMA3a+XTomd8vHyMPMeczowOoki7W52R9n5QduQCnJn1jEXalKkkuK
 iETkrIwwUL9kG3cPfsXs78I7MpBalNfjlLG86kXSAT
X-Received: by 2002:a05:600c:c091:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-488d683662cmr240351205e9.19.1776312929685; 
 Wed, 15 Apr 2026 21:15:29 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581b9fbsm20839395e9.5.2026.04.15.21.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 21:15:29 -0700 (PDT)
Date: Thu, 16 Apr 2026 04:15:27 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <aeBiX5pbee2bkT9l@autotest-wegao.qe.prg2.suse.org>
References: <20260416005603.22427-2-wegao@suse.com>
 <20260416024324.4039-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260416024324.4039-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: New library function tst_get_free_uid
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

On Thu, Apr 16, 2026 at 02:43:24AM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wei,
> 
> On Thu, 16 Apr 2026 00:55:23 +0000, Wei Gao via ltp wrote:
> > [PATCH 2/2] open16: allow restricted O_CREAT of FIFOs and regular files
> >
> > This commit adds test cases to verify the security restrictions for opening
> > FIFOs and regular files in world-writable sticky directories.
> 
> The body only describes what the test does, not why it is being added.
> State the motivation explicitly, e.g. "Add LTP coverage for kernel commit
> 30aba6656f61 (Linux 4.19), which introduced protection against spoofing
> attacks via O_CREAT of FIFOs and regular files in world-writable sticky
> directories."
Patchset cover letter and the tags within the test code (which already reference
linux-git 30aba6656f61) clearly established the purpose
> 
> [...]
> 
> Regards,
> LTP AI Reviewer
> 
> ---
> Note:
> 
> Our agent completed the review of the patch.
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
