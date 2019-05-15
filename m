From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 May 2019 15:39:40 +0200
Subject: [LTP] [PATCH v2 2/2] OVL_MNT: put overlayfs lower, upper, work,
 mnt dir in a separated mountpoint
In-Reply-To: <20190515092129.26336-2-xzhou@redhat.com>
References: <20190503210005.GA18171@x230>
 <20190515092129.26336-1-xzhou@redhat.com>
 <20190515092129.26336-2-xzhou@redhat.com>
Message-ID: <20190515133940.GB5429@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Murphy,

> --- a/testcases/kernel/syscalls/execveat/execveat03.c
...
> -	/* Setup an overlay mount with lower file */
> -	SAFE_MKDIR("lower", 0755);
> -	SAFE_MKDIR("upper", 0755);
> -	SAFE_MKDIR("work", 0755);
> -	SAFE_MKDIR(OVL_MNT, 0755);
> -	ret = mount("overlay", OVL_MNT, "overlay", 0,
> -		    "lowerdir=lower,upperdir=upper,workdir=work");
> -	if (ret < 0) {
> -		if (errno == ENODEV) {
> -			tst_brk(TCONF,
> -				"overlayfs is not configured in this kernel.");
> -		}
> -		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
> -	}
> -	ovl_mounted = 1;
> +	if (setup_overlay(1) == 0)
> +		ovl_mounted = 1;
Here you change test behavior on ENODEV.

+ more info at 1st patch.

Kind regards,
Petr
