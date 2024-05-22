Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0DBC25B78
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 14:34:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 943EA3D0155
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 16:34:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB9EC3CEB69
 for <ltp@lists.linux.it>; Wed, 22 May 2024 16:33:44 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C38BE600117
 for <ltp@lists.linux.it>; Wed, 22 May 2024 16:33:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E276E22BD0;
 Wed, 22 May 2024 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716388423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nFlveN3DhomcuVHjzcqU+QAwLyxlJRom5jdjYpWps8k=;
 b=ee4QJD8S7Hwp0QiR2Q0PnTRDW9t1JjyuRTdVtIQjmeCslQg29wnlqZQaz8Cv66faYNZcXn
 /2rJ/ZUsLUaaIkI+w+1+c9euzH02fqgOj+cGKk5WFZBi3sRMgKj08GW4fdip61hgkfapNS
 BLFG5eeO87Uz3JYQDxjuj9rUl1CLtGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716388423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nFlveN3DhomcuVHjzcqU+QAwLyxlJRom5jdjYpWps8k=;
 b=SEE4TTN0GsFQMLlDVnis+O8/peIlY2ROK6RWEyZX1c5b0LoAbSa2qQ29O3zsMXVhDLfiQj
 /z/3M5q5koS0i+Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716388422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nFlveN3DhomcuVHjzcqU+QAwLyxlJRom5jdjYpWps8k=;
 b=w3V/YW3rFDDUuld3vYs4HxGIcg46ru+YUiCIHIdYXescmY9u0rTINvxmQh/lmbOZGrd4jw
 rwmpthAiXQy9KHbOV8TYIPHRY4hGnzwvPyNYAXC+NtjKA6E82bA79n/lyl1XGkQTGVLom7
 84ydRlpXw3YW9GMOM8ZEULyhTEwDW+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716388422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nFlveN3DhomcuVHjzcqU+QAwLyxlJRom5jdjYpWps8k=;
 b=4yPxiy2U0kiJx3Zu/4n4LW0xaO4M303mcNBM/kKfb1/zWBTPIfDspa0aR82rDyYz5IcbaU
 JWIHA6RX1V6BeECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDAE813A6B;
 Wed, 22 May 2024 14:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AwqlK0YCTmaJOwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 May 2024 14:33:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 22 May 2024 16:33:04 +0200
Message-Id: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACACTmYC/x3MSQqAQAwF0atI1jZoWl14FRFx+GrAiQREkL67j
 cu3qHrJoAKjOnlJcYvJeUTkaULj2h8LnEzRxBkXWcnsLj1HmHW7YkNvcH7myvNQeEZFMbsUszz
 /smlD+ADIuLsxYgAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=qYivq8ia/accoCDMvXUrGBYuoBBUpRzRlYvafzLJWZ8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTgIt4XPqsheuqQ57W6BbOuo5VUXsfUUj7oeRv
 OZWiu5GKriJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZk4CLQAKCRDLzBqyILPm
 RkkVC/9IQzNrM17J5CyzGZALqO00UlBZKFU01ysggWEX7mTwcUqPWRk7piU1vaisLKVNLPgynPE
 VGmHkGQH6wreOGptcHu2/oZFDi84TJkfQQRCiJRZLmN4S4sft/wriv+J8qq8q6rAjLJglMXBG/r
 nhlFSm1lamohNLEzYUOk/NDtroE1ooFqdVhUKt3/7RkOUOkhT4NEsnZLWrV23zT6GMgiYJkpi6T
 DPYqbw1LMhybV/Z9DCVnNzWzCSjO7BcC4kPmqy8vvVuI5HfJ28TBXguUHV3VCq7G/fTxaJv4BmV
 9SmmGDSgCbp/4BfczVTHfLroBA9HIbbrX8gcfp8D60bgfKalO0njfLa2ktiXADTimSjoc6LLuqO
 ZRj0c0qTQ5jqMOhGBpbuAfTlnvCqyS4G7pbmHbHEpzlgDrPRmQyN0y0LKp8G2o0HpHqnA7lBqEv
 a4NHXpJ+Vdpllh/HnQXEkBKzf17DfFL8fzCySqKlPNJzrYFf8irwD+vWkGL5Nk3Rroti4=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url, imap1.dmz-prg2.suse.org:helo,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Add process_mrelease testing suite
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

This testing suite is meant to add coverage for process_mrelease()
syscall, introduced in the kernel 5.15.

The testing suite is providing following tests:
- process_mrelease01
- process_mrelease02

Since there's no man pages, please consider the following
documentation instead:

https://lwn.net/Articles/864184/
https://lwn.net/Articles/865341/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (3):
      Add process_mrelease syscalls definition
      Add process_mrelease01 test
      Add process_mrelease02 test

 include/lapi/syscalls/aarch64.in                   |   1 +
 include/lapi/syscalls/arc.in                       |   1 +
 include/lapi/syscalls/arm.in                       |   1 +
 include/lapi/syscalls/hppa.in                      |   1 +
 include/lapi/syscalls/i386.in                      |   1 +
 include/lapi/syscalls/ia64.in                      |   1 +
 include/lapi/syscalls/mips_n32.in                  |   1 +
 include/lapi/syscalls/mips_n64.in                  |   1 +
 include/lapi/syscalls/mips_o32.in                  |   1 +
 include/lapi/syscalls/powerpc.in                   |   1 +
 include/lapi/syscalls/powerpc64.in                 |   1 +
 include/lapi/syscalls/s390.in                      |   1 +
 include/lapi/syscalls/s390x.in                     |   1 +
 include/lapi/syscalls/sh.in                        |   1 +
 include/lapi/syscalls/sparc.in                     |   1 +
 include/lapi/syscalls/sparc64.in                   |   1 +
 include/lapi/syscalls/x86_64.in                    |   1 +
 runtest/syscalls                                   |   3 +
 .../kernel/syscalls/process_mrelease/.gitignore    |   2 +
 .../kernel/syscalls/process_mrelease/Makefile      |   7 ++
 .../syscalls/process_mrelease/process_mrelease01.c | 118 +++++++++++++++++++++
 .../syscalls/process_mrelease/process_mrelease02.c |  75 +++++++++++++
 22 files changed, 222 insertions(+)
---
base-commit: e644691d30c3948a9788b735c51e09ca849ea47f
change-id: 20240522-process_mrelease-3f2632b432e6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
