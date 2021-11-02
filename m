Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA083C433FE
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 15:38:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B5960F24
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 15:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33B5960F24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DD7B3C7190
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 16:38:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A2A13C1314
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 16:38:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A6E621A00907
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 16:38:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CCEE8218F6;
 Tue,  2 Nov 2021 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635867482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6v0kc6ZWB33m/mJ1FlrzaIsclMlhoQJOMg4g5hELZvw=;
 b=1bGzvPtkKjLosWXiDd+WajL1llYO/bqNf9P/TG0PrOTVsXqkVMIR4RogcnxihlkLtGwxnF
 UIQ13nxv440sB51FUIgj/EhvSmUUO8s8rbNjevxg+7cK6s2BOmF1hmuZM5bZmm5WsImmZ6
 Z/eCw2O/861oz5pW0SsLNava9E8oLBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635867482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6v0kc6ZWB33m/mJ1FlrzaIsclMlhoQJOMg4g5hELZvw=;
 b=0XJdZz4A0NyOzz5ufaSH5Bj9AptdEJiMbOfRbrQ5xYR3C37sLQqKgWCnshoRkPuEAIl7UV
 RwJ8abQOiDlvV1CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96C7613D66;
 Tue,  2 Nov 2021 15:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rNNhIlpbgWEAUQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 02 Nov 2021 15:38:02 +0000
Date: Tue, 2 Nov 2021 16:38:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYFbWTggVXFkoKra@pevik>
References: <20211101145342.7166-1-chrubis@suse.cz>
 <20211101145342.7166-2-chrubis@suse.cz> <871r3yq0hm.fsf@suse.de>
 <YYEfNvjosOzWzKRJ@yuki> <YYFROnbswkA6knMN@pevik>
 <YYFU0K4eLWgT364K@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYFU0K4eLWgT364K@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] docparse: Implement #define and #include
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

> Hi!
> > Unless you send v3 feel free to add

> These two fixes are pretty minor changes, so I think that these can be
> fixed before applying.

Sure.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
