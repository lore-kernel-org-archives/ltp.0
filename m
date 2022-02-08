Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067C3C433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 17:56:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 764F03C9B77
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 18:56:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95D63C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 18:56:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DFB0460098E
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 18:56:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 322F3210E1;
 Tue,  8 Feb 2022 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644343002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tnaqO/zonYqYvitYGzKk/C+eqGRLLk3p8dCIpTRtR7o=;
 b=vqwmFl3kule1fV1MNfnf+J/a4ltI2kby5nf+TjY5mBmPQ8jhieTcUVORiyp1BUzkQalFaU
 OuGzcGVXlermwVB4E4sV3DcNd3F+Em7sEcwE/yC1Y1ClgcPGKq0JTYlmv8K/UrvwPnSGnT
 1Be9uzWQUaKz6h3BBLTtRK41tRRQ1iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644343002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tnaqO/zonYqYvitYGzKk/C+eqGRLLk3p8dCIpTRtR7o=;
 b=JF6HPgU2PBg+D4haZsuxvkcW9XVQC7CY709YYhbXRjjqHR5nLWbpgUYnHWfEDYONpJ2GDl
 N4CAyzf7cCtEjQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F78F13CDC;
 Tue,  8 Feb 2022 17:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +GmFBtquAmJScgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Feb 2022 17:56:42 +0000
Date: Tue, 8 Feb 2022 18:58:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YgKvVsFZZ9I3zBWi@yuki>
References: <20220126181210.24897-1-pvorel@suse.cz>
 <20220126181210.24897-4-pvorel@suse.cz> <YgJ6dOD7tC+7UQL2@yuki>
 <YgKqKM32COAnmxfo@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgKqKM32COAnmxfo@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] tst_test.sh: Add $TST_FORMAT_DEVICE and
 related vars
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
> Do you mean to swap here? i.e.:
> tst_mkfs "$TST_FS_TYPE" "$TST_DEV_FS_OPTS" "$TST_DEVICE" "$TST_DEV_EXTRA_OPTS"
> 
> But in tst_mkfs it has always been the second parameter:
> local device=${2:-$TST_DEVICE}
> 
> What am I missing?

The email that explains why we can't add dev_extra_ops to the tst_mkfs
the same way we do in C?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
