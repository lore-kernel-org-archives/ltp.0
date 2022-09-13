Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20541C54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:42:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 784B83CAAEB
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 10:42:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCE1E3CAA8E
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:42:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C3CD600353
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:42:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B35F5C023;
 Tue, 13 Sep 2022 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663058525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9MaAJWzmxUcpcozZ4QQplFU+lEvsZ+TH+UhoDpZhzTs=;
 b=j1i6dr3x654g6TowewO6h66O58XlxCOh8ihdLezgyExpldiSvAXX7irvjPj+pc1V3gvsSE
 0pK22gJxO722apgRQW42yOvwHX9z/vkMrLeNNYnikpcZ7ka15USxs2co3ckwwtf9p+IY0F
 wpC4+j0pQ6o7mWqctz+EiveGF7n1Q0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663058525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9MaAJWzmxUcpcozZ4QQplFU+lEvsZ+TH+UhoDpZhzTs=;
 b=W5aqDnafg1mIpcCIqIax0RInsT2Nxl/+bpTsru0zbvlrR/TGID4imJe9SRB7iKlGzbBU0J
 xjO9t3VV0FoLyiBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F31E1139B3;
 Tue, 13 Sep 2022 08:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AgjQOVxCIGPyHQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 08:42:04 +0000
Date: Tue, 13 Sep 2022 10:42:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YyBCW2EuXP1E8KNS@pevik>
References: <20220913062103.3910-1-pvorel@suse.cz>
 <20220913062103.3910-4-pvorel@suse.cz>
 <CAEemH2fC+Ld9uLdBR=_wUyciqoY29=GFKL4DQWpGhm8xp+pqUA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fC+Ld9uLdBR=_wUyciqoY29=GFKL4DQWpGhm8xp+pqUA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] fanotify14: Use TST_EXP_FD_ERRNO()
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
Cc: Matthew Bobrowski <repnop@google.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Petr,

> The TST_EXP_FD_ERRNO in the subject should be corrected as well.
> Otherwise, patch set LGTM.

Thanks for catching this. V2 merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
