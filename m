Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFA3CCF9F8
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 12:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762344372; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+TnG+eg2imaRGUIZGcDyXLEouw8Mv+I7HU5zAv6OZ+c=;
 b=b651G2IFDhW+xz6sVka3Jnl44XYCVYM4OPRBPVFZbe7YhJaCWQz3UPD2bzTr1A+b2LHy6
 Vuqwu77Eaq/k716QSa77rOcNVvjz0HWnZdGDTAn/x8K3cXUvIddl5dUVRz5sAiC2KWMoOck
 rRFO3FfhsQsXUyB0BQqCPaSqUTpvl7o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E41B23CE464
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 13:06:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 922733CE3C2
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 13:05:51 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCA361000A21
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 13:05:50 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so1186907266b.3
 for <ltp@lists.linux.it>; Wed, 05 Nov 2025 04:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762344350; x=1762949150; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+FtZY8HVGB8H/rwxocxZePj3qomC6OI3m0M9m/4jx1A=;
 b=DTEnmyPcNhBsW29w2Ba0V4cngRPP8vXZoIfGFpC2DzI3JVV2O2NCBiAv2pVXyN8gW5
 Wrf4lAUx5ro/SXvcNqTvacuxnjZKjqaT45mF7RUw0Yqqw0TRAbP/MmRsJrdCnMo+mYge
 e48scCRIGHYp1UWANKS3LHM2MAQPAzTIORkIkuA2dNy1YDVcwrnImeFE5qKBsdCMPvea
 qc/UuxWznNc6H2S9pkiG+7hoEnVx5noTGz3mr4IiAKTy3huTkQyta3F/Wb6g/HIRfjTI
 S4k/WpoD1kjQEg0Na7SIC6LFIaIERmJ8Ika9qqR0Cdff4Phx/2Wv/E+nJ9eHgjAcZCyF
 HtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762344350; x=1762949150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FtZY8HVGB8H/rwxocxZePj3qomC6OI3m0M9m/4jx1A=;
 b=C3X9bUBCBT3hTKK9aU+TvxaKIE7WlUMZDauTor1ZI/ELsbHKyr5ow22nsRr6V+G0XV
 uHSALQsrii3+dfypnzi3VsaOvBYt7LAG0pcINi9heZN41SVoZhyVg497AZXIQIkunFKS
 C2A69ad3vuuLwHR+GsiY8CitngnzUB7oF7nBJ/coci4OFPcr38HfjEtU31Llxy9Mvhr7
 YOLtmdClGmmwf9feYpekEdsdVVXmlt/Vc8TjbSab4eJVEn2doQ7Nx5jnPD2W1GVpyreG
 sRBS88bDYAcZF+bJLbguAktcyRQA/K+Dl0YYlZ1K6mzZP/ri/Kq072qSQBpSvZITF37V
 mOWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/slKkv5G6LH1Vx+fvkhGwxQEJSg0eZlDopdGEjl8pMW4888W8Q6N3YMkm5lQzjPjom9c=@lists.linux.it
X-Gm-Message-State: AOJu0Yw5MWqXapDKEEuNBLN0RuGwHZzlvUIqcaf1j6LVdjde2StT7PPa
 lwpv2Eofsbv9sFmQSE2dqm/hwxVQ0tbxJhdUyDal5jLvrQT8+X6m0Jx8MBPrhW5rtA==
X-Gm-Gg: ASbGncuUMU4fvqzuPMjEHF1RvRBTueJftITrQyZcGACEr85HRol+TXqus58S6CXxzN2
 ajcGtGTXnQpAgXCg9qs5wJbg+pI9ervqDdO9jp1qHqkVeV3M4rkSD+3paJI54y+c8irklRP6ZMU
 fhExx4/pA5uxusN+pxKJlIiTKWRKO5eKLt4jq5MtCZzlQmsKHOryOJKjD7j7PoTPg7YHm0gwRL3
 6CfZ3BQywFb0mZ+SPO0AUAO0uo1t/JsapZ10M/O4PkJybJgO4VgHgBnvT3FtmUij3pMuwYQ2XP4
 bntFPxGRWiV5pr0gDN/vNI02CHDOgBoufk0ztUUuO5NsBwbKXWDx3Q6JUdtTbwgLXkjrtDiuF5h
 JRHuq1t+V4Nd/yfAmJ1NQ7bCbx9jU6BN3vHrCRZ1mz0Yy+fkhnHshHCxwwd1Yf7+tVWEURR9g81
 mhKy7qK5HAWkMU/xzGfg==
X-Google-Smtp-Source: AGHT+IFP9LXZdJMxOK56zi3sLdd46V3F6Rn1+6Ctoi/XZm+LJuULAA1hkRf6kcwy/iPb9Jy5PE4/8g==
X-Received: by 2002:a17:907:7f0f:b0:b70:b7c2:abe9 with SMTP id
 a640c23a62f3a-b72654cdf8fmr234178366b.38.1762344350146; 
 Wed, 05 Nov 2025 04:05:50 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b724074f5b1sm462044866b.74.2025.11.05.04.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 04:05:49 -0800 (PST)
Date: Wed, 5 Nov 2025 12:05:48 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aQs9hHHM8f9voSj3@autotest-wegao.qe.prg2.suse.org>
References: <20251030192543.761804-1-pvorel@suse.cz>
 <aQsOybjYzImfJopq@autotest-wegao.qe.prg2.suse.org>
 <aQsnO8YaLLt01WAy@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aQsnO8YaLLt01WAy@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: dirtyc0w_shmem: userfaultfd01: Add
 safe_userfaultfd()
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

On Wed, Nov 05, 2025 at 11:30:19AM +0100, Cyril Hrubis wrote:
> Hi!
> > > +	} else if (ret < 0) {
> > > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > > +			 "Invalid syscall(__NR_userfaultfd, %d) return value %d", flags, ret);
> > > +	}
> > I suppose main error handle if (ret == -1) already cover standard syscall
> > error, why still need check ret < 0 ?
> 
> We are testing kernel and we have to check for situation that are
> impossible under normal operation. There have been cases when a bug in a
> kernel patch caused the syscall to return invalid return values, so we
> are making extra sure that this does not happen.
Thanks for the explanation. 
Reviewed-by: Wei Gao <wegao@suse.com>
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
