From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 24 Jun 2021 21:31:44 +0200
Subject: [LTP] [PATCH v2 0/3] controllers/memcg: fixes for newer kernels
In-Reply-To: <20210617070730.7699-1-krzysztof.kozlowski@canonical.com>
References: <20210617070730.7699-1-krzysztof.kozlowski@canonical.com>
Message-ID: <bd56facc-55a3-4e8a-4e9d-304d5177462d@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17/06/2021 09:07, Krzysztof Kozlowski wrote:
> Hi,
> 
> This is a resend of previous Github pull:
> https://github.com/linux-test-project/ltp/pull/830
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


Hi everyone,

The patchset got positive LGTM on the Github. Any further comments for
it or can it be applied?

Best regards,
Krzysztof
