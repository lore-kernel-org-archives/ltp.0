Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kamalesh@linux.vnet.ibm.com>) id 1MHaAA-0003FO-Cm
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 09:13:34 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHaA7-0003tg-SX
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 09:13:34 +0000
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5JJ6uNi027438
	for <ltp-list@lists.sourceforge.net>; Sat, 20 Jun 2009 05:06:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5J9DQxW1151040
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2009 19:13:26 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5J9DQKA004669
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2009 19:13:26 +1000
Date: Fri, 19 Jun 2009 14:43:17 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <20090619091317.GA11782@linux.vnet.ibm.com>
References: <f5a7b3810906171318v503b0c77l27a5df2f057fb85c@mail.gmail.com>
	<1245346315.5041.42.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1245346315.5041.42.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [FIX PATCH] ltp-add_key
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com, naresh kamboju <naresh.kernel@gmail.com>

* Subrata Modak <subrata@linux.vnet.ibm.com> [2009-06-18 23:01:55]:

> Great to see you fix these issues and send across the fixes. However, i
> remember Kamalesh working on similar type of fixes.
> 
> Lets hear from Kamalesh, whether he has something additional from this
> series of patches, or, some other fixes in each patch apart from what
> you have already provided.
> 
> Kamalesh,
> 
> Would you like to say something here ?
> 
> Another suggestion. Naresh, next time when you send patches pertaining
> to one particular issue observed in several tests, then no. the patches,
> like [PATCH 00/N] to [PATCH N/N].

It could be nice to add a section in ltp-howto on sending patch sets.

> 
> Regards--
> Subrata
> 
> On Thu, 2009-06-18 at 01:48 +0530, naresh kamboju wrote: 
> > Hi,
> > 
> > I have noticed following failures and fixed.
> > 1. add_key01.c
> > 2. add_key02.c
> > 
> > 
> > Please find the patch below and as attachment.
> > 
> > Best regards
> > Naresh Kamboju
> > 
> > Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> > diff -Naurb a/testcases/kernel/syscalls/add_key/add_key01.c
> > b/testcases/kernel/syscalls/add_key/add_key01.c
> > --- a/testcases/kernel/syscalls/add_key/add_key01.c	2009-05-21
> > 23:39:37.000000000 +0530
> > +++ b/testcases/kernel/syscalls/add_key/add_key01.c	2009-06-17
> > 23:00:15.000000000 +0530
> > @@ -125,7 +125,7 @@
> >          for (lc = 0; TEST_LOOPING(lc); ++lc) {
> >                  Tst_count = 0;
> >                  for (testno = 0; testno < TST_TOTAL; ++testno) {
> > -                     TEST(result = syscall(286, "keyring", "wjkey",
> > NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
> > +                     TEST(result = syscall(__NR_add_key, "keyring",
> > "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
> >                       if(TEST_RETURN != -1) {
> >          		tst_resm(TPASS, "add_key call succeeded");
> >                          cleanup();
> > @@ -139,4 +139,3 @@
> >          }	
> >          tst_exit();
> >  }
> > -

Can you remove the result variable from the TEST() and make similar
changes to add_keys, set_tid_address, set_thread_area syscalls and
resubmit the patches.

 testcases/kernel/syscalls/add_key/add_key01.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/kernel/syscalls/add_key/add_key01.c
index 67a4c2f..56fbe1a 100644
--- a/testcases/kernel/syscalls/add_key/add_key01.c
+++ b/testcases/kernel/syscalls/add_key/add_key01.c
@@ -109,7 +109,6 @@ void setup() {
 }
 
 int main(int ac, char **av) {
-        int result;
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
 	
@@ -125,7 +124,7 @@ int main(int ac, char **av) {
         for (lc = 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {
-                     TEST(result = syscall(286, "keyring", "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
+                     TEST(syscall(__NR_add_key, "keyring", "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
                      if(TEST_RETURN != -1) {
         		tst_resm(TPASS, "add_key call succeeded");
                         cleanup();
			
			
			Kamalesh

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
