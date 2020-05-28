From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2020 13:56:36 +0200
Subject: [LTP] [RFC PATCH 1/2] LVM: Don't require root for
 generate_lvm_runfile.sh
In-Reply-To: <858875ff-2137-38b6-8301-f44e745f8026@suse.cz>
References: <20200528110554.10179-1-pvorel@suse.cz>
 <20200528110554.10179-2-pvorel@suse.cz>
 <858875ff-2137-38b6-8301-f44e745f8026@suse.cz>
Message-ID: <20200528115636.GB16726@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 28. 05. 20 13:05, Petr Vorel wrote:
> > LTPROOT can be in user writable directory. Having rights for make
> > install is user responsibility, it does not have to be guarded by
> > TST_NEEDS_ROOT=1.

> TST_NEEDS_ROOT=1 is there for tst_supported_fs. It won't find any mkfs
> programs if it's not running as root.
Right, thanks for info. Hm, there can be some tests which just want to know
supported filesystems without running them and we have to require root for them.

There could be a solutions (tst_get_supported_fs_types() could have warning
about PATH when user is not root and no mkfs.* found or just changing in
has_mkfs() "mkfs.%s does not exist" to "mkfs.%s does not found" to give more
obvious hint). But it's just a corner case issue, no need to bother with it.

Kind regards,
Petr
