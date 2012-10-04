Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TJjfv-0005oK-4M
	for ltp-list@lists.sourceforge.net; Thu, 04 Oct 2012 11:33:07 +0000
Date: Thu, 4 Oct 2012 13:33:34 +0200
From: chrubis@suse.cz
Message-ID: <20121004113334.GA16892@saboteur.suse.cz>
References: <502C63AC.5080001@casparzhang.com>
	<2042336520.6477173.1345188791970.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2042336520.6477173.1345188791970.JavaMail.root@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > Use readahead() syscall and check if subsequent
> > > read saves some I/O and if cache size increased.
> > >
> > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > > ---
> > >   testcases/kernel/syscalls/readahead/readahead02.c |  371
> > >   +++++++++++++++++++++
> > >   1 files changed, 371 insertions(+), 0 deletions(-)
> > >   create mode 100644
> > >   testcases/kernel/syscalls/readahead/readahead02.c
> > >
> > 
> > I'm thinking if we should write some common codes to fetch certain
> > fields from /proc/meminfo and if we should move read/write
> > /sys/kernel/vm files to libkerntest... We do have some duplicated
> > functions in mm tests.
> 
> Sounds reasonable, I also noticed seeing (and using) some snippets
> over and over again.

I'm plannig (for some time) to write scanf and printf like functions to
do exactly that, just haven't had time to write them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
