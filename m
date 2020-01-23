From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Jan 2020 14:15:22 +0100
Subject: [LTP] [PATCH v4] syscalls/newmount: new test case for new mount
 API
In-Reply-To: <20200123104114.GD27845@rei>
References: <20200116075633.29752-1-zlang@redhat.com>
 <20200116114900.GA4897@rei>
 <20200116150849.GF14282@dhcp-12-102.nay.redhat.com>
 <20200117074828.GA3979@dell5510>
 <20200117110554.GG14282@dhcp-12-102.nay.redhat.com>
 <20200123104114.GD27845@rei>
Message-ID: <20200123131522.GA94750@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Cyril, thanks for review.

> > For FUSE, I think we'd better to not test FUSE by default. Then let the case decide if
> > it would like to support a FUSE fs test. Change the TST_FS_SKIP_FUSE to TST_FS_SUP_FUSE,
> > if someone case wants to test a FUSE fs (likes ntfs), it should do special steps to mount
> > it, or it'll test linux internal ntfs.ko.

> It works fine for majority of testcases, the mount() and fsmount()
> syscalls are kind of special here. I guess that all we need to do here
> is to skip the fuse here.
Great, we get back to the original suggestion, which is in v4:
.dev_fs_flags	= TST_FS_SKIP_FUSE,

Kind regards,
Petr
