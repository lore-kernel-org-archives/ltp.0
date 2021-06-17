From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 17 Jun 2021 08:32:52 +0100
Subject: [LTP] [PATCH v2 0/3] controllers/memcg: fixes for newer kernels
In-Reply-To: <20210617070730.7699-1-krzysztof.kozlowski@canonical.com>
References: <20210617070730.7699-1-krzysztof.kozlowski@canonical.com>
Message-ID: <87im2d3pzv.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> writes:

> Hi,
>
> This is a resend of previous Github pull:
> https://github.com/linux-test-project/ltp/pull/830

LGTM (Reviewed on Github).

I doubt tests that expect a precise allocation figure are valid.

>
> The patches fix several test failures we are hitting since months, see:
> https://bugs.launchpad.net/bugs/1829979
> https://bugs.launchpad.net/bugs/1829984
>
> Best regards,
> Krzysztof
>
>
> Krzysztof Kozlowski (3):
>   controllers/memcg: accept range of max_usage_in_bytes
>   controllers/memcg: accept range of usage_in_bytes
>   controllers/memcg: accept non-zero max_usage_in_bytes after reset
>
>  .../controllers/memcg/functional/memcg_lib.sh | 22 ++++++++++++++-----
>  .../memcg_max_usage_in_bytes_test.sh          | 12 ++++++++--
>  .../memcg/functional/memcg_stat_rss.sh        | 20 ++++++++---------
>  .../memcg/functional/memcg_stat_test.sh       |  8 +++----
>  .../functional/memcg_usage_in_bytes_test.sh   | 10 +++++++--
>  5 files changed, 49 insertions(+), 23 deletions(-)
>
> -- 
> 2.27.0


-- 
Thank you,
Richard.
