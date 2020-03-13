From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Mar 2020 08:30:13 +0100
Subject: [LTP] [PATCH] proc01: exclude /proc/nfsd/clients/*/ctl
In-Reply-To: <20200312142520.25842-1-alexey.kodanev@oracle.com>
References: <20200312142520.25842-1-alexey.kodanev@oracle.com>
Message-ID: <20200313073013.GB31549@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> "ctl" files are write-only, added in Linux 5.3 with this commit
> 89c905beccbb ("nfsd: allow forced expiration of NFSv4 clients")

> Before the patch:
> proc01      1  TFAIL  :  proc01.c:396: read failed: /proc/fs/nfsd/clients/13/ctl: errno=EINVAL(22): Invalid argument
> proc01      0  TINFO  :  /proc/fs/nfsd/unlock_filesystem: known issue: errno=EINVAL(22): Invalid argument
> proc01      0  TINFO  :  /proc/fs/nfsd/unlock_ip: known issue: errno=EINVAL(22): Invalid argument
> ...

> After:
> proc01      0  TINFO  :  /proc/fs/nfsd/clients/13/ctl: known issue: errno=EINVAL(22): Invalid argument
> proc01      0  TINFO  :  /proc/fs/nfsd/unlock_filesystem: known issue: errno=EINVAL(22): Invalid argument
> proc01      0  TINFO  :  /proc/fs/nfsd/unlock_ip: known issue: errno=EINVAL(22): Invalid argument
> ...

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
