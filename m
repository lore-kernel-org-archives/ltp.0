Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEC2CD6E56
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 09:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780304488; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ni7lhfkrFicgMIRQFq7SHhzVjPGfwAlbT9sBVugm6MY=;
 b=DfkY13WdHDExgVp9HgSGEzkjJ9uxffdcVG83xywxk95s4hIRPGUt87wlmpTzUGjQB/ae0
 +klv3DP3TRy8OHfnb/aBTa0GGKci/ATH4sRaW9NxeqiYWI9mK99JI5hPsWdrGi35O5powYJ
 wKVFWR2uJy7A9q+BqyxNHcqBTbPRlMQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F0A13E30D3
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 11:01:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91A243E2DB7
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:01:07 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AE5F4200751
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:01:06 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bebde89cfd3so172286766b.2
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780304466; x=1780909266; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sJXwNO+Qzg0XMhz6jsgEJFEQdkYm48Peqps5Kk6mOq0=;
 b=a6kA5vIZ32wrMUfyJulmDCbKDRMiFPENvgF/3qac21z4hrce9v1B3sIZgpR1Fjasid
 wtQaNYXM7FIUL+NB4ecpgjzK/UI3fRJFVMRs6oCkTBtXsWM+5K8H8lWbD2cNmKUNSHRe
 tTmmmsJjJvnYnKBnKa6BNkBA5eLQZBMhJDqAqNoOI4QKHP4gQ0QqxBZ5hrX5WN3Rl2Bj
 GrF5fA5WCaPNvJNoJ2NOgBIXJL6IztM2sCcJH1dAHc0VaqZxAHiCDqFxMuhhQ0qqOcd5
 4qVjJ4gBSPF06ofkIbsOg25xf+RKPXQ3HO+DGLmucbryoBkyxOPj/Nq74GWvjfL9yCjf
 7+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780304466; x=1780909266;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJXwNO+Qzg0XMhz6jsgEJFEQdkYm48Peqps5Kk6mOq0=;
 b=Kga/haBa3Lx+624WKMugIShFVrmMRh8viuzV11Wkzzv9Q79vJKo6B7PeWH2O7lmeZD
 2lXPQ22KAIC/VklqlsxMho4VW0nZjPa/l5BcTNJifDu4N5JJI7XURnQLMMxHGn0cLMg8
 jZ9+xlUeRh5iipGyNKhKLXbsDXk68eUJgGF05h4G+btopCYHEmUCfeYUbJ3fuqlnEuD8
 k+olr6YtFLJTN5fqjBLYvV7+H2x8ywG3oMObIDGsvHVaH1FEZGV9RZkbLcptZS6mr+p2
 5TJkU7Y/S/bOKoBEQ1SPfbUf1HedUfb6YCYxTRywW539cLS9SCK9+jVeu5fL3Qe10k3s
 njOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jDwz4rm9CAScmoK0ZvLgRPTu4dtO56kIBYAuWWW0uOaMt8bjKnJvhdsG4hbSkLK/COsk=@lists.linux.it
X-Gm-Message-State: AOJu0Yzohlzg5P+206+VNURkNP8qOZHnQQj4Vi04kh0FVJ491aWmiMjn
 wlKnWpsNr+BGv+hicpp3fFj2O5PGp3kdgDV93pKnZVL9kij1PerOO2mRHjbNJC2Vr7Q=
X-Gm-Gg: Acq92OGadxTLNNaEEnWGtDg6ITGc9Xdskth+UdVrdowqDbZyIsKZDV0VAFb35SmBoFC
 jKEd7EXx8jDxQAXqEPecRHasrwUDpGXqvfpKY8ZFk4sY/Lxw7Bz9kQIdLlt1dwtavIkqRNk4F41
 gVnZ/rCc7Aue5tE/A65iBUq7LhoHHlBvTnKnh1pqE02mD8jTzrGKoLSFW6BvDdJ5LdPcAMbnz9G
 AE3dwiOs3sykvInp6Sk/m7/t7Da4JuLDusn9kPVMhPPOx3Nw67ZeE1jKVw9SyrP3ewSTCDQB0My
 D8afcMrAAquASsL9jfPJkufaXhxe1VLufXqELwQCcvWUcH6N6ugMQB5CFTBdA2MnU1KYWU8/fvk
 xkjUHF18/CYg8uMEF3cU8o9tn8+4Q0h6HLVs21r4BW4rp/Pc0BMDAaDgGXb88E3F6yWWhCRhe6a
 nYvPND2fae2EV1dBcAQnmaj5FbJJG7/vwP4B0Z2JAHiC32n2fIKrgnP3GYiiIa5LeAgZAV/ZU/8
 yYpPER3edUDVc96I3QViRq/BJ2yeEFI46daukTMVzPqng==
X-Received: by 2002:a17:907:1de7:b0:bed:9664:4a22 with SMTP id
 a640c23a62f3a-bed96646bc7mr114795266b.35.1780304465692; 
 Mon, 01 Jun 2026 02:01:05 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4a8800d2346cb1fd1859e6.dip0.t-ipconnect.de.
 [2003:ef:2f4a:8800:d234:6cb1:fd18:59e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef357635fsm22742504f8f.33.2026.06.01.02.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:01:04 -0700 (PDT)
Message-ID: <6a1d4a50.56f33bf0.11810a.d3b6@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260601085034.GA488366@pevik>
Date: Mon, 01 Jun 2026 09:01:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] gitignore: ignore ltp-agent setup files
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi Andrea,
> 
> Generally LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > The ltp-agent tool injects a number of files and symlinks into the LTP
> > working directory at runtime (AGENTS.md, GEMINI.md, .agents, .claude,
> > and the agents/, linter/ and skills/ symlinks pointing at the agent
> > data). These are local helpers used by the agent and must never be
> > tracked or committed.
> 
> > Directory entries for the injected symlinks are anchored to the
> > repository root (leading '/') and have no trailing slash, so they match
> > the ltp-agent symlinks without shadowing any unrelated subdirectory of
> > the same name.
> 
> Out of curiosity, here you talk about /agents /linters and /skills, right?

Yes

> 
> > Also ignore a few local agent working files: the /.pi/ session
> > directory and review-inline.txt scratch files.
> 
> > diff --git a/.gitignore b/.gitignore
> > index f10cd0c80e3655ad720e465f47c12ad0d51e7cd1..891ffb7b77325a83daa99e6f04bdc51f95490655 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -63,3 +63,16 @@ compile_commands.json
> 
> >  # added by scripts/checkpatch.pl
> >  .checkpatch-camelcase.*
> > +
> > +# ltp-agent setup
> Maybe link the agent project to make it obviou
> # https://github.com/linux-test-project/ltp-agent

I will add it

> 
> > +AGENTS.md
> > +GEMINI.md
> > +.agents
> > +.claude
> I wonder shouldn't all the above have leading '/' (slash)?
> OK to change before merge.

Sure

> 
> > +/agents
> > +/linter
> > +/skills
> > +
> > +# agents files
> What is the difference between "files" and "setup"?

I wanted to split ltp-agent stuff from generic agents usage such
as pi (https://pi.dev/) and spurious files produced by ltp-review
skill.

> 
> > +/.pi/
> > +review-inline.txt
> And here as well leading slash?

good idea indeed

> 
> 
> Kind regards,
> Petr

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
