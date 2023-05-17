Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE881C77B75
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 21:05:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCD653CEE21
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 23:05:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6CCD3C97B6
 for <ltp@lists.linux.it>; Wed, 17 May 2023 23:05:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 544B01400744
 for <ltp@lists.linux.it>; Wed, 17 May 2023 23:05:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41E8222668;
 Wed, 17 May 2023 21:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684357515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbms/Txq498JqVbAgHM47J5zYN7gKQ7qY0ibMy4bbuo=;
 b=H431aC/RhqLvDlgHWeDy8CkCBF0Yp83q/HJOqp5ebFvxC8JlUQVNj532jWImlJaAicAQXb
 kFShpQD6Jh0nTLJokvutwqbnkpACs7crkrVxPz+y/Wf5Ra4ZPXaOqrx2kLKWpjmZL7JRi2
 EyB//QPxjn7jhzB0yGZMQQddcukgr7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684357515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbms/Txq498JqVbAgHM47J5zYN7gKQ7qY0ibMy4bbuo=;
 b=0j0HEFTyVBAYuaNVnaW7yX7IlJGPHOuvDZzJwe+m84CmRqWZGPECBSlJRpOL6z/kJHyw7c
 QKtC1TiobuW3TzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FEE613478;
 Wed, 17 May 2023 21:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dr7SBotBZWSnFwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 17 May 2023 21:05:15 +0000
Date: Thu, 18 May 2023 00:32:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230517223238.GB8914@pevik>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230517153642.26919-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] Add test for CVE 2021-3656
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Nicolai Stange <nstange@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> +++ b/testcases/kernel/kvm/kvm_svm02.c
...
> +
> +#ifdef COMPILE_PAYLOAD
> +#if defined(__i386__) || defined(__x86_64__)
> +
> +#include "kvm_x86_svm.h"
> +
> +#define AVIC_REG_ADDR 0x280
> +#define AVIC_TEST_VAL 0xec
> +#define AVIC_READ_FAIL 0x12ead
> +
> +#define AVIC_INFO_MASK ((1ULL << 32) | 0xff0)
> +#define AVIC_INFO_EXP ((1ULL << 32) | AVIC_REG_ADDR)

These five constants aren't used at all.
Maybe copy paste from kvm_svm01.c ?

Acked-by: Petr Vorel <pvorel@suse.cz>

The rest LGTM, but I'm not the right person to review.
It'd be great if Nicolai would review.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
