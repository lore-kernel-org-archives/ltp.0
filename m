From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Mar 2021 15:06:39 +0200
Subject: [LTP] [PATCH] syscalls/chdir01: Add umask before mkdir
In-Reply-To: <20210317072652.26974-1-zhaogongyi@huawei.com>
References: <20210317072652.26974-1-zhaogongyi@huawei.com>
Message-ID: <YGMiX2+NklFVNeIX@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> When uid is nobody, umask is not 022, the test process might
Not sure if I understand "When uid is nobody, umask is not 022",
umask setup depends usually on the system. I wonder which system has different
setup for nobody.

BTW later was posted another solution, see my comments there.

Kind regards,
Petr

[2] https://patchwork.ozlabs.org/project/ltp/patch/20210322091512.103266-1-xieziyao@huawei.com/

> has not permmission to access the file which created by SAFE_MKDIR
> with mode 0755.
