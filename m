Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XWhig-0002IG-Sd
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 08:14:38 +0000
Date: Wed, 24 Sep 2014 10:14:20 +0200
From: chrubis@suse.cz
Message-ID: <20140924081420.GC10825@rei>
References: <1409047170-18251-2-git-send-email-mmarhefk@redhat.com>
	<1409320025-12778-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409320025-12778-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH 2/2 v2] containers: added mountns/mountns04.c
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
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	check_newns();	/* from mountns_helper.h */

Please remove this comment.

> +	tst_tmpdir();
> +	SAFE_MKDIR(cleanup, DIRA, 0777);
> +	SAFE_MKDIR(cleanup, DIRB, 0777);
> +	SAFE_TOUCH(cleanup, DIRA"/A", 0, NULL);
> +	SAFE_TOUCH(cleanup, DIRB"/B", 0, NULL);
> +}
> +
> +static void test(void)
> +{
> +	/* unshares the mount ns */
> +	if (unshare(CLONE_NEWNS) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
> +	/* makes sure mounts/umounts have no effect on a real system */
> +	SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
> +
> +	/* bind mounts DIRA to itself */
> +	SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
> +	/* bind mounts DIRB to itself */
> +	SAFE_MOUNT(cleanup, DIRB, DIRB, "none", MS_BIND, NULL);
> +
> +	/* makes mount DIRA unbindable */
> +	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_UNBINDABLE, NULL);
> +	/* makes mount DIRB shared */
> +	SAFE_MOUNT(cleanup, "none", DIRB, "none", MS_SHARED, NULL);
> +
> +	/* tries to bind mount unbindable DIRA to DIRB which should fail */
> +	if (mount(DIRA, DIRB, "none", MS_BIND, NULL) == -1)
> +		tst_resm(TPASS, "unbindable mount passed");
> +	else {
> +		SAFE_UMOUNT(cleanup, DIRB);
> +		tst_resm(TFAIL, "unbindable mount faled");
> +	}

This is merely cosmetic, but LKML coding style preffers having curly
brackets on both branches if they needs to be over one of them.

> +#else /* MS_SHARED && MS_PRIVATE && MS_REC && MS_UNBINDABLE */

And the comment about ifdefs applies here as well.


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
