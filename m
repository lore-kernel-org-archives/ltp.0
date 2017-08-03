From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 3 Aug 2017 14:44:09 +0300
Subject: [LTP] [PATCH v2 1/5] netstress: add basic support for DCCP &
	SCTP
In-Reply-To: <1490285557-18122-1-git-send-email-alexey.kodanev@oracle.com>
References: <1490285557-18122-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <d6ea276e-22a7-2de9-1d85-a6de648103be@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/23/2017 07:12 PM, Alexey Kodanev wrote:
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>
> v2: add SCTP protocol and use '-T' option instead of -U and -D
>
>  testcases/network/netstress/netstress.c |  123 ++++++++++++++++++++++++++-----
>  1 files changed, 103 insertions(+), 20 deletions(-)

Applied patch-set + added new test-cases for IPsec and vti.

Thanks,
Alexey

