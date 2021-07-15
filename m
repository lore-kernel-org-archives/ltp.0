From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 11:38:23 +0200
Subject: [LTP] [PATCH v6 0/5] 	Run tests in CI
In-Reply-To: <20210715083052.7138-1-pvorel@suse.cz>
References: <20210715083052.7138-1-pvorel@suse.cz>
Message-ID: <YPACD9fqq2HpD3gC@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi,

> changes v5->v6:
> * add new commit suggested by Cyril: "lib: Print Summary: into stderr"
> * fix final error evaluation for C tests in runtest.sh
> * run C and shell test separately (test-c and test-shell instead of
>   test). Having them separate helps to easily navigate in CI. This
>   required to add support to build.sh.

> Hope this is a final version.

Verified slightly modified version (see diff below):
https://github.com/pevik/ltp/actions/runs/1033374720

FYI I'd probably keep first commit "ib: Print Summary: into stderr" although it
should not be needed for CI as 1>&2 redirection fixed the output.

Can I merge it with your ack?

Kind regards,
Petr

diff --git ci/debian.sh ci/debian.sh
index a609da887..e929452ff 100755
--- ci/debian.sh
+++ ci/debian.sh
@@ -22,6 +22,7 @@ $apt \
 	clang \
 	gcc \
 	git \
+	iproute2 \
 	libacl1 \
 	libacl1-dev \
 	libaio-dev \
diff --git ci/fedora.sh ci/fedora.sh
index 959f3af20..dc1293aa5 100755
--- ci/fedora.sh
+++ ci/fedora.sh
@@ -13,6 +13,7 @@ $yum \
 	gcc \
 	git \
 	findutils \
+	iproute \
 	numactl-devel \
 	libtirpc \
 	libtirpc-devel \
diff --git ci/tumbleweed.sh ci/tumbleweed.sh
index ab622e05c..f1e7252f2 100755
--- ci/tumbleweed.sh
+++ ci/tumbleweed.sh
@@ -13,6 +13,7 @@ $zyp \
 	gcc \
 	git \
 	gzip \
+	iproute2 \
 	make \
 	kernel-default-devel \
 	keyutils-devel \
diff --git lib/newlib_tests/runtest.sh lib/newlib_tests/runtest.sh
index bd7995f3b..a11d6ed1a 100755
--- lib/newlib_tests/runtest.sh
+++ lib/newlib_tests/runtest.sh
@@ -79,7 +79,7 @@ run_tests()
 
 	for i in $vars; do
 		runtest_res TINFO "* $i"
-		./$i
+		./$i 1>&2
 		res=$?
 
 		[ $res -ne 0 -a $res -ne 32 ] && ret=1
@@ -94,7 +94,6 @@ run_tests()
 			*) runtest_brk TBROK "Error: unknown failure, exit code: $res";;
 		esac
 		runtest_res
-		sync
 	done
 
 	runtest_res TINFO "=== $target TEST RESULTS ==="
