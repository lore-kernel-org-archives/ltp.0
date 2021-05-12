From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 10:26:16 +0200
Subject: [LTP] [PATCH v3] syscalls/chown: Rewrite chown/chown04.c with
 the new api
In-Reply-To: <20210506074621.167505-1-xieziyao@huawei.com>
References: <20210506074621.167505-1-xieziyao@huawei.com>
Message-ID: <YJuRKEfwChqpx70G@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

>  testcases/kernel/syscalls/chown/chown04.c | 228 +++++++---------------
...
> +/*\
> + * [Description]
>   *
> - * Test Description:
> - *   Verify that,
> - *   1) chown(2) returns -1 and sets errno to EPERM if the effective user id
> - *		 of process does not match the owner of the file and the process
> - *		 is not super user.
> - *   2) chown(2) returns -1 and sets errno to EACCES if search permission is
> - *		 denied on a component of the path prefix.
> - *   3) chown(2) returns -1 and sets errno to EFAULT if pathname points
> - *		 outside user's accessible address space.
> - *   4) chown(2) returns -1 and sets errno to ENAMETOOLONG if the pathname
> - *		 component is too long.
> - *   5) chown(2) returns -1 and sets errno to ENOTDIR if the directory
> - *		 component in pathname is not a directory.
> - *   6) chown(2) returns -1 and sets errno to ENOENT if the specified file
> - *		 does not exists.
> + * Verify that,
> + * 1) chown(2) returns -1 and sets errno to EPERM if the effective user id
> + *    of process does not match the owner of the file and the process is not
> + *    super user
> + * 2) chown(2) returns -1 and sets errno to EACCES if search permission is
> + *    denied on a component of the path prefix
> + * 3) chown(2) returns -1 and sets errno to EFAULT if pathname points outside
> + *    user's accessible address space
> + * 4) chown(2) returns -1 and sets errno to ENAMETOOLONG if the pathname
> + *    component is too long
> + * 5) chown(2) returns -1 and sets errno to ENOENT if the specified file does
> + *    not exists
> + * 6) chown(2) returns -1 and sets errno to ENOTDIR if the directory component
> + *    in pathname is not a directory
> + * 7) chown(2) returns -1 and sets errno to ELOOP if too many symbolic links
> + *    were encountered in resolving pathname
> + * 8) chown(2) returns -1 and sets errno to EROFS if the named file resides on
> + *    a read-only filesystem
>   */

FYI this is needed for proper docparse formatting:

/*\
 * [Description]
 *
 * Verify that:
 *
 * 1. chown(2) returns -1 and sets errno to EPERM if the effective user id
 *    of process does not match the owner of the file and the process is not
 *    super user
 * 2. chown(2) returns -1 and sets errno to EACCES if search permission is
 *    denied on a component of the path prefix
 * 3. chown(2) returns -1 and sets errno to EFAULT if pathname points outside
 *    user's accessible address space
 * 4. chown(2) returns -1 and sets errno to ENAMETOOLONG if the pathname
 *    component is too long
 * 5. chown(2) returns -1 and sets errno to ENOENT if the specified file does
 *    not exists
 * 6. chown(2) returns -1 and sets errno to ENOTDIR if the directory component
 *    in pathname is not a directory
 * 7. chown(2) returns -1 and sets errno to ELOOP if too many symbolic links
 *    were encountered in resolving pathname
 * 8. chown(2) returns -1 and sets errno to EROFS if the named file resides on
 *    a read-only filesystem
 */

Kind regards,
Petr
