Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47324C433F5
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 09:55:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF3A83CA45D
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 11:55:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C821A3C0653
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:55:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D3DD420004D
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:55:41 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2788521115
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 09:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649670941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLat1i9DWQE9DeBmqbKrR+w+wgviX49F6JxI5nCJIag=;
 b=qH/dCv76CQk/mLeiJ7S7FGx3A1ibjSjfFLDk9HYhUd/7v0ewM+HkHnpUyU3jDQun2fvktq
 3KJ8PqRp3UjDCxbLQCZQhyW9NGAB8dDjT56JMNHJS8wlA3yFjaN0iXNZxvItYK8F0l779f
 JPqoAtsbta6a2QFeEDGhexLYGv5okNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649670941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLat1i9DWQE9DeBmqbKrR+w+wgviX49F6JxI5nCJIag=;
 b=sw6INvgczSp8ld/0XlFmsdxHHkldBjubCKCsmye5hxXFTJn4VRpuE41kgyNf1lKaFoub2y
 UgBGzo8zH01kdhBg==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DF0B1A3B89;
 Mon, 11 Apr 2022 09:55:40 +0000 (UTC)
References: <20220331113324.14742-1-mdoucha@suse.cz>
 <20220331113324.14742-3-mdoucha@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 11 Apr 2022 10:46:50 +0100
In-reply-to: <20220331113324.14742-3-mdoucha@suse.cz>
Message-ID: <87fsmkgd0j.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] KVM test infrastructure
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Martin,

Martin Doucha <mdoucha@suse.cz> writes:

> Implement LTP infrastructure for tests which require executing a special
> program inside KVM virtual machine. The infrastructure is split into two parts:
> the host library and the guest library.
>
> The host library provides functions for setting up and running virtual machines
> with test payload built from test sources.
>
> The guest library provides CPU bootstrap code and basic implementation of
> some C and LTP library functions as well as functions for accessing low-level
> arch features like special registers, interrupt tables or memory mapping tables.
>
> The test sources will contain both guest-side payload code and host-side setup
> code separated by preprocessor switch. The files get compiled twice with
> different compiler options. Once to build the VM payload, once to build
> the main program that will create the VM and execute the payload inside it.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
