From: Steve Muckle <smuckle@google.com>
Date: Tue, 26 Feb 2019 11:13:24 -0800
Subject: [LTP] [PATCH v4 2/3] aio_tio: convert to new lib
In-Reply-To: <20190226170243.134366-3-maennich@google.com>
References: <20190111085326.171826-1-maennich@google.com>
 <20190226170243.134366-1-maennich@google.com>
 <20190226170243.134366-3-maennich@google.com>
Message-ID: <e4bf66da-1f55-c93d-21c2-d82470090bea@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/26/2019 09:02 AM, Matthias Maennich wrote:
> Convert to the new test lib and perform various cleanups.
> Also refactor the test definition for readability.
> 
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>   testcases/kernel/io/aio/aio02/Makefile  |  24 +--
>   testcases/kernel/io/aio/aio02/aio_tio.c | 218 ++++++++++++------------
>   testcases/kernel/io/aio/aio02/common.h  |  28 ---
>   testcases/kernel/io/aio/aio02/main.c    |  37 ----
>   4 files changed, 110 insertions(+), 197 deletions(-)
>   delete mode 100644 testcases/kernel/io/aio/aio02/common.h
>   delete mode 100644 testcases/kernel/io/aio/aio02/main.c

Reviewed-by: Steve Muckle <smuckle@google.com>
