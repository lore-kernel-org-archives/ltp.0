Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WYH5X-0002WP-VE
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 15:40:27 +0000
Date: Thu, 10 Apr 2014 17:39:41 +0200
From: chrubis@suse.cz
Message-ID: <20140410153941.GA25778@rei>
References: <1395845334-8976-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395845334-8976-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v7] network: tcp_fastopen: add TCP Fast Open test
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
> +static int sock_recv_poll(int fd, char *buf, int buf_size, int *offset)
> +{
> +	struct pollfd pfd;
> +	pfd.fd = fd;
> +	pfd.events = POLLIN;
> +	int len = -1;
> +	while (1) {
> +		errno = 0;
> +		int ret = poll(&pfd, 1, wait_timeout / 1000);
> +		if (ret == -1) {
> +			if (errno == EINTR)
> +				continue;
> +			break;
> +		}
> +
> +		if (ret == 0) {
> +			errno = ETIME;
> +			break;
> +		}
> +
> +		if (ret != 1 || !(pfd.revents & POLLIN))
> +			break;
> +
> +		errno = 0;
> +		len = recv(fd, buf + *offset,
> +			buf_size - *offset, MSG_DONTWAIT);
> +
> +		if (len == -1 && errno == EINTR)
> +			continue;
> +		else
> +			break;
> +	}
> +
> +	return len;
> +}

You pass the offset as a pointer but do not modify the value. Forgot to
change it when the code around changed?

...

> +static void check_opt(const char *name, char *arg, int *val, int lim)
> +{
> +	if (arg) {
> +		if (sscanf(arg, "%i", val) != 1)
> +			tst_brkm(TBROK, NULL, "-%s option arg is not a number",
> +				 name);
> +		if (clients_num < lim)
                    ^
		    *val
> +			tst_brkm(TBROK, NULL, "-%s option arg is less than %d",
> +				name, lim);
> +	}
> +}
> +
> +static void check_opt_l(const char *name, char *arg, long *val, long lim)
> +{
> +	if (arg) {
> +		if (sscanf(arg, "%ld", val) != 1)
> +			tst_brkm(TBROK, NULL, "-%s option arg is not a number",
> +				 name);
> +		if (clients_num < lim)
                    ^
		    *val
> +			tst_brkm(TBROK, NULL, "-%s option arg is less than %ld",
> +				name, lim);
> +	}
> +}
> +

The rest looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
