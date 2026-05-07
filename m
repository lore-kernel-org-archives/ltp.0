Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D22FCD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778147538; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mLq2iErgS2LNNl5ztJJp1pb8bgW8uL2rdw7w+c4fHJw=;
 b=Xq6aq44ofp4CrM1T1fLilnm0j7C57nFZ2qI5sSAtzkB2fFSTxfrjcMeECYCM1OH+LbXdh
 6UGThj1qi1Peo9z4fmML+5xGCuow93YrV5bwz7LuI2eTKqd0iZtAUg5UB4gc60IHFztpdF8
 9JIiS6eF0GMc1kbbpd//WqmYPCpZvoI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAF653E2C3A
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:52:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F23093E24F7
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:51:54 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C9000140043C
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:51:53 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso5366605e9.2
 for <ltp@lists.linux.it>; Thu, 07 May 2026 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778147513; x=1778752313; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OXJ/unXnUkRBfw7GtiQHX+zEpO+6psMS1w8yGtahe/U=;
 b=gZbIYShIa+eCUOfgfIObGMXWH/89Y7CntHQdH7kTZlkpfxzQRC9QbHCKp9CvB4oj/s
 CwQXYTSJy0WTk9PTTzkvjpoqui+6j23H6eREVHVVTQymsHVQJGXHnvlF2cnkIiYKACPP
 Oej4k0S5Gy8CqBAfiohfr84H4pLBUwMViwId4AoX8x1N/CF1vTwMZ62uo7jSljGsua8b
 /9C7jFBaN3Jhrlr7XlqK4M52jrLj6Qtsqvbh1eRgzIHfhv8KWIR7O0UDa7AQAVR2AIPB
 hUL2Tobp5GTDFm6j8K1tuak3Rss9f2tZ04J0nt0A4/sRXLhlwH6it5AP95gbKyAeDXg6
 KOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778147513; x=1778752313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXJ/unXnUkRBfw7GtiQHX+zEpO+6psMS1w8yGtahe/U=;
 b=DAFYKfdNSMXG4YX5ztQjkPRjwziKp9G5th7uFNITs7ihPu0MoRRykOQZpzpLKHYqtw
 JBtLCbUQOAdg/qw3xaiG6DuArXAdElxd8eqxSKB7gLIEVPHNOHCPJVJfyrgDt5R/rZN/
 6u4Gn5tWyz+c0hHwITngjqiLNhPgSbvyxRIWovx+6mYkyG3weZZpAWcDMtGhWWSA7f11
 TrsnMUTM2f2tSVGG4bOR74ccPAPTnDDawa6aEyDeK/8tLhR1HHRM7cx+Tg6t7GSGJmEx
 9TpTgOlDhP7cFf+nxywE87PDP7rkEbd4G+Bmax3WjwKW/skcy5di4ZBpzeO0B/Z9t9QH
 wXzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Dxug/klxNPHOwjO+XGL0yDIyTXax+P4a0dD/FdYPVrH/2lO6DzQ6/I0EgK3lx8ZgjSkY=@lists.linux.it
X-Gm-Message-State: AOJu0YyWyGQk+jDLTav29wucaDlEHRAiPEFl1Cy8gvm33LDDz8uiUlmt
 k0mXl72fb51DkiP2o/rZ675dzF9fdbgkay3m1q76sqWoEIadJ7+UzkP6pUs3QK3KXQ==
X-Gm-Gg: AeBDies3MnVT1ahTHeGiEIih2FuKuJVKfss/2Va3za9tRH+/JKKHkPy/5NR85F6slYm
 PbuZo9nDqvWoTU8H1emKRRP3DwuNApf5Ar0bHN4yMda9sToJhvvYNZvsWbmOiy6340giQrUCLyx
 Nyx/5S6DBOUEkAsUEE9HR9Csyw4mCUMnJ5SBaqiKG35S5LAhO1jrEvVUJLwbvp0dr2XpVKrjCvu
 7MQ2AFpvNDqbIffwBnAZzaZpy9P519FmDlSsTq4kz3QyolyXe4vMiiiixgaGZ/vvdrupMRs9atq
 O7j55jMGSK3hjJHojZjOlrG+qLR7JRuVzSEKhiewVRtACzWNZbm8zVZmIi1BK6qiuolBlCDDdV2
 ZREEwPVk909jMVWMGv/hpJTBG6VD9t8B48OSIKgy0DC/rgRavF74fcJfxc+u0wTQ/GCulVKgxbO
 bZCx0B/JK6L7//6bB2dJrUYq1C1kar6oTfwaJ02pSJocc3f4qtL5wFMhHQqpP5J86x99Y6pgF/
X-Received: by 2002:a05:6000:24ca:b0:449:a07a:967f with SMTP id
 ffacd0b85a97d-4515cf127cemr12323563f8f.28.1778147513032; 
 Thu, 07 May 2026 02:51:53 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960811sm19970401f8f.27.2026.05.07.02.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:51:52 -0700 (PDT)
Date: Thu, 7 May 2026 09:51:51 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <afxgt-lV0hlsr1L-@autotest-wegao.qe.prg2.suse.org>
References: <20260430063500.4035-1-linuxtestproject.agent@gmail.com>
 <69fb7a32.df0a0220.1aa799.d780@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69fb7a32.df0a0220.1aa799.d780@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, May 06, 2026 at 05:28:18PM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> the agent review seems to be valid. The shmmax is defined as
> unsigned long and we should keep the unsigned state of the
> variable.

Kernel indeed saturates shmmax to INT_MAX for compat syscalls
Relevant kernel code in ipc/shm.c:

static int copy_compat_shminfo_to_user(void __user *buf, struct shminfo64 *in,
                                        int version)
{
        if (in->shmmax > INT_MAX)
                in->shmmax = INT_MAX; <<<<<<<
        if (version == IPC_64) {
                struct compat_shminfo64 info;
                memset(&info, 0, sizeof(info));
                info.shmmax = in->shmmax;

> 
> Please verify that it works and we can proceed with the patch.
> 
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
