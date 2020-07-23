From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 23 Jul 2020 14:29:44 +0800
Subject: [LTP] [PATCH v2 1/2] libs/libltpnewipc: Add libnewmsgctl.c
In-Reply-To: <20200722150124.GA2714@yuki.lan>
References: <20200618094139.24579-1-xuyang_jy_0410@163.com>
 <20200722150124.GA2714@yuki.lan>
Message-ID: <d46eecee-44dc-7ef2-1a1a-d6c99be527eb@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> As far as I can tell this is only used in msgstress testcases right?
> 
> So unless we plan to use it from different tests it does not make much
> sense to export it to the top level include and libs.
> 
> Or alternatively we do have libltpnewipc we can pust put the
> libnewmsgctl.c to that directory and with that we will have a single
> System V IPC helper library.
I think your word means merge libnewmsgctl.c and head file into 
libnewipc.c. So we only have a single system V ipc lib. I will do it.

Best Regards
Yang Xu


