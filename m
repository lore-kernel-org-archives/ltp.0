From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 29 Sep 2017 14:27:27 +0200
Subject: [LTP] [PATCH v2] utimensat_tests.sh: returns EPERM above 4.4.27
 and below 4.5.0
In-Reply-To: <1242297312.24336555.1506686917802.JavaMail.zimbra@redhat.com>
References: <1506552444-2399-1-git-send-email-naresh.kamboju@linaro.org>
 <20170929114503.GC12869@rei>
 <1242297312.24336555.1506686917802.JavaMail.zimbra@redhat.com>
Message-ID: <20170929122727.GA23788@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Great thanks for pushing it.

Now the only patch to consider is the v2 for controllers/cpuset I've
send yesterday. I'm kind of undecided, it fixes the main issue, but
oncovers a bunch of smaller ones for me. The cpuset_sched_domain,
cpuset_load_balance, cpuset_memory and cpuset_memory_pressure fail for
me.

Have you tried that patch? Does it work for you?

-- 
Cyril Hrubis
chrubis@suse.cz
