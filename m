From: Steve Muckle <smuckle@google.com>
Date: Tue, 26 Feb 2019 11:16:24 -0800
Subject: [LTP] [PATCH v4 3/3] io/aio: cleanup test directory
In-Reply-To: <20190226170243.134366-4-maennich@google.com>
References: <20190111085326.171826-1-maennich@google.com>
 <20190226170243.134366-1-maennich@google.com>
 <20190226170243.134366-4-maennich@google.com>
Message-ID: <eb62c02d-bf92-40cf-dab0-56fa13ef4fff@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/26/2019 09:02 AM, Matthias Maennich wrote:
> Now that aio_tio is just a single file test, consolidate the aio tests
> within io/aio.
> 
> Suggested-by: Steve Muckle <smuckle@google.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>   runtest/io                                    |  2 +-
>   testcases/kernel/io/aio/.gitignore            |  4 +--
>   testcases/kernel/io/aio/Makefile              | 22 +++++---------
>   testcases/kernel/io/aio/{aio01 => }/aio01.c   |  0
>   testcases/kernel/io/aio/aio01/Makefile        | 30 -------------------
>   .../io/aio/{aio02/aio_tio.c => aio02.c}       |  0
>   testcases/kernel/io/aio/aio02/Makefile        | 14 ---------
>   testcases/kernel/io/aio/aio02/README          | 12 --------
>   8 files changed, 10 insertions(+), 74 deletions(-)
>   rename testcases/kernel/io/aio/{aio01 => }/aio01.c (100%)
>   delete mode 100644 testcases/kernel/io/aio/aio01/Makefile
>   rename testcases/kernel/io/aio/{aio02/aio_tio.c => aio02.c} (100%)
>   delete mode 100644 testcases/kernel/io/aio/aio02/Makefile
>   delete mode 100644 testcases/kernel/io/aio/aio02/README

Reviewed-by: Steve Muckle <smuckle@google.com>
