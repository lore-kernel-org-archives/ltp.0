Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECD1E88D6E
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 01:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775264440; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wsYw/xw6DZkQtVsrd0cBVv3dl+ztnv2GSicmYENa6IE=;
 b=e+bUks+mNFRVbQ8jZLty7q8u5QFlpQnjyoqPEU8Z4uaZO/veiB8czJDxRf6f+SSAmhpI1
 P3X+iRz8TlGrzFifTSVr3lE+IA866OKXf7M5KogvWalTRt9nSEV1yATh5ctFBZEscaLrewA
 OMyfhKw68WBbFL76lgX4hSUBwlwvIlI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03FF63E4E60
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 03:00:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C9D03E4E54
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 03:00:16 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B94EA1A0069F
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 03:00:15 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so17851125e9.0
 for <ltp@lists.linux.it>; Fri, 03 Apr 2026 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775264415; x=1775869215; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WHmaAKeAW3+YNNNp6HZ0djcuSrEYAfZDv+KxexQkaZI=;
 b=G0V6zJNrTAwQlBl5KP/Buv14cMPrDgZtRLm59vIk2P3RolwMYEPq9dGZCBq1NNYRnZ
 L/Vur/STua7gDozy2ixanahTphkJXzbetQHT6uQaiR5DjwU34am+b0uUuaCPYbs2dT2u
 YOMncuB91ELgwMHcWTFTAibP7QbUDNfKEa/099wzCEOHwYP7Q/JSGQol1SRmTvUoFCXP
 VKvzIcbbsNhqtGn98750PB6pVFgJ4XHU9KOjKHYfyiaeRDBu/dJ8iVP/tT31fYrc0uN4
 j6jO+38ctpqq7hqwd/MrsiNthY0c4Y5nZKK4CBjJpG76gRb7cEnekgeYGGZW2M2CrMUc
 0djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775264415; x=1775869215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHmaAKeAW3+YNNNp6HZ0djcuSrEYAfZDv+KxexQkaZI=;
 b=WDLNbXuMNuy433BE+IyDuz+nY0rzX8AtpIfXBy3HRrPNCH+4x2z1E1gH0GFhr3YH1V
 Uww1JkaBPE70tkh7dLh1wK+bCjLS1F0hklXw7uMeqfEq+20e/9JpsikBY+GD0ZBDbPI9
 qPJwcXLN0bdsuzYDN2lpN4tTi++Ib+YbFlj90s9NyxNyALazMiNXvP0Yh4yLYMQsmI18
 1+kzHViUphREtjK6Fb8EP91HuD+sqPJM4St9f5F+3DA/6WtxbA0UPFxO8yM1D/Fyz1TG
 WPRnoi660PXNCiKeOk4T+7XVwYDRb8az5ulrOih2xCvYiTnJP13I5dy+kqhEzS/pgRw0
 Eqtw==
X-Gm-Message-State: AOJu0YzOs94cT93lpUM1YwP+rcZsaAhRuupKOMvloh+ythVxEYr+2MAg
 4AgzR8r0F19BQzPquf+2HIURXc+V5D+53dWjTJH99X8Y46k2FFnS3fIHl0px0LpWtg==
X-Gm-Gg: AeBDieuG3mZ7AysA+0TTcBtY5l02Vkltguf3Gmo6iyMq93uysmY8+Bbuz6jKDBNf/Mg
 q7UutTPhECcP2/HVuMqDCtl17PqZFmYoHl4gu9qL7GtW3zdpRjrPYfhjSIy5FVQAIIjydDB/vxU
 8uwZg666LYmjs3kobWJLUwNBPS8JXTy/NFFV44jNApKmzIX1ptuRj9DDf4sn9Mz3/oxE2B0z23v
 y+bJDWBLogsyc3+N6dfzbys3c+OuqrPVVHGrT7YXSRB6hArs7PVslF36n0MomFa70O0dK10vWEH
 EaI2P6JAMfMuSCxNDMvMFnj3P+YCPYdEDax4tJW2udIidu9HwX5WoMH2dwc554DmAy3IXxJ1MiU
 UtO0ABgTeFZEYexgethm+hsY1pYUfrkpj88hf5s8R2c+Qxrdy5bD88f4ZxaiQlVa1srJktmbztb
 lmn/ogPADMdNtB4Ef/t/wR6yxJPb4wapYv0O/8BETaa9HHq1dwAYE=
X-Received: by 2002:a05:600c:4f87:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488994a77b1mr70465045e9.12.1775264415005; 
 Fri, 03 Apr 2026 18:00:15 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488980e7a29sm43380325e9.4.2026.04.03.18.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 18:00:14 -0700 (PDT)
Date: Sat, 4 Apr 2026 01:00:12 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <adBinAOKPvrk2diD@autotest-wegao.qe.prg2.suse.org>
References: <20260317074340.589-1-wegao@suse.com>
 <20260317114635.944-1-wegao@suse.com>
 <20260327181710.GC1097030@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327181710.GC1097030@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] io_submit04: Add test case for RWF_NOWAIT flag
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

On Fri, Mar 27, 2026 at 07:17:10PM +0100, Petr Vorel wrote:
> Hi Wei, all,
> 
> > +	struct timespec timeout = { .tv_sec = 1 };
> > +	long nr = 1;
> > +
> > +	TEST(tst_syscall(__NR_io_submit, ctx, nr, iocbs));
> > +
> > +	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP) {
> > +		tst_brk(TCONF, "RWF_NOWAIT not supported by kernel");
> > +	} else if (TST_RET != nr) {
> > +		tst_brk(TBROK | TTERRNO, "io_submit() returns %ld, expected %ld",
> > +				TST_RET, nr);
> > +	}
> 
> Maybe move this to setup()?
Moving io_submit() to setup() breaks multi-iteration testing. Since io_getevents() reaps the request,
we should call io_submit() inside the run() loop to re-queue the operation for the next pass.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
