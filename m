Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TJmLp-0002M5-Pa
	for ltp-list@lists.sourceforge.net; Thu, 04 Oct 2012 14:24:33 +0000
Date: Thu, 4 Oct 2012 16:25:03 +0200
From: chrubis@suse.cz
Message-ID: <20121004142503.GB20568@saboteur.suse.cz>
References: <7fa9c1ccd34208d5b20d0438629639ab3ea70cae.1345032017.git.jstancek@redhat.com>
	<629a102c48a441d322209733b767a34ea207a191.1345032017.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <629a102c48a441d322209733b767a34ea207a191.1345032017.git.jstancek@redhat.com>
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
> Use readahead() syscall and check if subsequent
> read saves some I/O and if cache size increased.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/readahead/readahead02.c |  371 +++++++++++++++++++++
>  1 files changed, 371 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/readahead/readahead02.c

The same minor nits apply here as well.

(and don't forget about runtest entry)

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
