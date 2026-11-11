Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C9606A31C
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=EzRlowWS;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NOD31q4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794384754; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=46/Oma4wDqmn2YR21vkqIXDU1R49sr2bAHTnWDM3nxc=;
 b=EzRlowWSC1IUfozKr+J1KUqptxP+J5e1HDDq2t7mnbb+nfM5dqCiR1cXyU6bO5vXmKxFy
 SmHl2YA/VziT3Ny5xSouBSxdnp7JXjS5KnFRkW8BeJnaDdORHhrobMYiUwOXSzG8/WoRmnC
 XkstO7wzXplXrgTBmiF4kUrATUT1K4o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C3953CE356
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 09:12:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 774483C99C9
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 09:12:14 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 322CE600A5B
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 09:11:58 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so28923725e9.3
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 00:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794384712; x=1794989512; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3GWIWeeH11VP5k7EhN4IK7wRrg3lCW1JlSnXHhr7ywo=;
 b=NOD31q4E6XWrKqXEM5IZXajtGy81O5H8xRd9/vtadpTNah7c9QepVzkzf5heuD4n4B
 6dQz7HmHuEL4G0g8xaiDocBOY7M/CKRUt0vkTY65MYnPe6iPHkAQp4xMjr7KPeOlFSzF
 4rnZbLM4BCYmtjDkAyVqnj0PSvYOenBnoeDAW6lm1d582hHAvp1TsqLjm/M4FjFsQUMH
 b9GW4Cw3yx2QZdLm3Ur8O8It9VL3WWgZvlyANQKrXl+hXoWKSosoEJY4qquPrYYlFleM
 oCIkprFtOk0h+mOqUUznxiGmL+ivg5JesUIBpGyIBaYpPXxmIuIeZigufkeAQmXvZurz
 tc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794384712; x=1794989512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3GWIWeeH11VP5k7EhN4IK7wRrg3lCW1JlSnXHhr7ywo=;
 b=nI59yK1wq7h+olLWlIQX1UFZ2YTCoRK+mn4rmPGC/PZy9QHFake6+DsUbVO6efLb3a
 yfkw0i/wQ4lOMcAUDg1KAUNjvSEMmVsh5LP6smhoJQMQJ/IDWiNwA5UBjPIXRQN1fzZW
 65K0UvB9MOgrlDmYTEzX6BGAuKs53eXWUWyAqiY1kGS48cOLmVO6KDjcYmmmUG/IvWIC
 9soCAQ15d5UjoACf3bo/5KAK5B+5i4Q27SwnF8ATOdjkbFGYX4vdyh3iGbz8KfC5vQV7
 tJBCWcnfVqh+568+mYwxR6bbcyLseE5ejpQ51NL5gYG0+vlqJcWxiCQX10wYoAKyHGwM
 vWHA==
X-Gm-Message-State: APuU4Z93wQkCg4BzU1KaEVNAqGkAvWmUugMyz7RfT62LA4pNoNzd6Tp/
 yqXgbkUYp4sNDns34LaInVD6aqU0/nxrJB7shaY+8cHFKznnDz9Y5LOD6Za2wLPECOj3vZWDeJy
 DQ2s0/orc
X-Gm-Gg: AYBFou0RL/SJNAEO5ozeyspMj8DPD7Nh0Vj+2gBkAL+XhefUwoAcyI2741rt4lwe1fC
 lRLYa06oyEpcflYGjfVWrIyOq6+XtRx1PfPCa63WEdZ9mW9vhO2yQY0ClrqHDfAomEmKxbXjk9G
 W1FehxB4JMNlBCmIO1rN7hKWPW7UfxRFGyrmbO0LHfEXosoLebdUSBZoFTVBjD2RnoQDXCQ1848
 YuopvMcNnabJ+KsSahLwiZ9ait1hl0f7dSRdjeMIzVeYuXQ1diSxA8d6IbqnLu/+JGowUPdk42q
 3yvxlwit548xxBQJsukf9J+HOFFn9pmFfGeQnfpamQ+rS1d5BhT9ntXNV9cnalfu3ueO/Q7kt9j
 Ms8N+kfQYnAT/luJozjwWflSkSRbpO8jDC1wwKJ2J2WwIekYi6qs23hUx29u60G9RAyEvugISg1
 vRayifztxsD9FTZ0VIxut2p7lhKcPPEaQbMnY45riaE43yVfZJdtKjGwcxYEn0p/PguZwmy9wsc
 KTY4x7p6MWv6rHWS4/6I7NzHe2sA4sk0i1xHl0x2Wr3Jm0S7/YlUCWEl7FrOxN7zS8PNWMCeqMa
 2u28gWlB4Rdiil3EkzHxQHAZ2vNXxP2e51pf2D9vHLnyuGnvQY9XudRM6UlFA7AUDQnXUyNusw=
 =
X-Received: by 2002:a05:600c:3151:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4ba09344708mr28419065e9.4.1794384712431; 
 Wed, 11 Nov 2026 00:11:52 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4ba01feee1asm162814295e9.12.2026.11.11.00.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:11:52 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 11 Nov 2026 08:09:10 +0000
Message-ID: <20261111081150.15101-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Subject: [LTP] [PATCH v1] swapon04: Settle udev after mkswap to prevent
 tmpfs hole filling
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When mkswap formats and closes the loop device, systemd-udevd
asynchronously runs blkid probing on the device. On kernels prior to
5.18, tmpfs shmem_file_read_iter() treats non-iovec read iterators
(!iter_is_iovec(to)) as stacking filesystem reads, allocating real
zero-filled pages into holes (this behavior get fixed by commit
56a8c8eb1eaf ("tmpfs: do not allocate pages on read")).

When a udev worker reads the loop device after swapon-time discard
has punched holes in the tmpfs backing file, the probing reads
re-allocate up to 84 zero-filled pages (672 blocks), causing
blocks_after to exceed max_header_blocks and failing the test
intermittently on tmpfs (e.g. observed on SLE 15-SP4 aarch64):

  swapon04.c:167: TFAIL: blocks_after (672) > max_header_blocks (16)

Tracing block:block_rq_issue confirms that udev-worker reads the loop
device after discard has punched the holes:

  # mkswap writes swap header
  mkswap-703     [000] ..... 2100.340705: block_rq_issue: 7,1 WS 4096 () 0 + 8 [mkswap]
  # sys_swapon reads swap header
  swapon04-701   [000] ..... 2100.345665: block_rq_issue: 7,1 R 4096 () 0 + 8 [swapon04]
  # swapon-time discard punches holes across sectors 8..32767
  kworker/0:1H-31[000] ..... 2100.345715: block_rq_issue: 7,1 DS 16773120 () 8 + 32760 [kworker/0:1H]
  # udev-worker probes loop device 5.5ms after discard, re-allocating tmpfs pages
  (udev-worker)-655 [001] .. 2100.351255: block_rq_issue: 7,1 RA 4096 () 32640 + 8 [(udev-worker)]
  (udev-worker)-655 [000] .. 2100.351302: block_rq_issue: 7,1 RA 4096 () 32752 + 8 [(udev-worker)]
  (udev-worker)-655 [000] .. 2100.352286: block_rq_issue: 7,1 RA 126976 () 264 + 248 [(udev-worker)]

Wait for udev to settle after mkswap so that probing completes before
swapon discards the area.

Fixes: aabccf0a0117 ("swapon04: Add test for discard flags")
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/swapon/swapon04.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/swapon/swapon04.c b/testcases/kernel/syscalls/swapon/swapon04.c
index de95849e3..141456442 100644
--- a/testcases/kernel/syscalls/swapon/swapon04.c
+++ b/testcases/kernel/syscalls/swapon/swapon04.c
@@ -138,6 +138,7 @@ static void verify_swapon(unsigned int n)
 	struct stat st;
 	blkcnt_t blocks_before, blocks_after;
 	const char *const mkswap_argv[] = {"mkswap", loop_dev, NULL};
+	const char *const udevadm_argv[] = {"udevadm", "settle", NULL};
 
 	tst_res(TINFO, "Testing swapon(%s, %s)", loop_dev, tc->desc);
 
@@ -148,6 +149,7 @@ static void verify_swapon(unsigned int n)
 	SAFE_CLOSE(fd);
 
 	tst_cmd(mkswap_argv, "/dev/null", "/dev/null", 0);
+	tst_cmd(udevadm_argv, "/dev/null", "/dev/null", TST_CMD_PASS_RETVAL);
 
 	SAFE_STAT(BACKING_FILE, &st);
 	blocks_before = st.st_blocks;
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
