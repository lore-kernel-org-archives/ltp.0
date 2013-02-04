Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1U2ETE-00051y-35
	for ltp-list@lists.sourceforge.net; Mon, 04 Feb 2013 05:19:56 +0000
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1U2ETA-0000RD-8d
	for ltp-list@lists.sourceforge.net; Mon, 04 Feb 2013 05:19:56 +0000
Received: by mail-ie0-f171.google.com with SMTP id 10so5286580ied.16
	for <ltp-list@lists.sourceforge.net>;
	Sun, 03 Feb 2013 21:19:47 -0800 (PST)
Message-ID: <510F3F46.2010205@casparzhang.com>
Date: Mon, 04 Feb 2013 12:55:34 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <510F160D.9080503@cn.fujitsu.com>
	<1359948132-26248-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1359948132-26248-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH v2] syscalls/open11: new open(2) test case
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 02/04/2013 11:22 AM, Eryu Guan wrote:
>
> In addition to existing open(2) tests, add more basic tests and make
> sure open(2) works and handles error conditions correctly.
>
> There are 28 test cases:
> 1. Open regular file O_RDONLY
> 2. Open regular file O_WRONLY
> 3. Open regular file O_RDWR
> 4. Open regular file O_RDWR | O_SYNC
> 5. Open regular file O_RDWR | O_TRUNC
> 6. Open dir O_RDONLY
> 7. Open dir O_RDWR, expect EISDIR
> 8. Open regular file O_DIRECTORY, expect ENOTDIR
> 9. Open hard link file O_RDONLY
> 10. Open hard link file O_WRONLY
> 11. Open hard link file O_RDWR
> 12. Open sym link file O_RDONLY
> 13. Open sym link file O_WRONLY
> 14. Open sym link file O_RDWR
> 15. Open sym link dir O_RDONLY
> 16. Open sym link dir O_WRONLY, expect EISDIR
> 17. Open sym link dir O_RDWR, expect EISDIR
> 18. Open device special file O_RDONLY
> 19. Open device special file O_WRONLY
> 20. Open device special file O_RDWR
> 21. Open non-existing regular file in existing dir
> 22. Open link file O_RDONLY | O_CREAT
> 23. Open symlink file O_RDONLY | O_CREAT
> 24. Open regular file O_RDONLY | O_CREAT
> 25. Open symlink dir O_RDONLY | O_CREAT, expect EISDIR
> 26. Open dir O_RDONLY | O_CREAT, expect EISDIR
> 27. Open regular file O_RDONLY | O_TRUNC, behaviour is undefined but
>      should not oops or hang
> 28. Open regular file(non-empty) O_RDONLY | O_TRUNC, behaviour is
>      undefined but should not oops or hang
>
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> v2:
> 	Remove duplicated open device special test
>
>   runtest/ltplite                         |   1 +
>   runtest/stress.part3                    |   1 +
>   runtest/syscalls                        |   1 +
>   testcases/kernel/syscalls/open/open11.c | 424 ++++++++++++++++++++++++++++++++
>   4 files changed, 427 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/open/open11.c

Looks good to me.

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
