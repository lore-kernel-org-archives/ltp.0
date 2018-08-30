From: Li Wang <liwang@redhat.com>
Date: Thu, 30 Aug 2018 13:58:28 +0800
Subject: [LTP] [PATCH 4/5] fzsync: Simplify API with start/end race
 calls and limit exec time
In-Reply-To: <20180828093002.20368-5-rpalethorpe@suse.com>
References: <20180828093002.20368-1-rpalethorpe@suse.com>
 <20180828093002.20368-5-rpalethorpe@suse.com>
Message-ID: <CAEemH2d9ABZFAGJJ=ORoH0faTXQOQhmw8+7Q3uujUhcOBpT0dQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

I have gone though this new fzsync API, the whole picture looks good but
with a tiny issue maybe be needs adjustment.

1. Moving the expired time detection to tst_fzsync_end_race_a() function,
because it maybe better if exit the loop after finishing a complete race
testing, and it also makes the _start_race_a() more aligned to
_start_race_b() I guess.

2. Do fzsync_pair_cleanup when the expired time occuring. This is for JOIN
the threads which might have collision(I know it has very small probability
but in case of that)with new threads if with -i parameter. And re-org the
tst_fzsync_clenaup() to make sure to be widely used.

So, for suggestion 1&2, the related function will be changed as:

static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
{
tst_fzsync_pair_exit(pair);

if (pair->thread_b) {
SAFE_PTHREAD_JOIN(pair->thread_b, 0);
pair->thread_b = 0;
}
}

static inline int tst_fzsync_end_race_a(struct tst_fzsync_pair *pair)
{
if (tst_timer_expired_st(&pair->timer)) {
tst_res(TINFO,
"Exceeded fuzzy sync time limit, requesting exit");
tst_fzsync_pair_cleanup(pair);
}

tst_fzsync_time(&pair->a_end);
return tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr,
    &pair->spins);
}

3. I tend to agree with Cyril's opinion, to take use of
the tst_timeout_remaining() function which will be introduced by Jan's
patch for move_pages12, then fzsync can drop the expired time detection by
with new timer function involved.

4. The usage of fzsync is not very neat. For example in some places you
put tst_fzsync_start_race_b(&pair) into curves but others not, I know that
because of different situation needs variant race condition area,
but if we can have a uniform format to satisfy that, it would be more happy
to users.

5. I do not fully understand about the 'tst_fzsync_stat' part, if you can
give more explanation in code comments, that will be much appreciated.

Btw, I have tried this new API with my rhel7.5 x86_64 system, it woks fine
with or without -i parameter, and it also does correctly when the
execution_time expired. These comments are just FYI. Thanks!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180830/b55a3371/attachment.html>
