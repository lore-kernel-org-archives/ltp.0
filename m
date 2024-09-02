Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DEACD342B
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 13:38:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77C983C4C28
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 15:38:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 244D23C2FDB
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 15:38:24 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 69C4B1000920
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 15:38:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78B431FBAD;
 Mon,  2 Sep 2024 13:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725284303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7ZMTUfPl6A/bBA4jFXgn5DH85AswxKkcsWe+S6WTFM=;
 b=wN7O/n7dTx22rcCtybvgusJ26iCShBngmRZdXBIcfxkxvAEl4TpEo7uZEDDSzhed/sHKqq
 NDaaLtV8zNzZQ9qGFHpsQQkIcq3xPvQUaWWneCAXYgxazMPWaC2/uLXCEQJ7HGrQLeipvN
 gwWkzTcEvEUwQ3dWtVGbUMwhdx4qUyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725284303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7ZMTUfPl6A/bBA4jFXgn5DH85AswxKkcsWe+S6WTFM=;
 b=ddy+KZ6JniM3usP2j4QAhoGddkFE1aszhaxY1bO4rgBmmeiMggSBH/VgVeX0ZCJuSisPVw
 2DTF9yQAHiUR7WCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725284301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7ZMTUfPl6A/bBA4jFXgn5DH85AswxKkcsWe+S6WTFM=;
 b=q7ekMVCwgXhm38ezg4fqCdlXCg087dmE4yYY1XKbMj03zQnnbkeFJdvaGGBw1//l3PSg86
 Bvahn8c8F1i+RgF+Tj/hBH+nZpOSBtmFCZTXEpA7/d9bZuQ4lvYRFnc77JM7up3CdVgihk
 kOJ7Bwr/z7+87tPigvNM/OA6aUOH8lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725284301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7ZMTUfPl6A/bBA4jFXgn5DH85AswxKkcsWe+S6WTFM=;
 b=KUmsA0GFsQfeDA0zDpymnub+CE3q3No5Na4HTl8pC95i0WlJTjljlVG6OymdBEJ/aV49y/
 c/uLWzvXQFIZd/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6528013A7C;
 Mon,  2 Sep 2024 13:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eZHtF82/1WZlJQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Sep 2024 13:38:21 +0000
Date: Mon, 2 Sep 2024 15:36:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZtW_eHAar8bBP6vQ@yuki.lan>
References: <20240515114339.19708-1-andrea.cervesato@suse.de>
 <ZtHQIQE--xS0MAve@yuki.lan>
 <f3a459fc-1777-4106-8313-0bd4395c309d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3a459fc-1777-4106-8313-0bd4395c309d@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite fcnt14 test
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
> I don't know, is a silent version of EQ_LI really needed? It's a 
> particular use case, where also *FAILED is set, so I don't know...

Contrary I would say that this may be a common pattern when we want to
avoid spamming the test output:

	unsigned int failcnt = 0;

	TST_EXP_EQ_LI_SILENT(..., &failcnt);
	TST_EXP_EQ_LI_SILENT(..., &failcnt);
	TST_EXP_EQ_LI_SILENT(..., &failcnt);
	TST_EXP_EQ_LI_SILENT(..., &failcnt);

	if (!failcnt)
		tst_res(TPASS, "All values were fine");


Anyways, we can as well pull the code to the library when we get a
second user.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
