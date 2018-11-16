From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 16 Nov 2018 14:51:11 +0300
Subject: [LTP] [PATCH v4 1/2] net: Add tst_net_run helper
In-Reply-To: <20181113163008.9093-1-pvorel@suse.cz>
References: <20181113163008.9093-1-pvorel@suse.cz>
Message-ID: <09aff1dd-a89f-479b-49da-c0c776b08b91@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 13.11.2018 19:30, Petr Vorel wrote:
> and use it in tst_set_sysctl
> 
> + improve doc of tst_rhost_run()
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> Hi,
> 
> Maybe we could signal where error occurred:
> * return 0: ok on both lhost and rhost
> * return 1: failure on lhost
> * return 2: failure on rhost
> * return 3: failure on both lhost and rhost
> 

It is only when there is no "safe" option, right? when doing cleanup?
Could we print TWARN message inside tst_net_run() in such case?


