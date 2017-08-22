From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Aug 2017 03:53:45 -0400 (EDT)
Subject: [LTP] [PATCH v2 1/1] ltp-pan: Log start of test in kernel log
In-Reply-To: <20170821141106.30862-1-pvorel@suse.cz>
References: <20170821141106.30862-1-pvorel@suse.cz>
Message-ID: <1743284864.1426859.1503388425366.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> This can be switched by new '-Q' flag or by existing '-q' flag (quiet mode).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Please use v1, if switching by '-q' is enough.
> ---
>  pan/ltp-pan.c | 58
>  +++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 15 deletions(-)
> 

Hi,

Looks good to me too, worked as expected on old/new RHEL distros.

Regards,
Jan
