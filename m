Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WjqHn-0006k0-JE
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 13:28:55 +0000
Date: Mon, 12 May 2014 15:27:54 +0200
From: chrubis@suse.cz
Message-ID: <20140512132754.GC4741@rei>
References: <1399874087-15967-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399874087-15967-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib/tst_mkfs.c: fix -f option for mkfs.btrfs
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> In the earlier version of btrfs-progs, mkfs.btrfs doesn't
> support -f option. So it should be judged in advance before
> the command is called.

What system is this? What version of btrfs-progs?
(ideally these details should be included in the commit message)

> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  lib/tst_mkfs.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 7357cd9..92b4b54 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -35,11 +35,19 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>  	 * superblock on the device, which is the case here as we
>  	 * reuse one device for all tests.
>  	 */
> -	if (!strcmp(fs_type, "xfs") || !strcmp(fs_type, "btrfs")) {
> +	if (!strcmp(fs_type, "xfs")) {
>  		tst_resm(TINFO, "Appending '-f' flag to mkfs.%s", fs_type);
>  		argv[pos++] = "-f";
>  	}
>  
> +	if (!strcmp(fs_type, "btrfs")) {
> +		if (system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null") == 0) {


The system() and grep is a bit of a hack but I cannot find a better way
how to do this.

> +			tst_resm(TINFO, "Appending '-f' flag to mkfs.%s",
> +				fs_type);
> +			argv[pos++] = "-f";
> +		}
> +	}
> +
>  	if (fs_opts) {
>  		for (i = 0; fs_opts[i]; i++) {
>  			argv[pos++] = fs_opts[i];

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
