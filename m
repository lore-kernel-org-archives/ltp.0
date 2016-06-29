From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 29 Jun 2016 16:51:28 +0300
Subject: [LTP] [PATCH] network/virt: adjust virt_threshold by using
 environment variable
In-Reply-To: <1464350058-15558-1-git-send-email-alexey.kodanev@oracle.com>
References: <1464350058-15558-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <5773D260.4010005@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/27/2016 02:54 PM, Alexey Kodanev wrote:
> Add the ability to configure performance threshold of virtual
> devices by using environment variable. Also rename:
>
>    virt_threshold -> VIRT_PERF_THRESHOLD,
>
> and print it in the test result message.

Applied patch.

Thanks,
Alexey

