From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Jun 2021 11:19:43 +0200
Subject: [LTP] [PATCH 1/1] CI/debian: Install dblatex
Message-ID: <20210601091943.6300-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To fix missing dependencies:

checking for dblatex... no
configure: WARNING: PDF metadata generation skipped due missing suitable
generator, specify correct generator with
--with-metadata-generator=asciidoc|asciidoctor or use
--disable-metadata|--disable-metadata-html|--disable-metadata-pdf

Fixes: ff9c528f2 ("travis: Install docparse dependencies")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

to be applied on the top of "CI: Move from Travis to GitHub Actions" [1]
(older problem, but fixing on GitHub actions).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=246505

 ci/debian.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/debian.sh b/ci/debian.sh
index 743b79001..a609da887 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -46,5 +46,6 @@ $apt \
 	pkg-config
 
 $apt ruby-asciidoctor-pdf || true
+$apt asciidoc-dblatex || true
 
 df -hT
-- 
2.31.1

