Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0A8C433F5
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 10:23:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3732D3CA87F
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 12:23:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C7C13C9F6C
 for <ltp@lists.linux.it>; Thu,  5 May 2022 12:22:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EA90C600921
 for <ltp@lists.linux.it>; Thu,  5 May 2022 12:22:53 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4F5AB218E6;
 Thu,  5 May 2022 10:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651746173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RCz7ANvzW9bjFamUizEkVaxvMRTv4oFvcL4r2L5QPxY=;
 b=EKpuQ+X3RnY0qUanZlRDUXTF5PSewslSMxDlEEAJo7gTsTuMH7crc9eGvI4MNwtHVXkmjb
 D4Gc2RYHTz+Hi26dinX/0fv2ITS6WDbdA7eq4iHG5fMGvwOicb73e2u7ivwPmSNSIvXaNm
 j7hQRLT3LDG5kZb1J7OcReWou2rx/4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651746173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RCz7ANvzW9bjFamUizEkVaxvMRTv4oFvcL4r2L5QPxY=;
 b=QF/WHpbR2FT/wK+BreuhqpyA9ixZq9wv89a50/bAmuuPQlL2wrTBYUCwOs3+qw/CgiZcRT
 aH5/JLX9v5lEjTBQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 10F2F2C141;
 Thu,  5 May 2022 10:22:52 +0000 (UTC)
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz> <87a6bwe7ps.fsf@suse.de>
 <YnOdXct59/QFXd1Z@yuki>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 05 May 2022 11:09:50 +0100
In-reply-to: <YnOdXct59/QFXd1Z@yuki>
Message-ID: <87fslocm83.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 01/30] Introduce a concept
 of max runtime
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > +	int max_iteration_runtime;
>> 
>> It's not immediately clear if iteration refers to the inner test loop
>> (e.g. Fuzzy Sync) or the outer loop performed by adding '-i N'. Perhaps
>> it would be better to call it max_runtime and document that it is scaled
>> by '-i N'?
>
> It's not only the -i N paramater, it's carthesian product of:
>
> 	-i parameter x all_filesystems x test_variants
>
> And every single instance of that product is limited by the runtime
> value, which is the reason I want to have iteration explicitly in the
> name. Maybe we should call it instance instead or whatever else that may
> be more fitting.

I suppose it is the innermost runtime, so I would vote for inner_runtime
or just runtime. However whatever it is called it will require
explanation. What is considered to be an iteration, instance, inner, test
etc. is arbitrary.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
