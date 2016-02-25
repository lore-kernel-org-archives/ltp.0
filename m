From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 25 Feb 2016 12:50:25 +0300
Subject: [LTP] [PATCH v3] Clean up hugemmap02 testcase
In-Reply-To: <1455697356-4839-1-git-send-email-shuang.qiu@oracle.com>
References: <1455697356-4839-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <56CECE61.1020601@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 02/17/2016 11:22 AM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
>
> * Remove continue in the loop because it skips the cleanup
>
> * munmap() addr2 for 32-bit
>
> * close nfildes fd in the end of loop
>

Slightly changed the commit subject and applied.

Best regards,
Alexey

