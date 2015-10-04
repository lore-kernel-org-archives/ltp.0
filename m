From: Nicolas Joly <njoly@pasteur.fr>
Date: Sun, 4 Oct 2015 10:25:51 +0200
Subject: [LTP] [PATCH] Cleanup GCC_WARN_OLDSTYLE content
Message-ID: <20151004082551.GA20256@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Checking some build logs, i noticed that some flags "-g -O2" are
present multiple times.

cc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition  -I/home/njoly/emul/linux/ltp64/testcases/kernel/include -I../../../../include -I../../../../include   -L../../../../lib  access01.c   -lltp -o access01

The third copy on the previous command line comes from
GCC_WARN_OLDSTYLE variable which does include CFLAGS, duplicating them
and adding the needed -Wold-style-definition warning option.

Attached a small patch to clean this part by only adding the needed
option to GCC_WARN_OLDSTYLE.

Thanks.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
-------------- next part --------------
commit bf5a215a6d0ec3774b56c08f56c397753b10997f
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Sat Mar 21 09:24:49 2015 +0100

    m4: ltp-warn_oldstyle: Cleanup GCC_WARN_OLDSTYLE content.
    
    Do not save whole CFLAGS to GCC_WARN_OLDSTYLE, only the needed option.
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/m4/ltp-warn_oldstyle.m4 b/m4/ltp-warn_oldstyle.m4
index a35adcc..717e0a3 100644
--- a/m4/ltp-warn_oldstyle.m4
+++ b/m4/ltp-warn_oldstyle.m4
@@ -19,14 +19,15 @@ dnl
 
 AC_DEFUN([LTP_CHECK_CC_WARN_OLDSTYLE],[dnl
 
-AC_MSG_CHECKING([if $CC supports -Wold-style-definition])
+wflag="-Wold-style-definition"
+AC_MSG_CHECKING([if $CC supports $wflag])
 
 backup_cflags="$CFLAGS"
-CFLAGS+=" -Wold-style-definition"
+CFLAGS+=" $wflag"
 
 AC_LINK_IFELSE(
 	[AC_LANG_PROGRAM([])],
-	[GCC_WARN_OLDSTYLE="$CFLAGS"]
+	[GCC_WARN_OLDSTYLE="$wflag"]
 	[AC_MSG_RESULT([yes])],
 	[AC_MSG_RESULT([no])]
 )
