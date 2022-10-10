Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB53C433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 12:22:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A71283CAE66
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 14:22:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C0F73CAE5A
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 14:22:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 22245600103
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 14:22:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A7B3219AD;
 Mon, 10 Oct 2022 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665404542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqquEuQDCxxOBMf8knioOdDw9RAqLA5C04l4kPN8ldw=;
 b=huBS4P52MPPKTQ1r3OxpLER4h9mFMs5bDH5UduiIsFdNo0fISipz48C4JAqvkgiGcbjTs0
 CYfZQrZFl8JHXpsA4TiX2aRfjzjz4TIxYU4uMJ5mhHto/UhAGswYuDgLWdxruZMTFRbZKr
 Vecd09dSMThE0mQ/btgOZtUbCqF2TqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665404542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqquEuQDCxxOBMf8knioOdDw9RAqLA5C04l4kPN8ldw=;
 b=izcNHwFvhAPJyDe1Jj5fgBC9elM/Gi5jM898hEf8ffkuHyotybyCgVotkzuLpCo0HCJBLf
 xSN/5Jk/guro7BDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AE4813ACA;
 Mon, 10 Oct 2022 12:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QMuuAn4ORGOaYAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 10 Oct 2022 12:22:22 +0000
Date: Mon, 10 Oct 2022 14:24:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Y0QO6PKrwdrm6fEv@yuki>
References: <adf3a4e338625d85401a7d5ec94b33f86a277c18.1665385670.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adf3a4e338625d85401a7d5ec94b33f86a277c18.1665385670.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/ioctl03: add IFF_NO_CARRIER feature flag
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
> commit 195624d9c26b ("tun: support not enabling carrier in TUNSETIFF")
> introduced IFF_NO_CARRIER feature flag. Add it to known flags
> to avoid triggering:
>   ioctl03.c:85: TFAIL: (UNKNOWN 0x40)

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
