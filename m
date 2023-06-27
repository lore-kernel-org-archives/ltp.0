Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DC2EB64D9
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 12:59:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92CCC3CC9EA
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 14:59:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB7FF3C99A6
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 14:58:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CCBBC140096F
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 14:58:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E5AAE1F459;
 Tue, 27 Jun 2023 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687870731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=77nIadhicENjiK4BuEDDTdJodeGBQqI1o+vT1d7hapw=;
 b=nRtjgOhlBRTK1Rh3mHgs0q+UwSBFmQcnZuIVvEMDjDgJBEgMKOziixfzUfqvFf/TOy1HGe
 rNtDhbhwEiiC/T4Wd4FhQ5vgpLdpPmIEGW+VNBT4u4n2IJ9tnZl0C7b8MjRTAFo63J06wJ
 Yg7HizoHcHwizTZyfzNgfGFXRqtX0UM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687870731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=77nIadhicENjiK4BuEDDTdJodeGBQqI1o+vT1d7hapw=;
 b=6wqULNbfNllS9pj9EoNf/9UNTOOMZY+6ILH+Il8F7YXP0l8iRlouybbe6DOGG0jtW2GYda
 Xoxl2IsmXcMUIWDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8369D13276;
 Tue, 27 Jun 2023 12:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sGwsHAvdmmQCWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jun 2023 12:58:51 +0000
Date: Tue, 27 Jun 2023 14:58:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Message-ID: <20230627125849.GA36960@pevik>
References: <1687445437-2453-1-git-send-email-kashwindayan@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1687445437-2453-1-git-send-email-kashwindayan@vmware.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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

Tested-by: Petr Vorel <pvorel@suse.cz>

LGTM, but as I wrote, I'd prefer so load with SAFE_SOCKET().
Will you please send v3?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
