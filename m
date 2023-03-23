Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D01C74A5B
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 16:00:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D98AC3CE304
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 17:00:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3842F3CE2DB
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 16:59:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9449A20013B
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 16:59:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8464F1FE0C;
 Thu, 23 Mar 2023 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679587195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ySiqJRW+v7tDK7/eNTLLTOxdHPO/dD5JAdREwP60AT8=;
 b=V6VYPVmzMdUhpt8eqfpcITZ9V5jyacw6H7/Zu2utmKrxNr+871+gQzqQDvNKt3x8+W2P/n
 RIJ00efnK/ufrvxfz5zVAsrQynFd5Y5QkQUNwvCznmmTAogqMEMUbR+4fgcOXrDyUf1PCN
 we29j7qAio8PO46d0y9neDPfXeI4834=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679587195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ySiqJRW+v7tDK7/eNTLLTOxdHPO/dD5JAdREwP60AT8=;
 b=HgEqBQeoXmUC8+9wXoNzafatCDxkqTGMX5c6E4tbS1QFFLFLEVeERbqBAf1zg8Xhu5aGFe
 kKKKztupriJN35Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 332EB13596;
 Thu, 23 Mar 2023 15:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id X4YrCXt3HGQtOAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 15:59:55 +0000
Date: Thu, 23 Mar 2023 16:59:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <20230323155953.GA461339@pevik>
References: <20230309145917.26846-1-pvorel@suse.cz>
 <BYAPR13MB2503F6AE85D17F078B806C0AFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <20230310073406.GB2216@pevik> <20230310114747.GA5055@pevik>
 <BYAPR13MB2503C9BF7ED9D78FAD55E6FEFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2503C9BF7ED9D78FAD55E6FEFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Matus Marhefka <mmarhefk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

FYI merged. Thanks for your comments.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
