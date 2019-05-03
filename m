From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 May 2019 23:00:05 +0200
Subject: [LTP] [PATCH] OVL_MNT: put overlayfs lower, upper, work,
 mnt dir in separated mountpoint
In-Reply-To: <20190430043957.479-1-xzhou@redhat.com>
References: <20190430043957.479-1-xzhou@redhat.com>
Message-ID: <20190503210005.GA18171@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Acked-by: Petr Vorel <pvorel@suse.cz>

>  testcases/kernel/syscalls/inotify/inotify07.c | 24 +++++++++++------

> -#define OVL_MNT "ovl"
> +#define MNTPOINT	"mntpoint"
> +#define OVL_LOWER	MNTPOINT"/lower"
> +#define OVL_UPPER	MNTPOINT"/upper"
> +#define OVL_WORK	MNTPOINT"/work"
> +#define OVL_MNT		MNTPOINT"/ovl"
> +
>  #define TEST_APP "execveat_child"
>  #define TEST_FILE_PATH OVL_MNT"/"TEST_APP

> +static const char mntpoint[] = MNTPOINT;
> +
>  static int ovl_mounted;

>  static void do_child(void)
> @@ -91,12 +98,12 @@ static void setup(void)
>  	check_execveat();

>  	/* Setup an overlay mount with lower file */
> -	SAFE_MKDIR("lower", 0755);
> -	SAFE_MKDIR("upper", 0755);
> -	SAFE_MKDIR("work", 0755);
> +	SAFE_MKDIR(OVL_LOWER, 0755);
> +	SAFE_MKDIR(OVL_UPPER, 0755);
> +	SAFE_MKDIR(OVL_WORK, 0755);
>  	SAFE_MKDIR(OVL_MNT, 0755);
NOTE: Maybe it'd be worth of adding some helper to define these constants and creating this setup (in separate commit).


Kind regards,
Petr
