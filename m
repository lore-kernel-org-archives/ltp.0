From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jan 2020 11:11:19 +0100
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <20200107071324.29492-1-liwang@redhat.com>
References: <20200107071324.29492-1-liwang@redhat.com>
Message-ID: <20200107101119.GA22967@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  This function reads test block device stat file (/sys/block/<device>/stat) and
> -returns the bytes written since the last invocation of this function.
> +returns the bytes written since the last invocation of this function. To avoid
> +FS deferred IO metadata/cache interferes the result, we suggest doing "syncfs"
                                 |   interfecence    |

> +before the tst_dev_bytes_written first invocation. And an inline function named
> +tst_dev_sync is created for that intention.

Other than this it looks good to me, thanks for doing this, acked.


-- 
Cyril Hrubis
chrubis@suse.cz
