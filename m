Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PB4o5-0001V2-Jr
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 12:08:41 +0000
Date: Wed, 27 Oct 2010 14:18:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101027121837.GC4999@saboteur.suse.cz>
References: <AANLkTimHeBQkYhnPpAiOJx2R8Y1xznHffWYhAtBR=iCF@mail.gmail.com>
	<AANLkTi=zZud=H52Q5pE00gERVi6MfVF9QV7_C66W=CEP@mail.gmail.com>
	<20101027114756.GA4999@saboteur.suse.cz>
	<AANLkTinnQiYVwK5X9v2Ggg582yUaKS_iAE1JT5QnGi8v@mail.gmail.com>
	<20101027121005.GB4999@saboteur.suse.cz>
	<AANLkTinqoZDqBkGY79u1AHXMD_HAk+RKGGGrToLaz-Cr@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTinqoZDqBkGY79u1AHXMD_HAk+RKGGGrToLaz-Cr@mail.gmail.com>
Subject: Re: [LTP] Realtime tests on ARM
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
To: David Peverley <pev@sketchymonkey.com>
Cc: gowrishankar.m@in.ibm.com, ltp-list@lists.sourceforge.net

Hi!
> 
> Was your change to modify librttest.h as follows :
>    /* atomic_add - add integer to atomic variable and returns a value.
>     * i: integer value to add
>     * v: pointer of type atomic_t
>     */
>    static inline void atomic_add( int i, atomic_t *v )
>    {
>             (void)__sync_add_and_fetch(&v->counter, i);
>    }
> 
>    /* atomic_inc: atomically increment the integer passed by reference
>     */
>    static inline int atomic_inc(atomic_t *v)
>    {
>        return (int)__sync_add_and_fetch(&v->counter, 1);
>    }

No. I send a patch to fix inline assembler for x86 machine. But
Gowrishankar send a better patch that replaces inline assembler with gcc
builins. So I agreed that this is a better solution and acked his patch.

Anyway casts to (void) and (int) are useless here as the compiler
figures out this itself. And also atomic_add() is unused function after
this change as atomic_inc() was previously implemented as atomic_add(1, v)
and atomic_add() was used only to implement atomic_inc().

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
