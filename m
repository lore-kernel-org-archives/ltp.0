Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8F0C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Feb 2022 11:22:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41AC93C9D13
	for <ltp@archiver.kernel.org>; Fri, 25 Feb 2022 12:22:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DD373C9D13
 for <ltp@lists.linux.it>; Fri, 25 Feb 2022 12:22:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 358191A01E1D
 for <ltp@lists.linux.it>; Fri, 25 Feb 2022 12:22:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C8201F380;
 Fri, 25 Feb 2022 11:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645788123;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCfbXCUp5+ophv6ec3r8ehnYi1SZZmlSjfdHG9VIw1s=;
 b=nspph1VS8oQrbH/2TRbGzuXsPSfVdSW05Ccdog+5rFm9J6RVSa6sZxtf/P6JsDG1qynjCa
 7VLLQVuwZwhov/6gMJnrg/nSbntrHh9pe4h92xw+Jxusdv5mA64CP4jocY6FHEAQ9d5Ax4
 eD+tDwoZBFmgEcC9vx6BV404rxMYRIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645788123;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCfbXCUp5+ophv6ec3r8ehnYi1SZZmlSjfdHG9VIw1s=;
 b=tFRTuLo1f0S3dl+r4isT27yKK6+JehQ2GvmPREvmQzKLs+86+rFgddEu5qU71bwr9ZrPI5
 mJwVx+oM8gwDNaAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1854413B9A;
 Fri, 25 Feb 2022 11:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Jq9sBNu7GGKgDgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Feb 2022 11:22:03 +0000
Date: Fri, 25 Feb 2022 12:22:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yhi72eUBC3qDJj4r@pevik>
References: <20220225110152.26098-1-pvorel@suse.cz>
 <Yhi6BqmKc1zGMUHj@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yhi6BqmKc1zGMUHj@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci/debian: Temporarily not require libmm-dev
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

Hi all,

permanent remove merged as
0ee80c66e3 ("ci/debian: Remove libmm-dev")

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
