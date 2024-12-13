Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E94DE7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 01:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734052132; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WInIzknj2QmXw80qLuxLglAGGMcne0VFXFZNx9w/VL8=;
 b=Nueh6Ty9r9R6Ifq3tPavEP19dtpgARiE+P37254xA/uivgJNoEgNvCxTVOWPQ1iLuK5Fe
 qZV9BLUsVuOOOlcWQ2mGn1a8ONHe5BXWl5m437LWeW0EXhGSxMseVdINPGIpN45ZbmoVTgv
 IwrcIVwDXFQb4xsxdPSKFllOFG95wxE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B01F83EB184
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 02:08:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 861C93E9803
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 02:08:32 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C2E91016FEA
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 02:08:31 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso8469665e9.3
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 17:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734052111; x=1734656911; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TDLpdoLGHo+qN1+zdPI7VjrnBNnQwsa380EQWxzvQ3U=;
 b=X0JxPYhaSa+aZy8vmO+6EgI+4zaJu/WXJ9ITHJzJt/WnFkME97RWElWaAXBYSkx2EQ
 ikpQhI3Ccgp8OYOXlf5Bt3hiBFLQKby3A4S3kuc2AxSrw6XafB9vZPUFtqM68+LjiHTH
 X/SusmnS8Nvy029cfArGshPbZfFqs3w9okiO2+JghUBRvz+xApiJbVH++FJINUXYqKQy
 297a9YU848tS+efsn2UR6TI8UzFvGSLxl9AgAyFPLnh4LiR/3s+VJdES0iM4D2rMDEnI
 ASgvGWNfxAdRcfClc7sE9bhFQ765afeTiOsii5mh/fc3wGblR7iCrbXgXSDlqeveAyQV
 X0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734052111; x=1734656911;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDLpdoLGHo+qN1+zdPI7VjrnBNnQwsa380EQWxzvQ3U=;
 b=oV4AZwXJztKEvOvSAP6RJXQB3MLe3zn4ZAJaSGvrQpr75g8jnd9ky3on48oLqECCUg
 eOl9vj9QZZUrVcHetnSxNyMdC9GvlZXWTxo0HQ8Siftxn5dyQ1PW1d1ur70yDxZIAKY0
 zYHtA2IzBM7w5ww8gyLsJfm9lpEW0wrk6E+gHpm46sV931KtiexFedyPUQuJ327jLzaB
 MO2Bo6Jx8X8osQaWkzhHw9x2epLwIccmwQ+em0MsklOkYMotB/8hUH9QYZBL9R7kgIUJ
 PRqs+XUrIqwBSMYR7cFTq7WcGkmEHcxRP/YKvjKUYR1ElPq3CeC9EWq+CEvTJrY9IORi
 4g6w==
X-Gm-Message-State: AOJu0YzpaP5FLQ9s3TM8GfZ0Ep3TAn56wXhht0VmoTsu2cv1m01HQxUP
 l5moz8ceYAKXwcPdeqEQETEtOQXMUOFo+xYMwkF7jhC6RHAiyB/6Ng8tdqy6gOMGuaYOKdKyAxg
 y
X-Gm-Gg: ASbGncu0yLb5UEC/rA6rtAL3AN4jhtBxbak/KVlH+NcHfs4vs6JnmeUC/94qI5v5G7x
 cjx7sLVYoAUFlPxkpqXNIS32UHhlHPWyBKGSZzKQ1AeMDpi1m6fiIHFBMHVRsnZWuET3Vr78ca1
 JkKTxqopIBpwm/RyWr3c5NhUJNq4bLeYTpfWIx8D8sTN+1cI80PuhJQewLSh9tAt8wJfijQ6fEp
 IyInzD999EiAQzaHvom+Bj24p5NeRKilvGb5zwwOGDlVg==
X-Google-Smtp-Source: AGHT+IHaSVXhzlhLDRlBcvGMuCCxJvUtG2QwJKVO+PSpoRTh7g47Yl9LZEpqfYTDvp6KomRiC4sjCw==
X-Received: by 2002:a5d:6da4:0:b0:382:4926:98fa with SMTP id
 ffacd0b85a97d-3888e0f2cefmr321984f8f.40.1734052110962; 
 Thu, 12 Dec 2024 17:08:30 -0800 (PST)
Received: from localhost ([152.250.153.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21641f46e17sm81926405ad.221.2024.12.12.17.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 17:08:30 -0800 (PST)
Date: Thu, 12 Dec 2024 22:08:28 -0300
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <bch7hrahlshmgsodzp56jqcpwvjwrhzud3z24dvzlskokxoyo6@vis3gda44bwk>
References: <20241210-convert_mmap01-v4-1-c2338a2ca071@suse.com>
 <20241211014710.GC383036@pevik>
 <heoebo5b4mslxrpopscllz7a2rfviwltnxsvtl6bvsd4h7gacz@kttzguhbtix2>
 <20241211190017.GA440022@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241211190017.GA440022@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap01: Convert to new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello!

On 11 Dec 24 20:00, Petr Vorel wrote:
> > Hi Petr!
> 
> > On 11 Dec 24 02:47, Petr Vorel wrote:
> > > Hi Ricardo,
> 
> > > ...
> > > > +static void run(void)
> > > >  {
> > > > +	pid_t pid;
> > > > +
> > > > +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE,
> > > > +			 MAP_FILE | MAP_SHARED, fildes, 0);
> > > > +
> > > > +	/*
> > > > +	 * Check if mapped memory area beyond EOF are zeros and changes beyond
> > > > +	 * EOF are not written to file.
> > > > +	 */
> > > > +	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz))
> > > > +		tst_brk(TFAIL, "mapped memory area contains invalid data");
> > > FYI test fails when run more iterations (e.g. -i2)
> 
> 
> > Thanks for taking a look, but I don't see the issue here:
> 
> > # /opt/ltp/testcases/bin/mmap01 -i4
> > tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmaiVJsAq as tmpdir (fuse filesystem)
> > tst_test.c:1890: TINFO: LTP version: 20240930-73-g865be36ffce8
> > tst_test.c:1894: TINFO: Tested kernel: 6.11.0-virtme #1 SMP PREEMPT_DYNAMIC Fri Oct  4 13:39:48 -03 2024 x86_64
> > tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
> > mmap01.c:49: TPASS: Functionality of mmap() successful YES
> > mmap01.c:49: TPASS: Functionality of mmap() successful YES
> > mmap01.c:49: TPASS: Functionality of mmap() successful YES
> > mmap01.c:49: TPASS: Functionality of mmap() successful YES
> 
> > Summary:
> > passed   4
> > failed   0
> > broken   0
> > skipped  0
> > warnings 0
> 
> > I appended the "YES" just to make sure I wasn't running some outdated
> > code, can you please provide more details?
> 
> I have no idea myself. I verified if I'm using v4 [1] and I really do.
> Can you please push the code you're using?
> Your code I'm testing is in my fork [2].
> 
> Tested on more systems:

Many thanks! After a fresh build I started seeing those, too. The issue
is that run() changes the file and the second run uses this updated
file. I pushed a new revision with a new set_file to put it in a known
state before each run.

FWIW I pushed it here:

https://github.com/rbmarliere/ltp/tree/b4/convert_mmap01

Thanks,
-	Ricardo.


> 
> # ./mmap01 -i4
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmabiOth0 as tmpdir (tmpfs filesystem)
> tst_test.c:1890: TINFO: LTP version: 20240930-116-g23f5a4447
> tst_test.c:1894: TINFO: Tested kernel: 6.13.0-rc1-1.g492f944-default #1 SMP PREEMPT_DYNAMIC Mon Dec  2 08:55:00 UTC 2024 (492f944) x86_64
> tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
> mmap01.c:49: TPASS: Functionality of mmap() successful
> mmap01.c:68: TFAIL: mapped memory area contains invalid data
> 
> Summary:
> passed   1
> failed   1
> broken   0
> skipped  0
> warnings 0
> 
> $ ./mmap01 -i4
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmakqgzvS as tmpdir (tmpfs filesystem)
> tst_test.c:1890: TINFO: LTP version: 20240930-115-g786b808eda
> tst_test.c:1894: TINFO: Tested kernel: 6.11-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.11 (2024-11-23) x86_64
> tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
> mmap01.c:49: TPASS: Functionality of mmap() successful
> mmap01.c:68: TFAIL: mapped memory area contains invalid data
> 
> Summary:
> passed   1
> failed   1
> broken   0
> skipped  0
> warnings 0
> 
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20241210-convert_mmap01-v4-1-c2338a2ca071@suse.com/
> [2] https://github.com/pevik/ltp/commit/a3c07097784088a679e77a4486bb10adfe03eea0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
