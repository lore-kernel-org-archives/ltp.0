Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF33BC76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 08:25:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 751C53CCB33
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 10:25:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 273263CA486
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 10:25:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 246811A001D9
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 10:25:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6009E1F8BA;
 Tue, 28 Mar 2023 08:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679991904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/K0WWD0ZHDvYRVppdWa2cvApCuJKRGQCAylWzr2dWxE=;
 b=gtixRskfGMuMzO/hVy9TxGf9rLTBb74UdhjA9eWl/8IH/tnLMkM0CD48qIXnXGX/A4tmRW
 fs8lSe330te6GM4TyWgyLAQv8qt0GzY3AWuuXZ0Kfjly2XIVwE/5rKTzRIKrpMsCIiraOd
 Li+8Wq/vSDzYHlvIsmAlN1jRUaYojSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679991904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/K0WWD0ZHDvYRVppdWa2cvApCuJKRGQCAylWzr2dWxE=;
 b=HK7AOjq5Rj2yQM330bF1s2e97dKViFhwURufE693EBpovqpinE1X/jv8IlYQiMZtb2Pe68
 momfNfUxTu9irFAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42B5A1390D;
 Tue, 28 Mar 2023 08:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SauTD2CkImSfIQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 28 Mar 2023 08:25:04 +0000
Date: Tue, 28 Mar 2023 10:26:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <ZCKkp2qvvoc95bSG@yuki>
References: <20230323160508.672397-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323160508.672397-1-teo.coupriediaz@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] safe_open: Add missing mode from some calls
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
Good catch, applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
