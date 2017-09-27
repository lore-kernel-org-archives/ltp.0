From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Sep 2017 14:06:32 +0300
Subject: [LTP] [PATCH v3 1/1] network/stress: Fix and cleanup part of
 multicast group tests
In-Reply-To: <20170925165254.20595-1-pvorel@suse.cz>
References: <20170925165254.20595-1-pvorel@suse.cz>
Message-ID: <298e2e9a-7ff8-2c64-9ab6-62ff61d91e44@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09/25/2017 07:52 PM, Petr Vorel wrote:
> * Fix test for SSH and netns based testing.
> * Remove hardcoded rsh dependency.
> * Create shell library mcast-lib.sh (multicast specific) to reduce
>   duplicity in tests. Library uses test_stress_net.sh (and therefore
>   test_net.sh).
> * Merged IPv4 and IPv6 group tests into one file.
> * Renamed test names and files (readability).
> * Cleanup code + fixed typos.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Applied, thank you Petr.

Best regards,
Alexey

