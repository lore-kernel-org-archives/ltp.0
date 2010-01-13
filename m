Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1NV82g-0002ar-Pr
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 18:34:06 +0000
Received: from maroilles.sis.pasteur.fr ([157.99.64.223]
	helo=mail-interne3.pasteur.fr)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NV82d-0008LP-Bl
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 18:34:06 +0000
Date: Wed, 13 Jan 2010 19:33:44 +0100
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20100113183344.GA361348@medusa.sis.pasteur.fr>
References: <4B46D5F0.3090801@teldevice.co.jp>
	<20100108112534.GA333981@medusa.sis.pasteur.fr>
	<4B471F8D.7010907@teldevice.co.jp>
	<1263392362.5591.27.camel@subratamodak.linux.ibm.com>
	<364299f41001130952o6a57acd1m1544399fab0cb7f1@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41001130952o6a57acd1m1544399fab0cb7f1@mail.gmail.com>
Subject: Re: [LTP] LTP installation configure Error
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>

On Wed, Jan 13, 2010 at 09:52:37AM -0800, Garrett Cooper wrote:
[...]
> > Please see this patch and kindly make changes accordingly.
> 
> I don't know what you want to do about the compiler optimization bug,
> but I made the AC_MSG_WARN AC_MSG_ERROR on purpose because I _wanted_
> to catch cases that the autoconf test didn't cover so the test itself
> could be improved. Would you please:
> 
> 1. Provide your config.log.

Here follow the relevant parts.

njoly@lanfeust [linux:ltp] $ ./configure 
[...]
checking numaif.h usability... no
checking numaif.h presence... no
checking for numaif.h... no
configure: error: Couldn't find functional copy of quota v2 - are you running 2.4.x?

config.log:

configure:8448: gcc -c -g -O2  conftest.c >&5
conftest.c: In function `main':
conftest.c:51: error: `Q_GETINFO' undeclared (first use in this function)
conftest.c:51: error: (Each undeclared identifier is reported only once
conftest.c:51: error: for each function it appears in.)
configure:8455: $? = 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "ltp"
| #define PACKAGE_TARNAME "ltp"
[...]
| #define HAVE_ASM_LDT_H 1
| #define HAVE_STRUCT_USER_DESC 1
| /* end confdefs.h.  */
| 
| #define _LINUX_QUOTA_VERSION 2
| #include <sys/types.h>
| #include <sys/quota.h>
| #include <unistd.h>
| int
| main ()
| {
| 
| int main(void) {
|       struct dqblk dq;
|       return quotactl(Q_GETINFO, (const char *) "/dev/null", geteuid(),
|                       (caddr_t) &dq);
| }
|   ;
|   return 0;
| }
configure:8465: error: Couldn't find functional copy of quota v2 - are you running 2.4.x ?

> 2. Do `man 2 quotactl' and provide a description of what the function
> #include requirements are?

QUOTACTL(2)                Linux Programmer's Manual               QUOTACTL(2)

NAME
       quotactl - manipulate disk quota

SYNOPSIS
       #include <sys/types.h>
       #include <sys/quota.h>

       int quotactl(int cmd, const char *special, int id, caddr_t addr);

       #include <linux/unistd.h>

       #include <errno.h>

       _syscall4(int,  quotactl,  int,  cmd,  const char *, special , int, id,
       caddr_t, addr)


-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
