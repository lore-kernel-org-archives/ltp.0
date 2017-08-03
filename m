From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 3 Aug 2017 14:45:59 +0300
Subject: [LTP] [RFC PATCH v7 01/11] network/dhcp: Fix removing veth
 kernel module
In-Reply-To: <20170721040407.868-2-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-2-pvorel@suse.cz>
Message-ID: <b087c677-605c-1f57-3bc1-25927624b37a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/21/2017 07:03 AM, Petr Vorel wrote:
> From: Alexey Kodanev <alexey.kodanev@oracle.com>
>
> This patch fixes problems with dhcp based tests run via netns when they
> call TCONF:
>
> $ /opt/ltp/testscripts/network.sh -6
> dhcpd 1 TCONF: 'dhcpd' not found
> ...
> cat: /sys/class/net/ltp_ns_veth2/address: No such file or directory
>
> This also fixes other tests run after dhcp tests which are broken as
> netns setup got broken.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>

Applied.

Thanks,
Alexey

