From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 May 2016 14:53:50 +0200
Subject: [LTP] [PATCH] ppoll01: rewrite in new API
In-Reply-To: <d7a24122b97ae88bdeb9d864240137494d52ee0c.1464077434.git.jstancek@redhat.com>
References: <d7a24122b97ae88bdeb9d864240137494d52ee0c.1464077434.git.jstancek@redhat.com>
Message-ID: <20160524125349.GE10029@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void setup(void)
> +{
> +	int fd2;
> +
> +	SAFE_SIGNAL(SIGINT, sighandler);
> +
> +	if (sigemptyset(&sigmask_empty) == -1)
> +		tst_brk(TBROK | TERRNO, "sigemptyset");
> +	if (sigemptyset(&sigmask_sigint) == -1)
> +		tst_brk(TBROK | TERRNO, "sigemptyset");
> +	if (sigaddset(&sigmask_sigint, SIGINT) == -1)
> +		tst_brk(TBROK | TERRNO, "sigaddset");
> +
> +	fd1 = SAFE_OPEN("testfile1", O_CREAT | O_EXCL | O_RDWR,
> +		S_IRUSR | S_IWUSR);
> +	fds_good[0].fd = fd1;
> +	fds_good[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
> +	fds_good[0].revents = 0;
> +
> +	fd2 = SAFE_OPEN("testfile2", O_CREAT | O_EXCL | O_RDWR,
> +		S_IRUSR | S_IWUSR);
> +	fds_already_closed[0].fd = fd2;
> +	fds_already_closed[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
> +	fds_already_closed[0].revents = 0;
> +	SAFE_CLOSE(fd2);
> +	SAFE_UNLINK("testfile2");

There is also no need to unlink the testfile here.

> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_CLOSE(fd1);
> +	SAFE_UNLINK("testfile1");

And here, since tst_rmdir() will take care of that.

-- 
Cyril Hrubis
chrubis@suse.cz
