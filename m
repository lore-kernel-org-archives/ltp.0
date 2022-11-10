Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FD0C43217
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 16:00:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67A3E3CDD8E
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 17:00:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8978B3CAAE3
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 17:00:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8D63F60137C
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 17:00:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 86E5122316;
 Thu, 10 Nov 2022 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668096008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZqo5lqPryWJk2NnL9TxuGvUyUgcYMcC7egxPbehAL8=;
 b=blq5Qwlxj/NmDJfHC8XxX39KGY6lw/og2wK3Oq3ELA+9pGQigxEmxHq15mVcPK40PG7GCu
 1WMAPoYhS8h5GqKF64Cf1WpZ/fnxoSBznWCM+tbkMigw8uqHtut5Mza+8ckXE1nafAACiQ
 LwK/pfF0pHdamROWuKS3Bsw00UH74uE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668096008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZqo5lqPryWJk2NnL9TxuGvUyUgcYMcC7egxPbehAL8=;
 b=Sy5k0fSqP1oKdP9Od+HqMa3WOycduNZWc8oy7PjbIYC5hl95LKcaAigdg699PhTFgIKyDm
 zeTzeZ9vOdQxxkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7272E1332F;
 Thu, 10 Nov 2022 16:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MNEBGwggbWPqWQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 10 Nov 2022 16:00:08 +0000
Message-ID: <4409479a-2e65-31a2-f848-bd6921cd2fc2@suse.cz>
Date: Thu, 10 Nov 2022 17:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
To: Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>
References: <20221103164550.7037-1-mdoucha@suse.cz>
In-Reply-To: <20221103164550.7037-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Introduce new struct field for flags
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 03. 11. 22 17:45, Martin Doucha wrote:
> Tests using the .save_restore functionality currently cannot run
> without root privileges at all because the test will write
> into the path at least at the end and trigger error, even when
> the config paths are flagged as optional.
> 
> Introduce new tst_path_val field for flags and replace path prefix flags
> with bit flags. Also introduce new flags to control handling of read/write
> errors and read-only sysfiles and rewrite save_restore implementation
> accordingly.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> This is technically a v2 for
> https://patchwork.ozlabs.org/project/ltp/patch/20221021155740.8339-1-mdoucha@suse.cz/
> 
> I'll send a follow-up patchset to replace setup() code which requires root
> privileges without good reason after this patch gets merged. Here I've kept
> test changes to the minimum needed to maintain current save_restore behavior
> with the new flags system. The only change in behavior is the use of read-only
> handling flags where it's clear that the change is desired.
> 
> Though a few tests should get closer attention during review:
> - all KSM tests
> - add_key05
> - migrate_pages02

Does anybody have any change requests? Or can we merge this so that I 
can send the follow-up patchset?

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
