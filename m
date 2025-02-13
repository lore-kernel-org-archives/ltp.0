Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC566C0219D
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 14:07:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F3463C9AEA
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 15:07:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D107B3C1B29;
 Thu, 13 Feb 2025 15:06:58 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96A61620DAD;
 Thu, 13 Feb 2025 15:06:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8CAD021C85;
 Thu, 13 Feb 2025 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739455615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ay3bg7BZ2JodPCXBReBwT23nq9TBfAPgeqnaEWIPYKs=;
 b=O1IarhRne5aiJ4i5uBpkmJNIhJWsIqhMSC+po6kiwzZ6V3LhtijI1Vytrbkh18uTk6sjUu
 amp4/u7g55Y7xky14sUbHo+VvytB9a+pyUm/YokN7HBraZwjpPurzTu7n2nPsTPydwJGD8
 mLeW/F2uDZroKvbpqKOtNJ37mnHC76Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739455615;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ay3bg7BZ2JodPCXBReBwT23nq9TBfAPgeqnaEWIPYKs=;
 b=kFTwkUavDz3/DdGt56+FL3IIQ72lnY8/OYuEWlMgI7gcMQm+lgSpzeJdgx9DkBPauVJOP1
 1GPW9ekoR/m5zyDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739455615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ay3bg7BZ2JodPCXBReBwT23nq9TBfAPgeqnaEWIPYKs=;
 b=O1IarhRne5aiJ4i5uBpkmJNIhJWsIqhMSC+po6kiwzZ6V3LhtijI1Vytrbkh18uTk6sjUu
 amp4/u7g55Y7xky14sUbHo+VvytB9a+pyUm/YokN7HBraZwjpPurzTu7n2nPsTPydwJGD8
 mLeW/F2uDZroKvbpqKOtNJ37mnHC76Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739455615;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ay3bg7BZ2JodPCXBReBwT23nq9TBfAPgeqnaEWIPYKs=;
 b=kFTwkUavDz3/DdGt56+FL3IIQ72lnY8/OYuEWlMgI7gcMQm+lgSpzeJdgx9DkBPauVJOP1
 1GPW9ekoR/m5zyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 750C113874;
 Thu, 13 Feb 2025 14:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JcNTHH/8rWfiYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 13 Feb 2025 14:06:55 +0000
Date: Thu, 13 Feb 2025 15:06:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <ricardo@marliere.net>
Message-ID: <Z638gLVDlUBLPxlx@yuki.lan>
References: <20250212131618.6810-1-chrubis@suse.cz>
 <D7RBQ8EVJ237.1KWPQN7GTU9YG@marliere.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D7RBQ8EVJ237.1KWPQN7GTU9YG@marliere.net>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[ricardo=marliere.net];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Add shell test metadata parser
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> So, currently there's only testcases/kernel/mem/vma/vma05.sh and the
> goal is to add metadata to all *.sh tests, correct?

Indeed, now I'm looking at how to add setup and cleanup support to the
shell library so that we can convert more tests to it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
