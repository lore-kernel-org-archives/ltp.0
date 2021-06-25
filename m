From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 25 Jun 2021 11:13:29 +0200
Subject: [LTP] [PATCH v2 0/3] controllers/memcg: fixes for newer kernels
In-Reply-To: <CAEemH2dqM29Y5s5U2QbeONH30h6aR1B4DZxSnSdowWKSXzfgYQ@mail.gmail.com>
References: <20210617070730.7699-1-krzysztof.kozlowski@canonical.com>
 <bd56facc-55a3-4e8a-4e9d-304d5177462d@canonical.com>
 <CAEemH2dqM29Y5s5U2QbeONH30h6aR1B4DZxSnSdowWKSXzfgYQ@mail.gmail.com>
Message-ID: <56f9de88-92dd-a005-4248-107bf60083e2@canonical.com>
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
>     Hi everyone,
> 
>     The patchset got positive LGTM on the Github. Any further comments for
>     it or can it be applied?
> 
> 
> I slightly agree with Richard that we need an explanation/investigation
> on where the 32*PAGE_SIZE comes from. Otherwise, we are very possible
> to mask a counter bug if only to make the test happy.

I don't know where 32*PAGE_SIZE comes from and investigation would
require effort/time which I don't have.

I don't think we mask current bug as this appears in multiple kernels -
I tested from v5.4 up to 5.13.0-rc5-next-20210608.

It is possible this will mask future bugs but that's life of a project
depending on kernel internals, not on API or ABI. The kernel is allowed
to change such details any moment because it is neither part of API nor
ABI. Therefore you just have to live with inaccurate limits or keep
investigating every x-months.

For now the test is simply unreliable.

Best regards,
Krzysztof
