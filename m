Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ext-hannu.m.heikkinen@nokia.com>) id 1P1GSX-0000YI-B2
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 10:33:53 +0000
Received: from smtp.nokia.com ([147.243.1.47] helo=mgw-sa01.nokia.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P1GSV-0003ia-Gc
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 10:33:53 +0000
Date: Thu, 30 Sep 2010 13:31:20 +0000
From: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Message-ID: <20100930133120.GA4070@hannu-debian.research.nokia.com>
References: <4CA09D4D.6050708@st.com>
 <4CA34070.9070505@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CA34070.9070505@st.com>
Subject: Re: [LTP] ltp_clone alignment issues.
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
To: ext Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 29/09/10 15:34 +0200, ext Carmelo AMOROSO wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 9/27/2010 3:34 PM, Carmelo AMOROSO wrote:
> > Folks,
> > I want to reopen an old discussion on ltp_clone and stack alignment
> > issue (see
> > http://sourceforge.net/mailarchive/message.php?msg_name=4B421480.1040400%40petalogix.com).
> > Indeed recently a commit has partially fixed a problem on ARM
> > (0056e395170eb8fc3ffbb22d7bd364fe47c2013e), but I think this should be
> > extended to all archs that have stack that grows downwards.
> > 
> > Indeed, as Jiri replied in that old thread, the value passed to clone as
> > child stack should be never accessed, because it is the topmost address
> > of the memory allocated for the child process (it's the previous stack
> > pointer).
> > 
> > So, in archs that do not like unaligned stack, using (stack - size - 1 )
> > will cause the process to be killed by a SIGBUS, on other archs, we are
> > just wasting one byte of the malloc-ed stack.
> > 
> > On my SH4 arch, the stack must be 4byte aligned (as in ARM).
> > 
> > Please, find attached a patch against master branch
> > 
> > Best regards,
> > Carmelo
> 
> Hi,
> any feedback on this ?
> 
> Cheers,
> Carmelo

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 lib/cloner.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/cloner.c b/lib/cloner.c
index 6ad4a00..e53c9cf 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -59,16 +59,13 @@ ltp_clone(unsigned long clone_flags, int (*fn)(void
*arg), void *arg,
        ret = clone(fn, stack, clone_flags, arg);
 #elif defined(__ia64__)
        ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL,
NULL);
-#elif defined(__arm__)
+#else
        /*
-        * Stack size should be a multiple of 32 bit words
-        * & stack limit must be aligned to a 32 bit boundary
+        * For archs where stack grows downwards, stack points to the topmost
address
+        * of the memory space set up for the child stack.
         */
        ret = clone(fn, (stack ? stack + stack_size : NULL),
                        clone_flags, arg);
-#else
-       ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
-                       clone_flags, arg);
 #endif
 
        return ret;
-- 
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Hi,

Acked-by Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>

Br,
Hannu

-- 
Hannu Heikkinen
http://www.nixu.com

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
