Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <peter.pearse@linaro.org>) id 1ObsET-0007qY-L8
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 09:38:25 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1ObsER-0006bb-FI
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 09:38:25 +0000
Received: by iwn34 with SMTP id 34so10641353iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 22 Jul 2010 02:38:18 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 22 Jul 2010 10:07:28 +0100
Message-ID: <AANLkTikq6X_ICkQbfLS9GUSnA3jCUdodxrHkdGYtgZFk@mail.gmail.com>
From: Peter Pearse <peter.pearse@linaro.org>
Subject: [LTP] [PATCH] ARM: Correct stack size & alignment for clone tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4809579363897756092=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Paul Larson <paul.larson@linaro.org>

--===============4809579363897756092==
Content-Type: multipart/alternative; boundary=005045013bbe62314f048bf63ffc

--005045013bbe62314f048bf63ffc
Content-Type: text/plain; charset=ISO-8859-1

An ARM stack must be a multiple of 32 bit words in length, and 32 bit
aligned.

Signed-off-by: Peter Pearse <peter.pearse@linaro.org>

---
diff -purN ltp-full-20100630/lib/cloner.c
ltp-full-20100630_patched/lib/cloner.c
--- ltp-full-20100630/lib/cloner.c      2010-07-03 19:29:04.000000000 +0100
+++ ltp-full-20100630_patched/lib/cloner.c      2010-07-22
11:36:24.830445453 +0100
@@ -59,6 +59,13 @@ ltp_clone(unsigned long clone_flags, int
        ret = clone(fn, stack, clone_flags, arg);
 #elif defined(__ia64__)
        ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL,
NULL);
+#elif defined(__arm__)
+       /*
+        * Stack size should be a multiple of 32 bit words
+        * & stack limit must be aligned to a 32 bit boundary
+        */
+       ret = clone(fn, (stack ? stack + stack_size : NULL),
+                       clone_flags, arg);
 #else
        ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
                        clone_flags, arg);
---

--005045013bbe62314f048bf63ffc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

An ARM stack must be a multiple of 32 bit words in length, and 32 bit align=
ed.<br><br>Signed-off-by: Peter Pearse &lt;<a href=3D"mailto:peter.pearse@l=
inaro.org">peter.pearse@linaro.org</a>&gt;<br><br>---<br>diff -purN ltp-ful=
l-20100630/lib/cloner.c ltp-full-20100630_patched/lib/cloner.c<br>
--- ltp-full-20100630/lib/cloner.c=A0=A0=A0=A0=A0 2010-07-03 19:29:04.00000=
0000 +0100<br>+++ ltp-full-20100630_patched/lib/cloner.c=A0=A0=A0=A0=A0 201=
0-07-22 11:36:24.830445453 +0100<br>@@ -59,6 +59,13 @@ ltp_clone(unsigned l=
ong clone_flags, int<br>
=A0=A0=A0=A0=A0=A0=A0 ret =3D clone(fn, stack, clone_flags, arg);<br>=A0#el=
if defined(__ia64__)<br>=A0=A0=A0=A0=A0=A0=A0 ret =3D clone2(fn, stack, sta=
ck_size, clone_flags, arg, NULL, NULL, NULL);<br>+#elif defined(__arm__)<br=
>+=A0=A0=A0=A0=A0=A0 /*<br>+=A0=A0=A0=A0=A0=A0=A0 * Stack size should be a =
multiple of 32 bit words<br>
+=A0=A0=A0=A0=A0=A0=A0 * &amp; stack limit must be aligned to a 32 bit boun=
dary<br>+=A0=A0=A0=A0=A0=A0=A0 */<br>+=A0=A0=A0=A0=A0=A0 ret =3D clone(fn, =
(stack ? stack + stack_size : NULL),<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clone_flags, arg);<br>=A0#else<br>=A0=A0=
=A0=A0=A0=A0=A0 ret =3D clone(fn, (stack ? stack + stack_size - 1 : NULL),<=
br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clone=
_flags, arg);<br>---<br><br>

--005045013bbe62314f048bf63ffc--


--===============4809579363897756092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============4809579363897756092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4809579363897756092==--

