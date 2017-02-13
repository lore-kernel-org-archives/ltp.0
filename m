From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 13 Feb 2017 11:03:55 -0500 (EST)
Subject: [LTP] [PATCH 4/6] test.sh: Remove tst_{acquire, release}_device,
 tst_mkfs
In-Reply-To: <20170208110255.443-4-chrubis@suse.cz>
References: <20170208110255.443-1-chrubis@suse.cz>
 <20170208110255.443-4-chrubis@suse.cz>
Message-ID: <1615801703.3823999.1487001835110.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Wednesday, 8 February, 2017 12:02:53 PM
> Subject: [LTP] [PATCH 4/6] test.sh: Remove tst_{acquire, release}_device,	tst_mkfs
> 
> There are not used by any test that uses test.sh library.

Not even this one? ./testcases/kernel/fs/fs_readonly/test_robind.sh
It sources test.sh and calls tst_mkfs.

Other than that, I think we agreed to drop/replace 1/6, and skip
update_results() if ipc has not been set up.

The rest looks good to me.

Regards,
Jan

> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/lib/test.sh | 72
>  ---------------------------------------------------
>  1 file changed, 72 deletions(-)

