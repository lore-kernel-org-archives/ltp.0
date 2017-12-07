From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 7 Dec 2017 14:25:45 +0300
Subject: [LTP] [RFC PATCH 1/2] network/ipsec: Add trap to INT and
	require root
In-Reply-To: <20171206144214.27317-1-pvorel@suse.cz>
References: <20171206144214.27317-1-pvorel@suse.cz>
Message-ID: <91d018e3-744f-ec0d-114a-05871d3a1205@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 12/06/2017 05:42 PM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/stress/ipsec/ipsec_lib.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
> index cee755fe0..5cc2c9a45 100644
> --- a/testcases/network/stress/ipsec/ipsec_lib.sh
> +++ b/testcases/network/stress/ipsec/ipsec_lib.sh
> @@ -21,6 +21,9 @@
>  
>  . test_net.sh
>  
> +tst_require_root

> +trap "tst_brkm TBROK 'test interrupted'" INT

Could we add it to test_net.sh?

$ grep 'trap "' . -r

./busy_poll/busy_poll03.sh:trap "tst_brkm TBROK 'test interrupted'" INT
./busy_poll/busy_poll01.sh:trap "tst_brkm TBROK 'test interrupted'" INT
./busy_poll/busy_poll02.sh:trap "tst_brkm TBROK 'test interrupted'" INT
./stress/ns-tools/test_net_stress.sh:   trap "tst_brkm TBROK 'test interrupted'" INT
./stress/ssh/ssh-stress:        trap "tst_brkm TBROK 'test interrupted'" INT
./stress/ftp/ftp-upload-stress: trap "tst_brkm TBROK 'test interrupted'" INT
./stress/ftp/ftp-download-stress:       trap "tst_brkm TBROK 'test interrupted'" INT
./stress/interface/if4-addr-change:trap "tst_brkm TBROK 'test interrupted'" INT
./stress/http/http-stress:      trap "tst_brkm TBROK 'test interrupted'" INT
./stress/dns/dns-stress:        trap "tst_brkm TBROK 'test interrupted'" INT
./dhcp/dhcp_lib.sh:trap "tst_brkm TBROK 'test interrupted'" INT
./virt/virt_lib.sh:trap "tst_brkm TBROK 'test interrupted'" INT
./tcp_fastopen/tcp_fastopen_run.sh:trap "tst_brkm TBROK 'test interrupted'" INT


Thanks,
Alexey

> +
>  # Authenticated encryption with associated data
>  AEALGO="rfc4106_128"
>  # Encryption algorithm

