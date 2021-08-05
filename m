From: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Thu, 05 Aug 2021 17:50:11 -0400
Subject: [LTP] [PATCH 6/7] syscalls/fanotify20: Test file event with
 broken inode
In-Reply-To: <CAOQ4uxis23+T3=+R+9rKkxtZLtS4S4LJ6RBgG0AEHsg4=MJyRA@mail.gmail.com>
 (Amir Goldstein's message of "Wed, 4 Aug 2021 08:27:46 +0300")
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-7-krisman@collabora.com>
 <CAOQ4uxizX0ar7d9eYgazcenQcA7Ku7quEZOLbcaxKJiY0sTPLA@mail.gmail.com>
 <87k0l1hkuz.fsf@collabora.com>
 <CAOQ4uxis23+T3=+R+9rKkxtZLtS4S4LJ6RBgG0AEHsg4=MJyRA@mail.gmail.com>
Message-ID: <87tuk3ef3g.fsf@collabora.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi Amir,

thanks for the review.

Amir Goldstein <amir73il@gmail.com> writes:
> Well, I would not expect a FAN_FS_ERROR event to ever have 0 error
> value. Since this test practically only tests ext4, I do not think it
> is reasonable
> for the test to VERIFY a bug. It is fine to write this test with expectations
> that are not met and let it fail.

This gave me a good chuckle. :)  I will check for a
EXT4_ERR_EFSCORRUPTED and propose a fix on ext4.

>
> But a better plan would probably be to merge the patches up to 5 to test
> FAN_FS_ERROR and then add more test cases after ext4 is fixed
> Either that or you fix the ext4 problem along with FAN_FS_ERROR.
>
> Forgot to say that the test needs to declare .needs_cmds "debugfs".
>
> In any case, as far as prerequisite to merging FAN_FS_ERROR
> your WIP tests certainly suffice.
> Please keep your test branch around so we can use it to validate
> the kernel patches.
> I usually hold off on submitting LTP tests for inclusion until at least -rc3
> after kernel patches have been merged.

As requested, I will not send a new version of the test for now. I
published them on the following unstable branch:

  https://gitlab.collabora.com/krisman/ltp -b fan-fs-error

The v1, as submitted in this thread is also available at:

  https://gitlab.collabora.com/krisman/ltp -b fan-fs-error-v1

Thanks,

-- 
Gabriel Krisman Bertazi
