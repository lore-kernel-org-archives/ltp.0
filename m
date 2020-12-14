From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 14 Dec 2020 14:21:00 +0300
Subject: [LTP] [PATCH 1/1] host01.sh: Allow to overwrite the default
 hostname
In-Reply-To: <20201211071545.10209-1-pvorel@suse.cz>
References: <20201211071545.10209-1-pvorel@suse.cz>
Message-ID: <e504fd30-aacd-ec7b-6f09-172242573e6e@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11.12.2020 10:15, Petr Vorel wrote:
> Using hostname for test requires DNS setup.
> Allow to set hostname (e.g. github.com) via $HOSTNAME in case host not
> set. This restores the old behavior (the legacy API version used $RHOST).
> 
> Suggested-by: Petr Cervinka <pcervinka@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/tcp_cmds/host/host01.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
