Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A954C982D8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 15:42:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4889B3EABB7
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 17:42:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACE533E76A8
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:42:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ACF1C14010E7
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:42:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1A7E1F385;
 Fri, 18 Sep 2026 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789746150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwz7u1JZkUbtx7OS1+LzoHTGy4kQlpozAhDq13zdBOI=;
 b=gS29f8gM1XiXrYE64TqSJUeVaUp7T80MqlxOyEWzm0ZhfrisQsIadeCxOZMyLtSA4RTrSh
 xA28pMZe6STSPBg5Kr674Mud86G1i0Y+vn+nfrSU+MR7VL6E1DcBDmxUqa8eLp4+HaFP31
 fZ/W6D0KFzqltFCgMSyo7D2Rxk0DEU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789746150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwz7u1JZkUbtx7OS1+LzoHTGy4kQlpozAhDq13zdBOI=;
 b=W+XP38FL+cVt3ak+1X21ufGhrm+1LiIjf9dPaKiEBUqot53yUrU9zSbEhIg00BHn9pdpLb
 7Foc+u1T8ZTORDAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789746146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwz7u1JZkUbtx7OS1+LzoHTGy4kQlpozAhDq13zdBOI=;
 b=Qu8mKCUy+hnJqhzaX/HKgtV0QbbNwpLO88j9oIok4GOBANgGJfhMzDWiquUKM9FZ98gMZU
 gpzAeWwX66GeWLSpMQ9Jp7a8l8c7DPkFcGMFefT55ODcKKrDAAxi8p9DehNL6zWFEb5lUW
 bDfvllKDEIwZzVYa8xGPdwuMt9ZhXDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789746146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwz7u1JZkUbtx7OS1+LzoHTGy4kQlpozAhDq13zdBOI=;
 b=eXyIko0aKQQ+cM0DG1LWpq8HGk+VkzpYc1UAbGWs80X5DjKzm5Qe0VvYxa57nALdalU7bJ
 3IgW71BU40skIKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 409B11348F;
 Fri, 18 Sep 2026 15:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6bfQN+FbrWqqSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Sep 2026 15:42:26 +0000
Date: Fri, 18 Sep 2026 17:42:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260918154224.GA1973373@pevik>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-9-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-9-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 08/36] keyctl14: Negative tests for
 KEYCTL_DESCRIBE
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

Hi all,

I merged patchset up to this patch.

FYI if it helps you, the rest of the patchset is in my fork in branch

andrea/keyctl.v3.fixes.final

https://github.com/pevik/ltp/commits/refs/heads/andrea/keyctl.v3.fixes.final/

As I'm getting the rest of Cyril's review I'll likely merge the rest of the
patchset soon (most certainly tonight).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
