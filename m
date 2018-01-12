From: Li Wang <wangli.ahau@gmail.com>
Date: Fri, 12 Jan 2018 17:48:29 +0800
Subject: [LTP] [PATCH] migrate_pages02: update for 4.15
In-Reply-To: <beeaa6fe1b73872ebe59b55c1fac419d37bc0b03.1515676244.git.jstancek@redhat.com>
References: <beeaa6fe1b73872ebe59b55c1fac419d37bc0b03.1515676244.git.jstancek@redhat.com>
Message-ID: <CAE1O6mh1N_odRvys0+yRSZ4rGUXkPP8yeo_VosKriEqNQ8Xvbg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11 January 2018 at 21:16, Jan Stancek <jstancek@redhat.com> wrote:
> commit 313674661925 ("Unify migrate_pages and move_pages access checks")
> tightened checks for unprivileged user. It requires that callers real
> uid/gid matches target [es]uig/[es]gid and target to be dumpable
> (see __ptrace_may_access()).
>
> It broke the test, because change of only euid is no longer
> sufficient.
>
> This patch updates test to use setuid(), which sets all user IDs.
> Since we can't change uid back to 0, we fork additional child
> process for "caller", which is now free to drop privileges.
>
> This change should be backwards-compatible with kernels < 4.15.
> Tested on 4.15-rc6 and 4.14.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Works fine on both RHEL kernel-3.10.0-693.el7.x86_64 and upstream
kernel-4.15.0-rc7.


Li Wang
liwang@redhat.com
