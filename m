Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540C0C25B47
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 20:11:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68C773CF4EC
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 22:11:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 091AC3CD037
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 22:11:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFC3F1402FAA
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 22:11:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C8B621C6F;
 Tue, 24 Oct 2023 20:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698178299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6S/4BDB3zcakzzm7C7pQdpYZbQ0jupn//yYLkZlddsE=;
 b=IkJG2wkvZgjXFrrN0WTY4vrt24pnnutcDeszivuIIwK9x5v74FRZMJlT7+tBn01oqdsjjU
 i+sEenoEtZnPJ2JfQJw4OC21rtLb3oEptQXHKofVu2KOtAEi+Awmx/Q7GicvSOJPmo1D+2
 RlHoG+BIs6DKwX9tMXcrpRtezaxVVtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698178299;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6S/4BDB3zcakzzm7C7pQdpYZbQ0jupn//yYLkZlddsE=;
 b=OKPeF2F/LxTfDsWn01HEfFlpLkErY/BH3IYUaApYbwzEuV2L8z0DlK7oa2VFI4vt8Q8BJL
 ANwGsEQeJdijGqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BB6D1391C;
 Tue, 24 Oct 2023 20:11:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L+ZYDPokOGVmVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Oct 2023 20:11:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Oct 2023 22:11:33 +0200
Message-ID: <20231024201135.264768-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.50)[97.74%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fix CI for CentOS 7
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

this is untested fix for CentOS 7. i.e. it fixes the compilation, but I
haven't tested it on the actual VM (I don't have any and don't plan to
do any further testing).

That brings me to the question if we still want to keep support for
CentOS 7, which has kernel: 3.10, glibc: 2.17, gcc: 4.8.5 [1].
But I'll raise this question on a separate RFC thread on ML,
where I Cc more people.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions

Petr Vorel (2):
  lapi: Add uinput.h
  input_helper: Fix compilation on CentOS 7

 configure.ac                          |  1 +
 include/lapi/uinput.h                 | 15 +++++++++++++++
 testcases/kernel/input/input_helper.c |  1 +
 3 files changed, 17 insertions(+)
 create mode 100644 include/lapi/uinput.h

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
