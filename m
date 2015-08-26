Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZUcH4-0005j6-8O
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2015 15:06:02 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZUcH2-00081f-2l
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2015 15:06:02 +0000
Date: Wed, 26 Aug 2015 17:05:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150826150521.GA19278@rei.suse.de>
References: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
	<1439899089-7601-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439899089-7601-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v3] added helper tools for creating and
 working with namespaces
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static int open_ns_fd(const char *pid, const char *ns)
> +{
> +	int fd;
> +	char file_buf[30];
> +
> +	sprintf(file_buf, "%s/%s/ns/%s", PROC_PATH, pid, ns);
> +
> +	fd = open(file_buf, O_RDONLY);
> +	if (fd > 0) {
> +		ns_fd[ns_fd_index] = fd;
> +		++ns_fd_index;
> +		return 0;
> +	} else if (fd == -1 && errno != ENOENT) {
> +		tst_resm(TINFO | TERRNO, "open");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void close_ns_fd(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ns_fd_index; i++)
> +		close(ns_fd[i]);
> +}
> +
> +static int child_fn(void *arg)
> +{
> +	char **args = (char **)arg;
> +
> +	execvp(args[2], args+2);
> +	tst_resm(TINFO | TERRNO, "execvp");
> +	return 1;
> +}
> +
> +/*
> + * ./ns_exec <NS_PID> <PROGRAM> [ARGS]
> + */
> +int main(int argc, char *argv[])
> +{
> +	int i, rv, pid;
> +
> +	rv = syscall(__NR_setns, -1, 0);
> +	if (rv == -1 && errno == ENOSYS) {
> +		tst_resm(TINFO, "setns is not supported in the kernel");
> +		return 1;
> +	}
> +
> +	if (argc < 3) {
> +		tst_resm(TINFO, "%s <NS_PID> <PROGRAM> [ARGS]\n", argv[0]);
> +		return 1;
> +	}
> +
> +	rv = 0;
> +	memset(ns_fd, 0, sizeof(ns_fd));
> +	rv |= open_ns_fd(argv[1], "ipc");
> +	rv |= open_ns_fd(argv[1], "mnt");
> +	rv |= open_ns_fd(argv[1], "net");
> +	rv |= open_ns_fd(argv[1], "pid");
> +	rv |= open_ns_fd(argv[1], "user");
> +	rv |= open_ns_fd(argv[1], "uts");
> +	if (rv != 0)
> +		return 1;
> +
> +	if (ns_fd_index == 0) {
> +		tst_resm(TINFO, "no namespace entries in /proc/%s/ns/",
> +			 argv[1]);
> +		close_ns_fd();
> +		return 1;
> +	}
> +
> +	for (i = 0; i < ns_fd_index; i++) {
> +		if (syscall(__NR_setns, ns_fd[i], 0) == -1) {
> +			tst_resm(TINFO | TERRNO, "setns");
> +			close_ns_fd();

On SLES12 (kernel 3.12.28) setns() fails for the fd opened from "user"
namespace. I'm getting EINVAL here. Everything seems to work fine if I
comment the rf |= open_ns_fd(argv[1], "user"); line above.

Unfortunately EINVAL seems to be catch-all error for setns(), any idea
what is wrong here?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
