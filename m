Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PgKuB-00014w-FX
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 17:36:11 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PgKu9-000646-6u
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 17:36:11 +0000
Received: by wyb40 with SMTP id 40so1933765wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 09:36:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110121133933.5d72795d@regolo>
References: <20110121133933.5d72795d@regolo>
Date: Fri, 21 Jan 2011 09:36:02 -0800
Message-ID: <AANLkTinADcBWpV8UADG0kaY1Wvjngc2hgbs3Yc7usH+Y@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix access out of bounds in dup204.c.
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
To: Cristian Greco <cristian@regolo.cc>
Cc: ltp-list@lists.sourceforge.net

On Fri, Jan 21, 2011 at 4:39 AM, Cristian Greco <cristian@regolo.cc> wrote:
> Hi,
>
> this should fix an access out-of-bounds.

This was the proper solution. Thanks for spotting the issue!
-Garrett

diff --git a/testcases/kernel/syscalls/dup2/dup204.c
b/testcases/kernel/syscalls/dup2/dup204.c
index fd20ece..5b33484 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -132,10 +132,10 @@ void cleanup()

        TEST_CLEANUP;

-       for (i = 0; i < sizeof(fd); i++) {
+       for (i = 0; i < (sizeof(fd) / sizeof(fd[0])); i++) {
                close(fd[i]);
                close(nfd[i]);
        }

        tst_rmdir();
-}
\ No newline at end of file
+}

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
