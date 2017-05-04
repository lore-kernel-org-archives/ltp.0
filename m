From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 4 May 2017 14:59:00 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] syslog-lib.sh: Produce TCONF instead of
 TBROK	for journald
In-Reply-To: <20170502181749.16375-1-chrubis@suse.cz>
References: <20170502181749.16375-1-chrubis@suse.cz>
Message-ID: <240867630.7382524.1493924340310.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> If there is no traditional syslog daemon installed these testcaess exit
> with TBROK which is not correct since these tests are simply not
> applicable if no syslog daemon is installed.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/syslog/syslog-lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> index e166d3a45..35c13daf7 100755
> --- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> +++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> @@ -86,8 +86,8 @@ EOF
>  )
>  		fi
>  	else
> -		tst_resm TBROK "Couldn't find syslogd, syslog-ng or rsyslogd"
> -		cleanup 1
> +		tst_resm TCONF "Couldn't find syslogd, syslog-ng or rsyslogd"
> +		cleanup 32
>  	fi
>  
>  	# Back up configuration file
> --
> 2.12.2

ACK

Regards,
Jan
