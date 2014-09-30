Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XYw1K-0003TD-EV
	for ltp-list@lists.sourceforge.net; Tue, 30 Sep 2014 11:55:06 +0000
Date: Tue, 30 Sep 2014 13:54:26 +0200
From: chrubis@suse.cz
Message-ID: <20140930115425.GB8499@rei.suse.cz>
References: <1409480940.6575.1.camel@G08JYZSD130126>
	<1409481052.6575.3.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409481052.6575.3.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 3/4] multicast/mc_member: Some cleanup
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
> * Delete trace_logic that is used to debug.
> * Use test.sh script and use tst_* instead of end_testcase.
> * Delete some unuseful comments.
> 
> * Fix old-style function definition.

And the same applies to this patch as well.

> +		count=`grep 105 $ERRFILE | wc -l`
> +		if [ $count -gt 3 ]; then
> +			tst_brkm FAIL "Could not join members!"
> +		fi
> +
> +		COUNT=$(( $COUNT + 1 ))
> +
> +	done   # end of while numloop
                ^
		Please remove these dumbious comments too.


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
