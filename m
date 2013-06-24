Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ur8tA-0003sW-AL
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:41:08 +0000
Date: Mon, 24 Jun 2013 17:42:32 +0200
From: chrubis@suse.cz
Message-ID: <20130624154231.GA2808@rei>
References: <51C7FD6D.4010904@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51C7FD6D.4010904@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] mmap/mmap13.c: new case to test SIGBUS error
 of mmap
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> Test SIGBUS error by accessing to a portion of the buffer that does not
> correspond to the file.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  runtest/syscalls                        |   1 +
>  testcases/kernel/syscalls/mmap/mmap13.c | 152 ++++++++++++++++++++++++++++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mmap/mmap13.c

...

> +
> +		addr = mmap(0, page_sz * 2, PROT_READ | PROT_WRITE,
> +			    MAP_FILE | MAP_SHARED, fildes, 0);

The first parameter should really have been NULL, pushed with that
change, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
