Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0485CC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 19:25:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC5573C97EC
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 20:25:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B50E03C1A87
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:24:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A39F7600878
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:24:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A2D171F38D;
 Wed, 23 Mar 2022 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648063488;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JAMpnfv+s/mk8jWPRcmf0NSEMOIbfAn70ftFaDenjtg=;
 b=gp5RoD3K53cwyltG9EqA5MpJO4WdE63NYdplcJYAEPQt03lx2PrOWByBNvxkhwPLp8PSwo
 bxe+aLRMw11wX5rr4z7gMbMdk8YB7Mtz6aXEVfrQmb61ezLo2Ki/hQ7jKywUmTEFgLTD7/
 owmHS8RgDgzm+CvFhwVX9V00KR3Y3Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648063488;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JAMpnfv+s/mk8jWPRcmf0NSEMOIbfAn70ftFaDenjtg=;
 b=zKmjbNf61WVJROqfNAhDbLrJkIn4GwDrNQdph+IUXXW7304iW6cK0kdy1fFZE/4dN/4YZj
 ZBB55gmHtdtVVBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F7D913302;
 Wed, 23 Mar 2022 19:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bmWkEwB0O2JdTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 19:24:48 +0000
Date: Wed, 23 Mar 2022 20:24:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <Yjtz/oUOMBarvd8t@pevik>
References: <623414B7.6060004@fujitsu.com>
 <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] Add SAFE_ACCESS macro
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

Hi Dai,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Also adding Xu tag from previous version (Dai you can dare to add it for next
version if the patch does not change):
https://lore.kernel.org/ltp/62340304.1000500@fujitsu.com/
https://patchwork.ozlabs.org/project/ltp/patch/1647550813-1958-1-git-send-email-daisl.fnst@fujitsu.com/

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
