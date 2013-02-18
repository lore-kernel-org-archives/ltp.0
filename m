Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U7VHz-0005QM-IY
	for ltp-list@lists.sourceforge.net; Mon, 18 Feb 2013 18:18:07 +0000
Date: Mon, 18 Feb 2013 19:17:36 +0100
From: chrubis@suse.cz
Message-ID: <20130218181734.GA28740@rei.Home>
References: <cover.1361196214.git.jstancek@redhat.com>
	<a5da91845477cb0ddbd59d37eb328175dac90698.1361196214.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5da91845477cb0ddbd59d37eb328175dac90698.1361196214.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v3 2/3] setns: add new syscall test setns01
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
> +static void setup1(struct testcase_t *t, int i)
> +{
> +	t->ns_type = ns_types[i];
> +	t->fd = open("dummy", O_CREAT);

While I tried to compile this code, I've got error as open with O_CREAT
is required to pass the mode.

> +	if (t->fd == -1)
> +		tst_brkm(TFAIL|TERRNO, cleanup, "setup1:open failed");
> +	unlink("dummy");
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The Go Parallel Website, sponsored by Intel - in partnership with Geeknet, 
is your hub for all things parallel software development, from weekly thought 
leadership blogs to news, videos, case studies, tutorials, tech docs, 
whitepapers, evaluation guides, and opinion stories. Check out the most 
recent posts - join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
