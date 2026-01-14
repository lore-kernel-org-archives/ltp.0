Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DEAD37E33
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 14:23:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 330953C9BE5
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 15:23:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5605F3C7624
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 15:23:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8193C1000998
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 15:23:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E29825BEAF;
 Wed, 14 Jan 2026 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768400609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5hX81kc3AjM8nWqMqzGyq7+2+7/yhZh+X9D71db4ygQ=;
 b=aMFvg791ONiyhEUVnNFHQ6NbB2Dk0m1fEaHctA54un8+2Y7t5Y6hpzsR9JDF8sWxJ4Yahw
 laWQHvEzL07UhWZHOYCwz7Vj0hjz0tyKvOWsbNPxKaWlHGPjoelG2tsTsETFmMMFwQJA35
 QqrQLvNzvqadfp3g+aG7UwTKlsrlnNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768400609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5hX81kc3AjM8nWqMqzGyq7+2+7/yhZh+X9D71db4ygQ=;
 b=sCfy5Jw6h/xOWdIaL+hNWT28Y9m+Zl98k4tKYkE/wcEDbWPy/+VbkvrSk12+IQcRWp5eV2
 hTE14WKfb9C8PoCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768400608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5hX81kc3AjM8nWqMqzGyq7+2+7/yhZh+X9D71db4ygQ=;
 b=18RKGhA6hbyoSZRK2SlTt57dKxvSmbrtx++oSp/qJsxGkksohooeayjhZX+NlUxjUE0qbe
 nAclHDBdvnlwSQ/2oUEayQzIszSEtGJXg4YUZkAb1wyB2kC558ywIjlq8UeETNv+Pz4o22
 M2kMb5JJJ9qaEOc+kxPn9AOHPWR8cvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768400608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5hX81kc3AjM8nWqMqzGyq7+2+7/yhZh+X9D71db4ygQ=;
 b=GzNxhhyYdkC3v0wBppikr5AGe4OLfz8VLZG+yKCIXe6vE5FVhlRODVRPmSi3XJ9V5+WnXr
 ZABNKa1Sl6OqJrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3D483EA63;
 Wed, 14 Jan 2026 14:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LKTULeCmZ2lERwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 14 Jan 2026 14:23:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 14 Jan 2026 15:23:25 +0100
MIME-Version: 1.0
Message-Id: <20260114-fix_ci_doc-v1-1-5203d4c21546@suse.com>
X-B4-Tracking: v=1; b=H4sIANymZ2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0MT3bTMivjkzPiU/GRdI1NDc0tLQ+PkRMsUJaCGgqJUoCzYsOjY2lo
 AIZb/p1wAAAA=
X-Change-ID: 20260114-fix_ci_doc-25179913ca9d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768400608; l=1154;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=dDlGoL/hAWfs5P4eEFyhaUczv2w4gmkvYnM2IQf2V1A=;
 b=e9BCjSZsDN59JbE90MfpdN7Z8Gr2Ylu2Xy7OePY6oyt+CMJ9dz/iK6nDNkdk+Wwz5Zi8Tz1Nz
 MRQ74sg6M+yDpP8hG6/O0KLnp7tn2YkN8E+/9LOKSNSmg/4TUaYtEuS
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ci: fix documentation build for new patches
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

curl command was not alligned with the ci-docker-build.yml workflow, so
it was failing due to HTTP request error.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .github/workflows/ci-sphinx-doc.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
index b225d32a6ba448fef2fb103cf7f891557be27a05..3dccf8b86a40c142c82021dac8b6ee7c1a273aea 100644
--- a/.github/workflows/ci-sphinx-doc.yml
+++ b/.github/workflows/ci-sphinx-doc.yml
@@ -46,7 +46,7 @@ jobs:
           git config --global --add safe.directory "$GITHUB_WORKSPACE"
 
           git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"
-          curl -k "${{ inputs.SERIES_MBOX }}" | git am
+          curl -k -L --retry 3 --max-redirs 1 --location-trusted "${{ inputs.SERIES_MBOX }}" | git am
 
           ./ci/tools/patchwork.sh state "${{ inputs.SERIES_ID }}" "needs-review-ack"
 

---
base-commit: 012f63081ad9cb2e5d5de4005e5cfed29f5c0edf
change-id: 20260114-fix_ci_doc-25179913ca9d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
