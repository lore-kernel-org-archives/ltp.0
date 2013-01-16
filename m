Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1TvYnK-0006mj-1Q
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 19:37:06 +0000
Received: from mail-qa0-f43.google.com ([209.85.216.43])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TvYnI-0005En-Nw
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 19:37:05 +0000
Received: by mail-qa0-f43.google.com with SMTP id cr7so3661429qab.16
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Jan 2013 11:36:59 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 16 Jan 2013 20:36:58 +0100
Message-ID: <CA+icZUVWeLTYYEmjh7PfjB62dLZJeUjbX00FO-OyDvT6-8pGqg@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [LTP]  realtime/lib: Fix includes in Makefile?
Reply-To: sedat.dilek@gmail.com
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
To: ltp-list@lists.sourceforge.net

Hi,

I am here on latest ltp-git (20130109-5-g385d792).

After copying "config.mk.default" and doing a 'make distclean'...

$ cp -v include/mk/config.mk.default include/mk/config.mk

$ make distclean

... I see this breakage:
[...]
make[1]: Entering directory `/home/wearefam/src/ltp/ltp-git/testcases/realtime'
rm -f -rf autom4te.cache
rm -f -f aclocal.m4 config.log config.status
rm -f -f include/realtime_config.h include/stamp-h1
make[1]: Leaving directory `/home/wearefam/src/ltp/ltp-git/testcases/realtime'
for d in testcases/realtime; do \
            make -C "/home/wearefam/src/ltp/ltp-git/$d" distclean; \
        done
make[1]: Entering directory `/home/wearefam/src/ltp/ltp-git/testcases/realtime'
make -C lib -f "/home/wearefam/src/ltp/ltp-git/testcases/realtime/lib/Makefile"
clean
make[2]: Entering directory
`/home/wearefam/src/ltp/ltp-git/testcases/realtime/lib'
/home/wearefam/src/ltp/ltp-git/testcases/realtime/lib/Makefile:25:
../../../../config.mk: No such file or directory
make[2]: *** No rule to make target `../../../../config.mk'.  Stop.
make[2]: Leaving directory
`/home/wearefam/src/ltp/ltp-git/testcases/realtime/lib'
make[1]: *** [lib-clean] Error 2
make[1]: Leaving directory `/home/wearefam/src/ltp/ltp-git/testcases/realtime'
make: *** [distclean] Error 2

The below patch fixes the issue for me. Unsure if it is correct.

diff --git a/testcases/realtime/lib/Makefile b/testcases/realtime/lib/Makefile
index 8860549..fbbb873 100644
--- a/testcases/realtime/lib/Makefile
+++ b/testcases/realtime/lib/Makefile
@@ -22,7 +22,8 @@

 top_srcdir             ?= ../../..

-include $(top_srcdir)/../config.mk
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../config.mk

 CFLAGS                 += -D_GNU_SOURCE

Please, comment!

Regards,
- Sedat -

------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
