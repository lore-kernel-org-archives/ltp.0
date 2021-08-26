From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 26 Aug 2021 11:50:22 +0200
Subject: [LTP] [PATCH v5 3/3] syscalls/msgstress: tune limit of
 processes for small machines
In-Reply-To: <YR+vZjqYBh/f6yAZ@yuki>
References: <20210820100028.97487-1-krzysztof.kozlowski@canonical.com>
 <20210820100028.97487-4-krzysztof.kozlowski@canonical.com>
 <YR+vZjqYBh/f6yAZ@yuki>
Message-ID: <5342909d-f4fd-6d6d-80b9-4bd230ff7370@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20/08/2021 15:34, Cyril Hrubis wrote:
> Hi!
>> Forking the exactly amount of processes as the limit (either from
>> max_pids or from cgroups) is risky - OS might be doing some work and
> 
> This comment does not seem to match the code. We apply the reserve to
> the cgroup limit only. If we wanted to make sure that the reserve is
> applied even in the case where there is no systemd cgroup we would have
> to apply it in the tst_get_free_pids_() just before we check if
> used_pids >= max_pids instead.

You are right. I'll move it to tst_get_free_pids_ to handle such case.


Best regards,
Krzysztof
