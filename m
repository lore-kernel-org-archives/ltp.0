From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Nov 2016 11:16:09 +0100
Subject: [LTP] [PATCH] cgroup: fix mount errors on cgroup subsys
In-Reply-To: <CAEemH2eDEy+JHEyJ_NQwMmosXsBmrUYoPan1ACWwjAgzR_wy6Q@mail.gmail.com>
References: <1479899346-4261-1-git-send-email-liwang@redhat.com>
 <20161123123521.GE3346@rei.lan>
 <CAEemH2eDEy+JHEyJ_NQwMmosXsBmrUYoPan1ACWwjAgzR_wy6Q@mail.gmail.com>
Message-ID: <20161124101454.GC14986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Why can't we mount the cgroup only when it's not mounted yet and
> > use the path it's mounted on otherwise? We do that for the functional
> > tetscases already.
> 
> I thought that the original case including cgroup mounted test, so I
> unmount the system cgroup and do itself mount & testing there.

Well the original test was written at times where cgroups were shiny and
new and were not mounted by default on some well defined location...

-- 
Cyril Hrubis
chrubis@suse.cz
