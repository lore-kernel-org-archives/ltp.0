From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Jan 2020 13:54:11 +0800
Subject: [LTP] [PATCH] syscalls/userfaultfd01: Always require
 CAP_SYS_PTRACE
In-Reply-To: <20200121052447.GA6657@dell5510>
References: <1575532537-27105-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200121052447.GA6657@dell5510>
Message-ID: <5707ecce-aec4-a80d-5ec6-f9c728625634@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Peter

> Hi Xu,
>
>> Since commit cefdca0a86be ("userfaultfd/sysctl: add vm.unprivileged_userfaultfd").
>> , it adds a global sysctl knob "vm.unprivileged_userfaultfd" to control whether
>> unprivileged users can use the userfaultfd system calls.  Set this to 1 to allow
>> unprivileged users to use the userfaultfd system calls, or set this to 0 to
>> restrict userfaultfd to only privileged users (with SYS_CAP_PTRACE capability).The
>> default value is 1. In order to use userfaultfd always, require CAP_SYS_PTRACE.
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Good idea, thanks!

We have pushed "syscalls/userfaultfd01: add hint about unprivileged_userfaultfd" patch(v2)[1].

This is v1.? li Wang and me both think adding hint is more wise, more info see[2].

[1] https://github.com/linux-test-project/ltp/commit/7dc571d3ad1908d6e50163a06ef848f096fe880a
[2] http://lists.linux.it/pipermail/ltp/2020-January/014921.html

Best Regards
Yang Xu

> Kind regards,
> Petr
>
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200121/5a4e74fb/attachment-0001.htm>
