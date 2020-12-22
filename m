From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Dec 2020 18:10:33 +0100
Subject: [LTP] [PATCH] cpio_tests.sh: Fix failure with BusyBox cpio
In-Reply-To: <20201221110120.26165-1-radoslav.kolev@suse.com>
References: <20201221110120.26165-1-radoslav.kolev@suse.com>
Message-ID: <20201222171033.GB126602@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav,

> A very limited BusyBox cpio requires the archive format to be
> explicitly set to newc when creating an archive.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...

> +ARCHIVE_FORMAT=""
ARCHIVE_FORMAT=
(quotes not needed)

> +
> +if cpio 2>&1 | grep -q '\-o\sCreate (requires -H newc)'; then
> +	ARCHIVE_FORMAT="-H newc"
> +fi
> +
>  cpio_test()
>  {
>  	ROD mkdir "dir"
> @@ -16,7 +22,7 @@ cpio_test()
>  	done

>  	ROD find dir -type f > filelist
> -	EXPECT_PASS cpio -o \> cpio.out \< filelist
> +	EXPECT_PASS cpio -o $ARCHIVE_FORMAT \> cpio.out \< filelist
>  	ROD mv "dir" "dir_orig"
>  	ROD mkdir "dir"
>  	EXPECT_PASS cpio -i \< cpio.out

Kind regards,
Petr
