From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jun 2020 13:13:31 +0200
Subject: [LTP] [PATCH V6 01/17] syscalls/timer_gettime: Add support for
 time64 tests
In-Reply-To: <20200625111017.5yjsqi56u6q3u3s2@vireshk-i7>
References: <a4a628a637a6eeeed4249656836bd217f5cbb9ac.1590144577.git.viresh.kumar@linaro.org>
 <9621b4f97b539f2e080b00491eb9ba4973878028.1591760262.git.viresh.kumar@linaro.org>
 <20200624142327.GA5181@yuki.lan>
 <20200625095006.d6ndameqblecadp4@vireshk-i7>
 <20200625110751.GB23637@yuki.lan>
 <20200625111017.5yjsqi56u6q3u3s2@vireshk-i7>
Message-ID: <20200625111331.GD23637@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Indeed that's what I had in mind, can we please abstract this properly
> > as well? I guess that we can add helpers such as tst_its_interval_sec()
> > tst_its_inverval_nsec, etc.
> 
> I preferred it this way as no one else uses it and so maybe we can
> live without adding those helpers ?

I'm pretty sure we will need them for the timer_settime() tests anyway,
i.e. test that would do timer_settime() and then timer_gettime() to
check that the timer is read back correclty.

-- 
Cyril Hrubis
chrubis@suse.cz
