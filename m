Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U5FAm-0002pv-Vt
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 12:41:21 +0000
Date: Tue, 12 Feb 2013 13:41:49 +0100
From: chrubis@suse.cz
Message-ID: <20130212124149.GB9378@rei>
References: <cover.1360149841.git.jstancek@redhat.com>
	<6624dba3afd6a1782b4d3760871964f14be60a38.1360149841.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6624dba3afd6a1782b4d3760871964f14be60a38.1360149841.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2 3/3] setns: add new syscall test setns02
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
> +static void setup(void)
> +{
> +	char tmp[PATH_MAX];
> +
> +	tst_require_root(NULL);
> +
> +	/* runtime check if syscall is supported */
> +	syscall(__NR_setns, -1, 0);
> +

What happens when the syscall is not supported? The call should return
-1 and errno should be set to ENOSYS but the return value is not
checked, I'm puzzled.

> +	/* check if kernel has CONFIG_*_NS set and exports /proc entries */
> +	ns_ipc_fd = get_ns_fd(getpid(), "ns/ipc");
> +	ns_uts_fd = get_ns_fd(getpid(), "ns/uts");
> +	if (ns_ipc_fd == -1 && ns_uts_fd == -1)
> +		tst_brkm(TCONF, NULL, "your kernel has CONFIG_IPC_NS, "
> +			"CONFIG_UTS_NS or CONFIG_PROC disabled");
> +
> +	if (getcwd(tmp, PATH_MAX) == NULL)
> +		tst_brkm(TBROK|TERRNO, NULL, "getcwd");
> +	ipc_key = ftok(tmp, 65);
> +	shmid = shmget(ipc_key, getpagesize(), IPC_CREAT | 0666);
> +	if (shmid == -1)
> +		tst_brkm(TBROK|TERRNO, NULL, "shmget");
> +
> +	TEST_PAUSE;
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
