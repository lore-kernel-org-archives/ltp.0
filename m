From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 May 2016 17:01:55 +0200
Subject: [LTP] [PATCH v2] creat05: don't assume number of opened fds
In-Reply-To: <28627e5e1631723fccf734af32372e7fa4655ce7.1463496559.git.jstancek@redhat.com>
References: <28627e5e1631723fccf734af32372e7fa4655ce7.1463496559.git.jstancek@redhat.com>
Message-ID: <20160517150155.GH12051@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	if (last_fd <= 0)
> +	if (num_opened_fds == 0)
>  		return;

We can leave out this if now since the for would be no-op now.

> -	for (fd = first_fd + 1; fd <= last_fd; fd++) {
> -		if (close(fd))
> -			tst_res(TWARN | TERRNO, "close(%i) failed", fd);
> +	for (i = 0; i < num_opened_fds; i++) {
> +		if (close(opened_fds[i])) {
> +			tst_res(TWARN | TERRNO, "close(%i) failed",
> +				opened_fds[i]);
> +		}
>  	}

We may also free the allocated array here.

>  }

Otherwise it looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
