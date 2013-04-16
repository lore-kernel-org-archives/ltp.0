Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1US3vl-0005s1-1x
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 11:20:09 +0000
Date: Tue, 16 Apr 2013 13:20:56 +0200
From: chrubis@suse.cz
Message-ID: <20130416112055.GA17493@rei>
References: <shuang.qiu@oracle.com>
	<1366099791-14020-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1366099791-14020-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH] Replace "-E" option for sed.
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
To: shuang.qiu@oracle.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> The '-E' option is obsoleted and is no longer supported by sed in most
> Linux distributions.  Use '-r' instead.
> ---
>  .../kernel/syscalls/utimensat/utimensat_tests.sh   |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> index 6776087..b8eba51 100755
> --- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> +++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> @@ -260,7 +260,7 @@ fi
>  pattern="[[:space:]]*Defaults[[:space:]]*requiretty.*"
>  if grep -q "^${pattern}" $sudoers; then
>  	tst_resm TINFO "Comment requiretty in $sudoers for automated testing systems"
> -	if ! sed -E -i.$$ -e "s/^($pattern)/#\1/" $sudoers; then
> +	if ! sed -r -i.$$ -e "s/^($pattern)/#\1/" $sudoers; then
>  		tst_resm TBROK "failed to mangle $sudoers properly"
>  		exit 1
>  	fi

Strangely enough both -E and -r were working on all my testing machines
but SLES9. Looking at bussybox documentation only -r is supported for
sed applet.

Commited, thanks.

(Please add Signed-off-by: line next time.)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
