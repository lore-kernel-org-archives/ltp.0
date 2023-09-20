Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CF6CE79AD
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 09:53:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9E0E3CDEB5
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 11:53:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD89A3CDEB8
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:53:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C978F1A02361
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:53:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2BA5A1FE96;
 Wed, 20 Sep 2023 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695203602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0KyA/j52QNnt2UOvkM9p5AbrL0OhvAS4eKBSepPhzM=;
 b=i50kMEVArCku/fy3jU+cH8CDiB0V4A/7SL7fYonrOABOeg0ji23S7/4zBXTry/1GRuaLxP
 xchuminG/QvHAUqqZsqjml4+xrzV5RZ2iJsOf4ZKvsGvpsspmRfsdh4z041v//EZuImPU+
 TdY+dP+F8X1bBEaG5kRaoB12JdQzc0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695203602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0KyA/j52QNnt2UOvkM9p5AbrL0OhvAS4eKBSepPhzM=;
 b=hcvxTrBcLx2TJikCRPYvdCwYB5KD8pp8sganPgsqtou+TrCbynAy0ZAU7tz1UoFC3GI8cc
 It56Nc+wneisXzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E49131333E;
 Wed, 20 Sep 2023 09:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QFS8NhHBCmVpBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 20 Sep 2023 09:53:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Sep 2023 11:53:14 +0200
Message-Id: <20230920095318.340582-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230920095318.340582-1-pvorel@suse.cz>
References: <20230920095318.340582-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] tools: Add a script for tagging the release
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A helper for new releases.

Functions will be reused in another script (next commit).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/lib.sh         | 31 +++++++++++++++++
 tools/tag-release.sh | 80 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
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
index 000000000..18bef4b17
--- /dev/null
+++ b/tools/tag-release.sh
@@ -0,0 +1,80 @@
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
+relnotes="/tmp/$(basename $upstream_git)-release-$tag"
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
+title "Creating skeleton file for release notes"
+cat > $relnotes <<EOF
+TODO: Add changelog
+
+## credit
+Many thanks to the people contributing to this release:
+\`\`\`
+    $ git shortlog -sen $old_tag..
+EOF
+git shortlog -s -n $old_tag.. >> $relnotes
+
+cat >> $relnotes <<EOF
+\`\`\`
+
+Also thanks to patch reviewers:
+
+$ git log $old_tag.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r
+\`\`\`
+EOF
+
+git log $old_tag.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r >> $relnotes
+
+cat >> $relnotes <<EOF
+\`\`\`
+
+and testers:
+$ git log $old_tag.. | grep -Ei 'tested-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r
+\`\`\`
+EOF
+git log $old_tag.. | grep -Ei 'tested-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r >> $relnotes
+echo '```'  >> $relnotes
+
+echo "Skeleton file for release notes: $relnotes"
+
+title "git push"
+ask "Pushing changes to upstream git"
+rod git push origin master:master
+git push origin $tag
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
