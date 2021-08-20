From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 20 Aug 2021 10:34:30 +0200
Subject: [LTP] [PATCH v4 4/4] syscalls/msgstress: tune limit of
 processes for small machines
In-Reply-To: <YR6AAfuxrdw9wuZ/@yuki>
References: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
 <20210629121047.100391-5-krzysztof.kozlowski@canonical.com>
 <YR6AAfuxrdw9wuZ/@yuki>
Message-ID: <fa2d4021-48b4-39ee-bdf9-b54e7055804e@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19/08/2021 18:00, Cyril Hrubis wrote:
> Hi!
>> Forking the exactly amount of processes as the limit (either from
>> max_pids or from cgroups) is risky - OS might be doing some work and
>> interfere with the test.  Instead leave some reserve (hard-coded to
>> 500) for the OS so the test won't fail on fork failure.
> 
> Isn't 500 far too many? I would expect that 50 would be more than
> enough.

I wanted to stay on the safe side to avoid false failures especially
that even with 500 reserve there will be plenty of PIDs to stress the
system.

I can change it to 50.


Best regards,
Krzysztof
