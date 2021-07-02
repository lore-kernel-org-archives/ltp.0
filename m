From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 2 Jul 2021 12:49:07 +0200
Subject: [LTP] [PATCH v2 0/3] controllers/memcg: fixes for newer kernels
In-Reply-To: <CAEemH2dqM29Y5s5U2QbeONH30h6aR1B4DZxSnSdowWKSXzfgYQ@mail.gmail.com>
References: <20210617070730.7699-1-krzysztof.kozlowski@canonical.com>
 <bd56facc-55a3-4e8a-4e9d-304d5177462d@canonical.com>
 <CAEemH2dqM29Y5s5U2QbeONH30h6aR1B4DZxSnSdowWKSXzfgYQ@mail.gmail.com>
Message-ID: <ced1d406-97f4-286a-656b-671a333ba46a@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25/06/2021 10:21, Li Wang wrote:
> 
> 
> On Fri, Jun 25, 2021 at 3:31 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com
> <mailto:krzysztof.kozlowski@canonical.com>> wrote:
> 
>     On 17/06/2021 09:07, Krzysztof Kozlowski wrote:
>     > Hi,
>     >
>     > This is a resend of previous Github pull:
>     > https://github.com/linux-test-project/ltp/pull/830
>     <https://github.com/linux-test-project/ltp/pull/830>
>     >
>     > The patches fix several test failures we are hitting since months,
>     see:
>     > https://bugs.launchpad.net/bugs/1829979
>     <https://bugs.launchpad.net/bugs/1829979>
>     > https://bugs.launchpad.net/bugs/1829984
>     <https://bugs.launchpad.net/bugs/1829984>
>     >
>     > Best regards,
>     > Krzysztof
>     >
>     >
>     > Krzysztof Kozlowski (3):
>     >? ?controllers/memcg: accept range of max_usage_in_bytes
>     >? ?controllers/memcg: accept range of usage_in_bytes
>     >? ?controllers/memcg: accept non-zero max_usage_in_bytes after reset
> 
> 
>     Hi everyone,
> 
>     The patchset got positive LGTM on the Github. Any further comments for
>     it or can it be applied?
> 
> 
> I slightly agree with Richard that we need an explanation/investigation
> on where the 32*PAGE_SIZE comes from. Otherwise, we are very possible
> to mask a counter bug if only to make the test happy.

On newer v5.11 the max_usage_in_bytes go even above 32 pages up to 34.

I got some explanation from Michal Hocko [1] from which one can try to
conclude:
1. There is significant caching in memory accounting. Not only charging
of cgroup is once per MEMCG_CHARGE_BATCH batch (try_charge()), but also
statistics are gathered from per-cpu if threshold exceed
MEMCG_CHARGE_BATCH (__mod_memcg_state()).

2. Depending on machine (different amount of CPUs), the memory group
charging be less or more accurate.

3. The accuracy of group memory accounting is not considered as
important thus test relying on it, will be failing from time to time.


I'll send a v3 with significantly increased limits and some explanation.

[1]
https://lore.kernel.org/linux-mm/85b8a4f9-b9e9-a6ca-5d0c-c1ecb8c11ef3@canonical.com/T/#m6459b3be3a86f5eaf2cfc48dd586b6faf949e440


Best regards,
Krzysztof
