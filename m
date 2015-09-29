From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Sep 2015 18:45:30 +0200
Subject: [LTP] [PATCH] ftp/ftp02: The case needs to check vsftpd first
In-Reply-To: <1442365546-63246-1-git-send-email-cuibixuan@huawei.com>
References: <1442365546-63246-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <20150929164530.GA32482@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  testcases/network/tcp_cmds/ftp/ftp02 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/ftp/ftp02 b/testcases/network/tcp_cmds/ftp/ftp02
> index 92e7944..6b84f22 100755
> --- a/testcases/network/tcp_cmds/ftp/ftp02
> +++ b/testcases/network/tcp_cmds/ftp/ftp02
> @@ -38,7 +38,7 @@
>  
>  setup()
>  {
> -	tst_check_cmds expect ftp useradd userdel
> +	tst_check_cmds expect ftp useradd userdel vsftpd
>  	export TEST_USER="ftpuser2"

I see that rest of the ftp testcases that uses vsftpd has it in
tst_check_cmds. However it would be cleaner to add this check to the top
of the ftp_setup file so that it's called at the moment the file is
sourced and remove it from the individual testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
