Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MYoOH-00066y-Sm
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 21:51:21 +0000
Received: from qw-out-1920.google.com ([74.125.92.145])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYoO6-0002Pk-DC
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 21:51:16 +0000
Received: by qw-out-1920.google.com with SMTP id 5so168559qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 05 Aug 2009 14:51:04 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 5 Aug 2009 14:51:04 -0700
Message-ID: <364299f40908051451h20e9a265m1b9edc19a67b2ceb@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] waitid(2) broken on 2.6.29?
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
To: LTP list <ltp-list@lists.sourceforge.net>

Sorry -- I know this isn't a linux support list but I was wondering
whether or not anyone else could stimulate this error on x64:

gcooper@orangebox ~ $ gcc -D_GNU_SOURCE -Wall -o foo foo.c
gcooper@orangebox ~ $ ./foo
strerror: Invalid argument
gcooper@orangebox ~ $ cat foo.c
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>

int
main (void)
{
        siginfo_t infop;
        errno = 0;
        pid_t id = fork();
        if (0 <= id) {
                if (! id) {
                        exit (0);
                }
        } else {
                perror("fork()");
        }
        /*printf("errno: %d\n", errno);*/
        waitid(P_ALL, 0, &infop, WNOHANG);
        /*printf("errno: %d\n", errno);*/
        if (errno) {
                printf("strerror: %s\n", strerror(errno));
        }
        return 0;
}
gcooper@orangebox ~ $ uname -a
Linux orangebox 2.6.29-gentoo-r5 #2 SMP PREEMPT Sun Jun 14 01:11:32
PDT 2009 x86_64 Intel(R) Core(TM)2 Quad CPU Q9400 @ 2.66GHz
GenuineIntel GNU/Linux

For whatever reason it doesn't seem to function, even in a simple test
program, and it wasn't functioning before in waitid02, so I'm trying
to determine whether or not this is a valid issue.

IIRC we saw similar issues on 2.6.24 with PPC on mips n32 with cavium
boards, so this might be a bit-width issue?

If someone can provide a counterargument for where waitid02 passes
(say x86) and it passes with my test app above, that would be helpful.

Thanks,
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
