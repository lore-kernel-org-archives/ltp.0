Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UeRMv-0005X4-SK
	for ltp-list@lists.sourceforge.net; Mon, 20 May 2013 14:47:21 +0000
Date: Mon, 20 May 2013 16:48:27 +0200
From: chrubis@suse.cz
Message-ID: <20130520144827.GB21016@rei.suse.cz>
References: <4e8cb837f8dd19db77ca70bd3b0094b060b0b0a0.1368780870.git.jstancek@redhat.com>
	<f86dfe8123738c73c9dc2fd08309bfbe09e925e6.1368780870.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f86dfe8123738c73c9dc2fd08309bfbe09e925e6.1368780870.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 2/2] waitid02: split code into separate testcases
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
> +static void waiting_child(struct testcase_t *t)
> +{
> +	int dummy;
> +	read(t->pipefd[0], &dummy, 1);
> +}
> +
> +static void stopped_child(struct testcase_t *t)
> +{
> +	int dummy;
> +	kill(getpid(), SIGSTOP);
> +	read(t->pipefd[0], &dummy, 1);
> +}
> +
> +static void setup2(struct testcase_t *t)
> +{
> +	if (pipe(t->pipefd) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "pipe");
> +	makechild(t, waiting_child);

I wonder if it would be better to use the TST_CHECKPOINT() interface
that I have written to address synchronization issues.

Have you used pipes because you wanted to avoid tst_tmpdir() and the
FIFO that the code uses? Unfortunately the checkpoint interface must use
fifo instead of pipes to be usable for cases where the file descriptors
cannot be propagated to child because it does exec() right after
fork()... If that is the issue, I can rewrite the checkpoint interface
in a way that would allow either pipe or fifo depending on
initialization parameters.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
