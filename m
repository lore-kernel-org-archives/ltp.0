Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8219DC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 10:37:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A4BA3CDCCE
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 11:37:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B4923CB4DB
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 11:37:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02B07605640
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 11:37:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B024B219CD;
 Fri,  3 Nov 2023 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699007854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rd9+8VmN0wGXe3t6LkCfpom2ssLHgI41aMhOfcvyQZg=;
 b=i/bFjfy4iJCkvVIgkdkssTV3NDx+oKdLpiP55NsFjsNELMhL3eBEVIsXtWXZe5/uf41af6
 3FKCRXqT3qH1U3Fn+mbgTj398swTJaKX3/YwZYcLZZHiwUd1AkBB3LSTqG/GeJZJafFnaC
 E/cqkPe4PqP0HMmwfM/U9BkV6c57KRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699007854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rd9+8VmN0wGXe3t6LkCfpom2ssLHgI41aMhOfcvyQZg=;
 b=6qdMW1ryqxqV8o2np0G6cpAkxF64Osb/ova6Xr5BSXfRm8VOasDLZCbLd/scGD8cTZCvhH
 myAFRtDg5A6QijBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 936B01348C;
 Fri,  3 Nov 2023 10:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kC/+Im7NRGWHGwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 03 Nov 2023 10:37:34 +0000
Date: Fri, 3 Nov 2023 11:38:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZUTNj43_CYMi0m38@yuki>
References: <20230908073407.31444-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230908073407.31444-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork10 test using new LTP API
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
Pushed with two minor changes, thanks.

1. Used the more usuall condition for open fd in cleanup
2. Change SAFE_READ() to pass 1 for len_strict so that we are sure whole
   block was read

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
