Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkANw-0005Di-Lm
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 10:56:36 +0000
Date: Tue, 13 May 2014 12:55:31 +0200
From: chrubis@suse.cz
Message-ID: <20140513105531.GA11786@rei>
References: <1399973868-26408-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399973868-26408-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] docs: add a paragraph about access() to
 Common Problems section
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  doc/test-writing-guidelines.txt |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 91edbf0..aaf6b4a 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -883,6 +883,13 @@ settings which may clear some of the bits. If your test depends on specific
>  file permissions you need to 'chmod()' the file afterwards or use SAFE_TOUCH()
>  that does the 'chmod()' for you.
>  
> +3.2 access()
> +~~~~~~~~~~~
> +
> +If access(some_file, W_OK) is executed by root it will return success even
> +if the file has read-only permission. As a workaround you can use 'open()' to

Perhaps it would be more clear to say "even if the file doesn't have
write permission bits set." Because access() still returns zero if the
file is not writeable nor readable. And the same goes for R_OK for
privileged user.

The X_OK behaves a bit differently, there must be at least one
executable flag enabled in this case.

> +test sysfs file for write permission. It might not work for other filesystems,
> +but you have stat, lstat and fstat functions.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
