From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 29 Sep 2017 15:22:46 +0200
Subject: [LTP] [PATCH v2] utimensat_tests.sh: returns EPERM above 4.4.27
 and below 4.5.0
In-Reply-To: <99358338.24358917.1506689529910.JavaMail.zimbra@redhat.com>
References: <1506552444-2399-1-git-send-email-naresh.kamboju@linaro.org>
 <20170929114503.GC12869@rei>
 <1242297312.24336555.1506686917802.JavaMail.zimbra@redhat.com>
 <20170929122727.GA23788@rei>
 <99358338.24358917.1506689529910.JavaMail.zimbra@redhat.com>
Message-ID: <20170929132246.GA25704@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Now the only patch to consider is the v2 for controllers/cpuset I've
> > send yesterday. I'm kind of undecided, it fixes the main issue, but
> > oncovers a bunch of smaller ones for me. The cpuset_sched_domain,
> > cpuset_load_balance, cpuset_memory and cpuset_memory_pressure fail for
> > me.
> > 
> > Have you tried that patch? Does it work for you?
> 
> I think I tried v1 (very long time ago) on 3.10 kernel (RHEL7),
> and I recall 1 or 2 failures, but that was unrelated to patch.

I've tried the patch on pre-systemd distro and it breaks the tests
there, so let's shelve the patch for now. I will get to it right after
the release is done and also look into the reset of the failures I'm
getting on 4.4 kernel, which is the one I've tested.

-- 
Cyril Hrubis
chrubis@suse.cz
