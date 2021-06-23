From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 23 Jun 2021 11:39:04 +0200
Subject: [LTP] [PATCH 1/2] syscalls/msgstress03: fix fork failure on
 small memory systems
In-Reply-To: <60D2FEFC.8030706@fujitsu.com>
References: <20210622111440.74722-1-krzysztof.kozlowski@canonical.com>
 <60D2FEFC.8030706@fujitsu.com>
Message-ID: <8dd7fb6b-c1d4-819c-9013-f19589f89eb3@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23/06/2021 11:28, xuyang2018.jy@fujitsu.com wrote:
> Hi Krzysztof
>> Running syscalls/msgstress03 on a system with less than ~4 GB of RAM fails:
>>
>>      msgstress03    1  TFAIL  :  msgstress03.c:155: 	Fork failed (may be OK if under stress)
>>
>> In dmesg:
>>
>>      LTP: starting msgstress03
>>      cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-1.scope
>>
>> The reason is cgroups pid limit set by systemd user.slice.  The limit is
>> set for login session, also for root user.  For example on 2 GB RAM
>> machine it is set as:
>>      /sys/fs/cgroup/pids/user.slice/user-0.slice/pids.max:5207
> This file only exists on cgroupv1 and cgroupv2 should use
> /sys/fs/cgroup/user.slice/user-0.slice/pids.max.

I can use both paths.

> 
> Also if some embedded system doesn't have systemd, do we have a generic 
> way or fallback way to calculate the pid max?

This slice is set by systemd, so no-systemd systems are out of scope
because:
1. They will not be affected by this.
2. The limits there might be set by other init manager so other patch
should come in. Making a generic solution for unknown-init-managers is a
much bigger task and not necessarily needed,


Best regards,
Krzysztof
