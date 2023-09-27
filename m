Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FB6E82CD2
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 20:22:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F09F33CE188
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 22:22:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73AE73CBA91
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C2DF31A00EAC
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16FB21F37E;
 Wed, 27 Sep 2023 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695846085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGPWp2luWhpj9l06v4FAZJwSZaqIT7TiNr2a5BkuQ2E=;
 b=pXnnc9sc391eZZVlTetT7MFT/HS5k7mvEXpxwXBE8g9JqEZtDS0rVHuQwNXt6gcnMZG9Iz
 RAsOfnhD5OZ1dwHlvVXu/KZD+auDdbpACe8dulh6ecFSzU3D1RNPPxIDhieo4cf08Jvob4
 l1WwfXBODR1BZ9sOuKHG05BJhumIQp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695846085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGPWp2luWhpj9l06v4FAZJwSZaqIT7TiNr2a5BkuQ2E=;
 b=BUfX4O1in6d6jZh0gGKly8dC/QAD0fXd0gOVY6LIG98KEbxy58mbvyE8czJ33sI7fvUj5p
 KqEI0hJljYTrFpDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC90C13479;
 Wed, 27 Sep 2023 20:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qLg6KMSOFGWGewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 20:21:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Sep 2023 22:21:16 +0200
Message-Id: <20230927202121.300325-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927202121.300325-1-pvorel@suse.cz>
References: <20230927202121.300325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/6] tools: Add a script for tagging the release
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

A helper for new releases.

Functions will be reused in another script (next commit).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/lib.sh         | 31 ++++++++++++++++++++++++++++++
 tools/tag-release.sh | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100755 tools/lib.sh
 create mode 100755 tools/tag-release.sh

diff --git a/tools/lib.sh b/tools/lib.sh
new file mode 100755
index 000000000..c96433d28
--- /dev/null
+++ b/tools/lib.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
+
+ask()
+{
+	local msg="$1"
+	local answer
+
+	printf "\n$msg. Proceed? [N/y]: "
+	read answer
+	case "$answer" in
+		[Yy]*) : ;;
+		*) exit 2
+	esac
+}
+
+quit()
+{
+	printf "\n$@\n" >&2
+	exit 1
+}
+
+rod()
+{
+	eval "$@" || quit "$@ failed"
+}
+
+title()
+{
+	echo "===== $1 ====="
+}
diff --git a/tools/tag-release.sh b/tools/tag-release.sh
new file mode 100755
index 000000000..2967c7b4d
--- /dev/null
+++ b/tools/tag-release.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
+# Tag LTP release.
+# https://github.com/linux-test-project/ltp/wiki/LTP-Release-Procedure
+set -e
+
+upstream_git="linux-test-project/ltp"
+tag="$(date +%Y%m%d)"
+old_tag="$(git describe --abbrev=0)"
+tag_msg="LTP $tag"
+
+. $(dirname "$0")/lib.sh
+
+cd $(dirname "$0")/..
+
+if ! git ls-remote --get-url origin | grep -q $upstream_git; then
+	quit "Not an upstream project"
+fi
+
+if ! git --no-pager diff --exit-code; then
+	quit "Please commit your changes before making new release"
+fi
+
+if git show $tag 2> /dev/null; then
+	quit "Tag '$tag' already exists"
+fi
+
+if grep -q "$tag" VERSION; then
+	quit "Tag '$tag' already in VERSION file"
+fi
+
+title "git tag"
+echo "new tag: '$tag', previous tag: '$old_tag'"
+echo "$tag" > VERSION
+git add VERSION
+rod git commit -S --signoff --message \"$tag_msg\" VERSION
+rod git tag --sign --annotate $tag --message \"$tag_msg\"
+git --no-pager show $tag --show-signature
+
+ask "Please check tag and signature"
+
+title "git push"
+ask "Pushing changes to upstream git"
+rod git push origin master:master
+git push origin $tag
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
