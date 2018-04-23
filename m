From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Apr 2018 10:45:17 +0200
Subject: [LTP] [RFC PATCH 2/8] lib/tst_test: Populate the read-only fs
In-Reply-To: <20180405140154.6218-3-chrubis@suse.cz>
References: <20180405140154.6218-1-chrubis@suse.cz>
 <20180405140154.6218-3-chrubis@suse.cz>
Message-ID: <20180423084517.g3scwucoywn7mg3s@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Populate the read only filesystem with a file and a directory.

> This is needed for a testing syscalls such as unlink() or rmdir() for
> EROFS error.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---

Whole patchset LGTM.

Tested-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr
