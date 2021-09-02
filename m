From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  2 Sep 2021 13:58:37 +0200
Subject: [LTP] [PATCH 5/5] checkbashisms: Disable 'type' check
Message-ID: <20210902115837.2199-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

'type' is part of POSIX, but as part of the X/Open Systems Interfaces
option (XSI). The checkbashisms man page explicitly says:

	Note that the definition of a bashism in this context roughly
	equates to "a shell feature that is not required to be supported
	by POSIX"; this means that some issues flagged may be permitted
	under optional sections of POSIX, such as XSI or User Portability.

'type' is flagged because it is an optional feature. But because it's
supported by all common shells (i.e.  > bash, zsh, dash, busybox sh,
mksh) we use it even in the library => disable the check.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

follow up to patchset "checkbashisms.pl in make check + fixed docs" [1].

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=260711

 scripts/checkbashisms.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkbashisms.pl b/scripts/checkbashisms.pl
index ba417c993..6dc762cb7 100755
--- a/scripts/checkbashisms.pl
+++ b/scripts/checkbashisms.pl
@@ -675,7 +675,8 @@ sub init_hashes {
         $LEADIN . qr'shopt(\s|\Z)'       => q<shopt>,
         $LEADIN . qr'suspend\s'          => q<suspend>,
         $LEADIN . qr'time\s'             => q<time>,
-        $LEADIN . qr'type\s'             => q<type>,
+        # LTP supports type
+        # $LEADIN . qr'type\s'             => q<type>,
         $LEADIN . qr'typeset\s'          => q<typeset>,
         $LEADIN . qr'ulimit(\s|\Z)'      => q<ulimit>,
         $LEADIN . qr'set\s+-[BHT]+'      => q<set -[BHT]>,
-- 
2.33.0

