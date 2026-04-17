Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F9F43682
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 09:00:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26A9F3E4BA2
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 11:00:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F6D43CCB72
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:59:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3CDA41000967
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:59:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4AAB35BCE9;
 Fri, 17 Apr 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776416387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bh4lBRzK5eDNYzzDNdh1qr3b9w7dHM3vO9oZHY+619Y=;
 b=x6rv+73UTwSC0cDXtxB2OkIJisVE8hTA6MVWkMmpbdapCezUZmImOPo5xsLnVb4KfSC+ju
 FBkixQHJPQuVoRDfT9e4z6co8czlnlQO3tZtr/YoUOk6GZm0z5smVrCWvvu7K8IysZZAgA
 L0MMORH8vlnRdAshaSgmMbvzXJPtZPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776416387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bh4lBRzK5eDNYzzDNdh1qr3b9w7dHM3vO9oZHY+619Y=;
 b=NJID+X6Ce9TLI6RfmxD6wHCYWOrT4G8qg7m1DklhmZdgKVV/l7auF7lRrYvTSGGe1XIx3p
 gAlXqwi6XRj/okBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776416383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bh4lBRzK5eDNYzzDNdh1qr3b9w7dHM3vO9oZHY+619Y=;
 b=YWjnPCKKssySPVfyzBq8q2B0CYKGeZBglZxrF2T5vCu2CyzMZOj3vz/ddSa9NYRK6sANKh
 WEElXt5DOwd2MSmoj2VAiNIQtBnDGkHa5EpkxDckv4d4cdU1E9yyoS8bsHwHoCjNEf52eE
 yPeN95aCKnbkhrgFwUQ6nA4bJFC9UQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776416383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bh4lBRzK5eDNYzzDNdh1qr3b9w7dHM3vO9oZHY+619Y=;
 b=DBSSKmrbDZQp7GQlkU/U1C3QdgVEO0FNKLRQstLV+mGDRckoQVlHRDOh+PznVJKmTYzX4/
 /xNwzud7ywWNfBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FAAC593AE;
 Fri, 17 Apr 2026 08:59:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Mb2pBX/24WkWXQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 08:59:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Apr 2026 10:59:31 +0200
Message-ID: <20260417085931.331281-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.cz,redhat.com,suse.com,gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,ubuntu.com:url,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] ci: doc: Replace Ubuntu bionic with noble
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

Replace Ubuntu 18.04 LTS bionic with  Ubuntu 24.04 LTS noble (the latest
Ubuntu LTS).

Ubuntu 18.04 LTS bionic EOL 3 years ago (2023-04). Repositories were
publicly available until now, remove it to fix CI.

Exact error is missing Packages file

    W: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/bionic-backports/InRelease  Connection failed [IP: 91.189.91.82 80]
    E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/bionic/universe/binary-amd64/Packages  Connection timed out [IP: 91.189.92.23 80]

which causes gcc not being installed.

Although repository has Packages.gz and Packages.xz (therefore it
should somehow work or it might be GitHub Actions issue) we don't need
to keep bionic (we have older distro openSUSE Leap 42), which we still
use for testing SLE1-SP2 build).

Reported-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <wangli.ahau@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Add Ubuntu 24.04 LTS noble

Link to v1:
https://lore.kernel.org/ltp/20260416183500.316638-1-pvorel@suse.cz/

@Li: I dared to keep your RBT in case you're not online before merge.

CI (my fork, faster than our CI)
https://github.com/pevik/ltp/actions/runs/24556720790

 .github/workflows/ci-docker-build.yml | 2 +-
 doc/users/supported_systems.rst       | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index 16d99f097a..405a7f0690 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -110,7 +110,7 @@ jobs:
               CC: gcc
               TREE: out
 
-          - container: "ubuntu:bionic"
+          - container: "ubuntu:noble"
             env:
               CC: gcc
 
diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
index dabb5883ad..b241d05739 100644
--- a/doc/users/supported_systems.rst
+++ b/doc/users/supported_systems.rst
@@ -34,12 +34,6 @@ Oldest build tested distributions
       - 4.8.5
       - \-
 
-    * - Ubuntu 18.04 LTS bionic
-      - 4.15
-      - 2.27
-      - 7.3.0
-      - \-
-
     * - Debian 11 (bullseye)
       - 5.10
       - 2.31
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
