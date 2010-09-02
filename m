Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OrAm1-0000Xe-3F
	for ltp-list@lists.sourceforge.net; Thu, 02 Sep 2010 14:28:17 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id F16B389471
	for <ltp-list@lists.sourceforge.net>;
	Thu,  2 Sep 2010 16:28:09 +0200 (CEST)
Date: Thu, 2 Sep 2010 16:47:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100902144720.GA16059@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix realtime atomic_add() inline asm
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
To: ltp-list@lists.sourceforge.net


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
The atomic_add() assembler for x86 is missing hint for gcc that value of
v->counter is being modified by xaddl instruction and as this variable
is changed only from this asm runtime, some combination of gcc
optimalizations allows for this value to be placed in binary .rodata
section resulting in realtime tests segfaulting when trying to do
atomic_add(). It's reproducible on SLES11 (gcc 4.3.2) with -O2.

Patch attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--5vNYLRcllDrimb99
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="realtime_inline_asm_fix.patch"

diff --git a/testcases/realtime/include/librttest.h b/testcases/realtime/include/librttest.h
index e526ab4..cddc399 100644
--- a/testcases/realtime/include/librttest.h
+++ b/testcases/realtime/include/librttest.h
@@ -119,7 +119,7 @@ static inline int atomic_add(int i, atomic_t *v)
 	__i = i;
 	asm volatile(
 			"lock; xaddl %0, %1;"
-			:"=r"(i)
+			:"=r"(i), "+m" (v->counter)
 			:"m"(v->counter), "0"(i));
 	return i + __i;
 #elif defined(__powerpc__)

--5vNYLRcllDrimb99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--5vNYLRcllDrimb99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--5vNYLRcllDrimb99--

