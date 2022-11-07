Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF06C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 15:04:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99B9D3CDA3B
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 16:04:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBB653CABA2
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 16:04:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 614766002A8
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 16:04:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22E2E224EB;
 Mon,  7 Nov 2022 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667833462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPUKIIrWfm2fi/FM15/inbCEwa/nDNBCJSh/W7N9jW0=;
 b=TUHB86an3AfZcXPmxsv4nwUD1FCaLawk6h4JgaTU8aPtvPCb8pp0JJOU6VY4rCt3Tx6OdH
 FImmpOhcrNNam+J6HEfoRP6TnQEXQRKP0U0f0w7Gqg4mh/5BC4cFZsOGddT7ZZoqk8vdIQ
 FvX80rOnET53cY1KnJjGqZ7u0CpwAcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667833462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPUKIIrWfm2fi/FM15/inbCEwa/nDNBCJSh/W7N9jW0=;
 b=m2YHB9Gdi0w7vUC0z2cqG2wPYY5h/r0JyfwHa8rozFHbjO3NpQ18b8NuG+lXpFUTnoFJ/P
 VTSfxEIvdarJZmBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0381C13AC7;
 Mon,  7 Nov 2022 15:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nQH0OnUeaWMVFwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 07 Nov 2022 15:04:21 +0000
Date: Mon, 7 Nov 2022 16:05:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <Y2ke0FphPNuXb+kD@yuki>
References: <20221103164431.365731-1-teo.coupriediaz@arm.com>
 <20221103164431.365731-2-teo.coupriediaz@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221103164431.365731-2-teo.coupriediaz@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] regen.sh: Use intptr_t for tst_syscall return
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
Reviwed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
