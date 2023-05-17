Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D86EC77B75
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 20:39:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F1013CEE4A
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 22:39:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED6293CB2C4
 for <ltp@lists.linux.it>; Wed, 17 May 2023 22:38:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3AF5C1000426
 for <ltp@lists.linux.it>; Wed, 17 May 2023 22:38:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E58FB1FD69;
 Wed, 17 May 2023 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684355932;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pP4A0YmIuPTYm4VN2SDMv9NvNXBRUMp0+b//08XEGcU=;
 b=fmYZXzMYy+KUQ+1fOzYRBqQISnJ2t4ub/6U8+dHl7CoXkTW6jfkrJPxKXeY+hxYazMM1aJ
 TSv0dKbe9fY5JJHXYNNGV7q1fpFSTZy8WHhwNenAoWDRRK00xsuofjHRM4a0bhELFgEoQ6
 iOMQDtiOPQk7qMvr2X5So/7hCl5BAaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684355932;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pP4A0YmIuPTYm4VN2SDMv9NvNXBRUMp0+b//08XEGcU=;
 b=7QpyacComc/Kj0DzGIMQFG4u+N3nPGYtrNuAqJtvX72MfCO3n7rFkLp6+X/r1HZADIDkun
 8bOMJpD9gjEK3cDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6B2613478;
 Wed, 17 May 2023 20:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xgV4K1w7ZWSuDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 17 May 2023 20:38:52 +0000
Date: Thu, 18 May 2023 00:08:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230517220827.GA8914@pevik>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230517153642.26919-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/7] KVM: Add VMSAVE/VMLOAD intercept constants
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

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/kvm/include/kvm_x86_svm.h | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/testcases/kernel/kvm/include/kvm_x86_svm.h b/testcases/kernel/kvm/include/kvm_x86_svm.h
> index 965d1e716..3eb832849 100644
> --- a/testcases/kernel/kvm/include/kvm_x86_svm.h
> +++ b/testcases/kernel/kvm/include/kvm_x86_svm.h
> @@ -37,10 +37,15 @@
>  /* SVM event intercept IDs */
>  #define SVM_INTERCEPT_HLT 0x78
>  #define SVM_INTERCEPT_VMRUN 0x80
> +#define SVM_INTERCEPT_VMLOAD 0x82
> +#define SVM_INTERCEPT_VMSAVE 0x83
>  #define SVM_INTERCEPT_MAX 0x95

>  /* SVM vmrun exit codes */
>  #define SVM_EXIT_HLT 0x78
> +#define SVM_EXIT_VMRUN 0x80
> +#define SVM_EXIT_VMLOAD 0x82
> +#define SVM_EXIT_VMSAVE 0x83
It looks like these three aren't used anywhere.

Kind regards,
Petr

>  #define SVM_EXIT_AVIC_NOACCEL 0x402
>  #define SVM_EXIT_INVALID ((uint64_t)-1)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
