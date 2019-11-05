From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Nov 2019 09:44:39 +0530
Subject: [LTP] stable-rc-5.3.9-rc1: regressions detected -
 remove_proc_entry: removing non-empty directory 'net/dev_snmp6',
 leaking at least 'lo'
In-Reply-To: <CA+G9fYsWTFQZTHXUDPToaepnKGBoh61SsA_8SHcYgYZXN_L+mg@mail.gmail.com>
References: <CA+G9fYsWTFQZTHXUDPToaepnKGBoh61SsA_8SHcYgYZXN_L+mg@mail.gmail.com>
Message-ID: <CA+G9fYu+6A3pYQGs2rydYtHNSCf1t9+OTRqrZeCbpc2ARLx2zA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sasha and Greg,

On Mon, 4 Nov 2019 at 20:59, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Linux stable rc 5.3 branch running LTP reported following test failures.
> While investigating these failures I have found this kernel warning
> from boot console.
> Please find detailed LTP output log in the bottom of this email.
>
> List of regression test cases:
>   ltp-containers-tests:
>     * netns_breakns_ip_ipv6_ioctl
>     * netns_breakns_ip_ipv6_netlink
>     * netns_breakns_ns_exec_ipv6_ioctl
>     * netns_breakns_ns_exec_ipv6_netlink
>     * netns_comm_ip_ipv6_ioctl
>     * netns_comm_ip_ipv6_netlink
>     * netns_comm_ns_exec_ipv6_ioctl
>     * netns_comm_ns_exec_ipv6_netlink

These reported failures got fixed on latest stable-rc 5.3.y after
dropping a patch [1].
The kernel warning is also gone now.

metadata:
  git branch: linux-5.3.y
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git commit: 75c9913bbf6e9e64cb669236571e6af45cddfd68

ref:
[PATCH AUTOSEL 5.3 12/33] blackhole_netdev: fix syzkaller reported issue
[1] https://lkml.org/lkml/2019/10/25/794

Best regards
Naresh Kamboju
