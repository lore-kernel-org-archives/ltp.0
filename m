Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1C9C4167D
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 15:41:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FFA33CE5D2
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 16:41:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 193433CE5B8
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 16:40:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AAB5C600ECA
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 16:40:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A69F1F6E6;
 Mon, 13 Nov 2023 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699890051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bRHSe+ToxykHeAOokAgBAaNCrqlWDpRqClO0l3+6Q2A=;
 b=rVNNT7iAM9vjTLy6WhoHa4z1P9uQx4R7pkxQnuxUAY1W1yU58ysYzNWdtkNd0noboLNILP
 HilUXTMvetBy+FfDKyhBGxE6Nincea6OrsRcwcK/KIo9MKhqqp5m4FDDDhgOG7DLzywgS+
 PhuXtbh2/alaT2dbIt42rcspLlrIMOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699890051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bRHSe+ToxykHeAOokAgBAaNCrqlWDpRqClO0l3+6Q2A=;
 b=pF3JPLXMwiLGp6hDlLPaRs4+ejlp+dlRHmSKf9aIa/aLsbY4lcsgIiBAgRQX6srkgT+PIF
 yfZUAw66kmieyHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C0D71358C;
 Mon, 13 Nov 2023 15:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BuEnAoNDUmX8UQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Nov 2023 15:40:51 +0000
Date: Mon, 13 Nov 2023 16:40:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20231113154049.GB2223773@pevik>
References: <20231013151724.23057-1-mdoucha@suse.cz>
 <20231013151724.23057-4-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231013151724.23057-4-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] crypto: Replace old netlink helper functions
 with netlink contexts
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

...
> +++ b/include/tst_crypto.h
> @@ -13,67 +13,13 @@
>  #define TST_CRYPTO_H

>  #include "lapi/cryptouser.h"
> -
> -/**
> - * A reference to a crypto session and associated state.
> - *
> - * Holds state relevant to a netlink crypto connection. The seq_num is used
> - * to tag each message sent to the netlink layer and is automatically
> - * incremented by the tst_crypto_ functions. When the netlink layer sends a
> - * response (ack) it will use the sequences number from the request.
> - *
> - * Some functions, such as delete ALG, may return EBUSY in which case it is
> - * safe to retry them. The retries field allows you to set the number of
> - * times this should be done. If set to zero the operation will only be tried
> - * once. For operations which do not return EBUSY, the field is ignored.
> - *
> - * Use TST_CRYPTO_SESSION_INIT to statically initialize this struct with sane
> - * defaults.
> - */
> -struct tst_crypto_session {
> -	/** File descriptor for the netlink socket */
> -	int fd;
> -	/** A sequence number used to identify responses from the kernel. */
> -	uint32_t seq_num;
> -	/** Number of times some operations will be retried. */
> -	uint32_t retries;
> -};

include/tst_crypto.h still contains "@relates tst_crypto_session". I guess this
should be replaced with "@relates tst_netlink_context", right?

I can fix this before merge.

...
> -/**
> - * Default static definition of tst_crypto_session.
> - *
> - * @relates tst_crypto_session
> - */
> -#define TST_CRYPTO_SESSION_INIT {\
> -	.fd = 0,                 \
> -	.seq_num = 0,            \
> -	.retries = 1000          \
I quite like this macro which had the default values.
But atm only retries 1000 is what needs to be specified, thus understand that
you didn't introduce any macro wrapper).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
