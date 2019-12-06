From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 6 Dec 2019 17:18:46 +0100
Subject: [LTP] [PATCH] syscalls/newmount: new test case for new mount API
In-Reply-To: <20191206162332.GH4601@dhcp-12-102.nay.redhat.com>
References: <20191128173532.6468-1-zlang@redhat.com>
 <20191203130339.GF2844@rei>
 <20191206162332.GH4601@dhcp-12-102.nay.redhat.com>
Message-ID: <20191206161846.GC729@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sorry I can't be 100% sure what you mean at here. Do you mean as this:
> --
> TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
> if (TST_RET < 0) {
> 	tst_brk(TFAIL | TTERRNO,
> 		"fsopen %s", tst_device->fs_type);
> }
> sfd = TST_RET;
> tst_res(TPASS, "fsopen %s", tst_device->fs_type);

Yes, indeed. The tst_brk() calls exit() so it never returns back to the
caller.

-- 
Cyril Hrubis
chrubis@suse.cz
