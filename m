Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E84AC636CC
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 17:26:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFD463CC9E9
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 18:26:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A64C3C1047
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 18:26:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1A3FF1000608
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 18:26:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F7911FEAF;
 Mon, 13 Feb 2023 17:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676309173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRFxcdLKB7r/5qjHs03cIA6drF5duKnJBel+SM4xOVE=;
 b=sBxMbMllmzybjZXVlVoA8M9ILAPJ6pA4hjqjsG30YUPSW3gZqCBVAkjKzXjbOkgxhOttq1
 f3Dsemsib6S/HGpGAnFoX1E+8ZhgZYwPD0yeqV2M3nm+hKAJKrexeqfDTgHFLhmPTvlPRk
 NOM3EkSRlivS1LBRsd3lkISHvYj4GP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676309173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRFxcdLKB7r/5qjHs03cIA6drF5duKnJBel+SM4xOVE=;
 b=gL1fOVZrvm94Da0i6UwanwIi8S8jcVwLj7B5DDBgs9UPuo3ORck8Ty41ZvdcxREXyYP/DT
 Tg36fwkofaMtyDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E52CC1391B;
 Mon, 13 Feb 2023 17:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uT8WLLRy6mMdYAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Feb 2023 17:26:12 +0000
Date: Mon, 13 Feb 2023 18:26:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y+pysr+HTTN/aAcX@pevik>
References: <20230125222703.19943-2-pvorel@suse.cz>
 <20230213152655.64295-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230213152655.64295-1-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] hugepage15: Resolve compile time warning
 generating with -O0
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

Hi Tarun,

thanks for rebasing. I dared to separate include change into it's own commit
(merged as 2 commits).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
