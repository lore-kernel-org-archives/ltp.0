From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 7 May 2021 16:35:08 +0800
Subject: [LTP] [PATCH 3/3] syscalls/io_submit: Convert libaio wrapper
 function to kernel syscall
In-Reply-To: <YJQz+MgeKcflG+Zn@pevik>
References: <20210429115021.24128-1-xieziyao@huawei.com>
 <20210429115021.24128-4-xieziyao@huawei.com> <YJE5bkB8+PFBMWwD@yuki>
 <f47c4ec5-2d4a-76c8-5ef4-f8cfb12961e9@huawei.com> <YJPnpfByh/C5kXbr@pevik>
 <YJP2IDZIEOltnTiq@yuki> <YJQz+MgeKcflG+Zn@pevik>
Message-ID: <20346193-98d6-1a2f-0f07-3305bbc33f8f@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Thanks a lot for your suggestions. I just submitted new testcases for 
native AIO.

Please see: https://patchwork.ozlabs.org/project/ltp/list/?series=242617

And if there are no questions, I'll continue with the following:
1. Convert the original libaio testcases to the new API;
2. Add native AIO testcases for other testsuites in kernel/syscalls.

Thanks very much!

Kind Regards,
Ziyao
