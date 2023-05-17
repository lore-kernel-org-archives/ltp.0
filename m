Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9F9C77B7A
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 21:58:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 390513CEE46
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 23:58:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 901163CA31C
 for <ltp@lists.linux.it>; Wed, 17 May 2023 23:57:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9DBDB600842
 for <ltp@lists.linux.it>; Wed, 17 May 2023 23:57:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD4D22262B;
 Wed, 17 May 2023 21:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684360674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OouIGsSoGJ7J1OlHrnobL3C0lDRiK9RY2DXi3+bbuX4=;
 b=eV76p3EaV51VErBRI+fwd7987zIIO/siFkJVOOxN/kwWybEkfM+62fHMtxdpFVN4xcRAle
 8j2sz6BevP1wEgjAWhaxLtdQ+X/+ffpVcQP6tCQThr8cPm0NQADAH8NKHNzIEQluHFgLPF
 Ja0WVL9M2Ms6J6/YcENhsKz3JdgEhDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684360674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OouIGsSoGJ7J1OlHrnobL3C0lDRiK9RY2DXi3+bbuX4=;
 b=UNysb6eORNHjCeyNjLud2oKO6H6PrsOTB+lf1QRbc/NQ4pMcbEUJJ5j3+Cz9eVKimbrwCr
 DEeYO2z5kN6k1KBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96F1D13358;
 Wed, 17 May 2023 21:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BbtgI+JNZWS8LAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 17 May 2023 21:57:54 +0000
Date: Thu, 18 May 2023 01:20:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230517232054.GE8914@pevik>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-7-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230517153642.26919-7-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/7] KVM: Add STGI/CLGI intercept constants
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

> +++ b/testcases/kernel/kvm/include/kvm_x86_svm.h
> @@ -39,6 +39,8 @@
>  #define SVM_INTERCEPT_VMRUN 0x80
>  #define SVM_INTERCEPT_VMLOAD 0x82
>  #define SVM_INTERCEPT_VMSAVE 0x83
> +#define SVM_INTERCEPT_STGI 0x84
SVM_INTERCEPT_STGI is not used anywhere.

Kind regards,
Petr

> +#define SVM_INTERCEPT_CLGI 0x85

>  #define SVM_INTERCEPT_MAX 0x95

>  /* SVM vmrun exit codes */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
