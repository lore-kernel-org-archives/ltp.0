From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 22 Nov 2017 15:52:15 +0300
Subject: [LTP] [PATCH] runpwtests03:skip read check for the files
 without read permission
In-Reply-To: <1511345823-11979-1-git-send-email-shuang.qiu@oracle.com>
References: <1511345823-11979-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <9ef92391-29da-bf88-9997-408570f73dd4@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/22/2017 01:17 PM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
>
> According to the cpufreq-stats doc,cpufreq/stats/reset is
> write-only attribute of cpu freq sysfs file.
> So skip the cat checking for the files like this file which
> has not read permission.

Applied, thanks!
