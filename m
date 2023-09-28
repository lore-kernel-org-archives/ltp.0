Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEFFCE7B19
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 10:45:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D87AF3CDBFD
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 12:45:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DF033CBA71
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 12:45:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6CC40201117
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 12:45:08 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 760161F895;
 Thu, 28 Sep 2023 10:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695897907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gpgvuAhAtH4Tz6jPO2kJhq+78tA5D3NTwCdNWaxnhZ4=;
 b=azAYNFFkczRFgDzWRmFThidcjInNaosmf43X01olUYMWiO+GKm5OUZQ56bAM6fWqibfs/B
 6yG4QIPPsvN7Byu98gmsthNQGAjLanjHP3hk4NMz25y06ODTqgs71O5SuA26rkm4Ws4Akm
 pHm+EMv83TudbhBv7+vkeADj6mA9QuA=
Received: from g78.cable.virginm.net (rpalethorpe.tcp.ovpn1.nue.suse.de
 [10.163.17.14]) by relay2.suse.de (Postfix) with ESMTP id 1B17C2C143;
 Thu, 28 Sep 2023 10:45:07 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 28 Sep 2023 11:44:58 +0100
Message-ID: <20230928104458.12115-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add simple Containerfile
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This adds a regular container (or Docker) file which builds LTP from
source. This is initially intended for testing the LTP itself.

The resulting container has just the LTP installation and runtime
dependencies. However it is still quite large, probably due to debug
symbols.

The container can be built with a command like:

podman build -t tumbleweed/ltp \
       --build-arg PREFIX=registry.opensuse.org/opensuse/ \
       --build-arg DISTRO_NAME=tumbleweed \
       --build-arg DISTRO_RELEASE=20230925 .

Or just

podman build -t alpine/ltp .

It contains Kirk in /opt/kirk. So

cd /opt/kirk && ./kirk -f ltp -r syscalls

will run some tests.

Note a much smaller container can be found at:
https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*
This is created with SUSE's build system which does not use container files

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Marius Kittler <mkittler@suse.de>
---

RFC comments:
    * Add git clean -fdX which should remove any build artifacts
      this is different from the suggestion of just doing a check. I just
      found it easier to remove the build files.
    * Added seperate alpine and tumbleweed runtime scripts. Again it's
      different from the suggestion just because it's easier to add
      seperate scripts than adding a switch
    * Obviously a number of distros are missing runtime scripts. They can
      be added when someone is motivated to do so.

 .dockerignore            |  1 +
 Containerfile            | 32 ++++++++++++++++++++++++++++++++
 ci/alpine-runtime.sh     | 16 ++++++++++++++++
 ci/tumbleweed-runtime.sh | 13 +++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100644 .dockerignore
 create mode 100644 Containerfile
 create mode 100755 ci/alpine-runtime.sh
 create mode 100755 ci/tumbleweed-runtime.sh

diff --git a/.dockerignore b/.dockerignore
new file mode 100644
index 000000000..bbcd7072f
--- /dev/null
+++ b/.dockerignore
@@ -0,0 +1 @@
+Containerfile
diff --git a/Containerfile b/Containerfile
new file mode 100644
index 000000000..2f8192c3b
--- /dev/null
+++ b/Containerfile
@@ -0,0 +1,32 @@
+ARG PREFIX=docker.io/
+ARG DISTRO_NAME=alpine
+ARG DISTRO_RELEASE=3.18
+
+FROM $PREFIX$DISTRO_NAME:$DISTRO_RELEASE AS build
+ARG LTPROOT=/opt/ltp
+ARG DISTRO_NAME=alpine
+ARG DISTRO_RELEASE=3.18
+
+RUN mkdir /build
+WORKDIR /build
+COPY . /build
+RUN ./ci/${DISTRO_NAME}.sh
+RUN git clean -fdX
+RUN ./build.sh -p $LTPROOT -i
+
+FROM $PREFIX$DISTRO_NAME:$DISTRO_RELEASE
+ARG LTPROOT=/opt/ltp
+ARG KIRKROOT=/opt/kirk
+ARG DISTRO_NAME=alpine
+
+COPY --from=build /build/ci/${DISTRO_NAME}-runtime.sh $LTPROOT/runtime-deps.sh
+RUN $LTPROOT/runtime-deps.sh
+
+COPY --from=build $LTPROOT $LTPROOT
+ENV LTPROOT=$LTPROOT
+ENV PATH=$LTPROOT/testcases/bin:$LTPROOT/bin:$PATH
+
+RUN mkdir -p $KIRKROOT
+COPY --from=build /build/tools/kirk $KIRKROOT
+
+USER ltp
diff --git a/ci/alpine-runtime.sh b/ci/alpine-runtime.sh
new file mode 100755
index 000000000..e4941f329
--- /dev/null
+++ b/ci/alpine-runtime.sh
@@ -0,0 +1,16 @@
+#!/bin/sh -eux
+
+apk add \
+        acl \
+        keyutils \
+        libaio \
+        libacl \
+        libcap \
+        libselinux \
+        libsepol \
+        libtirpc \
+        numactl \
+        openssl \
+        py3-msgpack
+
+adduser -D -g "Unprivileged LTP user" ltp
diff --git a/ci/tumbleweed-runtime.sh b/ci/tumbleweed-runtime.sh
new file mode 100755
index 000000000..5207988e7
--- /dev/null
+++ b/ci/tumbleweed-runtime.sh
@@ -0,0 +1,13 @@
+#!/bin/sh -eux
+
+zyp="zypper --non-interactive install --force-resolution --no-recommends"
+
+$zyp \
+	iproute2 \
+	keyutils \
+	libaio1 \
+	libmnl0 \
+	libnuma1 \
+	libtirpc3
+
+useradd ltp
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
