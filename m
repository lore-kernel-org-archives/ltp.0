From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Oct 2018 18:13:25 +0200
Subject: [LTP] [PATCH] network/nfs: support default setup,
	use local mount
In-Reply-To: <1539091079-21887-1-git-send-email-alexey.kodanev@oracle.com>
References: <1539091079-21887-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20181012161325.GA29781@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> For default setup, start the server locally instead and mount
> inside netns to run NFS traffic over the veth or whatever is
> used for a single machine setup.

> We could also use lo interface, we just need to skip the last
> check in nfs_mount()/nfs_lib.sh.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

LGTM, thanks for the patch!

BTW how about split runtest/net.nfs, so it takes shorter to run?
Maybe it takes so long on my side as I still experience some problems with NFS,
which I haven't debugged yet (timeout).


Kind regards,
Petr
