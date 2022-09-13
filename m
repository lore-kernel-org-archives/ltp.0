Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D930C54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 06:33:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D01C3CAB8E
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:33:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC4453CAAE3
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:33:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A16F600AA2
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:33:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 881DE5BE0D;
 Tue, 13 Sep 2022 06:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663050799;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=btk8hqPIe/0vdFDMNkr4Cy8DDV+OvhnXZ0qMKN2emfI=;
 b=TB47HiJ2p3pwMbVqrqykqLQO62mKkdT7t+rhhLwk7OLFQVNTbGG390gKDrKGvLecLhvf8A
 tlVubn2eNyejTsWxrcuOjc+znzzWHvt488vx8K2L7acgqmwGrOoQOwniDcekj+Li3gA6Il
 KYpfOwZgG/PjJxAasmlYFsEKaigyNCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663050799;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=btk8hqPIe/0vdFDMNkr4Cy8DDV+OvhnXZ0qMKN2emfI=;
 b=VbN6UlF68Le2Wk+AUNC4YElycU93PlbXZs5vBTMi1LSxvilLbCx9emAleNxVSjAjLaO4nT
 j+4JGZQTvtjAYnBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BE23139B3;
 Tue, 13 Sep 2022 06:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lg7zFC8kIGMcawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 06:33:19 +0000
Date: Tue, 13 Sep 2022 08:33:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: huangjuniter@foxmail.com
Message-ID: <YyAkLcUW9ZETUkAA@pevik>
References: <tencent_357C210832AC0D20B4889919FC9761627505@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_357C210832AC0D20B4889919FC9761627505@qq.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pm_include.sh: Fix calculation error of
 no_of_sockets
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

Hi Jun,

thanks for git commit description.

Merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
