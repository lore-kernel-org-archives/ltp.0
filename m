Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4654C4332F
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 14:10:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77C8A3CBFF1
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 15:10:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FE913CBFA6
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 15:10:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7B5FF1A00CBD
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 15:10:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED34F337AE;
 Fri,  9 Dec 2022 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670595012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lb6vrLQBJMNx5rnsXRn+a68LpAd9OXcH4J+VMxXOtl8=;
 b=gzI8Kkkq8mrn0v+a8ltgrBvHE3G4zz410fceDAWC9qhF63hglW47AbEf8z8qejlEVmMZRw
 n4ekPwtvBrGB5ZmLC4RuEBGIYWVNvb7dRTUsBh2B/t7uBjSO/bKMMoXTIXxsTFT3DssIoX
 pNJwLGl3I14CVJKP0CRSJjJxHPn3m0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670595012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lb6vrLQBJMNx5rnsXRn+a68LpAd9OXcH4J+VMxXOtl8=;
 b=PAkhuMjLoXYHY0XOxzgGF8g4Fy5mj69csZ7UPvjLU3+DlYUq+iiZPMVzapW2ORplJYHqnR
 kZBqmsbCtduS3dBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9443138E0;
 Fri,  9 Dec 2022 14:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hDL/K8RBk2PmBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Dec 2022 14:10:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 Dec 2022 15:10:02 +0100
Message-Id: <20221209141002.15551-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] ci: Add hook to mirror docparse to homepage
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
Cc: Aleks L <aleksandrosansan@gmail.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

GitHub Actions git push hook generates metadata HTML and push it
to LTP homepage.

Hook pushes only if there are actual changes in generated doc.

NOTE: this change requires to add:

1) Personal Access Token (PAT) to any developer which has write access
to homepage git repository [3]. In Developer settings -> Personal access
tokens -> Tokens (classic) [4]), where set:
Note: GH_PERSONAL_ACCESS_TOKEN
Select scopes: public_repo (minimal permission)
Expiration: either never or regularly renew.

2) Allow PAT in LTP organisation (I dared to already set it)
Iin linux-test-project group -> Settings -> Third-party Access -> Personal
access tokens -> Settings [5]
select:
Allow access via personal access tokens (classic)
API and Git access will be allowed using an organization member's personal access token (classic)

3) Add repository action secret to ltp repository
IN Settings -> Actions -> New repository secret [6]:
name: GH_PERSONAL_ACCESS_TOKEN
value: the value of previously created token.

Because using token, default permission is just read.

Reviewed-by: Aleks L <aleksandrosansan@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* permission write => read (the real permission is done with token)
* remove unused env

Testing:
https://github.com/foo-pevik/ltp_foo/actions/runs/3656966820
https://github.com/foo-pevik/linux-test-project.github.com_foo/commit/785150ba13a9934d6ce7325abecd05e3643a00ed

No generation with irrelevant change:
https://github.com/foo-pevik/ltp_foo/actions/runs/3656968653

 .github/workflows/metadata-mirror.yml | 139 ++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 .github/workflows/metadata-mirror.yml

diff --git a/.github/workflows/metadata-mirror.yml b/.github/workflows/metadata-mirror.yml
new file mode 100644
index 000000000..296b3286c
--- /dev/null
+++ b/.github/workflows/metadata-mirror.yml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+name: "Mirror metadata doc to homepage"
+
+on:
+  push:
+    branches:
+      - master
+
+permissions: {}
+jobs:
+  metadata-mirror:
+    permissions:
+      contents: read
+
+    runs-on: ubuntu-latest
+    if: ${{ github.repository == 'linux-test-project/ltp' }}
+    steps:
+      - name: Check secret
+        env:
+          GH_PERSONAL_ACCESS_TOKEN: ${{ secrets.GH_PERSONAL_ACCESS_TOKEN }}
+        run: |
+          if [ -z "$GH_PERSONAL_ACCESS_TOKEN" ]; then
+            echo "::error::GH_PERSONAL_ACCESS_TOKEN environment variable is not set"
+            exit 1
+          fi
+
+      - name: Checkout LTP
+        uses: actions/checkout@v3
+        with:
+          path: ltp
+          # we need to fetch whole history to get 'git describe' working for correct version in docs
+          fetch-depth: 0
+
+      - name: Checkout LTP homepage
+        uses: actions/checkout@v3
+        with:
+          repository: "linux-test-project/linux-test-project.github.com"
+          path: linux-test-project.github.com
+          persist-credentials: false
+
+      - name: Check metadata need to be updated
+        run: |
+          cd "$GITHUB_WORKSPACE/ltp/testcases/"
+
+          # check for changes
+          cd "$GITHUB_WORKSPACE/linux-test-project.github.com"
+          git grep '<p><strong>Version</strong>:' metadata/metadata.nightly.html
+          sed -ne 's/.*<p><strong>Version<\/strong>: \(.*\)<\/p>/\1/p' metadata/metadata.nightly.html
+          old_commit=$(sed -ne 's/.*<p><strong>Version<\/strong>: \(.*\)<\/p>/\1/p' metadata/metadata.nightly.html)
+          old_commit=$(echo "$old_commit" | sed 's/.*-g\(.*\)/\1/')
+          echo "::notice::old commit in linux-test-project.github.com: '$old_commit'"
+
+          echo "git log $old_commit..HEAD testcases/ | wc -l"
+          git log $old_commit..HEAD testcases/ | wc -l
+
+          echo "git log $old_commit..HEAD testcases/ 2>&1 | wc -l"
+          git log $old_commit..HEAD testcases/ 2>&1 | wc -l
+
+          if [ "$(git log $old_commit..HEAD testcases/ 2>&1 | wc -l)" = 0 ]; then
+            echo "::notice::no file changes in testcases/ directory since '$old_commit' => exit without commit and push"
+            exit 0
+          fi
+
+      - name: Install dependencies
+        run: |
+          apt="apt install -y --no-install-recommends"
+          sudo $apt asciidoctor autoconf automake libjson-perl libwww-perl make
+
+          echo "which asciidoctor"
+          which asciidoctor || { echo "::error::missing asciidoctor"; exit 1; }
+
+      - name: Configure LTP
+        run: |
+          cd "$GITHUB_WORKSPACE/ltp/"
+          make autotools && ./configure --with-metadata-generator=asciidoctor && make Version || { echo "::error::LTP configure failed"; exit 1; }
+
+      - name: Generate html metadata doc
+        run: |
+          cd "$GITHUB_WORKSPACE/ltp/metadata/"
+          echo "going to generate metadata"
+          make -j$(nproc)
+
+      - name: Check possible LTP homepage update
+        run: |
+          cd "$GITHUB_WORKSPACE/ltp/"
+          ltp_commit=$(git log --pretty=format:"%h" -1 .)
+          echo "::notice::Search for $ltp_commit in metadata/metadata.nightly.html"
+
+          cd "$GITHUB_WORKSPACE/linux-test-project.github.com"
+          grep "<p><strong>Version</strong>:" metadata/metadata.nightly.html
+          git pull
+          grep "<p><strong>Version</strong>:" metadata/metadata.nightly.html
+          if grep "<p><strong>Version</strong>: .*${ltp_commit}.*</p>" metadata/metadata.nightly.html; then
+            echo "::notice::$ltp_commit already in metadata/metadata.nightly.html => exit without commit and push"
+            exit 0
+          fi
+
+      - name: Push generated html metadata to LTP homepage
+        env:
+          GH_PERSONAL_ACCESS_TOKEN: ${{ secrets.GH_PERSONAL_ACCESS_TOKEN }}
+        run: |
+          git config --global user.email "actions@github.com"
+          git config --global user.name "Metadata doc mirror"
+
+          cd "$GITHUB_WORKSPACE/ltp/"
+          commit=$(git log --pretty=format:"%h" -1 .)
+          commit_desc=$(git log --pretty=format:"%h (\"%s\")" -1 .)
+          echo "commit_desc: '$commit_desc'"
+
+          cd "$GITHUB_WORKSPACE/linux-test-project.github.com"
+
+          # pull in case previous hook pushed later than checkout here had started
+          git pull
+
+          cp -v "$GITHUB_WORKSPACE/ltp/docparse/metadata.html" metadata/metadata.nightly.html
+
+          # skip if there is only different version and time
+          echo "Check for changes"
+          if ! git diff --unified=0 --no-color | grep -Po '(?<=^\+)(?!\+\+).*' | grep -v -e '^<p><strong>Version</strong>:' -e '^Last updated'; then
+            echo "::notice::No changes in metadata/metadata.nightly.html => exit without commit and push"
+            exit 0
+          fi
+
+          git add .
+
+          # only commit if there are changes
+          if git diff-index --quiet HEAD --; then
+            echo "::notice::No files changed in $GITHUB_WORKSPACE/linux-test-project.github.com => exit without commit and push"
+            git status
+            exit 0
+          fi
+
+          printf "metadata.nightly.html: Update to $commit\n\nUpdate metadata.nightly.html to $commit_desc\n" > /tmp/msg
+          git commit -F /tmp/msg .
+
+          echo "::notice::GH_PERSONAL_ACCESS_TOKEN: $GH_PERSONAL_ACCESS_TOKEN"
+          git push https://${GH_PERSONAL_ACCESS_TOKEN}@github.com/linux-test-project/linux-test-project.github.com.git
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
