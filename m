Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB100E7D26A
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 09:01:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12C4D3CE1C7
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 11:01:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F49B3C9969
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 11:01:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40D9160156F
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 11:01:14 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id AB5E61F74D;
 Tue, 26 Sep 2023 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695718874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kA++/OZUCG7dPRVzoWkwOhBxaQcsheLJBBHbHIhgnqk=;
 b=YCvf/qhWKoc89mHIoxtjHjixvnG3cP9tk+DxkLSWqRHEHQzhhue0ZKAGbPYQnqjA/UbJXu
 ZRYVYmHQSSm5DdhaeL+bUfU6ygQrjVX/GJ6h+YkQvd+Tb+w67F9+SWpa868diUwcUb2Hu5
 cjo8KgjQ2uOWOKU+x+hMumiJrmGRWFo=
Received: from g78.cable.virginm.net (rpalethorpe.tcp.ovpn1.nue.suse.de
 [10.163.17.14]) by relay2.suse.de (Postfix) with ESMTP id 5AB472C142;
 Tue, 26 Sep 2023 09:01:14 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 26 Sep 2023 10:01:01 +0100
Message-ID: <20230926090101.7565-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH] Add simple Alpine container
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

Can be built with `docker/podman build .`. Then run with `podman -it
run sh`. It contains Kirk in /opt/kirk. So `cd /opt/kirk && ./kirk -f
ltp --run-suite syscalls` will run some tests.
---

Hello,

This builds and installs the LTP and Kirk inside an Alpine
container. The idea is to use a standard container workflow to build
and run the LTP from source. This helps with testing LTP itself and
running tests inside a container.

I'd like to add some container files to upstream to help with various
workflows.

The container has a number of problems:

1. If the Git directory has build artifacts in it, these are copied
   into the container (.dockerignore may help)
2. The resulting container is quite large (possibly due to debug symbols)
3. Where should we put container files and how should we name them?
4. Making the slightest change results in a complete container rebuild

Note that SUSE publishes a TW container based on our packaging system:
https://build.opensuse.org/project/show/benchmark:ltp:devel
https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*

Also, for developing tests, it may be better to build the LTP outside
of a container then copy in the files.

Latest tree is here:
https://github.com/richiejp/ltp/tree/alpine-container

 Containerfile | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Containerfile

diff --git a/Containerfile b/Containerfile
new file mode 100644
index 000000000..7bd50ce52
--- /dev/null
+++ b/Containerfile
@@ -0,0 +1,35 @@
+FROM alpine:3.18 AS build
+ARG LTPROOT=/opt/ltp
+
+RUN mkdir /build
+WORKDIR /build
+COPY . /build
+RUN ./ci/alpine.sh
+RUN ./build.sh -p $LTPROOT -i
+
+FROM alpine:3.18
+ARG LTPROOT=/opt/ltp
+ARG KIRKROOT=/opt/kirk
+
+RUN apk add \
+            acl \
+            keyutils \
+            libaio \
+            libacl \
+            libcap \
+            libselinux \
+            libsepol \
+            libtirpc \
+            numactl \
+            openssl \
+            py3-msgpack
+
+COPY --from=build $LTPROOT $LTPROOT
+ENV LTPROOT=$LTPROOT
+ENV PATH=$LTPROOT/testcases/bin:$LTPROOT/bin:$PATH
+
+RUN mkdir -p $KIRKROOT
+COPY --from=build /build/tools/kirk $KIRKROOT
+
+RUN adduser -D -g "Unprivileged LTP user" ltp
+RUN su ltp
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
