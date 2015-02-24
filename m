Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQC3Z-00039H-4q
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 09:45:33 +0000
Date: Tue, 24 Feb 2015 10:44:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150224094455.GB32083@rei>
References: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1423212090-24164-5-git-send-email-gux.fnst@cn.fujitsu.com>
	<20150209143918.GE7605@rei.suse.de>
	<54DC3853.7030203@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54DC3853.7030203@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 5/6] power_management: cleanup
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
To: "gux.fnst" <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> -$sched_mc & sched_smt=$sched_smt"
> >> +				echo "${FAIL}: cpu consolidation passed for" \
> >> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
> >>   			fi
> >>   			;;
> >>   		*)
> >>   			if [ $pass_count -lt 5 ]; then
> >> -               	tst_resm TFAIL "cpu consolidation for sched_mc=\
> >> -$sched_mc & sched_smt=$sched_smt"
> >> -           	else
> >>   				RC=1
> >> -				tst_resm TPASS "cpu consolidation for sched_mc=\
> >> -$sched_mc & sched_smt=$sched_smt"
> >> +				echo "${FAIL}: cpu consolidation for" \
> >> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
> >> +			else
> >> +				echo "${PASS}: cpu consolidation for" \
> >> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
> >
> > I do not get how removing tst_resm and changing it to echo satisfies
> > "Use functions in test.sh, eg. tst_brkm" from the commit log.
> 
> This is a subset of each test case, eg. runpwtests_exclusive01.sh. Here if we use
> tst_resm TPASS/TFAIL, it results in a mismatch between the count of TPASS/TFAIL and
> the TST_COUNT in each case. So I change "tst_resm" to "echo".
> I don't have a better way to do this. Could you give me some hints about it? Thanks!

If these are separable testcases the best would be to split them into
testcases. If they are not, we can always fix the TST_COUNT to match the
reality...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
