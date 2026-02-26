Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045BDFC592F
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 12:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772107236; h=to :
 in-reply-to : references : message-id : date : mime-version : subject
 : list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QTndfAISdcqxzXB6o37sssUK8eOp4gkWfMC9IOEgX7k=;
 b=WosfJfotMwibNF5txvlcgSYbYF5bCrLpMVmUn4hABdxsIl68H/EfGLxEgYDN1v21hh7Z8
 cnraa1Y0wJwSDUy1cA0QZcCxtGNfTVXe63Wp0T5cIG+sS1+8t6YOo9Gfqhqih7P9zKV1Vtq
 7ZrBZUmNppcXPOb3PobXTprYl1Y5RYM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4700F3CB820
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 13:00:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA0AE3C7BA1
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 13:00:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 21B1E1A0091F
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 13:00:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2116402E8;
 Thu, 26 Feb 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94B993EA62;
 Thu, 26 Feb 2026 12:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HJ80Iso1oGn1eQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 26 Feb 2026 12:00:10 +0000
To: ppavlu@suse.cz, ltp@lists.linux.it, Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20260220154742.54150-1-mdoucha@suse.cz>
References: <20260220154742.54150-1-mdoucha@suse.cz>
Message-Id: <177210721055.697091.9289775077554114667.b4-ty@suse.com>
Date: Thu, 26 Feb 2026 13:00:10 +0100
MIME-Version: 1.0
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-3.90 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 FORGED_SENDER(0.30)[andrea.cervesato@suse.com,andrea.cervesato@suse.de];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_NEQ_ENVFROM(0.10)[andrea.cervesato@suse.com,andrea.cervesato@suse.de];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Add test for fanotify monitoring of tracefs
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On Fri, 20 Feb 2026 16:47:07 +0100, Martin Doucha wrote:
> Add test for reading basic fanotify events from a tracefs mount.
> The test will activate monitoring of FAN_MODIFY events from the
> whole mountpoint, create a new kprobe, activate it, deactivate it
> and remove it again. This should generate exactly 4 FAN_MODIFY events.
> 
> On some kernels with badly backported tracefs fixes, this may trigger
> NULL pointer dereference. The testcase is intentionally simple but
> sufficient to trigger this kind of bug. More complex tracing subtests
> can be added later.
> 
> [...]

Applied, thanks!

[1/2] tst_fs.h: Add TST_TRACEFS_MAGIC constant
      commit: a510fbdd2e85eb0d736a1fe498e03340d4af21fe
[2/2] Add test for fanotify monitoring of tracing filesystem
      commit: 6d941650ab4b629b3c27423edbda08597106db5f

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
