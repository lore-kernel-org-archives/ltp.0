Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB49CC531D0
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 23:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784849336; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2GJM5t0wnqnwJKduOznEJ26vA9/HvfSlvC2exus4aJ8=;
 b=B6LV/eZHN0bgJVA465E9i1npXGwxBTKOzc1iZV7rNDxgPaBXCABE7EZ7z4K+o7B/qa3qP
 ndHCE62Xj+TVN2fR2Ve/IiQqQIPj9K/mcOS1E3T3qmOPOiO0No6GlR4fDRWBUf7OXn1gLuf
 GmydhKLpVd/w3hG6jjHR89Vgz5fuNfc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F96C3E93E0
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 01:28:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58C4C3C17CE
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 01:28:35 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E4A4020016D
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 01:28:34 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so597985f8f.2
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784849314; x=1785454114; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LhaW9HHY3HXY57wfXHnI1VrIMwJkLtPyvlPoGwQTqp0=;
 b=PScOrMfjdKcoeXaBeF/EeRWzBSV8EXCmzzhq9hQLZcjFkJZUAzOnkq0SoPkj6M4rhW
 SGXwQczgtkmQc0aoPej+HsB+LfzUJ+7VDKrbG2SgRqCmKHO2BOIP2vsRQZgy3Xvue4KF
 y9iXtcWZw0Li9hdtbi4AhwAS+ltemy/fO1N+SAYvVfsJJdFZAB48sVVaavSEFzcZT/X+
 Q6ZmkwiCLnG0CBoxZfHkR188bCqKqFjo6LuLdgADOMptgKBywDubbdDCpeWDLWs2UfWf
 EN9UrgwCDIxwQwTH0yJr3u+XLlTRhliL1M6k2Qf+Pi5eD9mxB/+nmumMmpSo+yzAnh1v
 nUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784849314; x=1785454114;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LhaW9HHY3HXY57wfXHnI1VrIMwJkLtPyvlPoGwQTqp0=;
 b=dCY3ifhvaVZjQgUy3KO7qErGFYR0F7SE4ihI4ZvXu2WznpIUHH3GVYHPINIXbpgQS6
 fwj3nTa/l6X7euXpOtZMDyAVecKvhWsnbRqeU40LpCcvk08Xg+qJfYj++qKco/rCzvHI
 pPjotNGSXt1PDgNdnkx7iYCw5FPnxxgOPMXWhMrhNe+lCf+apnhtYqOfAdHBg8TkhFGo
 /lcyH1a/GE5925qEUsN1W5AM0ULKCWNMrn3e/AMp60ih0Bl3zxcKVrgQdB6gRXHVZ+tZ
 8QtZcGMO1eEGjZ/AvyeWZgZ72gNb0CJQj6T+xSjzHMbVQKyjqUxtdK0gJQne+HteV7TY
 ulVw==
X-Gm-Message-State: AOJu0YwfELIHXJLPwPJY7z3FJGap3+lpVgTPZMp0NLEIvIUOPq+73lhc
 YT7iFRTFYhcF+iVKlfOkAbPapvFbyxVSsjpdbzLsOFEIGbIH5LJy6KIhfLq30sTOKQfh9nFNDlE
 BU4c=
X-Gm-Gg: AR+sD12bA1/eKkctv8FDEWn3X/Yx00l6YhK3a9b5Ll4HOuDh5OCVcHpDMhNDSWUNMW4
 tmxBpjbghEYFl+BbGhuxtg4XIRnODtRDmM1PmJ+M4mfoakAbfB/x2lJJ5ZUnZB0E0bxVArleCuu
 c2mELbsBH0V5SO1IN8Yo5LiFHAFncaandmLZPUhmzB+8urb8zQeh8vcEwihRmo7TwY1ilJwQ7Di
 V3vIjfnPdFUswGMSCoEFWXkMjS6keQrD/9O0IQz5WgjiiNai82p80FruCXmkI4+rC5573g1+J4l
 w6A1EVhxRuBRS6slXA4b8lD68NGEYQXsneAR9zZXJPxxBuqHur7vW7Ug/j5FyWfX/5RiKLVntiv
 E19eZYTrlgVTpzOFJiTh1l42JUAG88OAqB1HUogO1nS7dP5hWtj60JHXTcgFbwsmYGsvLeng9Qv
 zH7X6t6DYs1hbVJXsyOLU=
X-Received: by 2002:a05:6000:2410:b0:45e:64b3:af44 with SMTP id
 ffacd0b85a97d-47f8dca37b5mr6198452f8f.36.1784849314333; 
 Thu, 23 Jul 2026 16:28:34 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5d9sm18381143f8f.5.2026.07.23.16.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 16:28:33 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:28:32 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <amKjoM7YCXGrzkoD@autotest-wegao.qe.prg2.suse.org>
References: <20260722044732.3547-2-wegao@suse.com>
 <6a620b76.e9cff95d.a2a1d.8578@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a620b76.e9cff95d.a2a1d.8578@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 1/3] lib/tst_uid: Remove spurious TERRNO from
 tst_get_free_gid success path
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

On Thu, Jul 23, 2026 at 12:39:17PM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> > tst_get_free_gid_() prints the found GID when it succeeds, but it
> > incorrectly includes TERRNO in tst_res_(). This prints whatever value
> > happens to be in errno (often 0 or a stale value) which is confusing in
> > a success path.
> > 
> > Remove the spurious TERRNO flag from the tst_res_() success message.
> > 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  lib/tst_uid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/tst_uid.c b/lib/tst_uid.c
> > index af4ef8cf7..b0b087362 100644
> > --- a/lib/tst_uid.c
> > +++ b/lib/tst_uid.c
> > @@ -24,7 +24,7 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
> >  			continue;
> >  
> >  		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
> > -			tst_res_(file, lineno, TINFO | TERRNO,
> > +			tst_res_(file, lineno, TINFO,
> >  				"Found unused GID %d", (int)ret);
> 
> uhm? technically it should print 0, ENOENT or ESRCH. That's what the
> statement is all about. Do you have a log showing what's the issue with it?

AI feedback error is misleading need remove in patch10 , so do you want add new AI
rule fix it?

Following is AI feedback:
https://patchwork.ozlabs.org/project/ltp/patch/20260707054804.24232-2-wegao@suse.com/
> +		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
> +			tst_res_(file, lineno, TINFO | TERRNO,
> +				"Found unused UID %d", (int)ret);
> +			return ret;

When getpwuid() returns NULL with errno set to ENOENT or ESRCH, TERRNO
appends the errno string to the message, producing output like:
"Found unused UID 5: No such file or directory". The function succeeded,
so the error string is misleading. Should TERRNO be dropped here, or
should it be conditionally omitted when errno indicates "not found"?

> 
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
