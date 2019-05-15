From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 May 2019 20:20:57 +0200
Subject: [LTP] [PATCH v2 1/2] OVL_MNT: add setup_overlay helper
In-Reply-To: <CAOQ4uxhaSBiKY7nLNnbvpc7mpcnyOJ8Ecf3Es8n_VTPBRnfF7g@mail.gmail.com>
References: <20190503210005.GA18171@x230>
 <20190515092129.26336-1-xzhou@redhat.com>
 <20190515133102.GA5429@dell5510> <20190515134245.GC5429@dell5510>
 <CAOQ4uxhaSBiKY7nLNnbvpc7mpcnyOJ8Ecf3Es8n_VTPBRnfF7g@mail.gmail.com>
Message-ID: <20190515182057.GA1856@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir, Murphy,


> I liked your idea of create_overlay_dirs/mount_overlay better.
> It is more flexible for future tests that may want to umount and
> mount overlay several times and the setup of lower/upper files
> could be very different in future tests, not limited to just creating
> files (maybe symlinks, xattr).
> The experience from xfstests overlay tests suggests that the
> create_overlay_dirs/mount_overlay helpers are a good model to follow.

Thanks for ideas, agree with it.

Other thing is to have const char *file, const int lineno as first parameters
for mount_overlay_() and create mount_overlay() and SAFE_MOUNT_OVERLAY() as macros,
which would use it. See tst_mkfs{_,}() as examples.

> Thanks,
> Amir.

Kind regards,
Petr
