Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ur9Wo-0003Hb-8g
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 16:22:06 +0000
Date: Mon, 24 Jun 2013 18:23:28 +0200
From: chrubis@suse.cz
Message-ID: <20130624162328.GC3492@rei>
References: <1372066195-18166-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372066195-18166-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] syscalls/swapon: fix for variable page size
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  testcases/kernel/syscalls/swapon/swapon01.c |   19 +++++-
>  testcases/kernel/syscalls/swapon/swapon02.c |   84 ++++++++++++---------------
>  testcases/kernel/syscalls/swapon/swapon03.c |   17 +-----
>  3 files changed, 55 insertions(+), 65 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
> index 11a49f9..05f1579 100644
> --- a/testcases/kernel/syscalls/swapon/swapon01.c
> +++ b/testcases/kernel/syscalls/swapon/swapon01.c
> @@ -132,6 +132,10 @@ int main(int ac, char **av)
>  /* setup() - performs all ONE TIME setup for this test */
>  void setup()
>  {
> +	char cmd_buffer[256];
> +
> +	long bs = sysconf(_SC_PAGESIZE);
> +	int count = 10;
>  
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
> @@ -154,15 +158,22 @@ void setup()
>  			 "Cannot do swapon on a file located on a nfs filesystem");
>  	}
>  
> -	if (!tst_cwd_has_free(65536)) {
> +	if (!tst_cwd_has_free(bs*count)) {
>  		tst_brkm(TBROK, cleanup,
>  			 "Insufficient disk space to create swap file");
>  	}
>  
>  	/*create file */
> -	if (system("dd if=/dev/zero of=swapfile01 bs=1024 count=65536 >"
> -		   " tmpfile 2>&1") != 0) {
> -		tst_brkm(TBROK, cleanup, "Failed to create file for swap");
> +	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
> +			"dd if=/dev/zero of=swapfile01 bs=%li "
> +			"count=%i > /tmp/file 2>&1", bs, count) < 0) {
> +		tst_brkm(TBROK, cleanup, 
> +			"sprintf() failed to create command string");
> +	}
> +
> +	if (system(cmd_buffer) != 0) {
> +		tst_brkm(TBROK, cleanup, "dd command failed to create file via "
> +			"command: %s", cmd_buffer);

This part of the code seems to be repeated several times. What about
making it into library code in lib/tst_fill_file.c instead?

Something like:

tst_fill_file(const char *path, char pattern, size_t bs, size_t count);

And I would open the and write the file directly rather than doing
system("dd ...");

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
