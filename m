Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9905ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:50:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33BEC3CAC32
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 13:50:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A46B3C941D
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 13:50:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B08DD600A3D
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 13:50:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B1D081F45B;
 Thu, 15 Sep 2022 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663242599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfyzcCXe/ktv8a7LkTsdhm4BRjUv5P5v5//xnBKXW9E=;
 b=ktFW13LKVmRSZ0XeH/pBYjNnu0+ytW/N0jvuyt5PmZy0oYJJgkce+rYWAbEBJEUZsNTOZd
 vQdHCMVSRZxiZYoos8d2c0uf/SeHo4xYH7UUvw7uYk1w23LDn71Eh8GV+4wzCzW5DIjCRK
 V2QrF/MeUSrRmO42wZreTohitin5jcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663242599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfyzcCXe/ktv8a7LkTsdhm4BRjUv5P5v5//xnBKXW9E=;
 b=zbHDYCgp4ADoLACeZJICUXSTFEnGVHwB/lvdj9ZqjR/q8sSMgR1j/QnwtxPykab3QzelI+
 cH9mzydrDhnPERCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BAE113A49;
 Thu, 15 Sep 2022 11:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TZ+NJGcRI2OCMgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 15 Sep 2022 11:49:59 +0000
Date: Thu, 15 Sep 2022 13:51:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyMR3Mv/BgKp4EJ0@yuki>
References: <20220914161930.27681-1-mdoucha@suse.cz>
 <20220914161930.27681-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220914161930.27681-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] ioctl_sg01: Add max_runtime
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
> Test setup can take very long time depending on the amount of free RAM.
> Set high max_runtime to avoid timeout issues.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Changes since v1:
> - Changed max_runtime from unlimited to 1 hour
> 
> We'll add .max_setup_runtime after the release to not break even more things.
> Let's use this as a temporary fix.

Fair enough. Pushed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
