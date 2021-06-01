From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 1 Jun 2021 11:48:44 +0300
Subject: [LTP] [PATCH 1/2] network/busy_poll: Fix tests in namespaced env
In-Reply-To: <20210531135314.5067-1-mdoucha@suse.cz>
References: <20210531135314.5067-1-mdoucha@suse.cz>
Message-ID: <f8300887-b372-950e-5c26-92ba36869246@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 31.05.2021 16:53, Martin Doucha wrote:
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/network/busy_poll/busy_poll01.sh | 15 ++++++---------
>  testcases/network/busy_poll/busy_poll02.sh |  7 +++----
>  testcases/network/busy_poll/busy_poll03.sh |  7 +++----
>  3 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
> 

Hi Martin,

...
>  setup()
>  {
>  	busy_poll_check_config
>  
> -	busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
> -	rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
> +	busy_poll_old="$(sysctl -n /proc/sys/net/core/busy_poll)"
> +	rbusy_poll_old=$(tst_rhost_run -c 'sysctl -ne /proc/sys/net/core/busy_poll')
>  }

Here should be net.core.busy_poll, not the path.
Otherwise looks good.
