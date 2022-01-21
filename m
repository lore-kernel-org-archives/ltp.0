Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3685C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 15:30:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18DCB3C9709
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 16:30:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F6303C9232
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 16:30:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 003476018B8
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 16:30:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2917D21900;
 Fri, 21 Jan 2022 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642779010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AzOVnywjv9r+sh5/OFx0s3RLymt6UDhAElPf0nbv/n0=;
 b=XD0BeyM5+LTXKntyjpViQ2iO2xtXAxXl/nGxqecyw346eUJUe1YejKkW2lhY2RJvXtcin6
 Zvbd+isUi+5WqU5a4qZae8bFCg3vr4BPmMve7o5ZfjhJnn5R0tGWgqvW2EJQcHlhYLXkBL
 7o4lKmsPYSjPiyo9RDdwN+hkyUpmXEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642779010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AzOVnywjv9r+sh5/OFx0s3RLymt6UDhAElPf0nbv/n0=;
 b=viojN9R9oEexqXPkAS5XLthCD4Ve3c/Y4EKk1iOsoRBNPBEmV6OYEENKTqBQA4azClcqEP
 syQi69YeUJUacBCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0861A139FE;
 Fri, 21 Jan 2022 15:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FrYBN4DR6mHCBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 15:30:08 +0000
Date: Fri, 21 Jan 2022 16:30:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YerReN2eDh98nWzZ@pevik>
References: <20220121134052.30048-1-pvorel@suse.cz>
 <20220121134052.30048-2-pvorel@suse.cz>
 <25efba68-899f-47b1-b4f3-e6a3ddc2ff78@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <25efba68-899f-47b1-b4f3-e6a3ddc2ff78@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v2 PATCH 2/2] dio_sparse: Set timeout 30 min
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

Hi Martin,

> Hi,
> the commit message needs an update due to changes but otherwise:
Thanks, again today!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
