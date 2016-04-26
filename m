From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 26 Apr 2016 20:07:09 +0300
Subject: [LTP] [PATCH v6 3/3] network/stress/icmp: add icmp-uni-basic to
 implement all icmp basic stress test
In-Reply-To: <1461550866-21003-4-git-send-email-haliu@redhat.com>
References: <1461550866-21003-1-git-send-email-haliu@redhat.com>
 <1461550866-21003-4-git-send-email-haliu@redhat.com>
Message-ID: <571FA03D.7000906@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hangbin,
On 04/25/2016 05:21 AM, Hangbin Liu wrote:
> ...
> +# The test case ID, the test case count and the total number of test case
I meant this particular line above :)
> ...
> +tst_ping $lhost_ifname $rhost_addr $ICMP_SIZE_ARRAY
> +if [ $? -ne 0 ]; then
> +	tst_brkm TFAIL "Check IPv${TST_IPV6:-4} $IPSEC_PROTO $IPSEC_MODE connectivity "

tst_brkm not needed here as well

> +else
> +	tst_resm TPASS "Check IPv${TST_IPV6:-4} $IPSEC_PROTO $IPSEC_MODE connectivity"
> +fi
> +
> +tst_exit

Cyril,

Do you have any objections to pushing the patch-set before release?

Thanks,
Alexey

