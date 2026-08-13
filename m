Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37A3C5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 14:47:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCFA33C6EE3
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 16:47:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4D543C5E2C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:46:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8AD8410008F4
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:46:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23C6B3EAC;
 Thu, 13 Aug 2026 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786632405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYTBic4EkvLk3ZmUY5hwmyRljthjmq2cZjJuGMFlUJI=;
 b=RunxPShvWgYUwNfbdSdzDoyzLCdh2BSwIKgsGwXWetDh1pMPZsxxLYuIyN6eKYcYps41Rr
 q1+b2aR2uDUMjsxSruMl14NWhQKTcMhJiNcLOBnreU6m5RebQg+h1DNJEA5c5saoKUPSzc
 A4sVwosBnmCb9L2vFnvX8GWFat7oE/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786632405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYTBic4EkvLk3ZmUY5hwmyRljthjmq2cZjJuGMFlUJI=;
 b=6nEwkEld2kXbxLMQrRi7zLiyTiHFCct9a6wcEAOGEPn6yDhu5/2BWpKWiHIJfSdiBGxSOh
 ZumpNMH/VfGc1pDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MUdKOV4X;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7m5tWEAt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786632401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYTBic4EkvLk3ZmUY5hwmyRljthjmq2cZjJuGMFlUJI=;
 b=MUdKOV4XJsJiBbDOBJHJv6LrAe0l8ZRqioK8ook+axZitZrwqoelmGOpAFyC8zasmbbjFR
 WdZqxELjWY4rCQITB6BGJOyjCtGarGEqFbDoJ80B9pRtoIpEc9dkwAjyOz4DblsDZ+rPt2
 kFHqOM2TghXFGBHpVxSFCGQ1HlNJNsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786632401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYTBic4EkvLk3ZmUY5hwmyRljthjmq2cZjJuGMFlUJI=;
 b=7m5tWEAtpc/S1Gq7jH+bHUKos7ixcgyD3mtX7zK9JXpjP0q7oDmnac4gm52IL1+EKi6Zg2
 2vuEyqiQgibCB4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AE0177E86;
 Thu, 13 Aug 2026 14:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Yb0RAdHYfWpMVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 13 Aug 2026 14:46:41 +0000
Date: Thu, 13 Aug 2026 16:46:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <an3Y03mKBzue5w2s@yuki.lan>
References: <20260811144854.97821-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260811144854.97821-1-avinesh.kumar@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 23C6B3EAC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,yuki.lan:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: Remove timer_*/speculative tests for
 invalid timerid
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
The only concern I have here is that there are UNIX-like OSes that
actually implement all the optional behavior and in that case these are
valid tests. AFAIK OpenBSD implements are these "may" clauses that Linux
implementation ignores completely.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
