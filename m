From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 30 Apr 2019 19:12:51 +0300
Subject: [LTP] [PATCH 2/2] net/tracepath: Rewrite into new API
In-Reply-To: <20190429072800.23067-2-pvorel@suse.cz>
References: <20190429072800.23067-1-pvorel@suse.cz>
 <20190429072800.23067-2-pvorel@suse.cz>
Message-ID: <946495a7-4f75-4cca-163d-9447818bf1c3@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 29.04.2019 10:28, Petr Vorel wrote:
> enhancements:
> * Check for tracepath -6 when tracepath6 not available
>   tracepath6 was removed in iputils s20161105 and replaced by tracepath -6,
>   this way it's portable for both all iputils releases
> 
> * Print tracepath version if -V is available (added in inputils s20190324)
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../network/tcp_cmds/tracepath/tracepath01.sh | 60 +++++++++----------
>  1 file changed, 29 insertions(+), 31 deletions(-)


Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
