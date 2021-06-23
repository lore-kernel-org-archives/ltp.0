From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 23 Jun 2021 15:58:18 +0200
Subject: [LTP] [PATCH v2 0/4] syscalls/msgstress: fixes for small systems
In-Reply-To: <20210623135524.80663-1-krzysztof.kozlowski@canonical.com>
References: <20210623135524.80663-1-krzysztof.kozlowski@canonical.com>
Message-ID: <fa241120-da74-618b-b708-9f113031c127@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23/06/2021 15:55, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1:
> 1. Move the code reading cgroups session limit to lib/tst_pid.c to
>    existing tst_get_free_pids_().
> 2. Allow reading session limits from cgroups v2.
> 3. Add patch 1/4 - typo fix.
> 4. Add patch 4/4 with the buffer/reserve of pids.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (4):
>   include/tst_pid.h: fix language typo (subtraction)
>   syscalls/msgstress04: fix fork failure on small memory systems
>   syscalls/msgstress03: fix fork failure on small memory systems
>   syscalls/msgstress: tune limit of processes for small machines

Ah, I messed up and sent v2 with duplicated patches. Sorry for the
noise, I will send a v3 to make it organized...


Best regards,
Krzysztof
