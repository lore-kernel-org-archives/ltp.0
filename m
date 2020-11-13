From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 19:50:07 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] travis: Use latest (Fedora 33)
Message-ID: <20201113185007.13662-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to fix Travis CI build, as Rawhide is currently failing on autoconf:

/usr/bin/autoconf: This script requires a shell more modern than all
/usr/bin/autoconf: the shells that I found on your system.
/usr/bin/autoconf: Please tell bug-autoconf@gnu.org about your system,
/usr/bin/autoconf: including any error possibly output before this
/usr/bin/autoconf: message. Then install a modern shell, or manually run
/usr/bin/autoconf: the script under such a shell if you do have one.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Fixing travis again.

Kind regards,
Petr

 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index b19a3b1c6..281ec9e96 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -40,7 +40,7 @@ matrix:
 
         # other builds
         - os: linux
-          env: DISTRO=fedora:rawhide MAKE_INSTALL=1
+          env: DISTRO=fedora:latest MAKE_INSTALL=1
           compiler: clang
 
         - os: linux
-- 
2.29.2

