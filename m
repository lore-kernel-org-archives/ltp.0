From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Feb 2017 10:40:40 -0500 (EST)
Subject: [LTP] [PATCH] aio_suspend_4-1: Fix failures on s390x
In-Reply-To: <20170202132226.32352-1-chrubis@suse.cz>
References: <20170202132226.32352-1-chrubis@suse.cz>
Message-ID: <93175945.2218188.1486050040647.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Thursday, 2 February, 2017 2:22:26 PM
> Subject: [PATCH] aio_suspend_4-1: Fix failures on s390x
> 
> The testcase often fails on s390x due to fast I/O. The AIO request we
> wanted to timeout on finishes too fast most of the time.
> 
> While this is not a complete fix it's good enough so that the test works
> fine if executed 1000 times, previously the success ratio was between
> 20% and 80%.
> 
> This patch changes:
> 
> * The file is written instead of read
>   - this simplifies the code and also ensures that we are not just
>     reading data from kernel caches
> 
> * The file is opened with O_SYNC
>   - which increases chance that the buffers are not written too fast
> 
> * The timeout is decreased
> 
> * The buffer sizes are increased, especially for the AIO operation we
>   want to timeout on
> 
> + Simplifications in error paths
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
> 
> Jan: Have you seen this test failing on s390x as well?

Yes, and I think also ppc. My notes say this is race-y testcase.

>      Can you please test the patch on RHEL on s390x?

I ran it for ~15 minutes on s390x in loop, no failures.

SNIP

Since this is write operation, skipping to "exit:" and free when we hit error,
while requests are still in-flight should be OK.

>  
>  	/* Wait for list processing completion */
>  	while (!received_all)
> -		sleep(1);
> +		usleep(50000);

Should we limit this loop by some counter? If something goes wrong,
this can loop forever.

Other than nit above, it looks good to me, ACK.

Regards,
Jan
