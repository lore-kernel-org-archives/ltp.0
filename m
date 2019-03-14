From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Mar 2019 12:15:15 +0100
Subject: [LTP] [PATCH v2 1/4] shell: Add tst_mount() helper
In-Reply-To: <20190314094919.12723-2-pvorel@suse.cz>
References: <20190314094919.12723-1-pvorel@suse.cz>
 <20190314094919.12723-2-pvorel@suse.cz>
Message-ID: <20190314111515.GA16190@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +Mounting and unmounting filesystems
> ++++++++++++++++++++++++++++++++++++
> +
> +The 'tst_mount' and 'tst_umount' helpers are a safe way to mount/umount a filesystem.
>  
> -The 'tst_umount' helper is a safe way to umount a filesystem.
> +The 'tst_mount' mounts '$TST_DEVICE' of '$TST_FS_TYPE' (optional) to '$TST_MNTPOINT',
> +using optional '$TST_MNT_PARAMS'. It creates before mounting the '$TST_MNTPOINT'
> +directory if not exists and fails if mounting was unsuccessful.

The last nit is this piece of docummentation.

- The last sentence is missing subject, generally the sentence does not
  make much sense
- We should document that TST_MNTPOINT defaults to mntpoint

So it should be something as:

The 'tst_mount' mounts '$TST_DEVICE' of '$TST_FS_TYPE' (optional) to
'$TST_MNTPOINT' (defaults to mntpoint), optionally using the
'$TST_MNT_PARAMS'. The '$TST_MNTPOINT' directory is created if it didn't
exist prior to the function call.


Otherwise it all looks fine, acked with a change to this docs.

-- 
Cyril Hrubis
chrubis@suse.cz
