Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A56DC433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 11:46:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33AEA3C9696
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 12:46:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E237C3C966A
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 12:45:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4238B1400059
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 12:45:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A199218E6;
 Wed, 19 Jan 2022 11:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642592749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rjKgredrINuI3+GNHJs+bSUqVUnDDT2LS4N6gR1sie4=;
 b=NkGBbp1FazENKF4XiCZFPdLVmO71ukpSW64csYLRusUpGN7LPR1wP8LVUmweEYg5F332g5
 PW5cE0nX7H8XqtlwQcVOmzQZr31NvKrsvMqFzmGZ7aarfV0xIdmIT5qlvk+T7kO1IchhJP
 qLUq8BrdSMjok9CtjfHGoilAMewZlac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642592749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rjKgredrINuI3+GNHJs+bSUqVUnDDT2LS4N6gR1sie4=;
 b=7JhzBUVCznMDYzp8pWiJUBFbqXqNpCc5jZw4J1G5bYeEuRvlN/OVZeR1AUN3Gp4xr6KAFH
 a2xlMAt97x9OcZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F7B913B31;
 Wed, 19 Jan 2022 11:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jOP+DO3552E3eAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jan 2022 11:45:49 +0000
Date: Wed, 19 Jan 2022 12:45:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yef56y6oyGepGfpO@pevik>
References: <20220119111533.8356-1-mdoucha@suse.cz> <Yef0lBQ5aryeC5ew@pevik>
 <0bd9af6b-9750-134a-8740-8017103ca4ee@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0bd9af6b-9750-134a-8740-8017103ca4ee@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite statx04 test
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

> On 19. 01. 22 12:23, Petr Vorel wrote:
> > Hi Martin,

> >> ...

> > I'd put this into commit message (can be done during merge).

> Sure.

> >> +	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
> > Before merge we should cast to prevent "comparison of integer expressions of
> > different signedness" warning:
> > for (i = 0, expected_mask = 0; i < (int)ARRAY_SIZE(attr_list); i++)

> It's better to fix that by changing the type of "i" to size_t or
+1

> unsigned int. But GCC could easily deduce that one of the values is a
> constant well within the range of signed int and not bother us with the
> warning...
Agree :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
