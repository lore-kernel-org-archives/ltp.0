From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Mon, 12 Jul 2021 11:37:01 +0300
Subject: [LTP] [PATCH v2 1/2] shmget03: don't depend on existed shared
 resources
In-Reply-To: <CAEemH2ehOzddTbDqZBcbyZcnUy3899u_U81XGtckf1Gs_LJGMA@mail.gmail.com>
References: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2ehOzddTbDqZBcbyZcnUy3899u_U81XGtckf1Gs_LJGMA@mail.gmail.com>
Message-ID: <af9eb653-4c75-938e-71b1-2e4050b39d26@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12.07.2021 11:28, Li Wang wrote:
> 
> 
> On Mon, Jul 12, 2021 at 3:54 PM Alexey Kodanev <aleksei.kodanev@bell-sw.com <mailto:aleksei.kodanev@bell-sw.com>> wrote:
> 
>     It's unlikely, but still possible that some of them could be
>     created/released during the test as well, so the patch only
>     checks errno.
> 
>     Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com <mailto:aleksei.kodanev@bell-sw.com>>
>     ---
>     v2: * Move the loop to the test run function and try to get
>     ? ? ? ENOSPC errno there.
> 
> 
> I'm fine to go with this but move?the loop to test run without any
> limit will bring new fail if running with parameter '-i 2'.
> 
> We have to handle that situation (maybe add a judgment to skip
> test for run?more times) in case someone uses it like:

Or just release them asap after tpass?

> 
> # ./shmget03 -i 2
> tst_test.c:1344: TINFO: Timeout per run is 0h 05m 00s
> shmget03.c:44: TPASS: Maximum number of segments reached (4096), used by test 4096
> shmget03.c:41: TFAIL: Failed to trigger ENOSPC error: EEXIST (17)
> 
> -- 
> Regards,
> Li Wang

