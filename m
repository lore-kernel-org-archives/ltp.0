From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Oct 2019 16:54:16 +0200
Subject: [LTP] [RFC PATCH] LTP Wrapper for Syzkaller reproducers
In-Reply-To: <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
References: <20191009142446.6997-1-rpalethorpe@suse.com>
 <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
Message-ID: <20191009145416.GA5014@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I don't have prior experience with LTP tests, but from reading the
> code it looks reasonable to me.
> 
> I assume that .needs_tmpdir = 1 ensures that each test runs in its own
> new temp dir, which is later removed.

Indeed, it's removed recursively by the test library.

> I've stared for a while at "rem / exec_time_start < 0.98" trying to
> understand what is that tst_timeout_remaining() returns that we want
> to kill that process when the ratio is < 0.98... provided that we
> convert 1 to float but not the other var. I failed to come up with the
> answer. I have potential answers for "<0.02" and ">0.98". But I assume
> you know what you are doing :)

The tst_timeout_remaining() returns remaining test timeout, so at test
start it returns something close to 300 seconds, since that is a default
for a LTP tests, so this would probably kill a process quite fast, if
I'm reading right, after a bit more than five seconds. I guess that this
is something intended for a quick v1 hack rather than for later use.

> Re tst_res(TINFO, "Timeout; killing reproducer"). Not sure how much it
> pollutes output on 3000 tests. If it is, it can make sense to remove
> it. Lots of tests run forever, killing it is not something of
> particular interest generally.

I guess so.

-- 
Cyril Hrubis
chrubis@suse.cz
