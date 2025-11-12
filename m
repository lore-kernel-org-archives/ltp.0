Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55868CCF9F8
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762949698; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vpwbo3X8UfjxpNHTavletmSPBI02IfwJCVx6I1d7RAM=;
 b=SAMnUMM8vbO8IPKqIXwY3e2vLO+ckf9CwztQ6Ikqx+mfyYNLwJw24fvKE2wb2PRJmKrza
 pU7DH1w1Se3jUoTnpHy81YQymlA16/Hb1O2WVC1so7ZXnsrilfuZ58koGv122w1HYDzrwnC
 tjpXOMDisskyF2O9xrM8+vPQahpJqlg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 981A33CF77B
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 13:14:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C46303CE39F
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 13:14:37 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0C9A86002EC
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 13:14:37 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b729f239b39so129313666b.0
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 04:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762949676; x=1763554476; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w0wdczggqHXRpc2SYhpEZEkMfaPNQiPSMEobXcCyZok=;
 b=cb2NnvAw7W43nJmnolRCr24OOSgnTLX5mmWVMp6pdM1IWYv1FcO7NzlDRJE1CkT8T+
 t1NpeqqhN8ltDykaBJ2NpaqPC+DQ5BvE+37pvPu6iZ5RJh/LiyDum1KR6s+faoswIzWO
 ehPp+xHhxq2EoUOlKVmXl7pXzcP3Fk4J555WuNA/KCNEkZoxe7N9Q/uDZaYdXXB39+38
 jfguzuSEsXSBLjQCaqK8fVflygsSZMkJ+PuwFAlpjwxBTLAgEaT/FNq3lFBx4qls0wWf
 qBXK5jd90IEI1NuVx9XSpKSv3yU5WENsUNB7f1AHsFYi9uh8pW4ec+yU/L9ZJKPVuwZO
 ptwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762949676; x=1763554476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0wdczggqHXRpc2SYhpEZEkMfaPNQiPSMEobXcCyZok=;
 b=k0ZzvtGr2tgnOhss4vFQjt2Up/Fh2pwpau/ZmTbMrPFffp1UlrA2TCFIcsum+r5cAn
 ETzch1dzHdGBApQncJ8l0KJqF/3yDOXWt+cqJ8C/pWQnjz0pEu8iy/QrYGygqbWpKMNi
 U4sU7KZ9+GprS49agi85Exm+gi/9vdCvnmEKmP9QAT5latiZVDwTZe/d+uL4BPID+Lww
 sOXxzdR4RmFudr66DssiU1xLQRYlLsLCKDwM57VmhFcCmFO+runyDuonuTC/zueeMbCE
 +YGnp3oGoMTTCcJ0izXF88bJZJy96/ly/yu68aieW40TxsInlDJ2Frr2GbvmYggX8rP5
 khqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVW0rjpOkqQmC2DrwCS/oFGkEsJzNMYbGxigX9T1YPp19ToRWwjfr6C7ImUwMagbMMZ2c=@lists.linux.it
X-Gm-Message-State: AOJu0Ywdk3v++GQawdHySYXUhrjWtpE9sQJaUI1A+EnYU1ikNCQBkiwv
 zp5sLRO6qLhfz3fLHJqfjoqMcjF+LQJkHXuEneBPgOy2s1q8zyvI2t1owwR0BL1QrQ==
X-Gm-Gg: ASbGncu3LKF7LvAJ0cxUeLXEDIyeL7LwuhgIF+yYCP8W8Ah+OJRQ9hChGaSfPK0sYVC
 ACyMC37Z+S8lCIJFPnC9QighyqbIonFP1RSSWsXhjO08FoTSw77ccRDEE2C3krSRmLx8bXeXDXS
 xEDoNywrIpKsFM02xAFSjfIEe/S9sVboMs1tPCT1BbIN+4qNJOsG25Qpqw9WJuCd+F4k0jHifIP
 GypI3uWMIl1ndC/+bl/Vorzx1cgOVyOWvD6BgvjQHuX/Vh+5g7WwsaZLD8FANAOz1MurkepRyIX
 q7nOFEYqV92wttImRTNhgutGbkkMDofWO06Un9HrEuqBTIn7ftmD4J/xVtjLPkIsZK3CvWJDMut
 jvxkfxUG5wbVF9kLCPOxDthvbtzirGCaLhEbs7nuXljH7E7wiU1v/LWv/SCkxoRTted1bp/uMt4
 n4/GIzyVZq5sKNy31y6JYNcTzRfTL2
X-Google-Smtp-Source: AGHT+IE9dSD7EDbWeTkwzcd52dkKMEjT3/I8rGo9li9WovI+voGPK9xdir6pf8GDpeyotJrh5byuaQ==
X-Received: by 2002:a17:907:7f8f:b0:b73:2ced:9af0 with SMTP id
 a640c23a62f3a-b733143803emr257520266b.27.1762949676391; 
 Wed, 12 Nov 2025 04:14:36 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9bcd59sm1565872866b.53.2025.11.12.04.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 04:14:36 -0800 (PST)
Date: Wed, 12 Nov 2025 12:14:34 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aRR6KkOIDr_RVMLe@autotest-wegao.qe.prg2.suse.org>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
 <20251101012320.24972-2-wegao@suse.com>
 <20251111120600.GA50277@pevik>
 <aRQuc47d3PpTczVB@autotest-wegao.qe.prg2.suse.org>
 <20251112092236.GA80114@pevik> <aRRiLUyES4M5qjOm@yuki.lan>
 <aRRwuF-KGB4AqXS5@autotest-wegao.qe.prg2.suse.org>
 <aRRzA1ZRZA0osKsc@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRRzA1ZRZA0osKsc@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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

On Wed, Nov 12, 2025 at 12:44:03PM +0100, Cyril Hrubis wrote:
> Hi!
> > > > Thanks for info. Sure, no problem.
> > > > 
> > > > Cc Cyril in case it's worth to fix it in metaparse.c.
> > > 
> > > The metaparse tool does macro expansion, that shouldn't be a problem.
> > > 
> > > Also metaparse only scans testcases/ directory during the build. The
> > > lib/ directory is not parsed at all.
> > 
> > @Cyril 
> > Could you help confirm following is the correct way use ?
> 
> Yes, forcing double pass for the macro preprocessor is the correct
> solution and We already have the same code in TST_TO_STR() in
> tst_common.h
> 
Thanks Cyril / Petr, i will update it in next version.
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
