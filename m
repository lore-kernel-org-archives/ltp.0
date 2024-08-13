Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B13FC52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 09:09:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E73CE3D20F9
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 11:09:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F7833CB1E9
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 11:09:38 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=schwab@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6BD151000A27
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 11:09:38 +0200 (CEST)
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7A28E2037E;
 Tue, 13 Aug 2024 09:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723540177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nD7f/wZwNg0G2rJCBZWgY6OX6Dlb0HqIx2dQxr3osJQ=;
 b=eGLsGv7Gqeg6U0CkJ/IA1gzbE21H74iEykDSMvICs/Hv4NoPnGd+mO6bxLwww7JKPMRXL3
 bS2sn0RhwIGwABNskrVrK6gC6+QpytF87OrnFJ+454XBbKCS1Hk2YMTItevG8fKMiObns4
 on7Xmxo1yl/5T0Gc+WNRQTaXb2DJztI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723540177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nD7f/wZwNg0G2rJCBZWgY6OX6Dlb0HqIx2dQxr3osJQ=;
 b=VKFXVadc9kTtrT468B171hn2ZJH5ZszDxjQXv6iayWKEduUf/hc8X3rNmv4b5sU7y22lvg
 m8bRE3mQgkTmd6Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723540177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nD7f/wZwNg0G2rJCBZWgY6OX6Dlb0HqIx2dQxr3osJQ=;
 b=eGLsGv7Gqeg6U0CkJ/IA1gzbE21H74iEykDSMvICs/Hv4NoPnGd+mO6bxLwww7JKPMRXL3
 bS2sn0RhwIGwABNskrVrK6gC6+QpytF87OrnFJ+454XBbKCS1Hk2YMTItevG8fKMiObns4
 on7Xmxo1yl/5T0Gc+WNRQTaXb2DJztI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723540177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nD7f/wZwNg0G2rJCBZWgY6OX6Dlb0HqIx2dQxr3osJQ=;
 b=VKFXVadc9kTtrT468B171hn2ZJH5ZszDxjQXv6iayWKEduUf/hc8X3rNmv4b5sU7y22lvg
 m8bRE3mQgkTmd6Dw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 6BE7B4A04EA; Tue, 13 Aug 2024 11:09:37 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <210cbd45-5df1-466f-897e-069a51c40d24@suse.com> (Andrea
 Cervesato's message of "Tue, 13 Aug 2024 10:53:50 +0200")
References: <mvm7cckdeqf.fsf@suse.de>
 <4b3c0504-93c9-4359-ab50-35fef5f7ee9c@suse.com>
 <mvm34n8dd1q.fsf@suse.de>
 <210cbd45-5df1-466f-897e-069a51c40d24@suse.com>
X-Yow: LBJ, LBJ, how many JOKES did you tell today??!
Date: Tue, 13 Aug 2024 11:09:37 +0200
Message-ID: <mvmy150bxgu.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.977]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; RCVD_COUNT_ONE(0.00)[1];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix landlock06 test
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

On Aug 13 2024, Andrea Cervesato wrote:

> My question was if you tested it locally,

Yes, I did.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
