Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1Mqpaw-0001OM-Oj
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 14:46:54 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mqpaq-0003dw-SH
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 14:46:54 +0000
Message-ID: <4ABB864B.8000801@bull.net>
Date: Thu, 24 Sep 2009 16:46:35 +0200
From: Jacky Malcles <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] fs_di TestCase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Subrata,

when this TC is ending it removes all directories/files  under /tmp that
may be embarrassing so,
if you agree I suggest that it only removes what has to do with the
TestCase; this is the purpose of the following patch.

Signed-off-by: JACKY MALCLES <Jacky.Malcles@bull.net>

diff -uprN ltp-full-20090831.orig/testcases/kernel/fs/fs_di
ltp-full-20090831/testcases/kernel/fs/fs_di
diff -uprN ltp-full-20090831.orig/testcases/kernel/fs/fs_di/fs_di
ltp-full-20090831/testcases/kernel/fs/fs_di/fs_di
- --- ltp-full-20090831.orig/testcases/kernel/fs/fs_di/fs_di
2009-08-31 07:15:46.000000000 +0200
+++ ltp-full-20090831/testcases/kernel/fs/fs_di/fs_di   2009-09-24
16:06:05.000000000 +0200
@@ -95,7 +95,6 @@ $trace_logic
     if [ "$CLEANUP" = "ON" ]; then
        rm -rf $TCtmp
        rm -rf ${TESTFS}
- -       rm -rf $TMPBASE/*
         rm -f $TCtmp/testfile*
     fi

regards,
- --
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEVAwUBSruGS3FYHhojb+kFAQILlQgAj+G7Ey6K8EBiskbySOs2VU/MbuI1zv+s
YnkVVSWj1dx7VMGCYdxvz+xINTunBMeLtomskodYmGkbSS12+012MmlsDHiYf/05
oybPYxc+6qp+JKQBUBjESdQ2/7YC58pW+uk6AJRinpfjczeozDk49E9EeEd9qtJn
tlZy72mIscZe4u8nHVferPpMTzA2O5VqQp9Iy34YjYeEob0ttrLiqSMwTtN4RAWK
DUD/l9FwPgdxBQjwEvtKItKUxB9rMS+Vu6Np1gYGBQYrwFzTm+M2UGwwmdyUCwdM
yjJQx0SRqImR2ldVg0QbgrAsdwRRfIAkvhWFSCCSQzN67JP3QW84/w==
=UWZ2
-----END PGP SIGNATURE-----

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
