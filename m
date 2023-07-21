Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC0BC001DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 16:16:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A87AB3CDC7F
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 18:16:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 546463C949E
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 18:16:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B2165600290
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 18:16:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 27BE9218E3;
 Fri, 21 Jul 2023 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689956201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUK7P3ZO1x2I1bIDB8kZYolgZUz6aEcgh0ozIvvNbQs=;
 b=iZu262OPHTDiGGiJbel6yMGQ9JEm3AzzkXhI5jKwJBKYfZc8iKwZKLcS0u7KX7TjzXr0iY
 7C9Ask1+GU1TXbHsWElyQRWOZ0lBMU8Sra4lxY/Tb6d6ZJLPT33IExdEGCeoGT34LaUmru
 2U0bMhLJS2g+pPwo/2jwCm73ukzKgIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689956201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUK7P3ZO1x2I1bIDB8kZYolgZUz6aEcgh0ozIvvNbQs=;
 b=2UPp+p+vY9ySXvu7MMy/xz06x6W9NkIg3wL7u4te9SbWMDi6/HUlB6V/iVJedS+GXPmZhf
 KnAR4m4gF3cZy2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C8B3134B0;
 Fri, 21 Jul 2023 16:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MIe/AWivumSpQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 16:16:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: chrubis@suse.cz
Date: Fri, 21 Jul 2023 18:16:36 +0200
Message-Id: <20230721161636.1465036-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719103743.4775-2-chrubis@suse.cz>
References: <20230719103743.4775-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] sched/rt: Fix sysctl_sched_rr_timeslice
 intial value
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
Cc: juri.lelli@redhat.com, jbohac@suse.cz, vincent.guittot@linaro.org,
 peterz@infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 bsegall@google.com, mingo@redhat.com, mgorman@suse.de, vschneid@redhat.com,
 bristot@redhat.com, dietmar.eggemann@arm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
