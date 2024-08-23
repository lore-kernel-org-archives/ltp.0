Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ADDC531DC
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 11:42:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C759D3D2332
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 13:42:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F3123D2258
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 13:42:26 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E5E3C1000403
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 13:42:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AD2C223C9;
 Fri, 23 Aug 2024 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724413344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TcW+kCAH1cL6h21dzG0D5FbGeqBLAHcdnDWuMtK6g8M=;
 b=2v02dCfLCgVzU1D0nS1sixHr66Qeniyh/xFr2bumWvpidSSxXNzmTRiyLzVczeGu0aspLl
 cwmoirOvR9v7My8SCbom1T6qfgHkhkvSuEjiPY7o3z+7rSRIdmoiZUn5sxt4Q4S+m7OHKX
 EVdDlcMImk49Cg+xBTL6l0+Q9bSBBJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724413344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TcW+kCAH1cL6h21dzG0D5FbGeqBLAHcdnDWuMtK6g8M=;
 b=Rv9LQ0yM2jeTeKtvRJypCWaLhVKGGiD61RF26rjphEPsXQCo+OckXMOMahMkikKBYAayun
 ckv9VpbevxwRWVBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724413344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TcW+kCAH1cL6h21dzG0D5FbGeqBLAHcdnDWuMtK6g8M=;
 b=2v02dCfLCgVzU1D0nS1sixHr66Qeniyh/xFr2bumWvpidSSxXNzmTRiyLzVczeGu0aspLl
 cwmoirOvR9v7My8SCbom1T6qfgHkhkvSuEjiPY7o3z+7rSRIdmoiZUn5sxt4Q4S+m7OHKX
 EVdDlcMImk49Cg+xBTL6l0+Q9bSBBJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724413344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TcW+kCAH1cL6h21dzG0D5FbGeqBLAHcdnDWuMtK6g8M=;
 b=Rv9LQ0yM2jeTeKtvRJypCWaLhVKGGiD61RF26rjphEPsXQCo+OckXMOMahMkikKBYAayun
 ckv9VpbevxwRWVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 154D81398B;
 Fri, 23 Aug 2024 11:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sePMA6B1yGbeRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 11:42:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 23 Aug 2024 13:42:14 +0200
Message-ID: <20240823114217.1261861-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] ci: Simplify and speedup minimal installation
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I tried to address Andrea's complain against installing and uninstalling
(hard to debug).

Now minimal installation is really the fastest.

Tested: https://github.com/pevik/ltp/actions/runs/10525033207

Kind regards,
Petr


Petr Vorel (3):
  ci/debian: Simplify dependencies installation / removal
  ci/debian: Speedup minimal variant installation
  ci/debian.sh: Make dependencies really minimal

 .github/workflows/ci-docker-build.yml |  2 +-
 ci/debian.minimal.sh                  | 16 +----
 ci/debian.sh                          | 88 +++++++++++++++++----------
 3 files changed, 58 insertions(+), 48 deletions(-)

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
