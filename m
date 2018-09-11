From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 11 Sep 2018 11:24:37 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls/execveat01: new test to verify
 execveat unlinked fd
In-Reply-To: <1533111474.1176.4.camel@mtkswgap22>
References: <1533111474.1176.4.camel@mtkswgap22>
Message-ID: <1149740228.46962437.1536679477401.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> + * DESCRIPTION
> + *     Check if an unlinked executable can run in overlayfs mount.
> + *     The regression is introduced from 8db6c34f1dbc ("Introduce v3
> + *     namespaced file capabilities"). in security/commoncap.c,
> + *     cap_inode_getsecurity() use d_find_alias() cause unhashed dentry
> + *     can't be found. The solution could use d_find_any_alias() instead of
> + *     d_find_alias().
> + *
> + *     From kernel 4.14, this case is expected fails, execveat shell
> + *     return EINVAL.
> + *
> + */

We should fix this for release. If EINVAL is expected behaviour,
test should give PASS.

It's failing with 4.18:

tst_test.c:1063: INFO: Timeout per run is 0h 05m 00s
execveat03.c:71: FAIL: execveat() returned unexpected errno: EINVAL

Summary:
passed   0
failed   1
skipped  0
warnings 0

Regards,
Jan
