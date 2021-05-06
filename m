From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 6 May 2021 15:12:16 +0800
Subject: [LTP] [PATCH 1/3 v2] syscalls/chown: Rewrite chown/chown02.c
 with the new api
In-Reply-To: <YJAFldREJ1aQBDdh@yuki>
References: <20210430094513.162499-1-xieziyao@huawei.com>
 <20210430094513.162499-2-xieziyao@huawei.com> <YJAFldREJ1aQBDdh@yuki>
Message-ID: <31bca9c3-acd8-7d7d-7c41-152571e8f605@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Thanks for the modification, Cyril. BTW, the macro definition of 
FILE_MODE is useless and I suggest deleting it.

Please see: 
https://patchwork.ozlabs.org/project/ltp/patch/20210506071118.140135-1-xieziyao@huawei.com/

Kind regards,
Ziyao

On 2021/5/3 22:15, Cyril Hrubis wrote:
> Hi!
> Pushed with minor changes, thanks.
> 
> * I've updated the documentation comment a bit
> * Moved the chmod() to the run() function so that the test
>    changes back the modified permissions with -i parameter
> 
