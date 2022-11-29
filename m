Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC021C4167B
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 13:39:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 918373CC5C7
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 14:39:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABA893C85AE
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:38:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 83C5E140096D
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:38:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEB9621BDB;
 Tue, 29 Nov 2022 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669729135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nEYNIgoLLOrgiYllLoDgHJD80dnd1RGSHmbJovEXAss=;
 b=D1HwBjU5Gtr2wo52mVaj3Ua8HafzJTkZmg8jhCUDzSUnkI8x6VENd1zBcu7uSqshAahuVD
 Nnrf0YoJm0uJa/Dhzs9Dky4gBwU++/LDCihlxXIPb6GQIXT2kDBId9jK2cnnvAQRMVi1hp
 fV4czN/7yCefHUObIZEOSXvsqHryY/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669729135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nEYNIgoLLOrgiYllLoDgHJD80dnd1RGSHmbJovEXAss=;
 b=uZaAprpuKcZPUqutXtprIrXIMsuKLIhIfdtFUfxmrKpJ4BQj2BWVcVERRNUtbwMbATPvMF
 CfG5OjNTxJDZ7RBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9181B13AF6;
 Tue, 29 Nov 2022 13:38:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NviaIm8LhmOuNQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 29 Nov 2022 13:38:55 +0000
Date: Tue, 29 Nov 2022 14:40:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y4YLvhQfIW1SW1XB@yuki>
References: <20221128091508.75414-1-teo.coupriediaz@arm.com>
 <Y4UMUqkLijWXOWu6@pevik> <Y4YEnmDLD7AEMHrr@yuki>
 <Y4YK6uhK94C0vrVR@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4YK6uhK94C0vrVR@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/1] brk: use direct syscalls
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
> WDYT about .test_variants? In that case it'd be tested also on musl
> or any platform where it's implemented.

I would got for it, that way we would test both the kernel implemntation
and that libc does something sensible, e.g. returns error.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
