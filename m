From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  2 Aug 2021 19:35:36 +0200
Subject: [LTP] [PATCH v7 7/7] ci: Install iproute2
In-Reply-To: <20210802173536.19525-1-pvorel@suse.cz>
References: <20210802173536.19525-1-pvorel@suse.cz>
Message-ID: <20210802173536.19525-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

shell API test runtime dependency. To fix:

runtest TINFO: * shell/net/tst_rhost_run.sh
tst_rhost_run 1 TCONF: 'ip' not found

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v7.

 ci/debian.sh     | 1 +
 ci/fedora.sh     | 1 +
 ci/tumbleweed.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/ci/debian.sh b/ci/debian.sh
index a609da887..e929452ff 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -22,6 +22,7 @@ $apt \
 	clang \
 	gcc \
 	git \
+	iproute2 \
 	libacl1 \
 	libacl1-dev \
 	libaio-dev \
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 959f3af20..dc1293aa5 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -13,6 +13,7 @@ $yum \
 	gcc \
 	git \
 	findutils \
+	iproute \
 	numactl-devel \
 	libtirpc \
 	libtirpc-devel \
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index ab622e05c..f1e7252f2 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -13,6 +13,7 @@ $zyp \
 	gcc \
 	git \
 	gzip \
+	iproute2 \
 	make \
 	kernel-default-devel \
 	keyutils-devel \
-- 
2.32.0

