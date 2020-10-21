From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 21 Oct 2020 21:35:47 +0200
Subject: [LTP] Broken Fedora build
Message-ID: <20201021193547.GA49488@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Fedora build is broken due missing <sys/timeb.h> [1].
Quick fix would probably be to use Fedora 33 instead of Rawhide. [2]
But we should port hugetlb.c and trace_sched.c (if used) to gettimeofday or
clock_gettime. [3]

Kind regards,
Petr

[1] https://travis-ci.org/github/linux-test-project/ltp/jobs/737698948
[2] https://www.spinics.net/lists/fedora-devel/msg279551.html
[3] https://www.spinics.net/lists/fedora-devel/msg279545.html
