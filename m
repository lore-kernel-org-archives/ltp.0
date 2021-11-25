Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0391C433EF
	for <ltp@archiver.kernel.org>; Thu, 25 Nov 2021 11:06:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B749C3C8631
	for <ltp@archiver.kernel.org>; Thu, 25 Nov 2021 12:06:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 534163C092B
 for <ltp@lists.linux.it>; Thu, 25 Nov 2021 12:06:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DD1F210008FE
 for <ltp@lists.linux.it>; Thu, 25 Nov 2021 12:06:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E542F1FD3C;
 Thu, 25 Nov 2021 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637838376;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DF+fn7KlDobANYbUL4GaMfJ+d3JuVHAXPvMgx0UmJGY=;
 b=y+VIH0enD+cgE0U42sFQjYvqR1lnj4o1stV4eFgdU58IwCX+ye4fEScbTyobZv/1WPLvQf
 7btHAfr9uMuX38Kaa3yM1niGrlEtmviOutw1LQrrSGT7HLqCmqAiCJvEs/wBnYcsDyKNQq
 wn/zHp/oFOQ/DOgLgsXRw2y/oor5E7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637838376;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DF+fn7KlDobANYbUL4GaMfJ+d3JuVHAXPvMgx0UmJGY=;
 b=pW86GM/C06IBcdr38p0PLH6zx2wjHSnYhko/om+/Qek/NNMqiUVwXpPDZih6MkA+SQUAT6
 8XQpSWtG6o6QS9Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC76113B81;
 Thu, 25 Nov 2021 11:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SjdsLChun2F5VAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 25 Nov 2021 11:06:16 +0000
Date: Thu, 25 Nov 2021 12:06:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YZ9uJxpGVuSQGEaA@pevik>
References: <20211123151537.14913-1-mdoucha@suse.cz>
 <20211123151537.14913-3-mdoucha@suse.cz> <YZ1Dmbh+m6blfLzZ@pevik>
 <9d0f2161-4c10-6318-5a15-470cc12fe76c@suse.cz>
 <YZ4LAN2RrJntGlFq@pevik>
 <8b239e34-14cc-dfab-cdf4-bec9148a3a42@bell-sw.com>
 <69812961-2e53-c80d-7b5a-b37305215149@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69812961-2e53-c80d-7b5a-b37305215149@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Add test for NFS directory listing
 regression
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

Hi Martin, Alexey,

> On 24. 11. 21 15:07, Alexey Kodanev wrote:
> > Hi Petr, Martin

> > Overall the new test looks good, and I would only replace the old style
> > command substitution count=`ls ...` with count=$(ls ...).
+1, thanks for a review.

> Good idea.

I'll do that before merging this (later today).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
