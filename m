From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Jun 2017 17:04:23 +0200
Subject: [LTP] [PATCH] Make getrusage04 be able to loop more times
In-Reply-To: <2050137840.17454791.1496994121958.JavaMail.zimbra@redhat.com>
References: <1496388495-30584-1-git-send-email-chuhu@redhat.com>
 <20170607151315.GA30168@rei.suse.de>
 <2050137840.17454791.1496994121958.JavaMail.zimbra@redhat.com>
Message-ID: <20170612150423.GA32564@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Do we have? I think we need something like below, not clear
> about if this can be done with function or macro ;).
> 
> timval_minus(tv1, tv2) 
> and
> timeval_gt
> timeval_lt
> timeval_e

We only need to add tst_timeval_diff_us() into tst_timer.h then we can
compare the resulting values in microsenconds. Which would mean adding
tst_timeval_to_us() and tst_timeval_diff(), then adding the
tst_timeval_diff_us() that combines these two.

It should be staturated difference though, i.e. the conversion from
timeval to microseconds should return LONG_LONG_MAX in a case that the
end result would overflow long long.

As I said I can add these into the tst_timer.h, and also fix the
timespec to us and ms conversions to be saturated.

-- 
Cyril Hrubis
chrubis@suse.cz
