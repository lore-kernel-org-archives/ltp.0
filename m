Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <benoit.marcot@arm.com>) id 1V45Ma-0000L5-JX
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 08:33:00 +0000
Received: from service88.mimecast.com ([195.130.217.12])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V45MW-0007W5-Sx
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 08:33:00 +0000
From: Benoit Marcot <Benoit.Marcot@arm.com>
Date: Tue, 30 Jul 2013 09:32:49 +0100
Message-ID: <1C23526A7C42DB45BBF55B662C7C530E25B49F550D@BUNGLE.Emea.Arm.com>
References: <51F7338D.4060804@cn.fujitsu.com>
	<51F735B2.5030007@cn.fujitsu.com> <51F73E13.9040802@cn.fujitsu.com>
	<1C23526A7C42DB45BBF55B662C7C530E25B49F54B3@BUNGLE.Emea.Arm.com>
In-Reply-To: <1C23526A7C42DB45BBF55B662C7C530E25B49F54B3@BUNGLE.Emea.Arm.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mount/mount06.c: fix a compile error
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

In the other hand Dan's patch gives a hint about *why* it's failing to compile, which is nice.

> -----Original Message-----
> From: Benoit Marcot [mailto:Benoit.Marcot@arm.com]
> Sent: 30 July 2013 09:19
> To: DAN LI; gaowanlong@cn.fujitsu.com
> Cc: LTP list
> Subject: Re: [LTP] [PATCH] mount/mount06.c: fix a compile error
>
> Hi!
>
> I had the same problem to compile the latest commits; I patched in the same
> way as testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c:
>
> #ifndef MS_MOVE
> #define MS_MOVE         8192
> #endif
>
> Benoit
>
> > -----Original Message-----
> > From: DAN LI [mailto:li.dan@cn.fujitsu.com]
> > Sent: 30 July 2013 05:16
> > To: gaowanlong@cn.fujitsu.com
> > Cc: LTP list
> > Subject: Re: [LTP] [PATCH] mount/mount06.c: fix a compile error
> >
> > On 07/30/2013 11:40 AM, Wanlong Gao wrote:
> > > On 07/30/2013 11:31 AM, DAN LI wrote:
> > >>
> > >> The definitions of MS_PRIVATE and MS_MOVE were only added to glibc
> > >> headers in version 2.12.
> > >>
> > >> If the version of glibc is older than 2.12, define these two flags.
> > >>
> > >> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> > >> ---
> > >>  testcases/kernel/syscalls/mount/mount06.c |    5 +++++
> > >>  1 files changed, 5 insertions(+), 0 deletions(-)
> > >>
> > >> diff --git a/testcases/kernel/syscalls/mount/mount06.c
> > >> b/testcases/kernel/syscalls/mount/mount06.c
> > >> index acfb22d..ab1a472 100644
> > >> --- a/testcases/kernel/syscalls/mount/mount06.c
> > >> +++ b/testcases/kernel/syscalls/mount/mount06.c
> > >> @@ -31,6 +31,11 @@
> > >>  #include "usctest.h"
> > >>  #include "safe_macros.h"
> > >>
> > >> +#if !(__GLIBC_PREREQ(2, 12))
> > >
> > > Why not do like below?
> >
> > I think it also clearly shows the reason why this definition should
> > exist here(glibc version related).
> >
> > Regards,
> > DAN LI
> >
> > > #ifndef MS_MOVE
> > > #define xxx
> > > #define xxx
> > > #endif
> > >
> > > Wanlong Gao
> > >
> > >> +#define MS_MOVE   8192
> > >> +#define MS_PRIVATE        (1 << 18)
> > >> +#endif
> > >> +
> > >>  #define MNTPOINT_SRC      "mnt_src"
> > >>  #define MNTPOINT_DES      "mnt_des"
> > >>  #define LINELENGTH        256
> > >>
> > >
> > >
> >
> >
> >
> > ----------------------------------------------------------------------
> > -------- Get your SQL database under version control now!
> > Version control is standard for application code, but databases havent
> > caught up. So what steps can you take to put your SQL databases under
> > version control? Why should you start doing it? Read more to find out.
> > http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.c
> > lk
> > trk
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>
> -- IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended recipient,
> please notify the sender immediately and do not disclose the contents to any
> other person, use it for any purpose, or store or copy the information in any
> medium.  Thank you.
>
>
> ------------------------------------------------------------------------------
> Get your SQL database under version control now!
> Version control is standard for application code, but databases havent caught
> up. So what steps can you take to put your SQL databases under version
> control? Why should you start doing it? Read more to find out.
> http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clk
> trk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
