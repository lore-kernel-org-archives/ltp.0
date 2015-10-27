From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 27 Oct 2015 15:47:50 +0300
Subject: [LTP] [PATCH 1/4] network: add test for low latency busy poll
In-Reply-To: <1442396839-29900-1-git-send-email-alexey.kodanev@oracle.com>
References: <1442396839-29900-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <562F7276.5090807@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,
On 09/16/2015 12:47 PM, Alexey Kodanev wrote:
> The test measures the performance of TCP client/server
> with and without busy poll feature, then it compares results.
>
> Enabling of busy poll is done globally via sysctl knobs,
> values are set to recommended ones (according to Linux docs).
>
> The feature was added in Linux 3.11.

Any comments regarding this patch-set?

Thanks,
Alexey
