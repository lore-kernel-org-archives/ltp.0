Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A9C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 12:47:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A6293EAD8E
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:47:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9A963EAD87
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:46:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E94991000D28
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:46:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A14A1FE06;
 Thu,  3 Sep 2026 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788439609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u+v5rvcMPxs8te7AYkav7ZHb/EjOIo2aUFViLHMTss0=;
 b=HlO3LNxfaEElK9huzRycsBjGLCeEkJG8x3SUePUaL5ZZQWJjme0uhiG90nuflNFsSqvBaf
 fubSoMP86DTxPvc8NfUEmKBQxCMxmOU9QOuMhk255N1Egcl66DZnYoVDEqcfZZaZyC20OS
 7xiqfTjbIodDS4Xcvw4D4Ii+kxFh5dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788439609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u+v5rvcMPxs8te7AYkav7ZHb/EjOIo2aUFViLHMTss0=;
 b=MMiuIs0roKIpDWLwNklWV5WZE4mmcdUZ0nli99WudFiyCbEwax/bNRYZmskEjH84/TtzrP
 3dP/uUx3n5UEGvCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788439605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u+v5rvcMPxs8te7AYkav7ZHb/EjOIo2aUFViLHMTss0=;
 b=AwJRHr9yqvTY5ZhPH0avO7EOFHLM6eL1pUoCkPwGNo8ek1aaavmqkQQI06mKfnlfVt5E6A
 JgqdjhmH8SPWpQJGWnYqdh6/mmsIHWwISr/9nSEwqNRWXZYWrISqW7dv47HOWqNGny+Nf/
 YH+KV2h539t3iKvsWguUpt5J4O4wEIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788439605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u+v5rvcMPxs8te7AYkav7ZHb/EjOIo2aUFViLHMTss0=;
 b=eNoHMBSX5BQrlFiG9JBc2n8MapIV0z3sADe41CkF0nkQvOCca383K3SlRIy8Sqhe7aRNc7
 Ahv0DCDeklfT/FDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0146F136E6;
 Thu,  3 Sep 2026 12:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3l6uOTRsmWqHLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 12:46:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Sep 2026 14:46:27 +0200
Message-ID: <20260903124631.1100746-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[12]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 0/4] testscripts: Remove outdated scripts (ltp-pan)
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
Cc: Tim Bird <tim.bird@sony.com>, Steffen Jaeckel <sjaeckel@suse.de>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Steffen reported we still have scripts and doc mentioning ltp-pan.

These tests scripts should not be used by anybody as we have kirk.
Also, they are not working since ltp-pan removal anyway.

I also wonder if these controllers scripts should still have that ending
part, which wait for pid. (I'm not even commenting "echo helloworld >
myfifo").

I'd also prefer to remove realtime scripts:

testcases/realtime/Makefile
testcases/realtime/run.sh
testcases/realtime/scripts/Makefile
testcases/realtime/scripts/__init__.py
testcases/realtime/scripts/parser.py
testcases/realtime/scripts/run_c_files.sh
testcases/realtime/scripts/setenv.sh
testscripts/test_realtime.sh

Well I'd prefer to convert port pi_perf, prio-wake to rt-tests and
delete the whole testsuite.

https://github.com/linux-test-project/ltp/issues/1078#issuecomment-2212913818

NOTE: I already dared to remove outdated doc without a review:
https://github.com/linux-test-project/ltp/commit/e2a35f746e6c7893129f1d19eb20d15de0f33d75
https://github.com/linux-test-project/ltp/commit/252f56dcf371be59abd906654d9e77184a9239e4

Kind regards,
Petr


Petr Vorel (4):
  Remove testscripts/network.sh
  Remove testscripts/tpm_tools.sh
  Remove testscripts/ltp-aiodio.sh
  controllers: Remove obsolete references to ltp-pan

 .../cpuctl/run_cpuctl_stress_test.sh          |   2 +-
 .../controllers/cpuctl/run_cpuctl_test.sh     |   4 +-
 testscripts/ltp-aiodio.sh                     | 327 ------------------
 testscripts/network.sh                        | 118 -------
 testscripts/tpm_tools.sh                      | 173 ---------
 testscripts/yesenter.txt                      |   2 -
 6 files changed, 3 insertions(+), 623 deletions(-)
 delete mode 100755 testscripts/ltp-aiodio.sh
 delete mode 100755 testscripts/network.sh
 delete mode 100755 testscripts/tpm_tools.sh
 delete mode 100644 testscripts/yesenter.txt

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
