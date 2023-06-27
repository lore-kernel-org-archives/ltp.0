Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D87BEB64D9
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 11:04:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60C403CC38C
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 13:04:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40B1C3C99A3
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 13:04:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 52CAE1A008AD
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 13:04:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A04721863;
 Tue, 27 Jun 2023 11:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687863885;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tlm9hNQIv8HRv6wtgrv4+rMguf6MDMTe99ldPwkbgro=;
 b=OL9/pOey2OBaoLe0bXRIVB9FZ50YJNll/aFivPgNd2Avs1dBy9oCue12EUSkgia38A2q6y
 wD1oi+6wS6G3l3BHXEY6k5ge3ehpbNWO4Kl6l/4FhmVAKmUsc9Xt/ACKQF6iwta2wa+f+f
 l9Fcpz0ZeKxHUT8ESCT/xzuI+gEDOeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687863885;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tlm9hNQIv8HRv6wtgrv4+rMguf6MDMTe99ldPwkbgro=;
 b=jJmyg/hPN96ddT/EwOUNqQ/8t8N0edn/iIy6layUAP0h8nND76qjUr4D1Ovp+QsxHmzM3R
 cJLT25xF7brbPYAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAF6613276;
 Tue, 27 Jun 2023 11:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Z0npN0zCmmRbFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jun 2023 11:04:44 +0000
Date: Tue, 27 Jun 2023 13:04:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Message-ID: <20230627110443.GA24533@pevik>
References: <1687445437-2453-1-git-send-email-kashwindayan@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1687445437-2453-1-git-send-email-kashwindayan@vmware.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sctp_big_chunk: Do not use md5 hmac algo if
 fips is enabled
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
Cc: tkundu@vmware.com, akaher@vmware.com, vsirnapalli@vmware.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ashwin,

LGTM now.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
