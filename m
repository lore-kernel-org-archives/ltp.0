Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228C0C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 21:11:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD66A3C8FE3
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 22:11:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C97803C65E6
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 22:11:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61F862009AB
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 22:11:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 93BA61F38A;
 Mon, 24 Jan 2022 21:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643058668;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uy+UtmG+RxpK8ia1VY/ggx/d4Pbu50hrej85LfIQW0U=;
 b=1CK0ck8CqwoBPXPc9ra+CFBCmqIeXCHRjfl9JRBhkKGTXN6EiKo+tChlcHLdsS0bPMbkz3
 YepVeXyOa8sRusGHyGuuqWQfSf0aX0w9FxgyDYvld5TK7txGmdZjLKsfmZrV5WdI6q/8/5
 HL+P99nayuOKIidmqPaiuzNRMoagd3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643058668;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uy+UtmG+RxpK8ia1VY/ggx/d4Pbu50hrej85LfIQW0U=;
 b=p3KMVcpkwKu+xUnG8OmCFqC7ufg/QWl7G/epeVSLCMd37b/oFmXRR9ce9bR7J6m9Hp3CLS
 VJuKv4mqMlzY/WDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CCB213CCD;
 Mon, 24 Jan 2022 21:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RUbCEOwV72EOPwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 21:11:08 +0000
Date: Mon, 24 Jan 2022 22:11:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <Ye8V6jNFpVBwBQLo@pevik>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rpc_lib.sh: fix portmapper detection in case of
 socket activation
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
Cc: kernel@openvz.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For a record, merged alternative solution:
eb786468b ("rpc_lib.sh: Check for running RPC")

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
