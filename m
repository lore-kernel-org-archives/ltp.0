From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Dec 2019 21:34:01 +0100
Subject: [LTP] [PATCH] Remove duplicated ".needs_tmpdir=1" when using
 equivalent flags
In-Reply-To: <20191209074206.GA2373112@x230>
References: <1575447166-7813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191209074206.GA2373112@x230>
Message-ID: <20191209203401.GA2426018@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > From ltp library code, when we have used these flags(".needs_device"
> > ".mntpoint" ".resource_file" ".needs_checkpoints" ".format_device"
> > "mount_device" ".all_filesystems"), we don't need to set ".needs_tmpdir=1".
> > So remove it.

Patch for shell API (should be merged only if we agree on this one).
https://patchwork.ozlabs.org/patch/1206651/

Kind regards,
Petr
