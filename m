From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 4 May 2018 17:18:50 +0300
Subject: [LTP] [PATCH 1/1] ipneigh01: Replace TCONF error message with
 TINFO
In-Reply-To: <20180503113637.21573-1-asmorodskyi@suse.com>
References: <20180503113637.21573-1-asmorodskyi@suse.com>
Message-ID: <2943ea0b-0487-0136-bd1c-6d90bf80385f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03.05.2018 14:36, Anton Smorodskyi wrote:
> When test case catch that arp command not support ipv6
> it is more appropriate to send this as TINFO message
Hi Anton,

And why it is more appropriate? TCONF is not an error message.

> @@ -76,7 +76,7 @@ rhost=$(tst_ipaddr rhost)
>  if [ -z "$TST_IPV6" ]; then
>  	do_test "arp -a" "arp -d $rhost"
>  else
> -	tst_resm TCONF "'arp cmd doesn't support IPv6, skipping test-case"
> +	tst_resm TINFO "'arp cmd doesn't support IPv6, skipping test-case"
>  fi


TCONF here, only to make sure that the test results are consistent with
'TST_TOTAL=2', regardless whether we use '-6' option or not.
