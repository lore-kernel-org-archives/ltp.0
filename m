From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 2 Nov 2018 21:13:23 +0100
Subject: [LTP] [PATCH 5/6] network/mpls03: add MPLS over GRE and GREv6
In-Reply-To: <1540818202-11247-6-git-send-email-alexey.kodanev@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
 <1540818202-11247-6-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20181102201323.GB17405@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Note, support for GREv6 was added in Linux 4.19.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

Just one more tst_set_sysctl:

> +mpls_virt_setup()
> +{
...
> +	ROD sysctl -q net.mpls.conf.ltp_v0.input=1
> +	tst_rhost_run -s -c "sysctl -q net.mpls.conf.ltp_v0.input=1"
tst_set_sysctl net.mpls.conf.ltp_v0.input 1 safe


Kind regards,
Petr
