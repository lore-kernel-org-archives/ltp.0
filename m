From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Apr 2020 21:43:28 +0200
Subject: [LTP] [PATCH 3/4] syscalls/fanotify15: Add a test case for
 inode marks
In-Reply-To: <20200421065002.12417-4-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-4-amir73il@gmail.com>
Message-ID: <20200427194328.GB12248@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

>  	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
>  		FAN_EVENT_OK(metadata, len); i++) {
> @@ -262,7 +323,8 @@ static struct tst_test test = {
>  	.mount_device = 1,
>  	.mntpoint = MOUNT_POINT,
>  	.all_filesystems = 1,
> -	.test_all = do_test,
> +	.test = do_test,
> +	.tcnt = ARRAY_SIZE(test_cases),
>  	.setup = do_setup,
>  	.cleanup = do_cleanup
Again, missing (can be added during merge):
-	.cleanup = do_cleanup
+	.cleanup = do_cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f367a62a7cad"},
+		{}
>  };

Apart from already mentioned FSID_VAL_MEMBER() LGTM, but again, somebody more
experienced in fanotify and/or filesystems should look into it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
