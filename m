Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U5F2d-0000lf-Vs
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 12:32:56 +0000
Date: Tue, 12 Feb 2013 13:33:23 +0100
From: chrubis@suse.cz
Message-ID: <20130212123323.GA9378@rei>
References: <cover.1360149841.git.jstancek@redhat.com>
	<ea4d5250ff8316fa655eac37e5279a2fb611f23a.1360149841.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea4d5250ff8316fa655eac37e5279a2fb611f23a.1360149841.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2 2/3] setns: add new syscall test setns01
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +#define NS_MAX 5
> +static int ns_types[NS_MAX];
> +static int ns_fds[NS_MAX];
> +static int ns_total;
> +
> +static int get_ns_fd(int pid, const char *ns)
> +{
> +	char tmp[PATH_MAX];
> +	struct stat st;
> +	int fd = -1;
> +
> +	sprintf(tmp, "/proc/%d/%s", pid, ns);
> +	if (stat(tmp, &st) == 0) {
> +		fd = open(tmp, O_RDONLY);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, NULL, "failed to open %s", tmp);
> +	} else {
> +		if (errno != ENOENT)
> +			tst_brkm(TBROK|TERRNO, NULL, "failed to stat %s", tmp);
> +	}
> +	return fd;
> +}
> +
> +static void init_available_ns()

Missing void in the function parameters.

> +{
> +#define INIT_NS_TYPE(clone_type, proc_name) \
> +{ \
> +	int fd; \
> +	fd = get_ns_fd(getpid(), "ns/"proc_name); \
> +	if (fd != -1) { \
> +		ns_types[ns_total] = clone_type; \
> +		ns_fds[ns_total] = fd; \
> +		tst_resm(TINFO, "ns_fds[%d]=%d, ns_types[%d]=0x%x", ns_total, \
> +			fd, ns_total, clone_type); \
> +		ns_total++; \
> +	} \
> +}

I'm wondering why this is a macro and not regular function. The only
thing that I see and that wouldn't work is the string
concatenation, which should have been done before the function is
called. Or the get_ns_fd() could have additional parameter, since it
uses sprintf() anyway.

> +#if defined(CLONE_NEWIPC)
> +	INIT_NS_TYPE(CLONE_NEWIPC, "ipc");
> +#endif
> +#if defined(CLONE_NEWNS)
> +	INIT_NS_TYPE(CLONE_NEWNS, "mnt");
> +#endif
> +#if defined(CLONE_NEWNET)
> +	INIT_NS_TYPE(CLONE_NEWNET, "net");
> +#endif
> +#if defined(CLONE_NEWPID)
> +	INIT_NS_TYPE(CLONE_NEWPID, "pid");
> +#endif
> +#if defined(CLONE_NEWUTS)
> +	INIT_NS_TYPE(CLONE_NEWUTS, "uts");
> +#endif
> +
> +#undef INIT_NS_TYPE
> +}
> +
> +static void close_ns_fds()

Here missing void as well.

> +{
> +	int i;
> +
> +	for (i = 0; i < ns_total; i++)
> +		if (ns_fds[i] != -1)
> +			close(ns_fds[i]);
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
