Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOmDH-00020O-Tn
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 05:30:31 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOmDH-0001QB-3X
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 05:30:31 +0000
Received: by yxe33 with SMTP id 33so7990688yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 22:30:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A54AEFA.3030100@petalogix.com>
References: <4A5436D4.6070201@petalogix.com>
	<364299f40907080719q4ab01842v7e47a352b8214b8a@mail.gmail.com>
	<4A54AEFA.3030100@petalogix.com>
Date: Wed, 8 Jul 2009 22:30:30 -0700
Message-ID: <364299f40907082230m27683f17yd042bd569d0a5165@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016369201f071952d046e3f270e
Subject: Re: [LTP] IDcheck.sh - awk problem
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: michal.simek@petalogix.com
Cc: LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier.adi@gmail.com>

--0016369201f071952d046e3f270e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Jul 8, 2009 at 7:36 AM, Michal Simek<michal.simek@petalogix.com> wrote:
>
> Of course not because I cross compile ltp for Microblaze - correct
> /etc/passwd - group is on
> target system. Maybe worth to remove calling IDcheck.sh from make
> install and call it only before
> running the test.
>

Michal,
    Please give this patch a try, and instead when you run make
install, do SKIP_IDCHECK=1.
HTH,
-Garrett

This patch does the same as the previous released patch in this
thread, which is:

IDcheck.sh:
1. Fixes the DESTDIR != "" | "/" behavior.
2. Spew out less awk errors if files don't exist by instead
short-circuiting the logic to detect whether or not the file exists in
the fe function subroutine.

In addition to the above, this adds SKIP_IDCHECK behavior, by request
of Michal, so it's no longer required for make install, and can be
disabled by entering specifying the variable SKIP_IDCHECK=1 when
calling make install, e.g...

make \
[make-options-and-variables] \
SKIP_IDCHECK=1 \
install

Warning! This patch has Makefile changes and as such the files patched
contents should be committed directly, NOT the inline text shown below
(for reviewing purposes only).

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: IDcheck.sh
===================================================================
RCS file: /cvsroot/ltp/ltp/IDcheck.sh,v
retrieving revision 1.19
diff -u -r1.19 IDcheck.sh
--- IDcheck.sh  7 Jul 2009 14:30:27 -0000       1.19
+++ IDcheck.sh  9 Jul 2009 05:21:34 -0000
@@ -22,7 +22,6 @@
 #

 # Prompt user if ids/groups should be created
-clear
 echo "Checking for required user/group ids"
 echo ""

@@ -41,12 +40,11 @@

 # find entry.
 fe() {
-       ID=$1; shift
-       FILE=$1; shift
-       awk "/^$ID:/ { FOUND=1 } END { if (\$FOUND == 1) { exit 0; }
exit 1; }" \
-       "$FILE"
-       ec=$?
-       echo "$ID => $ec"
+    ID=$1; shift
+    FILE=$1; shift
+    [ -e "$FILE" ] || return $?
+    awk "/^$ID:/ { FOUND=1 } END { if (\$FOUND == 1) { exit 1; } exit 0; }" \
+    "$FILE"
 }

 prompt_for_create() {
@@ -70,13 +68,12 @@
        EUID=$(id -u)
 fi

-if [ -e "$passwd" -a ! -r "$passwd" ] ; then
-       echo "/etc/passwd not readable by uid $EUID"
+for i in "$passwd" "$group"; do
+    if [ -e "$i" -a ! -r "$i" ] ; then
+       echo "$i not readable by uid $EUID"
        exit 1
-elif [ -e "$group" -a ! -r "$group" ] ; then
-       echo "$group not readable by uid $EUID"
-       exit 1
-fi
+    fi
+done

 fe bin "$passwd"; NO_BIN_ID=$?
 fe daemon "$passwd"; NO_DAEMON_ID=$?
@@ -110,10 +107,10 @@
 #debug_vals

 if [ $CREATE_ENTRIES -ne 0 ] ; then
-       if ! touch "$group" ; then
-               echo "Couldn't touch $group"
-               exit 1
-       fi
+    if ! touch "$group" "$passwd" 2>/dev/null; then
+        echo "Failed to touch $group or $passwd"
+        exit 1
+    fi
 fi

 make_user_group() {
Index: Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/Makefile,v
retrieving revision 1.39
diff -u -r1.39 Makefile
--- Makefile    25 Mar 2009 06:17:48 -0000      1.39
+++ Makefile    9 Jul 2009 05:27:34 -0000
@@ -14,6 +14,10 @@
 export CFLAGS += -Wall $(CROSS_CFLAGS)
 export CC AR RANLIB CPPFLAGS LDFLAGS HAS_NUMA

+# SKIP_IDCHECK != 1, defaults to previous behavior, which is to execute
+# IDcheck.sh at the end of `make install'.
+SKIP_IDCHECK           ?= 0
+
 -include config.mk

 VPATH += include m4
@@ -36,8 +40,9 @@
        @$(MAKE) -C m4 install
        @$(MAKE) -C doc/man1 install
        @$(MAKE) -C doc/man3 install
-
+ifneq ($(filter $(SKIP_IDCHECK)),1)
        @./IDcheck.sh
+endif

 libltp.a: config.h
        @$(MAKE) -C lib $@

--0016369201f071952d046e3f270e
Content-Type: application/octet-stream; name="IDcheck_awk_fix+skip_check.diff"
Content-Disposition: attachment; filename="IDcheck_awk_fix+skip_check.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwx1fdr80

SW5kZXg6IElEY2hlY2suc2gKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvbHRwL2x0cC9J
RGNoZWNrLnNoLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjE5CmRpZmYgLXUgLXIxLjE5IElEY2hl
Y2suc2gKLS0tIElEY2hlY2suc2gJNyBKdWwgMjAwOSAxNDozMDoyNyAtMDAwMAkxLjE5CisrKyBJ
RGNoZWNrLnNoCTkgSnVsIDIwMDkgMDU6Mjc6MzQgLTAwMDAKQEAgLTIyLDcgKzIyLDYgQEAKICMK
IAogIyBQcm9tcHQgdXNlciBpZiBpZHMvZ3JvdXBzIHNob3VsZCBiZSBjcmVhdGVkCi1jbGVhcgog
ZWNobyAiQ2hlY2tpbmcgZm9yIHJlcXVpcmVkIHVzZXIvZ3JvdXAgaWRzIgogZWNobyAiIgogCkBA
IC00MSwxMiArNDAsMTEgQEAKIAogIyBmaW5kIGVudHJ5LgogZmUoKSB7Ci0JSUQ9JDE7IHNoaWZ0
Ci0JRklMRT0kMTsgc2hpZnQKLQlhd2sgIi9eJElEOi8geyBGT1VORD0xIH0gRU5EIHsgaWYgKFwk
Rk9VTkQgPT0gMSkgeyBleGl0IDA7IH0gZXhpdCAxOyB9IiBcCi0JIiRGSUxFIgotCWVjPSQ/Ci0J
ZWNobyAiJElEID0+ICRlYyIKKyAgICBJRD0kMTsgc2hpZnQKKyAgICBGSUxFPSQxOyBzaGlmdAor
ICAgIFsgLWUgIiRGSUxFIiBdIHx8IHJldHVybiAkPworICAgIGF3ayAiL14kSUQ6LyB7IEZPVU5E
PTEgfSBFTkQgeyBpZiAoXCRGT1VORCA9PSAxKSB7IGV4aXQgMTsgfSBleGl0IDA7IH0iIFwKKyAg
ICAiJEZJTEUiCiB9CiAKIHByb21wdF9mb3JfY3JlYXRlKCkgewpAQCAtNzAsMTMgKzY4LDEyIEBA
CiAJRVVJRD0kKGlkIC11KQogZmkKIAotaWYgWyAtZSAiJHBhc3N3ZCIgLWEgISAtciAiJHBhc3N3
ZCIgXSA7IHRoZW4KLQllY2hvICIvZXRjL3Bhc3N3ZCBub3QgcmVhZGFibGUgYnkgdWlkICRFVUlE
IgorZm9yIGkgaW4gIiRwYXNzd2QiICIkZ3JvdXAiOyBkbworICAgIGlmIFsgLWUgIiRpIiAtYSAh
IC1yICIkaSIgXSA7IHRoZW4KKwllY2hvICIkaSBub3QgcmVhZGFibGUgYnkgdWlkICRFVUlEIgog
CWV4aXQgMQotZWxpZiBbIC1lICIkZ3JvdXAiIC1hICEgLXIgIiRncm91cCIgXSA7IHRoZW4KLQll
Y2hvICIkZ3JvdXAgbm90IHJlYWRhYmxlIGJ5IHVpZCAkRVVJRCIKLQlleGl0IDEKLWZpCisgICAg
ZmkKK2RvbmUKIAogZmUgYmluICIkcGFzc3dkIjsgTk9fQklOX0lEPSQ/CiBmZSBkYWVtb24gIiRw
YXNzd2QiOyBOT19EQUVNT05fSUQ9JD8KQEAgLTExMCwxMCArMTA3LDEwIEBACiAjZGVidWdfdmFs
cwogCiBpZiBbICRDUkVBVEVfRU5UUklFUyAtbmUgMCBdIDsgdGhlbgotCWlmICEgdG91Y2ggIiRn
cm91cCIgOyB0aGVuCi0JCWVjaG8gIkNvdWxkbid0IHRvdWNoICRncm91cCIKLQkJZXhpdCAxCi0J
ZmkKKyAgICBpZiAhIHRvdWNoICIkZ3JvdXAiICIkcGFzc3dkIiAyPi9kZXYvbnVsbDsgdGhlbgor
ICAgICAgICBlY2hvICJGYWlsZWQgdG8gdG91Y2ggJGdyb3VwIG9yICRwYXNzd2QiCisgICAgICAg
IGV4aXQgMQorICAgIGZpCiBmaQogCiBtYWtlX3VzZXJfZ3JvdXAoKSB7CkluZGV4OiBNYWtlZmls
ZQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9sdHAvbHRwL01ha2VmaWxlLHYKcmV0cmll
dmluZyByZXZpc2lvbiAxLjM5CmRpZmYgLXUgLXIxLjM5IE1ha2VmaWxlCi0tLSBNYWtlZmlsZQky
NSBNYXIgMjAwOSAwNjoxNzo0OCAtMDAwMAkxLjM5CisrKyBNYWtlZmlsZQk5IEp1bCAyMDA5IDA1
OjI3OjM0IC0wMDAwCkBAIC0xNCw2ICsxNCwxMCBAQAogZXhwb3J0IENGTEFHUyArPSAtV2FsbCAk
KENST1NTX0NGTEFHUykKIGV4cG9ydCBDQyBBUiBSQU5MSUIgQ1BQRkxBR1MgTERGTEFHUyBIQVNf
TlVNQQogCisjIFNLSVBfSURDSEVDSwkhPSAxLCBkZWZhdWx0cyB0byBwcmV2aW91cyBiZWhhdmlv
ciwgd2hpY2ggaXMgdG8gZXhlY3V0ZQorIyBJRGNoZWNrLnNoIGF0IHRoZSBlbmQgb2YgYG1ha2Ug
aW5zdGFsbCcuCitTS0lQX0lEQ0hFQ0sJCT89IDAgCisKIC1pbmNsdWRlIGNvbmZpZy5tawogCiBW
UEFUSCArPSBpbmNsdWRlIG00CkBAIC0zNiw4ICs0MCw5IEBACiAJQCQoTUFLRSkgLUMgbTQgaW5z
dGFsbAogCUAkKE1BS0UpIC1DIGRvYy9tYW4xIGluc3RhbGwKIAlAJChNQUtFKSAtQyBkb2MvbWFu
MyBpbnN0YWxsCi0KK2lmbmVxICgkKGZpbHRlciAkKFNLSVBfSURDSEVDSykpLDEpCiAJQC4vSURj
aGVjay5zaAorZW5kaWYKIAogbGlibHRwLmE6IGNvbmZpZy5oCiAJQCQoTUFLRSkgLUMgbGliICRA
Cg==
--0016369201f071952d046e3f270e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--0016369201f071952d046e3f270e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016369201f071952d046e3f270e--

