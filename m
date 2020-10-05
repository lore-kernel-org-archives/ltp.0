From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Oct 2020 15:30:45 +0200
Subject: [LTP] [PATCH 02/11] travis: Add git
In-Reply-To: <20201005133054.23587-1-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
Message-ID: <20201005133054.23587-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

Needed in parse.sh script in next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 travis/alpine.sh     | 1 +
 travis/debian.sh     | 1 +
 travis/fedora.sh     | 1 +
 travis/tumbleweed.sh | 1 +
 4 files changed, 4 insertions(+)

diff --git a/travis/alpine.sh b/travis/alpine.sh
index 61ef144a8..f8960bed0 100755
--- a/travis/alpine.sh
+++ b/travis/alpine.sh
@@ -10,6 +10,7 @@ apk add \
 	automake \
 	clang \
 	gcc \
+	git \
 	keyutils-dev \
 	libaio-dev \
 	libacl \
diff --git a/travis/debian.sh b/travis/debian.sh
index b759a9576..28685f4d3 100755
--- a/travis/debian.sh
+++ b/travis/debian.sh
@@ -17,6 +17,7 @@ apt install -y --no-install-recommends \
 	devscripts \
 	clang \
 	gcc \
+	git \
 	libacl1 \
 	libacl1-dev \
 	libaio-dev \
diff --git a/travis/fedora.sh b/travis/fedora.sh
index 990a84daf..3c224f71e 100755
--- a/travis/fedora.sh
+++ b/travis/fedora.sh
@@ -8,6 +8,7 @@ yum -y install \
 	make \
 	clang \
 	gcc \
+	git \
 	findutils \
 	libtirpc \
 	libtirpc-devel \
diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
index 4d5e9da79..6247daa98 100755
--- a/travis/tumbleweed.sh
+++ b/travis/tumbleweed.sh
@@ -8,6 +8,7 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	clang \
 	findutils \
 	gcc \
+	git \
 	gzip \
 	make \
 	kernel-default-devel \
-- 
2.26.2

