Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CE7E7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 22:59:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71ED63E9441
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 23:59:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA75F3E9433
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 23:58:01 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C9CC1421763
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 23:57:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 402161F38F;
 Tue, 10 Dec 2024 22:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733871479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=97KQL1Cr0Bt7KP2yNZRRZum3LaSdm8igTdda5DKl0Cc=;
 b=DrgQuSZHD2WTg5AinkXXF3CxQBvrs6ZYVhYp8yjQxew/subrKfCSIr7bsqt219u7k5jCgb
 sseM5sMOoEoeshlGVcSWdsbVSzDwjiYL10pyWNplMWJxvQXZu1V8vGBxWGhmeEAmjjM3qt
 bJW9HKQO5IBG4ZxGNSRPqNHbJ8xOj9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733871479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=97KQL1Cr0Bt7KP2yNZRRZum3LaSdm8igTdda5DKl0Cc=;
 b=CpvHJ7UeF54QNTUEnFQmIZehHHPBVbz1mCA5/N4vigJwa1074twk1+REFD+akrqoRWhqrt
 AgpURc44ou8xT5AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733871479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=97KQL1Cr0Bt7KP2yNZRRZum3LaSdm8igTdda5DKl0Cc=;
 b=DrgQuSZHD2WTg5AinkXXF3CxQBvrs6ZYVhYp8yjQxew/subrKfCSIr7bsqt219u7k5jCgb
 sseM5sMOoEoeshlGVcSWdsbVSzDwjiYL10pyWNplMWJxvQXZu1V8vGBxWGhmeEAmjjM3qt
 bJW9HKQO5IBG4ZxGNSRPqNHbJ8xOj9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733871479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=97KQL1Cr0Bt7KP2yNZRRZum3LaSdm8igTdda5DKl0Cc=;
 b=CpvHJ7UeF54QNTUEnFQmIZehHHPBVbz1mCA5/N4vigJwa1074twk1+REFD+akrqoRWhqrt
 AgpURc44ou8xT5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01C4B138D2;
 Tue, 10 Dec 2024 22:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gs6qOnbHWGd9KQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Dec 2024 22:57:58 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 10 Dec 2024 23:57:46 +0100
Message-ID: <20241210225753.381770-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] ci: run shell loader tests
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

Tested: https://github.com/pevik/ltp/actions/runs/12266022900

Changes v1->v2:
* Adjusted docker options to be able to run more tests (--privileged -v/boot:/boot)
* Run more tests in CI
* Add new test lib/newlib_tests/shell/tst_device_size.sh
* GitHub Actions workaround removed (not needed)

shell/test_timeout.sh sometimes fails on GitHub Actions (not locally).
It'd be great to fix it and enable. Set TST_TIMEOUT when $GITHUB_ACTIONS
set?

I wonder how to fix tst_fuzzy_sync0[12] failure (happens only on GitHub
Actions, not locally). Too slow machine?

runtest TINFO: * tst_fuzzy_sync01
2024-12-10T21:06:46.0681820Z /__w/ltp/ltp/lib/tst_test.c:1890: TINFO: LTP version: 20240930
2024-12-10T21:06:46.0682752Z /__w/ltp/ltp/lib/tst_test.c:1894: TINFO: Tested kernel: 6.5.0-1025-azure #26~22.04.1-Ubuntu SMP Thu Jul 11 22:33:04 UTC 2024 x86_64
2024-12-10T21:06:46.0683625Z /__w/ltp/ltp/lib/tst_test.c:1725: TINFO: Timeout per run is 0h 03m 00s
2024-12-10T21:06:46.0692510Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:0  act:0  art:0  | =:101  -:66   +:31  
2024-12-10T21:06:46.0694960Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:0  act:1  art:0  | =:101  -:0    +:0   
2024-12-10T21:06:46.0698746Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:1  act:1  art:1  | =:101  -:3    +:0   
2024-12-10T21:06:46.0722288Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:3  act:1  art:1  | =:101  -:2    +:0   
2024-12-10T21:06:46.2536655Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:06:46.2537513Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:06:46.2538467Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =     9ns, avg_dev =    44ns, dev_ratio = 4.93 }
2024-12-10T21:06:46.2539590Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16401ns, avg_dev =    13ns, dev_ratio = 0.00 }
2024-12-10T21:06:46.2540738Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16404ns, avg_dev =     8ns, dev_ratio = 0.00 }
2024-12-10T21:06:46.2541797Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =     6ns, avg_dev =    36ns, dev_ratio = 6.52 }
2024-12-10T21:06:46.2542821Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =    12  , avg_dev =     7  , dev_ratio = 0.59 }
2024-12-10T21:06:46.2664692Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:06:46.2665676Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-23759, 23435]
2024-12-10T21:06:46.2666441Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10726, delay_bias = 0
2024-12-10T21:06:46.2667457Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -54ns, avg_dev =     5ns, dev_ratio = 0.09 }
2024-12-10T21:06:46.2669043Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16157ns, avg_dev =    25ns, dev_ratio = 0.00 }
2024-12-10T21:06:46.2670142Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16380ns, avg_dev =     3ns, dev_ratio = 0.00 }
2024-12-10T21:06:46.2671463Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =  -277ns, avg_dev =    26ns, dev_ratio = 0.10 }
2024-12-10T21:06:46.2672534Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =   402  , avg_dev =    35  , dev_ratio = 0.09 }
2024-12-10T21:06:49.0923890Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:3  act:1  art:1  | =:101  -:271  +:136657
2024-12-10T21:06:49.2658052Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:06:49.2658975Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:06:49.2659942Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    33ns, avg_dev =    28ns, dev_ratio = 0.84 }
2024-12-10T21:06:49.2661132Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16463ns, avg_dev =     5ns, dev_ratio = 0.00 }
2024-12-10T21:06:49.2662244Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16417ns, avg_dev =    32ns, dev_ratio = 0.00 }
2024-12-10T21:06:49.2663314Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =    79ns, avg_dev =    30ns, dev_ratio = 0.39 }
2024-12-10T21:06:49.2664348Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =    55  , avg_dev =    28  , dev_ratio = 0.50 }
2024-12-10T21:06:52.0272237Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:06:52.0273248Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-24238, 23931]
2024-12-10T21:06:52.0274078Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 169676, delay_bias = 0
2024-12-10T21:06:52.0275621Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -34ns, avg_dev =     3ns, dev_ratio = 0.09 }
2024-12-10T21:06:52.0276817Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16270ns, avg_dev =    11ns, dev_ratio = 0.00 }
2024-12-10T21:06:52.0278275Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16479ns, avg_dev =    14ns, dev_ratio = 0.00 }
2024-12-10T21:06:52.0279520Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =  -243ns, avg_dev =    14ns, dev_ratio = 0.06 }
2024-12-10T21:06:52.0280591Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =   357  , avg_dev =    22  , dev_ratio = 0.06 }
2024-12-10T21:06:54.2419535Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:1  act:1  art:3  | =:101  -:267601 +:78  
2024-12-10T21:06:54.4193309Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:06:54.4194214Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:06:54.4195173Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    14ns, avg_dev =    22ns, dev_ratio = 1.62 }
2024-12-10T21:06:54.4196275Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16615ns, avg_dev =   153ns, dev_ratio = 0.01 }
2024-12-10T21:06:54.4197355Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =  5859ns, avg_dev =   152ns, dev_ratio = 0.03 }
2024-12-10T21:06:54.4198408Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 10769ns, avg_dev =    25ns, dev_ratio = 0.00 }
2024-12-10T21:06:54.4199439Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17325  , avg_dev =    34  , dev_ratio = 0.00 }
2024-12-10T21:06:54.4258664Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:06:54.4260129Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-9108, 26396]
2024-12-10T21:06:54.4260948Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10378, delay_bias = 0
2024-12-10T21:06:54.4261896Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -55ns, avg_dev =     5ns, dev_ratio = 0.10 }
2024-12-10T21:06:54.4263121Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16406ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:06:54.4264546Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =  5662ns, avg_dev =     7ns, dev_ratio = 0.00 }
2024-12-10T21:06:54.4265661Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 10690ns, avg_dev =    12ns, dev_ratio = 0.00 }
2024-12-10T21:06:54.4266759Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17199  , avg_dev =     9  , dev_ratio = 0.00 }
2024-12-10T21:06:58.3616515Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:3  act:1  art:1  | =:101  -:277  +:230753
2024-12-10T21:06:58.5329851Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:06:58.5330708Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:06:58.5331674Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    16ns, avg_dev =    17ns, dev_ratio = 1.04 }
2024-12-10T21:06:58.5332794Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16446ns, avg_dev =    10ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.5333875Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =  5696ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.5334941Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 10766ns, avg_dev =    19ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.5335985Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17401  , avg_dev =    29  , dev_ratio = 0.00 }
2024-12-10T21:06:58.5374712Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:06:58.5376049Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-9178, 26558]
2024-12-10T21:06:58.5377027Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10246, delay_bias = 0
2024-12-10T21:06:58.5378252Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -52ns, avg_dev =     4ns, dev_ratio = 0.08 }
2024-12-10T21:06:58.5379584Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16430ns, avg_dev =     8ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.5380868Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =  5678ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.5382818Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 10700ns, avg_dev =    13ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.5383914Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17296  , avg_dev =    15  , dev_ratio = 0.00 }
2024-12-10T21:06:58.5847723Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:1  act:1  art:3  | =:101  -:12804 +:1   
2024-12-10T21:06:58.7565696Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:06:58.7566551Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:06:58.7567510Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    11ns, avg_dev =    31ns, dev_ratio = 2.73 }
2024-12-10T21:06:58.7568620Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  5683ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.7569707Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16357ns, avg_dev =    61ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.7570778Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -10662ns, avg_dev =    47ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.7572400Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17222  , avg_dev =    36  , dev_ratio = 0.00 }
2024-12-10T21:06:58.7628877Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:06:58.7629826Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-26461, 9218]
2024-12-10T21:06:58.7630618Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10369, delay_bias = 0
2024-12-10T21:06:58.7631844Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -51ns, avg_dev =     5ns, dev_ratio = 0.09 }
2024-12-10T21:06:58.7633010Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  5692ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.7634178Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16338ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.7635382Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -10697ns, avg_dev =    10ns, dev_ratio = 0.00 }
2024-12-10T21:06:58.7636480Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17326  , avg_dev =    14  , dev_ratio = 0.00 }
2024-12-10T21:06:58.8223646Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:2  act:1  art:1  | =:101  -:3    +:13612
2024-12-10T21:06:59.0022048Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:06:59.0022896Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:06:59.0023874Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    17ns, avg_dev =    11ns, dev_ratio = 0.65 }
2024-12-10T21:06:59.0024985Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  5652ns, avg_dev =     5ns, dev_ratio = 0.00 }
2024-12-10T21:06:59.0026594Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16463ns, avg_dev =     8ns, dev_ratio = 0.00 }
2024-12-10T21:06:59.0027707Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -10795ns, avg_dev =    12ns, dev_ratio = 0.00 }
2024-12-10T21:06:59.0028755Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17395  , avg_dev =    23  , dev_ratio = 0.00 }
2024-12-10T21:06:59.1130832Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:06:59.1131821Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-26475, 9105]
2024-12-10T21:06:59.1132596Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 16423, delay_bias = 0
2024-12-10T21:06:59.1133579Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =     9ns, avg_dev =     1ns, dev_ratio = 0.09 }
2024-12-10T21:06:59.1134695Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  5658ns, avg_dev =     3ns, dev_ratio = 0.00 }
2024-12-10T21:06:59.1135815Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16453ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:06:59.1136903Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -10786ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:06:59.1137951Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17356  , avg_dev =     8  , dev_ratio = 0.00 }
2024-12-10T21:07:02.2245141Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:1  act:1  art:2  | =:101  -:191299 +:222 
2024-12-10T21:07:02.3919805Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:07:02.3920653Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:07:02.3921630Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    -6ns, avg_dev =    11ns, dev_ratio = 1.69 }
2024-12-10T21:07:02.3923169Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 15570ns, avg_dev =     3ns, dev_ratio = 0.00 }
2024-12-10T21:07:02.3924258Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 15904ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:07:02.3925321Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =  -340ns, avg_dev =     8ns, dev_ratio = 0.02 }
2024-12-10T21:07:02.3926360Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =   485  , avg_dev =    17  , dev_ratio = 0.03 }
2024-12-10T21:07:03.4899007Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:07:03.4900050Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-19798, 19638]
2024-12-10T21:07:03.4900842Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 75802, delay_bias = 0
2024-12-10T21:07:03.4901830Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =     9ns, avg_dev =     1ns, dev_ratio = 0.10 }
2024-12-10T21:07:03.4903000Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 15700ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:07:03.4904099Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 15828ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:07:03.4905196Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =  -119ns, avg_dev =     7ns, dev_ratio = 0.06 }
2024-12-10T21:07:03.4906289Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =   149  , avg_dev =    11  , dev_ratio = 0.07 }
2024-12-10T21:07:23.3080898Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:3  act:1  art:0  | =:101  -:22   +:1028809
2024-12-10T21:07:23.4757888Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:07:23.4758941Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:07:23.4760498Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -10ns, avg_dev =    17ns, dev_ratio = 1.62 }
2024-12-10T21:07:23.4761822Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 15683ns, avg_dev =    76ns, dev_ratio = 0.00 }
2024-12-10T21:07:23.4763095Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 15947ns, avg_dev =    71ns, dev_ratio = 0.00 }
2024-12-10T21:07:23.4764323Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =  -275ns, avg_dev =    18ns, dev_ratio = 0.07 }
2024-12-10T21:07:23.4765493Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =   341  , avg_dev =    27  , dev_ratio = 0.08 }
2024-12-10T21:07:26.9727369Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:07:26.9728387Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-15945, 15847]
2024-12-10T21:07:26.9729228Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 218505, delay_bias = 0
2024-12-10T21:07:26.9730199Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -85ns, avg_dev =     8ns, dev_ratio = 0.09 }
2024-12-10T21:07:26.9731309Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 15814ns, avg_dev =     7ns, dev_ratio = 0.00 }
2024-12-10T21:07:26.9732397Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 15913ns, avg_dev =    10ns, dev_ratio = 0.00 }
2024-12-10T21:07:26.9733462Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =  -183ns, avg_dev =     9ns, dev_ratio = 0.05 }
2024-12-10T21:07:26.9734493Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =   184  , avg_dev =    10  , dev_ratio = 0.05 }
2024-12-10T21:08:22.5072327Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:654: TINFO: Exceeded execution loops, requesting exit
2024-12-10T21:08:22.5073965Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TFAIL: acs:0  act:1  art:3  | =:24   -:2999931 +:45  
2024-12-10T21:08:22.6734884Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:22.6735994Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:22.6737248Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    -1ns, avg_dev =    12ns, dev_ratio = 12.72 }
2024-12-10T21:08:22.6738483Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 15549ns, avg_dev =     3ns, dev_ratio = 0.00 }
2024-12-10T21:08:22.6739672Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =  5145ns, avg_dev =     5ns, dev_ratio = 0.00 }
2024-12-10T21:08:22.6740836Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 10403ns, avg_dev =    12ns, dev_ratio = 0.00 }
2024-12-10T21:08:22.6741972Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 16718  , avg_dev =    18  , dev_ratio = 0.00 }
2024-12-10T21:08:22.7014752Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:22.7015801Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-8206, 25409]
2024-12-10T21:08:22.7016616Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 11664, delay_bias = 0
2024-12-10T21:08:22.7017634Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -30ns, avg_dev =     3ns, dev_ratio = 0.09 }
2024-12-10T21:08:22.7018807Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 15804ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:08:22.7019949Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =  5104ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:08:22.7021030Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 10670ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:08:22.7022764Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17155  , avg_dev =     6  , dev_ratio = 0.00 }
2024-12-10T21:08:26.3461236Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:3  act:1  art:0  | =:101  -:185  +:224716
2024-12-10T21:08:26.5112701Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:26.5113552Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:26.5114527Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -26ns, avg_dev =    11ns, dev_ratio = 0.43 }
2024-12-10T21:08:26.5115654Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 15635ns, avg_dev =     8ns, dev_ratio = 0.00 }
2024-12-10T21:08:26.5116759Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =  5141ns, avg_dev =     5ns, dev_ratio = 0.00 }
2024-12-10T21:08:26.5117881Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 10468ns, avg_dev =    13ns, dev_ratio = 0.00 }
2024-12-10T21:08:26.5118928Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 16945  , avg_dev =    18  , dev_ratio = 0.00 }
2024-12-10T21:08:26.5190231Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:26.5191350Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-8316, 25473]
2024-12-10T21:08:26.5192150Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10452, delay_bias = 0
2024-12-10T21:08:26.5193106Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -80ns, avg_dev =     8ns, dev_ratio = 0.10 }
2024-12-10T21:08:26.5194227Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 15739ns, avg_dev =    15ns, dev_ratio = 0.00 }
2024-12-10T21:08:26.5195324Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =  5138ns, avg_dev =     3ns, dev_ratio = 0.00 }
2024-12-10T21:08:26.5208056Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 10521ns, avg_dev =    18ns, dev_ratio = 0.00 }
2024-12-10T21:08:26.5209149Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17028  , avg_dev =    18  , dev_ratio = 0.00 }
2024-12-10T21:08:28.1147217Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:0  act:1  art:3  | =:101  -:103988 +:46  
2024-12-10T21:08:28.2816811Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:28.2818022Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:28.2819041Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    10ns, avg_dev =     4ns, dev_ratio = 0.44 }
2024-12-10T21:08:28.2820198Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  5098ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:08:28.2821341Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 15784ns, avg_dev =    36ns, dev_ratio = 0.00 }
2024-12-10T21:08:28.2822420Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -10676ns, avg_dev =    35ns, dev_ratio = 0.00 }
2024-12-10T21:08:28.2823476Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17273  , avg_dev =    58  , dev_ratio = 0.00 }
2024-12-10T21:08:28.4904871Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:28.4905935Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-25526, 8220]
2024-12-10T21:08:28.4906700Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 22597, delay_bias = 0
2024-12-10T21:08:28.4907698Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =     9ns, avg_dev =     1ns, dev_ratio = 0.10 }
2024-12-10T21:08:28.4908903Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  5081ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:08:28.4910526Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 15778ns, avg_dev =    39ns, dev_ratio = 0.00 }
2024-12-10T21:08:28.4911966Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -10688ns, avg_dev =    39ns, dev_ratio = 0.00 }
2024-12-10T21:08:28.4913104Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17291  , avg_dev =    65  , dev_ratio = 0.00 }
2024-12-10T21:08:29.0628857Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:2  act:1  art:0  | =:101  -:37   +:55217
2024-12-10T21:08:29.2505421Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:29.2506273Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:29.2507254Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =     8ns, avg_dev =    21ns, dev_ratio = 2.74 }
2024-12-10T21:08:29.2508417Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  5096ns, avg_dev =     9ns, dev_ratio = 0.00 }
2024-12-10T21:08:29.2509494Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 15886ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:08:29.2510581Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -10782ns, avg_dev =    28ns, dev_ratio = 0.00 }
2024-12-10T21:08:29.2511831Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17363  , avg_dev =    39  , dev_ratio = 0.00 }
2024-12-10T21:08:35.5450554Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:35.5451556Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-25538, 8293]
2024-12-10T21:08:35.5452343Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 387147, delay_bias = 0
2024-12-10T21:08:35.5453886Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -79ns, avg_dev =     8ns, dev_ratio = 0.10 }
2024-12-10T21:08:35.5455014Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  5158ns, avg_dev =    55ns, dev_ratio = 0.01 }
2024-12-10T21:08:35.5456114Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 15882ns, avg_dev =    53ns, dev_ratio = 0.00 }
2024-12-10T21:08:35.5457208Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -10803ns, avg_dev =    10ns, dev_ratio = 0.00 }
2024-12-10T21:08:35.5458260Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 17372  , avg_dev =    11  , dev_ratio = 0.00 }
2024-12-10T21:08:38.8639382Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:0  act:1  art:2  | =:101  -:581144 +:122 
2024-12-10T21:08:39.0422780Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:39.0423674Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:39.0424648Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    -4ns, avg_dev =    22ns, dev_ratio = 4.90 }
2024-12-10T21:08:39.0425768Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16308ns, avg_dev =     9ns, dev_ratio = 0.00 }
2024-12-10T21:08:39.0426858Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =   608ns, avg_dev =     4ns, dev_ratio = 0.01 }
2024-12-10T21:08:39.0427924Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 15696ns, avg_dev =    24ns, dev_ratio = 0.00 }
2024-12-10T21:08:39.0428956Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 25310  , avg_dev =    37  , dev_ratio = 0.00 }
2024-12-10T21:08:39.0441503Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:39.0442467Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-969, 26060]
2024-12-10T21:08:39.0443778Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10100, delay_bias = 0
2024-12-10T21:08:39.0444751Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -34ns, avg_dev =     3ns, dev_ratio = 0.10 }
2024-12-10T21:08:39.0445854Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16158ns, avg_dev =     9ns, dev_ratio = 0.00 }
2024-12-10T21:08:39.0446930Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =   601ns, avg_dev =     0ns, dev_ratio = 0.00 }
2024-12-10T21:08:39.0447963Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 15523ns, avg_dev =     9ns, dev_ratio = 0.00 }
2024-12-10T21:08:39.0449002Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 25036  , avg_dev =    12  , dev_ratio = 0.00 }
2024-12-10T21:08:43.0075082Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:3  act:1  art:1  | =:101  -:141  +:240102
2024-12-10T21:08:43.0100324Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:1  act:1  art:3  | =:101  -:0    +:20  
2024-12-10T21:08:43.0143249Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:0  act:1  art:0  | =:101  -:134  +:0   
2024-12-10T21:08:43.1866626Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:43.1867455Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:43.1868411Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    -3ns, avg_dev =    18ns, dev_ratio = 6.23 }
2024-12-10T21:08:43.1869535Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =   620ns, avg_dev =     6ns, dev_ratio = 0.01 }
2024-12-10T21:08:43.1870721Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16449ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:08:43.1872504Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -15832ns, avg_dev =    17ns, dev_ratio = 0.00 }
2024-12-10T21:08:43.1873566Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 25529  , avg_dev =    20  , dev_ratio = 0.00 }
2024-12-10T21:08:43.3001210Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:43.3002180Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-26467, 1025]
2024-12-10T21:08:43.3002949Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 16572, delay_bias = 0
2024-12-10T21:08:43.3003909Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =  -115ns, avg_dev =    10ns, dev_ratio = 0.08 }
2024-12-10T21:08:43.3005036Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =   636ns, avg_dev =     5ns, dev_ratio = 0.01 }
2024-12-10T21:08:43.3006134Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16425ns, avg_dev =     7ns, dev_ratio = 0.00 }
2024-12-10T21:08:43.3007246Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -15904ns, avg_dev =    11ns, dev_ratio = 0.00 }
2024-12-10T21:08:43.3008302Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 25628  , avg_dev =    10  , dev_ratio = 0.00 }
2024-12-10T21:08:46.6079275Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:0  act:1  art:0  | =:101  -:208168 +:213 
2024-12-10T21:08:46.7877641Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:46.7878494Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:46.7879460Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    -3ns, avg_dev =     5ns, dev_ratio = 1.81 }
2024-12-10T21:08:46.7880570Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16473ns, avg_dev =    97ns, dev_ratio = 0.01 }
2024-12-10T21:08:46.7882169Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =    64ns, avg_dev =     4ns, dev_ratio = 0.06 }
2024-12-10T21:08:46.7883279Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 16406ns, avg_dev =    98ns, dev_ratio = 0.01 }
2024-12-10T21:08:46.7884317Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 26444  , avg_dev =    63  , dev_ratio = 0.00 }
2024-12-10T21:08:46.8612005Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:46.8612984Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-84, 26455]
2024-12-10T21:08:46.8613748Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 14245, delay_bias = 0
2024-12-10T21:08:46.8614707Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =   -80ns, avg_dev =     6ns, dev_ratio = 0.08 }
2024-12-10T21:08:46.8615825Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 19232ns, avg_dev =   616ns, dev_ratio = 0.03 }
2024-12-10T21:08:46.8616961Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =    61ns, avg_dev =     3ns, dev_ratio = 0.05 }
2024-12-10T21:08:46.8618024Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 19091ns, avg_dev =   613ns, dev_ratio = 0.03 }
2024-12-10T21:08:46.8619075Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 26261  , avg_dev =    15  , dev_ratio = 0.00 }
2024-12-10T21:08:54.0498784Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:3  act:1  art:1  | =:101  -:692  +:430966
2024-12-10T21:08:54.2483047Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:54.2484168Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:54.2485347Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    -5ns, avg_dev =    32ns, dev_ratio = 6.99 }
2024-12-10T21:08:54.2512305Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 21029ns, avg_dev =   160ns, dev_ratio = 0.01 }
2024-12-10T21:08:54.2513553Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =    59ns, avg_dev =     4ns, dev_ratio = 0.06 }
2024-12-10T21:08:54.2514611Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 20965ns, avg_dev =   178ns, dev_ratio = 0.01 }
2024-12-10T21:08:54.2515640Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 32868  , avg_dev =  2207  , dev_ratio = 0.07 }
2024-12-10T21:08:54.2532457Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:54.2533498Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-111, 26389]
2024-12-10T21:08:54.2534305Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10273, delay_bias = 0
2024-12-10T21:08:54.2535313Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    18ns, avg_dev =     2ns, dev_ratio = 0.09 }
2024-12-10T21:08:54.2536576Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 16363ns, avg_dev =     8ns, dev_ratio = 0.00 }
2024-12-10T21:08:54.2537736Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg =    69ns, avg_dev =     2ns, dev_ratio = 0.03 }
2024-12-10T21:08:54.2538909Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = 16312ns, avg_dev =     8ns, dev_ratio = 0.00 }
2024-12-10T21:08:54.2540021Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 26307  , avg_dev =    10  , dev_ratio = 0.00 }
2024-12-10T21:08:54.2839223Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:1  act:1  art:3  | =:101  -:1523 +:10366
2024-12-10T21:08:54.4621716Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:54.4622556Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:54.4623852Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    15ns, avg_dev =     5ns, dev_ratio = 0.30 }
2024-12-10T21:08:54.4624944Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =    78ns, avg_dev =     4ns, dev_ratio = 0.05 }
2024-12-10T21:08:54.4626012Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16393ns, avg_dev =    13ns, dev_ratio = 0.00 }
2024-12-10T21:08:54.4627081Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -16300ns, avg_dev =    14ns, dev_ratio = 0.00 }
2024-12-10T21:08:54.4628106Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 26311  , avg_dev =    18  , dev_ratio = 0.00 }
2024-12-10T21:08:54.4636736Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:54.4637733Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-26480, 123]
2024-12-10T21:08:54.4639863Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10083, delay_bias = 0
2024-12-10T21:08:54.4641040Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    18ns, avg_dev =     2ns, dev_ratio = 0.09 }
2024-12-10T21:08:54.4642297Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =    77ns, avg_dev =     4ns, dev_ratio = 0.05 }
2024-12-10T21:08:54.4643518Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16420ns, avg_dev =    93ns, dev_ratio = 0.01 }
2024-12-10T21:08:54.4644735Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -16325ns, avg_dev =    95ns, dev_ratio = 0.01 }
2024-12-10T21:08:54.4645927Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 26328  , avg_dev =    55  , dev_ratio = 0.00 }
2024-12-10T21:08:54.4965324Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:0  act:0  art:0  | =:101  -:10201 +:1671
2024-12-10T21:08:54.6696418Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:54.6697580Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 0
2024-12-10T21:08:54.6698704Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    21ns, avg_dev =     4ns, dev_ratio = 0.22 }
2024-12-10T21:08:54.6700002Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =    75ns, avg_dev =     5ns, dev_ratio = 0.06 }
2024-12-10T21:08:54.6701173Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16743ns, avg_dev =   572ns, dev_ratio = 0.03 }
2024-12-10T21:08:54.6702346Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -16648ns, avg_dev =   576ns, dev_ratio = 0.03 }
2024-12-10T21:08:54.6703485Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 19770  , avg_dev =  2120  , dev_ratio = 0.11 }
2024-12-10T21:08:54.6745311Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:54.6746307Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-26566, 123]
2024-12-10T21:08:54.6747099Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10266, delay_bias = 0
2024-12-10T21:08:54.6748133Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =    15ns, avg_dev =     1ns, dev_ratio = 0.09 }
2024-12-10T21:08:54.6749355Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =    77ns, avg_dev =     4ns, dev_ratio = 0.05 }
2024-12-10T21:08:54.6750534Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 16461ns, avg_dev =     9ns, dev_ratio = 0.00 }
2024-12-10T21:08:54.6751883Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -16369ns, avg_dev =     8ns, dev_ratio = 0.00 }
2024-12-10T21:08:54.6753006Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 26419  , avg_dev =     8  , dev_ratio = 0.00 }
2024-12-10T21:08:56.3414150Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync01.c:219: TPASS: acs:0  act:0  art:0  | =:101  -:104408 +:487 
2024-12-10T21:08:56.3415173Z 
2024-12-10T21:08:56.3415892Z Summary:
2024-12-10T21:08:56.3416191Z passed   23
2024-12-10T21:08:56.3417644Z failed   1
2024-12-10T21:08:56.3418167Z broken   0
2024-12-10T21:08:56.3418441Z skipped  0
2024-12-10T21:08:56.3418686Z warnings 0

runtest TINFO: * tst_fuzzy_sync02
2024-12-10T21:08:56.3422245Z runtest TINFO: * tst_fuzzy_sync02
2024-12-10T21:08:56.3443633Z /__w/ltp/ltp/lib/tst_test.c:1890: TINFO: LTP version: 20240930
2024-12-10T21:08:56.3444587Z /__w/ltp/ltp/lib/tst_test.c:1894: TINFO: Tested kernel: 6.5.0-1025-azure #26~22.04.1-Ubuntu SMP Thu Jul 11 22:33:04 UTC 2024 x86_64
2024-12-10T21:08:56.3445524Z /__w/ltp/ltp/lib/tst_test.c:1725: TINFO: Timeout per run is 0h 03m 00s
2024-12-10T21:08:56.3453315Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync02.c:164: TPASS: 0| =:101 
2024-12-10T21:08:56.5296598Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:08:56.5297489Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 1572
2024-12-10T21:08:56.5298528Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =  -596ns, avg_dev =     3ns, dev_ratio = 0.00 }
2024-12-10T21:08:56.5299708Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 18599ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:08:56.5300874Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 11937ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:08:56.5302022Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =  6066ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:08:56.5303135Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =  9751  , avg_dev =    14  , dev_ratio = 0.00 }
2024-12-10T21:08:56.5304575Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:08:56.5305526Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-17616, 31470]
2024-12-10T21:08:56.5306342Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10001, delay_bias = 1572
2024-12-10T21:08:56.5307324Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg =  -596ns, avg_dev =     3ns, dev_ratio = 0.00 }
2024-12-10T21:08:56.5308470Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg = 18599ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:08:56.5309616Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 11937ns, avg_dev =     4ns, dev_ratio = 0.00 }
2024-12-10T21:08:56.5310729Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg =  6066ns, avg_dev =     6ns, dev_ratio = 0.00 }
2024-12-10T21:08:56.5312017Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg =  9751  , avg_dev =    14  , dev_ratio = 0.00 }
2024-12-10T21:09:00.9201820Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync02.c:164: TPASS: 1| =:101 
2024-12-10T21:09:01.0848787Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:484: TINFO: Minimum sampling period ended
2024-12-10T21:09:01.0849660Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10000, delay_bias = 9931
2024-12-10T21:09:01.0850640Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg = -3787ns, avg_dev =   134ns, dev_ratio = 0.04 }
2024-12-10T21:09:01.0851859Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  6983ns, avg_dev =   645ns, dev_ratio = 0.09 }
2024-12-10T21:09:01.0852990Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 13154ns, avg_dev =   190ns, dev_ratio = 0.01 }
2024-12-10T21:09:01.0854078Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -9959ns, avg_dev =   347ns, dev_ratio = 0.03 }
2024-12-10T21:09:01.0855485Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 16071  , avg_dev =   555  , dev_ratio = 0.03 }
2024-12-10T21:09:01.0856560Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:494: TINFO: Reached deviation ratios < 0.10, introducing randomness
2024-12-10T21:09:01.0857498Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:497: TINFO: Delay range is [-11296, 21198]
2024-12-10T21:09:01.0858300Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:307: TINFO: loop = 10001, delay_bias = 9931
2024-12-10T21:09:01.0859260Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg = -3787ns, avg_dev =   134ns, dev_ratio = 0.04 }
2024-12-10T21:09:01.0860356Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg =  6983ns, avg_dev =   645ns, dev_ratio = 0.09 }
2024-12-10T21:09:01.0861433Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg = 13154ns, avg_dev =   190ns, dev_ratio = 0.01 }
2024-12-10T21:09:01.0862510Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg = -9959ns, avg_dev =   347ns, dev_ratio = 0.03 }
2024-12-10T21:09:01.0863584Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg = 16071  , avg_dev =   555  , dev_ratio = 0.03 }
2024-12-10T21:09:52.6826456Z /__w/ltp/ltp/include/tst_fuzzy_sync.h:654: TINFO: Exceeded execution loops, requesting exit
2024-12-10T21:09:52.6827841Z /__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync02.c:164: TFAIL: 2| =:15  
2024-12-10T21:09:52.6828306Z 
2024-12-10T21:09:52.6828417Z Summary:
2024-12-10T21:09:52.6828677Z passed   2
2024-12-10T21:09:52.6828910Z failed   1
2024-12-10T21:09:52.6829171Z broken   0
2024-12-10T21:09:52.6829429Z skipped  0
2024-12-10T21:09:52.6830161Z warnings 0

Petr Vorel (7):
  ci: Run docker as privileged to enable loop device
  ci: Mount bind host /boot
  testcases/lib/run_tests.sh: Check expected results
  Makefile: Add target to run shell loader
  build.sh: Allow to run shell loader tests
  ci: Add shell loader tests
  shell API: Add test for TST_DEVICE_SIZE

 .github/workflows/ci-docker-build.yml     |   7 +-
 Makefile                                  |   7 ++
 build.sh                                  |  19 ++--
 lib/newlib_tests/runtest.sh               |  52 ++++++++--
 lib/newlib_tests/shell/tst_device_size.sh |  17 ++++
 testcases/lib/run_tests.sh                | 118 ++++++++++++++++++----
 6 files changed, 181 insertions(+), 39 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_device_size.sh

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
