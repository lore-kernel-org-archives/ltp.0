Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E50C4332F
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 13:52:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53E953CBFD6
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 14:52:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 065933C30A8
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 12:05:15 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6C10D1A00CA4
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 12:05:14 +0100 (CET)
Received: by mail-pf1-x432.google.com with SMTP id x66so3435419pfx.3
 for <ltp@lists.linux.it>; Fri, 09 Dec 2022 03:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6BXjpHZoBhFU5AuA1loOsQojU9xJjEg58DKF5+yEKBY=;
 b=OaSHZPMy2Kjl7CKAQEt+ThEIXdl4qCMDesxcfnHwPMgExN88tXkzECRjGl1T9tIpYz
 5YwY7QsfHKXDxtmMvVKMogJbfaw5KwX44DZZ6CAo0+sl2JjzTU6RSSrSeUVoisbRGPJm
 EhTrGEPtyWJ2ygn12DSa+PjZR81yvkas6RRYkDSDrUd9Tel1hmMDTapKeHks+xR9PJPs
 dwSI+4W/QLuJwKSOP5jD9wO+DwsclKNQiZY/0pHxZcT6i1t1k0xxB80KeDuxxXwWXP+I
 Uo89HIjjshDKmo8lfrinSy9QjeGuDtinPfaXJ9qecBToTqWwQ/UmMtlgvEe59ErRdkuJ
 Yaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6BXjpHZoBhFU5AuA1loOsQojU9xJjEg58DKF5+yEKBY=;
 b=uHOkcFezlg+bUSK2oxe2O0pUHFayyboi5ff5P0rXll27LbCPmGl+ysrgYQzmCJnQLe
 xPVQxkC5mkY5RtPh/oDq+K68FzKDQrMHh8nFFMchgujJ2RWrajjc8kng/BDkKpBJbSdj
 nnCXvUw1wT5m+I5luBd+UTr6OoIWUJan7pri/IwAXt6ciCIaviV9gygO/YlLIP9XK+Ly
 lh/0j3B+7AlPjy9us2cVOeiK/8PDqvL+ALgib4+90G6EjeAgGrFpWBsPSbaQ0eL2zaym
 Ya/PesuKczqVifuv7dSkrQXm1Lbsl7JckCPgGOXQ8l4G40L8G2oBxWK5CAqMzn2Bd8Ad
 brUg==
X-Gm-Message-State: ANoB5pkLmoy4I6XrqWohOBGR9BcBGy0BN+yz7k6rhCGOqYfISpmHkoai
 VMGvpRsOywEMTLEi1Q+BLmQBo/dMJVynXF96OMI=
X-Google-Smtp-Source: AA0mqf73cnNTJFSED7Cxf+9FcMjzskxSL7L53TmdUKA88118hw9P5ao2XWGWST13iYZJntAeXHIDuYb+94C+fYbrs3A=
X-Received: by 2002:a63:e54b:0:b0:46f:8e45:8da1 with SMTP id
 z11-20020a63e54b000000b0046f8e458da1mr68499368pgj.71.1670583912725; Fri, 09
 Dec 2022 03:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20221209100359.6275-1-pvorel@suse.cz>
In-Reply-To: <20221209100359.6275-1-pvorel@suse.cz>
From: Aleks L <aleksandrosansan@gmail.com>
Date: Fri, 9 Dec 2022 12:05:02 +0100
Message-ID: <CAC6nk=1d2fH-K56zjkcMkfLnLAo68Z6KN14mWc0+BP99q34wBA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 09 Dec 2022 14:52:26 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] ci: Add hook to mirror docparse to homepage
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Peter, two comments:

+  metadata-mirror:
+    permissions:
+      contents: write # for git push

Since you are using GH_PERSONAL_ACCESS_TOKEN and not the default
GITHUB_TOKEN for push, I think "contents: read" should be sufficient. Could
you please try it?

+      - name: Checkout LTP homepage
+        uses: actions/checkout@v3
+        with:
+          repository: "linux-test-project/linux-test-project.github.com"
+          path: linux-test-project.github.com
+          persist-credentials: false
+        env:
+          GH_PERSONAL_ACCESS_TOKEN: ${{ secrets.GH_PERSONAL_ACCESS_TOKEN }}

I think the GH_PERSONAL_ACCESS_TOKEN env variable here is not used and can
be deleted. The checkout uses the standard GITHUB_TOKEN with read access to
public repos.

Otherwise LGTM

On Fri, Dec 9, 2022 at 11:04 AM Petr Vorel <pvorel@suse.cz> wrote:

> GitHub Actions git push hook generates metadata HTML and push it wo LTP
> homepage.
>
> Hook pushes only if there are actual changes in generated doc.
>
> NOTE: This requires to add Personal access tokens (classic)
> named as GH_PERSONAL_ACCESS_TOKEN with permissions to public_repo.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> automatic updates of our docparse documentation to our homepage [1]
> (linked in "nightly test documentation" [2]).
>
> This does push to our homepage git repository [3].
>
> This patchset required to add:
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
> API and Git access will be allowed using an organization member's personal
> access token (classic)
>
> 3) Add repository action secret to ltp repository
> IN Settings -> Actions -> New repository secret [6]:
> name: GH_PERSONAL_ACCESS_TOKEN
> value: the value of previously created token.
>
> I haven't tested fine-grained personal access tokens, maybe they are
> safer. Using proper GitHub App would be safer (would not include PAT),
> but I have spent already quite a lot of time with this, thus unless
> anybody objects I'd merge this way.
>
> I did example of this run on organisation which I created just for
> testing purposes:
>
> * working example
> action run [7], resulted in commit [8]. Example of unrelated commit [9]
> which does not trigger doc generation [10].
>
> * example of error, when token not set
> https://github.com/foo-pevik/ltp_foo/actions/runs/3650567244
> GH_PERSONAL_ACCESS_TOKEN environment variable is not set
>
> * example of invalid GH_PERSONAL_ACCESS_TOKEN
>
> https://github.com/foo-pevik/ltp_foo/actions/runs/3650579488/jobs/6166734733
> Notice: GH_PERSONAL_ACCESS_TOKEN: ***
> fatal: could not read Password for 'https://***@github.com': No such
> device or address
> Error: Process completed with exit code 128.
>
> Credits:
> * Inspiration from SwiftDocOrg [11], pointed out by Cyril
> * Thanks a lot to Aleks for hint with "persist-credentials: false".
>
> Kind regards,
> Petr
>
> [1] http://linux-test-project.github.io/
> [2] http://linux-test-project.github.io/metadata/metadata.nightly.html
> [3] https://github.com/linux-test-project/linux-test-project.github.com
> [4] https://github.com/settings/tokens/new
> [5]
> https://github.com/organizations/linux-test-project/settings/personal-access-tokens
> [6] https://github.com/foo-pevik/ltp_foo/settings/secrets/actions/new
> [7] https://github.com/foo-pevik/ltp_foo/actions/runs/3651475124
> [8]
> https://github.com/foo-pevik/linux-test-project.github.com_foo/commit/c2b94862da2c5741f08282988dcc0302e0847a69
> [9]
> https://github.com/foo-pevik/ltp_foo/commit/36a66a2f304b449e1c17d72bad1b1db46a30f36f
> [10] https://github.com/foo-pevik/ltp_foo/actions/runs/3651475552
> [11] https://github.com/SwiftDocOrg/github-wiki-publish-action
>
>  .github/workflows/metadata-mirror.yml | 141 ++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 .github/workflows/metadata-mirror.yml
>
> diff --git a/.github/workflows/metadata-mirror.yml
> b/.github/workflows/metadata-mirror.yml
> new file mode 100644
> index 000000000..9182c554d
> --- /dev/null
> +++ b/.github/workflows/metadata-mirror.yml
> @@ -0,0 +1,141 @@
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
> +      contents: write # for git push
> +
> +    runs-on: ubuntu-latest
> +    if: ${{ github.repository == 'linux-test-project/ltp' }}
> +    steps:
> +      - name: Check secret
> +        env:
> +          GH_PERSONAL_ACCESS_TOKEN: ${{ secrets.GH_PERSONAL_ACCESS_TOKEN
> }}
> +        run: |
> +          if [ -z "$GH_PERSONAL_ACCESS_TOKEN" ]; then
> +            echo "::error::GH_PERSONAL_ACCESS_TOKEN environment variable
> is not set"
> +            exit 1
> +          fi
> +
> +      - name: Checkout LTP
> +        uses: actions/checkout@v3
> +        with:
> +          path: ltp
> +          # we need to fetch whole history to get 'git describe' working
> for correct version in docs
> +          fetch-depth: 0
> +
> +      - name: Checkout LTP homepage
> +        uses: actions/checkout@v3
> +        with:
> +          repository: "linux-test-project/linux-test-project.github.com"
> +          path: linux-test-project.github.com
> +          persist-credentials: false
> +        env:
> +          GH_PERSONAL_ACCESS_TOKEN: ${{ secrets.GH_PERSONAL_ACCESS_TOKEN
> }}
> +
> +      - name: Check metadata need to be updated
> +        run: |
> +          cd "$GITHUB_WORKSPACE/ltp/testcases/"
> +
> +          # check for changes
> +          cd "$GITHUB_WORKSPACE/linux-test-project.github.com"
> +          git grep '<p><strong>Version</strong>:'
> metadata/metadata.nightly.html
> +          sed -ne 's/.*<p><strong>Version<\/strong>: \(.*\)<\/p>/\1/p'
> metadata/metadata.nightly.html
> +          old_commit=$(sed -ne 's/.*<p><strong>Version<\/strong>:
> \(.*\)<\/p>/\1/p' metadata/metadata.nightly.html)
> +          old_commit=$(echo "$old_commit" | sed 's/.*-g\(.*\)/\1/')
> +          echo "::notice::old commit in linux-test-project.github.com:
> '$old_commit'"
> +
> +          echo "git log $old_commit..HEAD testcases/ | wc -l"
> +          git log $old_commit..HEAD testcases/ | wc -l
> +
> +          echo "git log $old_commit..HEAD testcases/ 2>&1 | wc -l"
> +          git log $old_commit..HEAD testcases/ 2>&1 | wc -l
> +
> +          if [ "$(git log $old_commit..HEAD testcases/ 2>&1 | wc -l)" = 0
> ]; then
> +            echo "::notice::no file changes in testcases/ directory since
> '$old_commit' => exit without commit and push"
> +            exit 0
> +          fi
> +
> +      - name: Install dependencies
> +        run: |
> +          apt="apt install -y --no-install-recommends"
> +          sudo $apt asciidoctor autoconf automake libjson-perl
> libwww-perl make
> +
> +          echo "which asciidoctor"
> +          which asciidoctor || { echo "::error::missing asciidoctor";
> exit 1; }
> +
> +      - name: Configure LTP
> +        run: |
> +          cd "$GITHUB_WORKSPACE/ltp/"
> +          make autotools && ./configure
> --with-metadata-generator=asciidoctor && make Version || { echo
> "::error::LTP configure failed"; exit 1; }
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
> +          echo "::notice::Search for $ltp_commit in
> metadata/metadata.nightly.html"
> +
> +          cd "$GITHUB_WORKSPACE/linux-test-project.github.com"
> +          grep "<p><strong>Version</strong>:"
> metadata/metadata.nightly.html
> +          git pull
> +          grep "<p><strong>Version</strong>:"
> metadata/metadata.nightly.html
> +          if grep "<p><strong>Version</strong>: .*${ltp_commit}.*</p>"
> metadata/metadata.nightly.html; then
> +            echo "::notice::$ltp_commit already in
> metadata/metadata.nightly.html => exit without commit and push"
> +            exit 0
> +          fi
> +
> +      - name: Push generated html metadata to LTP homepage
> +        env:
> +          GH_PERSONAL_ACCESS_TOKEN: ${{ secrets.GH_PERSONAL_ACCESS_TOKEN
> }}
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
> +          # pull in case previous hook pushed later than checkout here
> had started
> +          git pull
> +
> +          cp -v "$GITHUB_WORKSPACE/ltp/docparse/metadata.html"
> metadata/metadata.nightly.html
> +
> +          # skip if there is only different version and time
> +          echo "Check for changes"
> +          if ! git diff --unified=0 --no-color | grep -Po
> '(?<=^\+)(?!\+\+).*' | grep -v -e '^<p><strong>Version</strong>:' -e '^Last
> updated'; then
> +            echo "::notice::No changes in metadata/metadata.nightly.html
> => exit without commit and push"
> +            exit 0
> +          fi
> +
> +          git add .
> +
> +          # only commit if there are changes
> +          if git diff-index --quiet HEAD --; then
> +            echo "::notice::No files changed in $GITHUB_WORKSPACE/
> linux-test-project.github.com => exit without commit and push"
> +            git status
> +            exit 0
> +          fi
> +
> +          printf "metadata.nightly.html: Update to $commit\n\nUpdate
> metadata.nightly.html to $commit_desc\n" > /tmp/msg
> +          git commit -F /tmp/msg .
> +
> +          echo "::notice::GH_PERSONAL_ACCESS_TOKEN:
> $GH_PERSONAL_ACCESS_TOKEN"
> +          git push https://${
> GH_PERSONAL_ACCESS_TOKEN}@github.com/linux-test-project/linux-test-project.github.com.git
> <http://GH_PERSONAL_ACCESS_TOKEN%7D@github.com/linux-test-project/linux-test-project.github.com.git>
> --
> 2.38.1
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
