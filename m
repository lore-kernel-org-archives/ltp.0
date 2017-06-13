From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jun 2017 14:58:06 +0200
Subject: [LTP] [PATCH] Make getrusage04 be able to loop more times
In-Reply-To: <1622893199.18143718.1497354464220.JavaMail.zimbra@redhat.com>
References: <1496388495-30584-1-git-send-email-chuhu@redhat.com>
 <20170607151315.GA30168@rei.suse.de>
 <2050137840.17454791.1496994121958.JavaMail.zimbra@redhat.com>
 <20170612150423.GA32564@rei.lan>
 <1622893199.18143718.1497354464220.JavaMail.zimbra@redhat.com>
Message-ID: <20170613125759.GF29757@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We only need to add tst_timeval_diff_us() into tst_timer.h then we can
> > compare the resulting values in microsenconds. Which would mean adding
> > tst_timeval_to_us() and tst_timeval_diff(), then adding the
> > tst_timeval_diff_us() that combines these two.
> 
> This really sounds simpler than compare with timeval directly. But compare
> with timeval directly would make it more difficult to overflow. 
> 
> > 
> > It should be staturated difference though, i.e. the conversion from
> > timeval to microseconds should return LONG_LONG_MAX in a case that the
> > end result would overflow long long.
> 
> That makes sense. But how long would it overflow once? 
> 
> >>> print "%d" % 0xffffffffffffffff
> 18446744073709551615
> >>> print 18446744073709551615 / 1000000
> 18446744073709
> >>> print "%d" % 0xffffffff
> 4294967295
> >>> print 4294967295 / 1000000
> 4294

The time_t in struct timespec and struct timeval are 64bit types on
64bit architectures, hence we can overflow 64 bit long long in a case
that the difference between two tv_sec is greater than
LLONG_MAX/1000000. It's extremly unlikely but may happen for instance if
the structures are overwritten with random mess for some reason.

-- 
Cyril Hrubis
chrubis@suse.cz
