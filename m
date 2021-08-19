From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Aug 2021 18:00:01 +0200
Subject: [LTP] [PATCH v4 4/4] syscalls/msgstress: tune limit of
 processes for small machines
In-Reply-To: <20210629121047.100391-5-krzysztof.kozlowski@canonical.com>
References: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
 <20210629121047.100391-5-krzysztof.kozlowski@canonical.com>
Message-ID: <YR6AAfuxrdw9wuZ/@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Forking the exactly amount of processes as the limit (either from
> max_pids or from cgroups) is risky - OS might be doing some work and
> interfere with the test.  Instead leave some reserve (hard-coded to
> 500) for the OS so the test won't fail on fork failure.

Isn't 500 far too many? I would expect that 50 would be more than
enough.

-- 
Cyril Hrubis
chrubis@suse.cz
