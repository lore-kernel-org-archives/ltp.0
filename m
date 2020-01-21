From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Jan 2020 06:24:47 +0100
Subject: [LTP] [PATCH] syscalls/userfaultfd01: Always require
 CAP_SYS_PTRACE
In-Reply-To: <1575532537-27105-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1575532537-27105-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200121052447.GA6657@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Since commit cefdca0a86be ("userfaultfd/sysctl: add vm.unprivileged_userfaultfd").
> , it adds a global sysctl knob "vm.unprivileged_userfaultfd" to control whether
> unprivileged users can use the userfaultfd system calls.  Set this to 1 to allow
> unprivileged users to use the userfaultfd system calls, or set this to 0 to
> restrict userfaultfd to only privileged users (with SYS_CAP_PTRACE capability).The
> default value is 1. In order to use userfaultfd always, require CAP_SYS_PTRACE.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Good idea, thanks!

Kind regards,
Petr
