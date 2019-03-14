From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Mar 2019 14:27:01 +0100
Subject: [LTP] [PATCH v2 1/4] shell: Add tst_mount() helper
In-Reply-To: <20190314111515.GA16190@rei>
References: <20190314094919.12723-1-pvorel@suse.cz>
 <20190314094919.12723-2-pvorel@suse.cz>
 <20190314111515.GA16190@rei>
Message-ID: <20190314132701.GA18419@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> The last nit is this piece of docummentation.

> - The last sentence is missing subject, generally the sentence does not
>   make much sense
> - We should document that TST_MNTPOINT defaults to mntpoint

> So it should be something as:

> The 'tst_mount' mounts '$TST_DEVICE' of '$TST_FS_TYPE' (optional) to
> '$TST_MNTPOINT' (defaults to mntpoint), optionally using the
> '$TST_MNT_PARAMS'. The '$TST_MNTPOINT' directory is created if it didn't
> exist prior to the function call.


> Otherwise it all looks fine, acked with a change to this docs.

Thank for fixes, merged!


Kind regards,
Petr
