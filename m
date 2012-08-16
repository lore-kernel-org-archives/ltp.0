Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1T1qQ2-0001cR-UX
	for ltp-list@lists.sourceforge.net; Thu, 16 Aug 2012 03:06:46 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T1qQ2-0003aO-9y
	for ltp-list@lists.sourceforge.net; Thu, 16 Aug 2012 03:06:46 +0000
Received: by pbcwy7 with SMTP id wy7so876721pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Aug 2012 20:06:40 -0700 (PDT)
Message-ID: <502C63AC.5080001@casparzhang.com>
Date: Thu, 16 Aug 2012 11:06:20 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <7fa9c1ccd34208d5b20d0438629639ab3ea70cae.1345032017.git.jstancek@redhat.com>
	<629a102c48a441d322209733b767a34ea207a191.1345032017.git.jstancek@redhat.com>
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

On 08/15/2012 08:04 PM, Jan Stancek wrote:
>
> Use readahead() syscall and check if subsequent
> read saves some I/O and if cache size increased.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   testcases/kernel/syscalls/readahead/readahead02.c |  371 +++++++++++++++++++++
>   1 files changed, 371 insertions(+), 0 deletions(-)
>   create mode 100644 testcases/kernel/syscalls/readahead/readahead02.c
>

I'm thinking if we should write some common codes to fetch certain 
fields from /proc/meminfo and if we should move read/write 
/sys/kernel/vm files to libkerntest... We do have some duplicated 
functions in mm tests.

Caspar



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
