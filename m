Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56354C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 10:27:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77AC93CBDB6
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 11:27:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 614ED3C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 11:27:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE94E60073E
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 11:27:17 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A06191FE8F;
 Tue, 13 Dec 2022 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670927236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mrOH5dck4SFknN8ozFZly7XWuH9RsY8cCaAxYHK0AHo=;
 b=fnjeytmwvWlLRgSe5XQMn5Q4wTD70YoD+LLq0Kz3S/1oAF+Zi6ge+Ya70i6f2LwChtMlXK
 7uzfvivOlzdGxb8nag5Dm7NILLyrPXpJPKeRmbr/HwbnA0dsrOesrH1UT9xX8za7fPleKI
 RpIuip87X08cM3+PolN4DX8kmHSB3cE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670927236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mrOH5dck4SFknN8ozFZly7XWuH9RsY8cCaAxYHK0AHo=;
 b=nQQgrdMwXnF6JI7pu2Ki10P0GlHZ8/t8ItbD1lJjnk2pn3lgUhNyu2Gf7SLXRg4yz3UdTt
 pqAZm4kKgaTQxuAQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 330712C141;
 Tue, 13 Dec 2022 10:27:16 +0000 (UTC)
References: <20221209141002.15551-1-pvorel@suse.cz>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Dec 2022 09:59:01 +0000
Organization: Linux Private Site
In-reply-to: <20221209141002.15551-1-pvorel@suse.cz>
Message-ID: <87bko7sinw.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ci: Add hook to mirror docparse to homepage
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, Aleks L <aleksandrosansan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> GitHub Actions git push hook generates metadata HTML and push it
> to LTP homepage.
>
> Hook pushes only if there are actual changes in generated doc.

IIUC we have to do most of the work to generate the meta data, but then
don't push it if there is no diff?

What are we saving with this optimisation?

>
> NOTE: this change requires to add:
>
> 1) Personal Access Token (PAT) to any developer which has write access
> to homepage git repository [3]. In Developer settings -> Personal access
> tokens -> Tokens (classic) [4]), where set:
> Note: GH_PERSONAL_ACCESS_TOKEN
> Select scopes: public_repo (minimal permission)
> Expiration: either never or regularly renew.
>
> 2) Allow PAT in LTP organisation (I dared to already set it)
> Iin linux-test-project group -> Settings -> Third-party Access -> Personal
> access tokens -> Settings [5]
> select:
> Allow access via personal access tokens (classic)
> API and Git access will be allowed using an organization member's personal access token (classic)
>
> 3) Add repository action secret to ltp repository
> IN Settings -> Actions -> New repository secret [6]:
> name: GH_PERSONAL_ACCESS_TOKEN
> value: the value of previously created token.
>
> Because using token, default permission is just read.

This seems like a very convoluted process. Can't we just put the
metadata generation in the docs build and upload the assets as usual?
I've never had to use a PAT to deploy a github page.

>
> Reviewed-by: Aleks L <aleksandrosansan@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * permission write => read (the real permission is done with token)
> * remove unused env
>
> Testing:
> https://github.com/foo-pevik/ltp_foo/actions/runs/3656966820
> https://github.com/foo-pevik/linux-test-project.github.com_foo/commit/785150ba13a9934d6ce7325abecd05e3643a00ed
>
> No generation with irrelevant change:
> https://github.com/foo-pevik/ltp_foo/actions/runs/3656968653
>
>  .github/workflows/metadata-mirror.yml | 139 ++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 .github/workflows/metadata-mirror.yml
>
> diff --git a/.github/workflows/metadata-mirror.yml b/.github/workflows/metadata-mirror.yml
> new file mode 100644
> index 000000000..296b3286c
> --- /dev/null
> +++ b/.github/workflows/metadata-mirror.yml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
> +
> +name: "Mirror metadata doc to homepage"
> +
> +on:
> +  push:
> +    branches:
> +      - master
> +
> +permissions: {}
> +jobs:
> +  metadata-mirror:
> +    permissions:
> +      contents: read
> +
> +    runs-on: ubuntu-latest
> +    if: ${{ github.repository == 'linux-test-project/ltp' }}
> +    steps:
> +      - name: Check secret
> +        env:
> +          GH_PERSONAL_ACCESS_TOKEN: ${{ secrets.GH_PERSONAL_ACCESS_TOKEN }}
> +        run: |
> +          if [ -z "$GH_PERSONAL_ACCESS_TOKEN" ]; then
> +            echo "::error::GH_PERSONAL_ACCESS_TOKEN environment variable is not set"
> +            exit 1
> +          fi

Do we not trust Github to set an env variable?

> +
> +      - name: Checkout LTP
> +        uses: actions/checkout@v3
> +        with:
> +          path: ltp
> +          # we need to fetch whole history to get 'git describe' working for correct version in docs
> +          fetch-depth: 0
> +
> +      - name: Checkout LTP homepage
> +        uses: actions/checkout@v3
> +        with:
> +          repository: "linux-test-project/linux-test-project.github.com"
> +          path: linux-test-project.github.com
> +          persist-credentials: false
> +
> +      - name: Check metadata need to be updated
> +        run: |
> +          cd "$GITHUB_WORKSPACE/ltp/testcases/"
> +
> +          # check for changes
> +          cd "$GITHUB_WORKSPACE/linux-test-project.github.com"
> +          git grep '<p><strong>Version</strong>:' metadata/metadata.nightly.html
> +          sed -ne 's/.*<p><strong>Version<\/strong>: \(.*\)<\/p>/\1/p' metadata/metadata.nightly.html
> +          old_commit=$(sed -ne 's/.*<p><strong>Version<\/strong>: \(.*\)<\/p>/\1/p' metadata/metadata.nightly.html)
> +          old_commit=$(echo "$old_commit" | sed 's/.*-g\(.*\)/\1/')
> +          echo "::notice::old commit in linux-test-project.github.com: '$old_commit'"
> +
> +          echo "git log $old_commit..HEAD testcases/ | wc -l"
> +          git log $old_commit..HEAD testcases/ | wc -l
> +
> +          echo "git log $old_commit..HEAD testcases/ 2>&1 | wc -l"
> +          git log $old_commit..HEAD testcases/ 2>&1 | wc -l
> +
> +          if [ "$(git log $old_commit..HEAD testcases/ 2>&1 | wc -l)" = 0 ]; then
> +            echo "::notice::no file changes in testcases/ directory since '$old_commit' => exit without commit and push"
> +            exit 0
> +          fi
> +
> +      - name: Install dependencies
> +        run: |
> +          apt="apt install -y --no-install-recommends"
> +          sudo $apt asciidoctor autoconf automake libjson-perl libwww-perl make
> +
> +          echo "which asciidoctor"
> +          which asciidoctor || { echo "::error::missing asciidoctor"; exit 1; }
> +
> +      - name: Configure LTP
> +        run: |
> +          cd "$GITHUB_WORKSPACE/ltp/"
> +          make autotools && ./configure --with-metadata-generator=asciidoctor && make Version || { echo "::error::LTP configure failed"; exit 1; }
> +
> +      - name: Generate html metadata doc
> +        run: |
> +          cd "$GITHUB_WORKSPACE/ltp/metadata/"
> +          echo "going to generate metadata"
> +          make -j$(nproc)
> +
> +      - name: Check possible LTP homepage update
> +        run: |
> +          cd "$GITHUB_WORKSPACE/ltp/"
> +          ltp_commit=$(git log --pretty=format:"%h" -1 .)
> +          echo "::notice::Search for $ltp_commit in metadata/metadata.nightly.html"
> +
> +          cd "$GITHUB_WORKSPACE/linux-test-project.github.com"
> +          grep "<p><strong>Version</strong>:" metadata/metadata.nightly.html
> +          git pull
> +          grep "<p><strong>Version</strong>:" metadata/metadata.nightly.html
> +          if grep "<p><strong>Version</strong>: .*${ltp_commit}.*</p>" metadata/metadata.nightly.html; then
> +            echo "::notice::$ltp_commit already in metadata/metadata.nightly.html => exit without commit and push"
> +            exit 0
> +          fi
> +
> +      - name: Push generated html metadata to LTP homepage
> +        env:
> +          GH_PERSONAL_ACCESS_TOKEN: ${{
> secrets.GH_PERSONAL_ACCESS_TOKEN }}

Why put a credential in an env variable anyway? Can we not simply write
${{ secrets.GH_PERSONAL_ACCESS_TOKEN }} below?

> +        run: |
> +          git config --global user.email "actions@github.com"
> +          git config --global user.name "Metadata doc mirror"
> +
> +          cd "$GITHUB_WORKSPACE/ltp/"
> +          commit=$(git log --pretty=format:"%h" -1 .)
> +          commit_desc=$(git log --pretty=format:"%h (\"%s\")" -1 .)
> +          echo "commit_desc: '$commit_desc'"
> +
> +          cd "$GITHUB_WORKSPACE/linux-test-project.github.com"
> +
> +          # pull in case previous hook pushed later than checkout here had started
> +          git pull
> +
> +          cp -v "$GITHUB_WORKSPACE/ltp/docparse/metadata.html" metadata/metadata.nightly.html
> +
> +          # skip if there is only different version and time
> +          echo "Check for changes"
> +          if ! git diff --unified=0 --no-color | grep -Po '(?<=^\+)(?!\+\+).*' | grep -v -e '^<p><strong>Version</strong>:' -e '^Last updated'; then
> +            echo "::notice::No changes in metadata/metadata.nightly.html => exit without commit and push"
> +            exit 0
> +          fi
> +
> +          git add .
> +
> +          # only commit if there are changes
> +          if git pdiff-index --quiet HEAD --; then
> +            echo "::notice::No files changed in $GITHUB_WORKSPACE/linux-test-project.github.com => exit without commit and push"
> +            git status
> +            exit 0
> +          fi
> +
> +          printf "metadata.nightly.html: Update to $commit\n\nUpdate metadata.nightly.html to $commit_desc\n" > /tmp/msg
> +          git commit -F /tmp/msg .
> +
> +          echo "::notice::GH_PERSONAL_ACCESS_TOKEN: $GH_PERSONAL_ACCESS_TOKEN"

Won't this print your PAT for the world to use?

> +          git push
> https://${GH_PERSONAL_ACCESS_TOKEN}@github.com/linux-test-project/linux-test-project.github.com.git




-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
