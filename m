From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 21 May 2020 15:11:49 +0200
Subject: [LTP] [PATCH 2/5] include: Add declaration of struct ipc64_perm
In-Reply-To: <5a10d33509ac73c26b233ab72c579f44386d0a55.1590057824.git.viresh.kumar@linaro.org>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
 <5a10d33509ac73c26b233ab72c579f44386d0a55.1590057824.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a2yN+AwWP-BdiPg+NkyB5z00jXoSt4vQCzPJfzWpZvW6w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 21, 2020 at 12:47 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This adds declaration of struct ipc64_perm, which will be used by
> following patches.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Like the other structures, there are multiple definitions in the kernel:

$ git grep ^struct.ipc64_perm
arch/parisc/include/uapi/asm/ipcbuf.h:struct ipc64_perm
arch/powerpc/include/uapi/asm/ipcbuf.h:struct ipc64_perm
arch/s390/include/uapi/asm/ipcbuf.h:struct ipc64_perm
arch/sparc/include/uapi/asm/ipcbuf.h:struct ipc64_perm
arch/xtensa/include/uapi/asm/ipcbuf.h:struct ipc64_perm
include/uapi/asm-generic/ipcbuf.h:struct ipc64_perm

Any reason you can't just #include <asm/ipcbuf.h> to get the
kernel's definition for the correct architecture?

        Arnd
