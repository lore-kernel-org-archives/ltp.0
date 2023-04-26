Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4AFC7618E
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 08:40:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C456F3CBB58
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 10:39:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 984C23CBB50
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 10:39:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 81B49140098C
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 10:39:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 54E781FDCE;
 Wed, 26 Apr 2023 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682498388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ImWRTQnxO424CJDdaAEGmyltv/690P5B5nx3fw+PI4=;
 b=Q2rZ6+sutoEUqiKm2oU2NhDtXf2Y9J3+satZXXZ1ljwumUYarJwSvsHk/Y7Twubhz7HAec
 8jMacmNT1XDf2ORxudZ6TqOb/Tal4TnPSM1LcFQeW6jLJhPGyStvKIrNP46/pIpVXbxNk9
 raev0ThhyRiG5K95K5mVScrEo38Ahzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682498388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ImWRTQnxO424CJDdaAEGmyltv/690P5B5nx3fw+PI4=;
 b=UcblrJUhrOuGt3HGvatrx6JfrVqpD9mA0U7nZmIolbpqUiFSkwcjp49HfpA3UMvQindfI8
 8AcP0uBw8UVOkkDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A417138F0;
 Wed, 26 Apr 2023 08:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QlPWBlTjSGTUHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Apr 2023 08:39:48 +0000
Date: Wed, 26 Apr 2023 10:38:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZEji6GMTZG2HCfE0@rei>
References: <20230426074950.8807-1-andrea.cervesato@suse.de>
 <ZEjgPy7kJbUG4r1W@rei>
 <827cbeda-719f-885c-f230-b6e2e248665f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <827cbeda-719f-885c-f230-b6e2e248665f@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Support return value in TST_* macros
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The reason is that I didn't want to handle every "break". To return 
> TST_RET after TST_EXP_POSITIVE_ seemed like a cleaner option.

We can always add another indirection, rename the TST_EXP_POSITIVE_ to
TST_EXP_POSITIVE__ and

#define TST_EXP_POSITIVE_(SCALL, SSCALL, ...) ({
		TST_EXP_POSITIVE__(SCALL, SSCALL, ...);
		TST_RET;
	})

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
