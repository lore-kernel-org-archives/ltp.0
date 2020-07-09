From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 8 Jul 2020 22:16:26 -0700
Subject: [LTP] BUG: KASAN: global-out-of-bounds in
 is_affected_midr_range_list on arm64
In-Reply-To: <CA+G9fYs3EavpU89-rTQfqQ9GgxAMgMAk7jiiVrfP0yxj5s+Q6g@mail.gmail.com>
References: <CA+G9fYs3EavpU89-rTQfqQ9GgxAMgMAk7jiiVrfP0yxj5s+Q6g@mail.gmail.com>
Message-ID: <559c5a04-a2ab-bfa2-c26e-4fbbf6d273ed@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 7/8/2020 9:36 PM, Naresh Kamboju wrote:
> While running LTP cpuhotplug test on mainline 5.8.0-rc4 the kernel BUG noticed
> on arm64 Juno-r2 KASAN config enabled kernel.
> 
> steps to reproduce:
> - boot KASAN enabled Juno-r2 device
> - cd /opt/ltp
> - ./runltp -f cpuhotplug
> 
> metadata:
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   git commit: 63e1968a2c87e9461e9694a96991935116e0cec7
>   kernel-config:
> https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/kernel.config
>   vmlinux: https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/vmlinux.xz
>   system.map: https://builds.tuxbuild.com/wc75HkrGrWgQCdI-l_1jUw/System.map
> 
> Test log:
> Name:   cpuhotplug02
> Date:   Thu Jul  9 00:09:24 UTC 2020
> Desc:   What happens to a process when its CPU is offlined?
> 

Just sent a tentative fix:

https://lore.kernel.org/linux-arm-kernel/20200709051345.14544-1-f.fainelli@gmail.com/
-- 
Florian
