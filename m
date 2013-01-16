Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1TvSqW-0003gQ-6R
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 13:16:00 +0000
Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TvSqV-0002oX-Dj
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 13:16:00 +0000
Received: by mail-qc0-f175.google.com with SMTP id j3so851355qcs.6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Jan 2013 05:15:54 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 16 Jan 2013 14:15:53 +0100
Message-ID: <CA+icZUUsDzP+uLWD0i=JpMSiK1Qu3Pdux19rE7wTeJJu+-FaZw@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [LTP]  Spelling "succeded" VS. "succeeded"
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

this is my first email to the LTP ML, so I am new and anot not
familiar with known or unknown conventions here.

I am using LTP, to be honest the "lite" test to check my Linux
(upstream) and Linux-Next kernels.
So, having run "runltplite.sh" successfully gives me a 1st impression
or orientation this kernel has no bigger issues.

To be honest I have checked with a minimal kernel-setup (a
localmodconfig-ed setup with some debugging enabled).

While looking trough the results especially searching for some
pattern, I noticed the different spelling of the word "succeeded" VS.
"succeded".
The spell-checker integrated in Firefox v18.0 tells me "succeeded"
with double-e is correct.

[ SUCCEDED - one "E" ]

$ egrep -i 'error|fail'
runltplite-results_3.8.0-rc3-next20130116-2-iniza-generic.txt | egrep
-i succeded
flock01     1  TPASS  :  flock() succeded with Shared Lock, returned
error number=0
flock01     2  TPASS  :  flock() succeded with Unlock, returned error number=0
flock01     3  TPASS  :  flock() succeded with Exclusive Lock,
returned error number=0

[ SUCCEEDED - double "E" ]

$ egrep -i 'error|fail'
runltplite-results_3.8.0-rc3-next20130116-2-iniza-generic.txt | egrep
-i succeeded
madvise02    5  TFAIL  :  madvise succeeded unexpectedly
open call succeededopen failed with EACCES as expectedopen call
succeeded<<<execution_status>>>

AFAICS flock01.c needs to be corrected:

--- ltp-full-20120903.orig/testcases/kernel/syscalls/flock/flock01.c
 2012-09-03 06:39:27.000000000 +0200
+++ ltp-full-20120903/testcases/kernel/syscalls/flock/flock01.c
2013-01-16 14:12:36.597859952 +0100
@@ -128,7 +128,7 @@ int main(int argc, char **argv)
                                continue;       /*next loop for MTKERNEL  */
                        } else {
                                tst_resm(TPASS,
-                                        "flock() succeded with %s,
returned error number=%d",
+                                        "flock() succeeded with %s,
returned error number=%d",
                                         test_cases[i].opt, TEST_ERRNO);
                        }

Not sure if you like that patch sent via git-email as a separate patch?

Thanks!

Kind regards,
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
