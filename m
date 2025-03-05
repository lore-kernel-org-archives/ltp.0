Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8596AC282D3
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 07:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741158296; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=z8pgMO7GKQMeJmx5wyPLUZ2/ReYUhAi8nMG74sK7tL4=;
 b=IyoGLTaSt4C9GmLF+n4+slMsN/yDg8CDVY4h1oKx4dQQOQMNSvnPRjHU4udAmRGUk/lCZ
 JDOESpn8/OB3p3fEuVZKYACk6lQx/a/iJvGSPzMRlu69KsCNtNvHuxws6MG8d7phfJrBKEy
 I9RCKxLJS1D5udhvC3LHk5pX9HA7Rx8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F8323CA090
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 08:04:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 172023C9B53
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 08:04:35 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 626261BD290A
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 08:04:35 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390eebcc331so261331f8f.1
 for <ltp@lists.linux.it>; Tue, 04 Mar 2025 23:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741158275; x=1741763075; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JjsMGlIZRV9MdJNwt5JPdBRu4WmiqB4HlDyF+SmHLRg=;
 b=BLTpg3wGs4PO/Ol3seqbEguotNisdqBbKbZOj57pGTtmHA+qrh8WvaIIe92k0tobhk
 +yUgSH9922mz3Twa8wzlyFxQ6rwD7tD+E6FPH3h1xNOAZ5chXZFVT3HHZxuCuXrjCrVU
 SqwaY1z9+o/Z99HP72yrEhFT2t6RKbq9o32zDD+iXE1xFPdTcJBI5ZJhtWQmSdxJe+JK
 Ws0ORgcI8gnKicQwzFxZF0vJG5IZ0w1swg+0jAa2TlpIKk+GsOwdmnO/vVpMnAOXuZKq
 S7wM0GbHGR98o/2DcFV7X3zYlIMSz+TWgQYQZrwjCLWXkvNXvGEdSNkhn0LCrivpLhgV
 cYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741158275; x=1741763075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjsMGlIZRV9MdJNwt5JPdBRu4WmiqB4HlDyF+SmHLRg=;
 b=m7fa13VT1XBN9x12KWSjeM7ckOwz7FDVIHzfkBX5MUcGyrEjn+s3v7uL6Vr7O/fyIR
 RYyvym9IUeL9EjzK5eDVFyRnFGaCQwrFUYOXaA2lRYM345WkL7a+002z4Wbz0ymnipxJ
 cbDSwJazhKb3QZ4+EX5TQDZF9HZrTJVrtYCXM49Jv9dhOdJp3HghnJfHZN4EcJb1c+k9
 B7RJAZ069qHcMSuU5RZX6cJnjRSTSumUBqdv7eHmoIneN/Z6s12dcgMTSWvRgPGX/W2l
 SrCykMPTSuKcKpYnbCtU3vniy3acPGHE9LF7Au/4DMtY7fMpYSnkAFlp8c33btBIN0m9
 Hz0A==
X-Gm-Message-State: AOJu0YytGwCCZYTzgcgYgaQWQMhhiN1bkTNAZCPwNlB5gbTBbqGGLhe4
 wrbdoYNVxctRZ82Kn79cuXD2ABk8J/eg0OoxyrVNecnW5hCT7WlXGhTaDhw4uQ8d/wLNF1xtJYM
 /lQ==
X-Gm-Gg: ASbGncsOfusgWU0XdZ1GAasrziEsdx4tGsvdkdySAUuJkDZUAMmK7SR3GjVinX9tfBt
 GEOA/lgUdJp2bkCgmeK0nMrctLNyLaxkQW/uoUvN9AYXqaYarx83ukHjlI5YU5tOCLXBHtyPYFZ
 KPwN8fTvC+hkdKyfX//8onFtRWGl/0rMQK21s6gFlPK0vKK7p8K3uH9qxOfRSlehUldGBBk/jxk
 phB3lPvDrfPqCmCTubFNGlxhGX/fc5V2WbGxhA2Ia7Ozhc61SRFdw1NBxt37WCid/DZLR0E6ePb
 herTfWdw9FdpluNvkSQGwHOIR9g6rcHNgpxNQxI=
X-Google-Smtp-Source: AGHT+IE3d65yv/b8aps27aq5cpzxzi/LwNEKN5hDLfj8Cn9nbHSfCsGKOTe8UJqroOA8Ex3N9pcWrQ==
X-Received: by 2002:a05:6000:4025:b0:38f:23c4:208c with SMTP id
 ffacd0b85a97d-3911561aba1mr4712717f8f.18.1741158274617; 
 Tue, 04 Mar 2025 23:04:34 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd429370esm8212735e9.14.2025.03.04.23.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 23:04:34 -0800 (PST)
Date: Wed, 5 Mar 2025 02:04:29 -0500
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Z8f3fbHD56aJrsMk@wegao>
References: <20250304034348.23389-1-wegao@suse.com>
 <20250304040601.23920-1-wegao@suse.com>
 <361f2b39-3deb-462d-90fe-4f2ee2de9b60@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <361f2b39-3deb-462d-90fe-4f2ee2de9b60@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] unshare03.c: Add test coverage for dup_fd()
 failure handling in unshare_fd()
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

On Tue, Mar 04, 2025 at 09:31:03AM +0100, Andrea Cervesato wrote:
> Hi,
> 
> thanks for editing the last version. A couple of comments below.
> 
> On 3/4/25 05:06, Wei Gao via ltp wrote:
> > +		nr_open + 1024);
> > +
> > +	SAFE_DUP2(2, nr_open + 64);
> > +
> > +	if (!SAFE_CLONE(&args)) {
> > +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> > +		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
> > +		TST_CHECKPOINT_WAKE(0);
> There's no need to use synchronization mechanisms because at the end of the
> test we call tst_reap_children() waiting for all the children to be
> completed.
There are some race condition happen and trigger failure sometimes if you do not
use this synchronization(Currently no idea why this happen). 
Rerun case 30 times can trigger 2 or 3 cases failed if not use synchronization in my env.
> > +		exit(0);
> > +	}
> > +
> > +	TST_CHECKPOINT_WAIT(0);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	clone3_supported_by_kernel();
> > +}
> > +
> > +static struct tst_test test = {
> > +	.forks_child = 1,
> > +	.needs_root = 1,
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.needs_checkpoints = 1,
> > +	.save_restore = (const struct tst_path_val[]) {
> > +		{FS_NR_OPEN, NULL, TST_SR_TCONF},
> > +		{}
> > +	},
> > +};
> > +
> > +#else
> > +TST_TEST_TCONF("unshare syscall is undefined.");
> > +#endif
> 
> The rest looks good. If you want I can edit the checkpoint thing and merge
> this patch.
> 
> Kind regards,
> Andrea Cervesato
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
