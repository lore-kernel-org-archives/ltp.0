From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 12 May 2021 17:19:20 +0800
Subject: [LTP] [PATCH v3] syscalls/chown: Rewrite chown/chown04.c with
 the new api
In-Reply-To: <YJuRKEfwChqpx70G@pevik>
References: <20210506074621.167505-1-xieziyao@huawei.com>
 <YJuRKEfwChqpx70G@pevik>
Message-ID: <058aa633-85cb-5378-be56-2be574d55adc@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> FYI this is needed for proper docparse formatting:
> 
> /*\
>   * [Description]
>   *
>   * Verify that:
>   *
>   * 1. chown(2) returns -1 and sets errno to EPERM if the effective user id
>   *    of process does not match the owner of the file and the process is not
>   *    super user
>   * 2. chown(2) returns -1 and sets errno to EACCES if search permission is
>   *    denied on a component of the path prefix
>   * 3. chown(2) returns -1 and sets errno to EFAULT if pathname points outside
>   *    user's accessible address space
>   * 4. chown(2) returns -1 and sets errno to ENAMETOOLONG if the pathname
>   *    component is too long
>   * 5. chown(2) returns -1 and sets errno to ENOENT if the specified file does
>   *    not exists
>   * 6. chown(2) returns -1 and sets errno to ENOTDIR if the directory component
>   *    in pathname is not a directory
>   * 7. chown(2) returns -1 and sets errno to ELOOP if too many symbolic links
>   *    were encountered in resolving pathname
>   * 8. chown(2) returns -1 and sets errno to EROFS if the named file resides on
>   *    a read-only filesystem
>   */
Already modified. Thanks for your review, Petr.

Kind Regards,
Ziyao
