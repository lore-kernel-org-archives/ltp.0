From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 6 Jun 2018 13:59:07 +0300
Subject: [LTP] [PATCH v2 ltp] network/stress/ssh/ssh-stress01-rmt: fix
 shellcheck error
In-Reply-To: <20180531023740.22811-1-yixin.zhang@intel.com>
References: <20180531023740.22811-1-yixin.zhang@intel.com>
Message-ID: <672590ff-bed2-22c5-a7a0-a19cb055b5d3@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 31.05.2018 05:37, Yixin Zhang wrote:
> testcases/network/stress/ssh/ssh-stress01-rmt:57:16: error: Since you
> double quoted this, it will not word split, and the loop will only run
> once. [SC2066]
> 
> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---

Applied, thanks!
