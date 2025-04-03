Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD607C3600C
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 15:47:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32BBF3CB254
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 17:47:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E084D3CA6F4
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 17:47:21 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9AA2E1A00808
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 17:47:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89019211B8;
 Thu,  3 Apr 2025 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743695239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXwoq2LzXOQzyBFqn5UvNN7M19Fz75c0LUbZNeEqgzw=;
 b=2ErRT+Mqv57cufH1GoCS831HUSsmBbo5QJz12VRf3GKK8kgdJkyXe/AAO5OpA8FOrhZkyH
 pLsJz38t6lp3YCx0G/NjvciIOI1xtSm5RC3lFY/q66DRtpShkQOLQAdSDm4sWhBObq2Gv2
 WjtaLKI4jJLjy6sadcamCSsjomfLrJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743695239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXwoq2LzXOQzyBFqn5UvNN7M19Fz75c0LUbZNeEqgzw=;
 b=P5RF6GWqdLhXCJv4qNwFx1HtBsJMHKWovX5EWbxTpPC7w8nfeIdSkz2VQH4Kecc4HDwyk8
 wdUg3aTSvuxj9kDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2ErRT+Mq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=P5RF6GWq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743695239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXwoq2LzXOQzyBFqn5UvNN7M19Fz75c0LUbZNeEqgzw=;
 b=2ErRT+Mqv57cufH1GoCS831HUSsmBbo5QJz12VRf3GKK8kgdJkyXe/AAO5OpA8FOrhZkyH
 pLsJz38t6lp3YCx0G/NjvciIOI1xtSm5RC3lFY/q66DRtpShkQOLQAdSDm4sWhBObq2Gv2
 WjtaLKI4jJLjy6sadcamCSsjomfLrJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743695239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXwoq2LzXOQzyBFqn5UvNN7M19Fz75c0LUbZNeEqgzw=;
 b=P5RF6GWqdLhXCJv4qNwFx1HtBsJMHKWovX5EWbxTpPC7w8nfeIdSkz2VQH4Kecc4HDwyk8
 wdUg3aTSvuxj9kDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76EFE13A2C;
 Thu,  3 Apr 2025 15:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TlLPG4et7mfobwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Apr 2025 15:47:19 +0000
Date: Thu, 3 Apr 2025 17:47:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Z-6tnZLIQvY3IIbb@yuki.lan>
References: <20250403101912.459507-1-pvorel@suse.cz>
 <0045063b-ae7f-4dd6-9b8e-9d760713ea3b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0045063b-ae7f-4dd6-9b8e-9d760713ea3b@suse.com>
X-Rspamd-Queue-Id: 89019211B8
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 0/2] Merge runtest files
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
> this is a _huge_ topic that might affect LTP automation configurations.
> 
> It's a job that IMHO should be done, but it makes more sense to wait for 
> testing suites definition in metadata, as well as a total refactoring of 
> old LTP tests.

For a bigger changes yes. I would say that eliminating runtest files
with a single test could be done sooner.

> The reason of my statements is not only that runtest files should be 
> removed one day, but also that known issues inside products which are 
> tested, often require years of analysis of the runtest files and their 
> executions. By shuffling tests around will create issues where there's 
> no need due to a small logical improvement.

I do not think that it's as severe as you describe it. We change runtest
files a lot in each release and additions to runtest/syscall are the most
frequent.

> I think we should start to push more on testing suites definition inside 
> metadata and to refactor tests as fast as possible. So we will be free 
> from runtest files, leading to a more coherent structure of the tests 
> organization.

We are getting there slowly, but I'm afraid that it will take years to
get there.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
