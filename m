Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WBPik-00037w-As
	for ltp-list@lists.sourceforge.net; Thu, 06 Feb 2014 14:14:26 +0000
Date: Thu, 6 Feb 2014 15:13:53 +0100
From: chrubis@suse.cz
Message-ID: <20140206141353.GA29219@rei.suse.cz>
References: <1387364436.1634.2.camel@G08JYZSD130126>
	<20140205150500.GB28615@rei.suse.cz>
	<1391688594.4999.5.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1391688594.4999.5.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] msgctl/msgctl13.c: add IPC_RMID test
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +
> +char *TCID = "acct13";

I've fixned this to be msgct rather than acct (in both testcases).

> +int TST_TOTAL = 1;
> +static void msgctl_verify(void);
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +
> +		tst_count = 0;
> +
> +		msgctl_verify();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void msgctl_verify(void)
> +{
> +	int msg_q;
> +	struct msqid_ds qs_buf;
> +
> +	msg_q = msgget(IPC_PRIVATE, MSG_RW);
> +	if (msg_q == -1)
> +		tst_brkm(TBROK, cleanup, "Can't create message queue");
> +
> +	TEST(msgctl(msg_q, IPC_RMID, &qs_buf));

And passed NULL here instead of the msqid_ds buf here, the third
parameter is ignored fro IPC_RMID operation.


Both pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
