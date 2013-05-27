Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uh08q-0002pI-PT
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 16:19:24 +0000
Date: Mon, 27 May 2013 18:20:33 +0200
From: chrubis@suse.cz
Message-ID: <20130527162032.GB31382@rei.suse.cz>
References: <4ea3e87b9e1000e948e77a117c7cd77dd3c9ccda.1369120163.git.jstancek@redhat.com>
	<f9e681d1d404dd60c51ddcc12d4aefe7bb633f93.1369297122.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f9e681d1d404dd60c51ddcc12d4aefe7bb633f93.1369297122.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v3 2/2] waitid02: split code into separate
	testcases
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
> +static void dummy_child(struct testcase_t *t)
> +{
> +}
> +
> +static void waiting_child(struct testcase_t *t)
> +{
> +	TST_CHECKPOINT_CHILD_WAIT(&checkpoint);
> +}
> +
> +static void stopped_child(struct testcase_t *t)
> +{
> +	kill(getpid(), SIGSTOP);
> +	TST_CHECKPOINT_CHILD_WAIT(&checkpoint);
> +}

Looks like none of the childs is using the parameter after the change to
checkpoint interface. We may remove it then.

The rest if fine. (Acked-By: Cyril Hrubis <chrubis@suse.cz>)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
