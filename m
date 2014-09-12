Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XSQRx-0007We-VX
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 12:59:41 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XSQRv-0007Ig-8O
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 12:59:41 +0000
Date: Fri, 12 Sep 2014 08:59:32 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1194817182.22301656.1410526772686.JavaMail.zimbra@redhat.com>
In-Reply-To: <5411BB3A.70308@redhat.com>
References: <1409047170-18251-1-git-send-email-mmarhefk@redhat.com>
	<1409319967-12730-1-git-send-email-mmarhefk@redhat.com>
	<1803448098.18473481.1409840011670.JavaMail.zimbra@redhat.com>
	<5411BB3A.70308@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2 v2] containers: added mountns/mountns03.c
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Jiri Jaburek" <jjaburek@redhat.com>
> To: "Matus Marhefka" <mmarhefk@redhat.com>
> Cc: ltp-list@lists.sourceforge.net, "Jan Stancek" <jstancek@redhat.com>
> Sent: Thursday, 11 September, 2014 5:09:46 PM
> Subject: Re: [LTP] [PATCH 1/2 v2] containers: added mountns/mountns03.c

> >> +++ b/testcases/kernel/containers/mountns/mountns03.c
> >> @@ -0,0 +1,245 @@
> >> +/* Copyright (c) 2014 Red Hat, Inc.
> >> + *
> >> + * This program is free software: you can redistribute it and/or modify
> >> + * it under the terms of version 2 the GNU General Public License as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >> + ***********************************************************************
> >> + * File: mountns03.c
> >> + *
> >> + * Tests a slave mount: slave mount is like a shared mount except that
> >> + * mount and umount events only propagate towards it.
> >> + * Description:
> >> + * 1. Creates directories "A", "B", "C", "D" and files "A/A", "B/B"
> >> + *    "C/C", "D/D"
> >> + * 2. Unshares mount namespace and makes it private (so mounts/umounts
> >> + *    have no effect on a real system)
> > 
> > Hi,
> > 
> >> + * 3. Bind mounts directory "A" to "A" and "B" to "B"
> > 
> > is the "B" to "B" part necessary in this case? First thing child does is
> > it mounts A to B.
> > 
> >> + * 4. Makes both directories ("A" and "B") shared
> > 
> > related to above, is it necessary to make B shared?
> 
> The obvious answer would be "yes", because ...

(atm. replying to this part only)

If you don't make B shared in parent, doesn't a bind operation in child make
it shared regardless? You are bind mounting a shared mount to non-shared one.

   ---------------------------------------------------------------------------
   |         BIND MOUNT OPERATION                                            |
   |**************************************************************************
   |source(A)->| shared       |       private  |       slave    | unbindable |
   | dest(B)  |               |                |                |            |
   |   |      |               |                |                |            |
   |   v      |               |                |                |            |
   |**************************************************************************
   |  shared  | shared        |     shared     | shared & slave |  invalid   |
   |          |               |                |                |            |
   |non-shared| shared        |      private   |      slave     |  invalid   |
   ***************************************************************************

I modified the mountns03 testcase, so it doesn't bind and make B shared,
consider following strace output:

unshare(CLONE_NEWNS)                    = 0
mount("none", "/", "none", MS_REC|MS_PRIVATE, NULL) = 0
mount("A", "A", 0x407ab0, MS_BIND, NULL) = 0  --> bind mounts directory "A" to "A"
mount("none", "A", "none", MS_SHARED, NULL) = 0  --> make "A" shared
access("A/C", F_OK)                     = -1 ENOENT (No such file or directory)  --> there's no C file in "A"
clone(child_stack=0x2597030, flags=CLONE_NEWNS|SIGCHLD) = 2396
read(3, Process 2396 attached
 <unfinished ...>
[pid  2396] getpid()                    = 2396
[pid  2396] mount("A", "B", 0x407ab0, MS_BIND, NULL) = 0  --> bind shared mount "A" to "B"
[pid  2396] mount("C", "B", 0x407ab0, MS_BIND, NULL) = 0  --> bind mount "C" to "B"
[pid  2396] write(4, "0", 1 <unfinished ...>
[pid  2394] <... read resumed> "0", 1)  = 1
[pid  2394] access("A/C", F_OK)         = 0  --> parent can see file "C" in "A"

Regards,
Jan

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
