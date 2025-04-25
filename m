Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EBEC369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 15:31:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9463CB9CE
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 17:31:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BB7C3CB83F
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:30:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 325E7600542
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:30:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0EDCF2116F;
 Fri, 25 Apr 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D55F01388F;
 Fri, 25 Apr 2025 15:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6P6zMqmqC2gSdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Apr 2025 15:30:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Apr 2025 17:30:45 +0200
Message-ID: <20250425153046.63853-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425153046.63853-1-pvorel@suse.cz>
References: <20250425153046.63853-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 0EDCF2116F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] ci: Skip openSUSE builds on broken repositories
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

opensuse/leap:latest container repos are sometimes broken:

zypper --non-interactive install --force-resolution --no-recommends autoconf ...
...
(86/88) Installing: kernel-default-devel-6.4.0-150600.23.47.2.x86_64 [..............done]
(87/88) Installing: libopenssl-devel-3.1.4-150600.2.1.noarch [..done]
(88/88) Installing: clang-17-bp156.1.1.x86_64 [..done]
Error: Process completed with exit code 106.

Previous commit added an attempt to recover from it (which may help) but
this way we get permanent failure in Patchwork (Patchwork API does not
update results, it just adds a new result) it's better to not keep this
as a failure.

Because patchwork does not have state "skip" use state "pending" (quite
correct - patch has not been yet tested).

TODO: automatically restart jobs with "pending" state.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci-docker-build.yml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index b476d993c5..09eb8bb6d4 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -131,7 +131,15 @@ jobs:
         INSTALL=${{ matrix.container }}
         INSTALL="${INSTALL%%:*}"
         INSTALL="${INSTALL%%/*}"
-        ACTION="$VARIANT" ./ci/$INSTALL.sh
+        ACTION="$VARIANT" ./ci/$INSTALL.sh || if [ $? -eq 106 ]; then
+          echo "::warning ::Skipping job due broken repositories"
+          ./ci/tools/patchwork.sh check \
+            "${{ inputs.SERIES_ID }}" \
+            "${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}" \
+            "${{ matrix.container }}" \
+            "pending" "Skipping job due broken repositories"
+          exit 0
+        fi
         if [ "$VARIANT" ]; then ./ci/$INSTALL.$VARIANT.sh; fi
 
     - name: Compiler version
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
