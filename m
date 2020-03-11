From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Mar 2020 19:56:38 +0100
Subject: [LTP] [PATCH v2 3/3] nfs_lib: Add option to run traffic via lo
 on netns
In-Reply-To: <20200311175011.12171-3-pvorel@suse.cz>
References: <20200311175011.12171-1-pvorel@suse.cz>
 <20200311175011.12171-3-pvorel@suse.cz>
Message-ID: <20200311185638.GA12912@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
...
> +# When set and test is using netns ($TST_USE_NETNS set) NFS traffic will go
> +# through lo interface instead of ltp_ns_veth* netns interfaces (useful for
> +# debugging whether test failures are related to veth/netns).
> +LTP_NFS_NETNS_USE_LO=
Sorry, this needs to be
LTP_NFS_NETNS_USE_LO=${LTP_NFS_NETNS_USE_LO:-}

+ suggest different name, if you don't like this.

Kind regards,
Petr
