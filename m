From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Jun 2021 10:49:39 +0200
Subject: [LTP] [PATCH 1/1] cgroup/cgroup_regression_test: Fix umount
 failure
In-Reply-To: <caf1bb46-5212-3c3d-f180-e722ef2cf8dd@jv-coder.de>
References: <20210628033002.GA1469@andestech.com>
 <caf1bb46-5212-3c3d-f180-e722ef2cf8dd@jv-coder.de>
Message-ID: <YNmNI3omBfAnj5dN@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

[ changed Cyril's address in Cc to the working one ]

> >   	mkdir cgroup/0
> >   	sleep 100 < cgroup/0 &	# add refcnt to this dir
> >   	rmdir cgroup/0
> > +	sync
> >   	# remount with some subsystems removed
> >   	# since 2.6.28, this remount will fail
> I would like a short comment close to the syncs. When I converted
> cpuset_regression_test.sh, I would have removed the sync in there, if there
> wouldn't have been any comment.
> Most of the time syncs are not required and just added by paranoid
> developers, but if there is a real reason, I think it should be stated in a
> comment.

Agree with this. Are all these sync really needed? Or just some?

Kind regards,
Petr

> J?rg
