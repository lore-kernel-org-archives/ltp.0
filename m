From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Nov 2019 11:46:03 +0100
Subject: [LTP] [PATCH 2/2] network/iptables: add new test for
 iptables-tranlsate and nft
In-Reply-To: <20191126115344.15926-2-alexey.kodanev@oracle.com>
References: <20191126115344.15926-1-alexey.kodanev@oracle.com>
 <20191126115344.15926-2-alexey.kodanev@oracle.com>
Message-ID: <20191128104603.GA3216@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> * Reuse the test-cases from iptables_tests by moving them
>   into iptables_lib.sh.

> * create nft rules with iptables-translate.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

Thanks for your patch.
Rewrite is ok, I'd just also drop dots from messages.

Also redirection to tst_iptables.out in cleanup() is pointless,
maybe we could just change:

cleanup()
{
	if lsmod | grep -q "ip_tables"; then
		NFRUN -F -t filter > /dev/null 2>&1
		NFRUN -F -t nat > /dev/null 2>&1
		NFRUN -F -t mangle > /dev/null 2>&1
		rmmod -v ipt_limit ipt_multiport ipt_LOG ipt_REJECT \
			 iptable_mangle iptable_nat ip_conntrack \
			 iptable_filter ip_tables nf_nat_ipv4 nf_nat \
			 nf_log_ipv4 nf_log_common nf_reject_ipv4 \
			 nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack \
			 > /dev/null 2>&1
	fi
}

For further work on iptables tests: I wonder if nc is more commonly installed in
distros than telnet (if yes, I'd be for using it).

But for nft01.sh I got error:

nft01 1 TINFO: INIT: Flushing all rules.
nft01 1 TCONF: nft not applicable for test 1
nft01 2 TINFO: Use nft to DROP packets from particular IP
nft01 2 TINFO: Rule to block icmp from 127.0.0.1
nft01 2 TFAIL: nft command failed to append new rule.
Error: Could not process rule: No such file or directory
add rule ip filter INPUT ip protocol icmp ip saddr 127.0.0.1 counter drop
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
nft01 3 TINFO: Use nft to REJECT ping request.
nft01 3 TINFO: Rule to reject ping request.
nft01 3 TFAIL: nft command failed to append new rule.
Error: Could not process rule: No such file or directory
add rule ip filter INPUT ip daddr 127.0.0.1 icmp type echo-request counter reject
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
nft01 4 TINFO: Use nft to log packets to particular port.
nft01 4 TINFO: Rule to log tcp packets to particular port.
nft01 4 TFAIL: nft command failed to append new rule.
Error: Could not process rule: No such file or directory
add rule ip filter INPUT ip daddr 127.0.0.1 tcp dport 45886 counter log prefix "1128114107:"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
nft01 5 TINFO: Use nft to log packets to multiple ports.
nft01 5 TINFO: Rule to log tcp packets to port 45801 - 45803.
nft01 5 TFAIL: nft command failed to append new rule.
Error: Could not process rule: No such file or directory
add rule ip filter INPUT ip daddr 127.0.0.1 tcp dport 45801-45803 counter log prefix "1128114107:"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
nft01 6 TINFO: Use nft to log ping request with limited rate.
nft01 6 TINFO: Rule to log ping request.
nft01 6 TFAIL: nft command failed to append new rule.
Error: Could not process rule: No such file or directory
add rule ip filter INPUT ip daddr 127.0.0.1 icmp type echo-request limit rate 3/hour burst 5 packets counter log prefix "1128114107:"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Tested on openSUSE Tumbleweed (5.3.8-1-default, nftables v0.9.2 (Scram),
iptables v1.8.3 (legacy)) and Debian unstable (5.2.0-rc3+, nftables v0.9.0 (Fearless Fosdick), iptables v1.8.2 (nf_tables)). Am I missing something, have wrong version?

Kind regards,
Petr
