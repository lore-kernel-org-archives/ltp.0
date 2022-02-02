Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670D7C433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 11:30:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E5B43C98B0
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 12:29:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD4D63C8F4A
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 12:29:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AEFB51000931
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 12:29:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC82B1F383;
 Wed,  2 Feb 2022 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643801387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/qtQ1vfj3bhRrhP00y3o4XKNTi0PrABt7KP98DImyg=;
 b=of6+gUharJIOlMWgWg/AKSKwn81skymn9sKb+hgIXhVf6KNxpWa5SXa81X4cxR77sSoBXu
 EvDWtX4fLkiaVqftFwKMg/bnyUjMVAzSb5ajSbXiOoIOhuqKZEalh+ydYXncQdrlfbt/IQ
 Ncm45zndQpjD2giW9lyZjE75uMd+0z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643801387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/qtQ1vfj3bhRrhP00y3o4XKNTi0PrABt7KP98DImyg=;
 b=GXaxI4xxZu8Vqnw0CbwTn7ow6RcrwKyFZ6s2Wx9dfs5zoa4KTHiW1c5iN1U/nkbNgdXE0k
 JOofnJm92bXicnCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B8FF13DFF;
 Wed,  2 Feb 2022 11:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BfwGFypr+mFgBwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 02 Feb 2022 11:29:46 +0000
Date: Wed, 2 Feb 2022 12:29:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: linux-sctp@vger.kernel.org, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Vlad Yasevich <vyasevich@gmail.com>,
 Neil Horman <nhorman@tuxdriver.com>, Martin Doucha <martin.doucha@suse.com>
Message-ID: <YfprHQcxAnsb1RI/@pevik>
References: <YfpnVfrto4Elshy5@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfpnVfrto4Elshy5@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] SCTP tests in LTP vs. on github.com/sctp
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

FYI we've been thinking about back in 2013.
https://lore.kernel.org/ltp/20130805121135.GB8739@rei/

I'd personally prefer sctp folks maintain them and we removed them from LTP.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
