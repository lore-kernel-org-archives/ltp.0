From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Oct 2019 14:57:03 +0800
Subject: [LTP] [PATCH] include: undefine _LINUX_TYPES_H if including
 sys/capability.h
In-Reply-To: <87sgnuw48s.fsf@rpws.prws.suse.cz>
References: <20191015101534.17691-1-liwang@redhat.com>
 <87sgnuw48s.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2dfHM7ExwYwdc-_oEw9_DftgfRw3mn2pnAEf1CKxyyn2A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.de> wrote:

...
> >  #ifdef HAVE_SYS_CAPABILITY_H
> >  # include <sys/capability.h>
> > +# undef _LINUX_TYPES_H
>
> My concern here is if linux/types.h has already been included. Then this
> could cause a redefinition error if it is included again.
>

Hmm, it looks tricky to solve this, because I didn't find a macro to show
version in libcap files.

Another method I can think of is to build a small program to check if that
libcap version is newer or not during the configure phase. If yes, then
export a new macro HAVE_NEWER_LIBCAP to be used in /lapi/capability.h.

The following patch has been verified on both rhel6 and rhel8, any comments?
[I'm not familiar with m4 syntax, just copy from other places]

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 3c2ee7937..3607179b5 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -10,7 +10,9 @@

 #ifdef HAVE_SYS_CAPABILITY_H
 # include <sys/capability.h>
-# undef _LINUX_TYPES_H
+# ifndef HAVE_NEWER_LIBCAP
+#  undef _LINUX_TYPES_H
+# endif
 #endif

 #ifndef CAP_NET_RAW
diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
index 02d3cac8c..8b1546401 100644
--- a/m4/ltp-cap.m4
+++ b/m4/ltp-cap.m4
@@ -14,4 +14,20 @@ if test "x$cap_libs" != x; then
        AC_DEFINE(HAVE_LIBCAP)
 fi
 AC_SUBST(CAP_LIBS,$cap_libs)
+
+AH_TEMPLATE(HAVE_NEWER_LIBCAP,
+[Define to 1 if you have newer libcap-2 installed.])
+AC_COMPILE_IFELSE([AC_LANG_SOURCE([
+#include <sys/capability.h>
+#include <linux/types.h>
+int main(void) {
+       __u16 a;
+       __u32 b;
+       return 0;
+}])],[has_newer_libcap="yes"])
+
+if test "x$has_newer_libcap" = xyes; then
+       AC_DEFINE(HAVE_NEWER_LIBCAP)
+fi
 ])
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191016/906d80d0/attachment.htm>
