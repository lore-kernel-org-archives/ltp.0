Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0550CDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 10:48:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1073F3CD443
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 12:48:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 632393C8B68
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 12:48:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A1D6D1BBEA42
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 12:48:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7AA8C1F74B
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697107717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUABDZ1aHBtOOHObRTtJfZbcwj9ZuwjBAU4PDWKdphA=;
 b=jfpXxmhqshowanmzZOSVA2Rc10NVorWiZhbLrBVnRpPPs+sCQQyduYfqtR25zCMFYQs7Gc
 zdguqpVX81A5VLq+wdPpEdXrQ8dta+FC49OVUmnmSQa+7kkaVEYFccs8TLTHg58YwuvwQW
 inB3X/bTovVT1WHYDdAPv8Ly7VDRLxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697107717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUABDZ1aHBtOOHObRTtJfZbcwj9ZuwjBAU4PDWKdphA=;
 b=bm1KwnwYEKLGrSluiQqCxht9UBoV8BnxqwM6mYCxkWwkR6ppe3Tyr6T8qGNU2XipMICVlw
 docDoD1jmZfbAcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69694139F9
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 10:48:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qfDPGAXPJ2UWGwAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 10:48:37 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu, 12 Oct 2023 12:48:37 +0200
Message-ID: <13368109.uLZWGnKmhe@linux-9lzf>
In-Reply-To: <ZSe6MNMQ6L5yJdV4@yuki>
References: <20231005134504.3828-1-mkittler@suse.de> <ZSe6MNMQ6L5yJdV4@yuki>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]; CTE_CASE(0.50)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix memcontrol tests under Tumbleweed
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

Am Donnerstag, 12. Oktober 2023, 11:19:44 CEST schrieb Cyril Hrubis:
> 
> Shouldn't we just remove all of dev_min_size records?
> 
> We already have DEV_SIZE_MB set to 300 in lib/tst_device.c so with no
> limits we will use the default 300Mb.

I thought so, too. However, when running this particular test without this 
minimum specified explicitly, it runs into the following error:

```
tst_test.c:1650: TINFO: === Testing on tmpfs ===
tst_test.c:1105: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1086: TINFO: Limiting tmpfs size to 32MB
tst_test.c:1119: TINFO: Mounting ltp-tmpfs to /tmp/LTP_memkrqX1e/mntdir 
fstyp=tmpfs flags=0
memcontrol02.c:93: TPASS: Expect: (current=0) == 0
memcontrol02.c:99: TINFO: Added proc to memcg: memory.current=262144
memcontrol02.c:46: TPASS: Expect: (memory.current=52690944) >= (size=52428800)
memcontrol02.c:51: TPASS: Expect: (memory.stat.anon=52449280) > 0
memcontrol02.c:52: TPASS: Expect: (size=52428800) ~= 
(memory.stat.anon=52449280)
memcontrol02.c:54: TPASS: Expect: (memory.current=52690944) ~= 
(memory.stat.anon=52449280)
memcontrol02.c:93: TPASS: Expect: (current=0) == 0
memcontrol02.c:99: TINFO: Added proc to memcg: memory.current=262144
memcontrol02.c:69: TINFO: Created temp file: memory.current=262144
memcontrol_common.h:34: TBROK: write(9,0x7ffda0f93710,8192) failed: ENOSPC (28)
```

Judging by the 3rd TINFO message the size for tmpfs filesystems is 
intentionally limited to 32MB which presumably also makes generally sense. 
However, here we *really* need more space. This is most likely also the reason 
why this test had `.dev_min_size = 256,` before in the first place. The other 
tests don't need it, though (and I guess the `.dev_min_size = 256,` had just 
been copied over from the first test).




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
