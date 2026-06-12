Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2643DCD98CC
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 02:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781229944; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=tHdGl8pwfMKqnffjELJaPEw//T+zKakh5tL/grama8A=;
 b=afPbNMACCK6FU+y4ynvUvyEpLkcWXahMwvLlJrhrkLzJxtOPNLsD9LGqPD/biqMkpEZ3l
 jG3uMRed8BKWRU1Z9y/7Iigo/0MNP5klLS4Qd+2/iT4mvRJ1SDzN2JA6zpjmC8uWul4orV5
 39ouaFUn4ZAzZAkFZDy6GGq0pbphycI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E9423E1EA0
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 04:05:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0176C3C5593
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 04:05:23 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 41610140033A
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 04:05:22 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso355063f8f.1
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 19:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781229921; x=1781834721; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qttcJEsQiEfl3lWc0PlXIEYsPQbX9aFASczeCecuVNA=;
 b=dw02NQ9ztHxpiynohAISZSvPhTa4T9Qm3uLTvpMTuGG69A1QNzs/9ijLYCykoIFxtV
 wNtIWz4pJ3W1+5jHPA2l3FU6vckCkKSG0lW51ktodif2hASsTlSMzRUITm+9LM7fNDWa
 bVPIMBgKBAiTtKMPgX7ZtTqEDD8tXHwaLZXH33yjoUd1rjIMUAb8sK6xpZ7/tJExohtT
 icm+5NpVKLL6xtH+lKaQcO1jVSvN5YEI1LdKZS22anwdTO2XqsjG8n2GfENmQ+4Y1QXh
 eKMWY4yY0q9aH5QMJ6I38BPmHogXfc035hX+VUzHaZsUdYwZVJeGoCwb+BqjtUqvaBiA
 LuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781229921; x=1781834721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qttcJEsQiEfl3lWc0PlXIEYsPQbX9aFASczeCecuVNA=;
 b=a+iQ514Rjrcjg2YkmVIE4SACRGgiNuMEedPGB8I8EGV/GytbH4vgD+l3fZgEwiaeBw
 UUzxwOZP8NeoPGuA9veqxM5tov6IxalEtH9ALpVCj9IqIsY7DzbPGSKfcMxL31vXaQuP
 BQt4g8fRc4CrCmlaTp44rXBHVfpNOxZ+EzXxxICnFn355tFqnE9GX6xqOtGY+Yg82UNo
 pGi2cU9K9xqLiwhiFeHWRVC0h0GMNd5cd7h5byqOOsd8WY969kgp7zosdL9Ev8AT7FBt
 QFxKX/RNDDvmhwqsqkI0Ca3cbxMy+LaDCjG28zyqZ2Y22XO9OnflK40GtqQeT14SGyB/
 JSAg==
X-Gm-Message-State: AOJu0Yx1QZEA3+gQYDqEBhTSbp0lRAgdw6gP22qrYzkivKsh1GQ1BBJ4
 a9biz/6lh4qd3Ef/+ssi7j0z6scxEm9aC9X8k852t6nGbfhHvFoNgUCNhLnralY5PA==
X-Gm-Gg: Acq92OGiRaAjjHrCxF4EevlTNaHqjDcmCKE+fFOCi8hWTnnVzil4eXbUEQloMAj2Jx9
 ughS5p0ZVAoHzbYJGfKQdf9GZCJuEq5yI55O0IS6FNoaz/8HG76OZXzmosVK2w4F4OWpDYDY5ii
 ZnCwBl/KgRCic3ecnbtYDHehjuSz0hygvb35RpzhqtwpVzJj9UZ/Qt1Gt30Agatsc3qRtJAiZoE
 vX86O3328ilZgnHuW32xvo7MWijxJypW2i4zT2USyAWeKEm4aHJll+LKDcnpAEyHrh0MF9VnGdk
 ezILgSc+bdtBqdp6hGQa1XyoRBVqkN8IE/qq5cfaQ3iUR+7azjwVfelCNtFsop8Ws0GzZ2S8NZQ
 gZjPreE2yu9Jd83tKVM4zlZLVJ6NjcXC9A0pfvJ5A8FGig+b+R6Qo1DUfk7YO+XmFM711A/rilj
 PKJQesbiKUK6PxHsqNnts1DYNrrTQCYp97pYkfS5Ty
X-Received: by 2002:adf:e102:0:b0:45e:e50e:3bc with SMTP id
 ffacd0b85a97d-4606dba5451mr632941f8f.29.1781229921660; 
 Thu, 11 Jun 2026 19:05:21 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm1061999f8f.19.2026.06.11.19.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 19:05:21 -0700 (PDT)
Date: Fri, 12 Jun 2026 02:05:19 +0000
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aitpXwrqwKkk06xF@autotest-wegao.qe.prg2.suse.org>
References: <20260508100101.7741-1-wegao@suse.com>
 <20260509073921.8487-1-wegao@suse.com>
 <0f226bbd-d348-4e73-8818-878b92902810@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f226bbd-d348-4e73-8818-878b92902810@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] pthread_detach_1-2: Fix failure on modern glibc
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
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 11, 2026 at 05:33:31PM +0200, Martin Doucha wrote:
> Hi,
> this looks like trying to hide a glibc bug to me. I've looked at both the
> POSIX standard and Linux man pages and there is no mention that already
> exited threads may be left joinable. I think we should report this as a bug
> and wait for response from glibc maintainers.

I think is actually not a glibc bug, but correct behavior under POSIX.

Link: The Open Group - pthread_detach (https://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_detach.html)

Wording: 
1)Under the DESCRIPTION section, it explicitly states:
    > "The behavior is undefined if the value specified by the thread argument to pthread_detach() does not refer to a joinable thread."

2)Under the CHANGE HISTORY section also mention:

Issue 6
The pthread_detach() function is marked as part of the Threads option.
IEEE Std 1003.1-2001/Cor 2-2004, item XSH/TC2/D6/95 is applied, updating the ERRORS section so that the [EINVAL] and [ESRCH] error cases become optional. <<<<<<

Issue 7
The pthread_detach() function is moved from the Threads option to the Base.
Austin Group Interpretation 1003.1-2001 #142 is applied, removing the [ESRCH] error condition. <<<<<<<<

Also include Adhemerval Zanella who submit the glibc change.

> 
> 
> 
> -- 
> Martin Doucha   mdoucha@suse.cz
> SW Quality Engineer
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
