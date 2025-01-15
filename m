Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AD1C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736937928; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=oUmn2XLmS3P29w+TsibEoTYl8z2d+n+mv02qioO2AZ8=;
 b=USMQkVDF3tPNNA3utmWvf1lcan3lNNVYS1i6HrBV7/k3hj+cBjjqX6bdJLiiMlDdRR9dy
 E0A0Yr/wfDG6/EYe3Fs0p2APdgLCxCAnrlj6n+TmgeHDxgScs3bZ3hPV7eEALgrWHE2DqRJ
 mR9/ISjSDDrgZogcG25iSxwCAOJ4AHk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFB773C7B79
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 11:45:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 852203C7B48
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 11:45:07 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 312AB141ECB1
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 11:45:06 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-ab2e308a99bso159337266b.1
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 02:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736937905; x=1737542705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ElDcofHHFqbTs8I684DZ0waaqC9ON223w6j2uktK8A=;
 b=DdF7TLDhSmMuMnYJenbeHa7GBJWi/shAtZ4R4JYFfPjSRle3fHOi+nBNUGj7D+7bhL
 QXxd1REZQp7t8UTPtfjuTxeVLCv//JU+C1+Ez55AKqcGAN44y0jwOQav8y1ur65M/uT7
 v332VCVtdQNPmVTEJ6Vyuanqxp1xafGDfjauj+T1yDtDFE59jFLKrkus2Cx4zykqmSmd
 0BJXSefyGZ3AHtS/owXcyQoWGCLIHYUZKEPh8o3lfIROWQesKrlTnk8u2F3FI9T0lVF4
 V9jTB08lN0CslXFbbcWofvwN6V4VArkDDdsfy1RUMJAuFEV88kFal51RcQ2QJIJqofnM
 9kbg==
X-Gm-Message-State: AOJu0YxIKOdCE3JZYSJQqnJ+QuVkPb1M4yIZz0LVP/BZkcynd+EI4ny/
 kEM0otA6tnnki8PxePpo8fSgAmScy4lYYvMWoOCfHOaaJ6aaGSW/TB6xPAF3Xxh7Lx6axg30Bvh
 4
X-Gm-Gg: ASbGnct9nUOEfd/oMCD1RbilB5GZlDEcaeKuJ0874shnK7z7xq1AyiBspfbrDQCYNf7
 PqLbL2lVVoxLPxuYXWoOMCwXpbXy6wjBWRTYRhHWRkFzCeH//IDfCrKQjKjuT3ijDbPObqmyMIN
 cEkasgK81nZjzYqH3d/FiDRHXdc9w2PzqmglFWF/6Qn5EKS/cVkOVmQc2xzhog3o5wWfs74E/1z
 aXdVMhcHaVJaCutUk2mcBQbiBYrrBXmi+Lh6jhRDw==
X-Google-Smtp-Source: AGHT+IHoyNM0/pAT7De03V3b835r1Xbq7X1aXMUmpxHAjtPEIPCKEAdyXRC2Wij/9knobQGvHik1cQ==
X-Received: by 2002:a17:907:7282:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-ab2c3c79cf5mr2238298866b.17.1736937905446; 
 Wed, 15 Jan 2025 02:45:05 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-723185482fcsm5511375a34.24.2025.01.15.02.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 02:45:04 -0800 (PST)
Date: Wed, 15 Jan 2025 07:44:59 -0300
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <vifwygnntr4s4u5xk5dgqmq2dni5mb2doay5mw35rf6ji5epd4@semy6ws4gcsx>
References: <20250114-fix_b4-config-v1-1-e03eff794599@suse.com>
 <7b366388-6a0b-45de-95fe-08beb7528062@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b366388-6a0b-45de-95fe-08beb7528062@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] .b4-config: Add checkpatch.pl default commands
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea!

On Wed, Jan 15, 2025 at 09:54:43AM +0100, Andrea Cervesato wrote:
> Hi,
> 
> thanks for this patch. I was using something similar, but the output here
> seems more reliable. What I don't really understand is the following error
> for many of the commits in the patch-set:

What patch-set are you referring to?

> 
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

I remember seeing those in the past, but was unable to see it when
running against the last patch-set I sent (regarding mmap refactors).
I'm running b4 version 0.14.2.

Replying to your other message: I agree with adding FILE_PATH_CHANGES to
the ignores, since there is no MAINTAINERS file in LTP. That should also
probably be added to include/mk/env_post.mk.

Thank you,
-	Ricardo.


> 
> Andrea
> 
> On 1/14/25 23:43, Ricardo B. Marliere via ltp wrote:
> > From: Ricardo B. Marliere <rbm@suse.com>
> > 
> > Blend b4 default checkpatch.pl flags with the ones defined in
> > include/mk/env_post.mk in .b4-config so that a contributor may use `b4 prep
> > --check` and `b4 am --check` in his workflow.
> > 
> > Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> > ---
> >   .b4-config | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/.b4-config b/.b4-config
> > index 2efdf2273240dcf57bd5cab174ff6c7a1952dd5b..5a16bd64ec98b91e17386c0eadc7ef0de54d86f3 100644
> > --- a/.b4-config
> > +++ b/.b4-config
> > @@ -4,3 +4,6 @@
> >       send-series-to = Linux Test Project <ltp@lists.linux.it>
> >       pw-url = https://patchwork.ozlabs.org/
> >       pw-project = ltp
> > +    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
> > +    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
> > +
> > 
> > ---
> > base-commit: 6fe8aa186559784f0394cd449cba6c53342790ec
> > change-id: 20250114-fix_b4-config-1ab84320000a
> > 
> > Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
