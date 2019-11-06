From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 Nov 2019 18:12:01 +0100
Subject: [LTP] [PATCH v1] cgroup_fj_stress: Avoid killall
In-Reply-To: <1572961744.4619.20.camel@suse.de>
References: <20191105112000.20633-1-cfamullaconrad@suse.de>
 <20191105132004.GA20849@dell5510>
 <1572961744.4619.20.camel@suse.de>
Message-ID: <20191106171201.GA22894@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

> > I wonder if we also want to kill cgroup_fj_proc this way (see
> > cgroup_fj_common.sh).

> I'm not sure if I understand you. We do kill cgroup_fj_proc this way.
> The `killall -9 cgroup_fj_proc` call in cgrouip_fj_common.sh looks for
> me like a cleaner and there is no `wait` or similar afterwards, so I
> would guess we are not facing the problem here. And I would keep
> killall here.
> As far as I can see, all other `cgroup_fj_proc&` calls already kill
> them separately.
OK, merged :).
Thanks!

> > I guess you're not planning to create minimal reproducer to prove the
> > problem of
> > left processes after killall, are you?

> Sure nice idea, I can give it a try. But not within this patchset.
Thanks!

Kind regards,
Petr
