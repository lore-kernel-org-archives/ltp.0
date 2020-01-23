From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jan 2020 14:33:39 +0100
Subject: [LTP] [PATCH 1/2] lib: Add timeout to TST_PROCESS_STATE_WAIT
In-Reply-To: <7946b1f4-a005-63ee-505f-f7b31d0893f9@163.com>
References: <20200122134239.28844-1-jcronenberg@suse.de>
 <a8618b2e-067c-9a66-02e7-3feceec1ff9c@cn.fujitsu.com>
 <2cfda6ff-b02f-00c4-b256-eeded0d3edda@suse.de>
 <7946b1f4-a005-63ee-505f-f7b31d0893f9@163.com>
Message-ID: <20200123133339.GC6762@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> We have tst_process_state_wait2 since commit dbf270c5 ("lib: Add
> >> tst_process_state_wait2()"), this api has same functions as
> >> tst_process_state_wait but only return error instead of TBROK.
> >>
> >> I think using TST_PROCESS_STATE_WAIT2 is confused and we can only expand
> >> tst_process_state_wait make it support sleep specifying in milliseconds.
> >>
> >> Best Regards
> >> Yang Xu
> > 
> > I don't think I quite understand what you mean. I can see that using
> > TST_PROCESS_STATE_WAIT2 is confusing. But I didn't want to touch the
> > existing TST_PROCESS_STATE_WAIT to ensure all older tests still run the
> > same. Are you saying i should go through all tests that use
> > TST_PROCESS_STATE_WAIT and specify that they use a timeout of 0(which
> > according to a git grep doesn't seem too many, so it wouldn't be too
> > much effort) and then change TST_PROCESS_STATE_WAIT to include a timeout
> Yes.
> > or should I just rename TST_PROCESS_STATE_WAIT2 to something that
> > seperates it more from tst_process_state_wait2?
> Also, I am fine with the second way. Let we listen cyril's advise.
> @Cyril What do you think about it?

Well that function is only supposed to be used from the old API while
the macro is defined for the new API so they are never exported at the
same time.

On the other hand we can change these few testcases quite easily, so we
may as well do that.

-- 
Cyril Hrubis
chrubis@suse.cz
