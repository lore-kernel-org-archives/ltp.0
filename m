From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 6 Jun 2017 14:32:06 +0300
Subject: [LTP] [PATCH v2] net: use LTP ns_create/ns_exec to support OS
 with legacy iproute
In-Reply-To: <1493823497-22391-1-git-send-email-alexey.kodanev@oracle.com>
References: <1493823497-22391-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <7dbae235-5fec-9ffe-d39f-49a6927c4c83@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 05/03/2017 05:58 PM, Alexey Kodanev wrote:
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> v2: move creation of veth pair out of 'if/else'

Applied v3 where 'ip' command not used. Also we can still run
'ip netns ex ltp_ns...' on the created network namespace.

