Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T2H3b-0007nW-6a
	for ltp-list@lists.sourceforge.net; Fri, 17 Aug 2012 07:33:23 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T2H3Z-0006r0-OP
	for ltp-list@lists.sourceforge.net; Fri, 17 Aug 2012 07:33:23 +0000
Date: Fri, 17 Aug 2012 03:33:11 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2042336520.6477173.1345188791970.JavaMail.root@redhat.com>
In-Reply-To: <502C63AC.5080001@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] new syscall test: readahead02
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, 16 August, 2012 5:06:20 AM
> Subject: Re: [LTP] [PATCH 2/2] new syscall test: readahead02
> 
> On 08/15/2012 08:04 PM, Jan Stancek wrote:
> >
> > Use readahead() syscall and check if subsequent
> > read saves some I/O and if cache size increased.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >   testcases/kernel/syscalls/readahead/readahead02.c |  371
> >   +++++++++++++++++++++
> >   1 files changed, 371 insertions(+), 0 deletions(-)
> >   create mode 100644
> >   testcases/kernel/syscalls/readahead/readahead02.c
> >
> 
> I'm thinking if we should write some common codes to fetch certain
> fields from /proc/meminfo and if we should move read/write
> /sys/kernel/vm files to libkerntest... We do have some duplicated
> functions in mm tests.

Sounds reasonable, I also noticed seeing (and using) some snippets
over and over again.

Regards,
Jan

> 
> Caspar
> 
> 
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
