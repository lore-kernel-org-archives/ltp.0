Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B4EC25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 07:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716882656; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cwfzeoGm93Cf5cG9a1oWTKzzIFORikZhcm6lJzjYi6g=;
 b=SAV7oYjMOWkTy9zxKpw0aRH1G9PX42fa1rDI6wjkG8slC5aOc+dGS2RYFIAAWPcopawFx
 7KgyCqS/XUrNpSt60r3p5bWyqhrV5hgPAyW2q2OsHefbaPJPmcKW9jhf/LpyfyJBo0TvBu0
 k0OSaq7voWqwfHpRHwp1yyPjZH3wm+s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41A633D04B8
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 09:50:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 952763C286E
 for <ltp@lists.linux.it>; Tue, 28 May 2024 09:50:33 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1563160081A
 for <ltp@lists.linux.it>; Tue, 28 May 2024 09:50:32 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45dso551252a12.1
 for <ltp@lists.linux.it>; Tue, 28 May 2024 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716882631; x=1717487431; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fHYHFMEyzSNaWjhdl7pRZdFz42TCaf7UX19+2k1E+BM=;
 b=H5tmHT04oKPTW9htEtY9n9mMGlm/U1+BImYyD0MYVIDw/rZE8IgqZuCls4zBbSxwEE
 nJJjKn+0s9imlHE7q4ZOoNlCzB9cZe9+rnG+Vsf04jiRypqBe5C+LGiCz+6u0k5q8MfX
 hBzMBS8fECNwp3jWV49H3FLnSxJ+wnyvHBNMmw37KduSaydr0zUHAsxu3R5jcgFkEjgX
 IfmEXUqwXrIM4qTt8IgskpKIPhRFn159aYOa1wosGI0cLbt/hPdIxnykVzT9LZIGZ7HM
 4GmQ7o8hc2N5/wPouEITmsqeLjNIuEXXXfc0TcLGGe4s7H/TiW6ccuClUDOieWPF6f/J
 B25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716882631; x=1717487431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fHYHFMEyzSNaWjhdl7pRZdFz42TCaf7UX19+2k1E+BM=;
 b=vInt01UjXk3ZRwNV9bDS7Qex7Fjilu57sG3QajRvXLw3jRoLFayPuLNqMPvwlXUztq
 pZJ7pcCUumJ+/jprA2QIf4HrOnMmS5qjcidJBY8eu9QUMM3RWsHVmihPvsLyEED/Iehq
 9r/5hrFCXmX5O4KO3edd/WToaO2q+E+QGdW9Qt8spdswL5qGKMvdyMnxLHSfMVzSfOkv
 epuzNOISkY0gB7Ia+wleiDWHSe9IMf4ok6+uIKqvrlou9SDGkHV9YWaMMgZ97hqrlxXf
 RSbFOA2w3IYLpSBqfeJd3ly2swk8LgVLMXIYI3+DLtuXZz3FZ3Yyq3akqA4NuaEclqJP
 vbNQ==
X-Gm-Message-State: AOJu0Yy4awQF/WEs63FVdAgTNmejcSJ/N5po6C+9Ls1rHpYdNS4HHTNv
 dIHd5Jyph52RxuNFCvoUTOQfJYC53sOIlWdl4zI/T6/VAaqoUHvjzank5xSoPJGGHaNXE1zMSdY
 =
X-Google-Smtp-Source: AGHT+IFuh7lg+Rwpo0CQ7Au6T8cle4jY3sP3LR1r0SzBp3USYi3n0LIoqsA1dtSoRsghO+lnFf8MOg==
X-Received: by 2002:a50:8e17:0:b0:578:67db:7516 with SMTP id
 4fb4d7f45d1cf-57867db77fcmr5355240a12.37.1716882631368; 
 Tue, 28 May 2024 00:50:31 -0700 (PDT)
Received: from wegao.118.84.169 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524bae15sm6955529a12.86.2024.05.28.00.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 00:50:31 -0700 (PDT)
Date: Tue, 28 May 2024 03:50:24 -0400
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZlWMwIanniehN7Rt@wegao.118.84.169>
References: <20240527202858.350200-1-pvorel@suse.cz>
 <b4cbc988-1616-428a-af96-f278cb4fc1e6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b4cbc988-1616-428a-af96-f278cb4fc1e6@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_device: Print info about acquiring device
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

On Tue, May 28, 2024 at 08:03:14AM +0200, Andrea Cervesato via ltp wrote:
> Hi!
> 
> Good idea
> 
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
  Reviewed-by: Wei Gao <wegao@suse.com>
> 
> On 5/27/24 22:28, Petr Vorel wrote:
> > Print how much space is being acquired. Also print hint on ENOSPC.
> > 
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   lib/tst_device.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/tst_device.c b/lib/tst_device.c
> > index d659b54cf..635b39d08 100644
> > --- a/lib/tst_device.c
> > +++ b/lib/tst_device.c
> > @@ -289,8 +289,10 @@ const char *tst_acquire_loop_device(unsigned int size, const char *filename)
> >   {
> >   	unsigned int acq_dev_size = size ? size : DEV_SIZE_MB;
> > +	tst_resm(TINFO, "Acquiring loop device %u MB", acq_dev_size);
> >   	if (tst_prealloc_file(filename, 1024 * 1024, acq_dev_size)) {
> > -		tst_resm(TWARN | TERRNO, "Failed to create %s", filename);
> > +		tst_resm(TWARN | TERRNO, "Failed to create %s%s", filename,
> > +			 errno == ENOSPC ? " (not enough space in $TMPDIR?)" : "");
> >   		return NULL;
> >   	}
> 
> Andrea
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
