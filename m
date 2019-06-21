From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 21 Jun 2019 06:13:52 -0400 (EDT)
Subject: [LTP] [PATCH] daemonlib.sh: call tty before executing service
In-Reply-To: <1561110806-2734-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1561110806-2734-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1766730430.29482900.1561112032870.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On my machine, polkit-0.112-22.el7.x86_64 has contained the [1] patch.
> 
> This patch leads service acitons(such as restart) don't stop if it doesn't
> find controlling terminal. Even the service has been executed successfully.
> You can reproduce it with the following code:
> 
> test.sh
> ----------------------------------------------
> echo "restart daemon"
> systemctl restart rsyslog.service >/dev/null 2>&1
> echo "restart success"
> ----------------------------------------------
> ./test.sh &  (it doesn't stop)
> restart daemon
> 
> ps -auxf
> --------------------------------------------------
> .... pts/1    T      \_ /bin/bash ./test.sh
> .... pts/1    T        \_ systemctl restart rsyslog.service
> .... pts/1    Tl         \_ /usr/bin/pkttyagent --notify-fd 6
> -------------------------------------------------
> 
> /var/log/secure
> ------------------------------------------------
> polkitd[1310]: Registered Authentication Agent for unix-process:18472:252325
> (system bus name :1.105 [/usr/bin/pkttyagent --notify-fd 6 --fallback],
> object
> path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8)
> ------------------------------------------------
> 
> This change leads to syslog[1-10] testcase hang. I fix it by adding tty
> beforce
> service, so these cases don't hang.

Bug 1711536 - polkit-0.112-22.el7 breaks restarting services from background process
https://bugzilla.redhat.com/show_bug.cgi?id=1711536

Not sure though we should be adding workarounds for what seems like a bug.

Regards,
Jan

> 
> (pkttyagent: PolkitAgentTextListener leaves echo tty disabled if
> SIGINT/SIGTERM)
> [1]https://gitlab.freedesktop.org/polkit/polkit/commit/bfb722bbe5a503095cc7e860f282b142f5aa75f1
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  testcases/lib/daemonlib.sh | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/lib/daemonlib.sh b/testcases/lib/daemonlib.sh
> index 0de3f86af..5807cbea0 100644
> --- a/testcases/lib/daemonlib.sh
> +++ b/testcases/lib/daemonlib.sh
> @@ -47,43 +47,43 @@ fi
>  start_daemon()
>  {
>  	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
> -		systemctl start $1.service > /dev/null 2>&1
> +		tty | systemctl start $1.service > /dev/null 2>&1
>  	elif command -v service >/dev/null 2>&1; then
> -		service $1 start > /dev/null 2>&1
> +		tty | service $1 start > /dev/null 2>&1
>  	else
> -		/etc/init.d/$1 start > /dev/null 2>&1
> +		tty |/etc/init.d/$1 start > /dev/null 2>&1
>  	fi
>  }
>  
>  stop_daemon()
>  {
>  	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
> -		systemctl stop $1.service > /dev/null 2>&1
> +		tty | systemctl stop $1.service > /dev/null 2>&1
>  	elif command -v service >/dev/null 2>&1; then
> -		service $1 stop > /dev/null 2>&1
> +		tty | service $1 stop > /dev/null 2>&1
>  	else
> -		/etc/init.d/$1 stop > /dev/null 2>&1
> +		tty | /etc/init.d/$1 stop > /dev/null 2>&1
>  	fi
>  }
>  
>  status_daemon()
>  {
>  	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
> -		systemctl is-active $1.service > /dev/null 2>&1
> +		tty | systemctl is-active $1.service > /dev/null 2>&1
>  	elif command -v service >/dev/null 2>&1; then
> -		service $1 status > /dev/null 2>&1
> +		tty | service $1 status > /dev/null 2>&1
>  	else
> -		/etc/init.d/$1 status > /dev/null 2>&1
> +		tty | /etc/init.d/$1 status > /dev/null 2>&1
>  	fi
>  }
>  
>  restart_daemon()
>  {
>  	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
> -		systemctl restart $1.service > /dev/null 2>&1
> +		tty | systemctl restart $1.service > /dev/null 2>&1
>  	elif command -v service >/dev/null 2>&1; then
> -		service $1 restart > /dev/null 2>&1
> +		tty | service $1 restart > /dev/null 2>&1
>  	else
> -		/etc/init.d/$1 restart > /dev/null 2>&1
> +		tty | /etc/init.d/$1 restart > /dev/null 2>&1
>  	fi
>  }
> --
> 2.18.1
> 
> 
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
