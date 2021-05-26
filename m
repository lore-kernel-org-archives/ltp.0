From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 26 May 2021 11:23:54 +0800
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile09 to the
 new API
In-Reply-To: <YK0UA1wzaROqJDD7@pevik>
References: <20210519084655.52780-1-xieziyao@huawei.com>
 <20210519084655.52780-3-xieziyao@huawei.com> <YKbbCLUlaICqSIK5@pevik>
 <88d2297a-58f1-2ee3-0db4-6686ffbf4de2@huawei.com> <YKeXHtPOexQr8Iic@pevik>
 <YK0UA1wzaROqJDD7@pevik>
Message-ID: <ea9ff360-540a-527c-83d4-44e8ad1c1b68@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> 
> BTW I wonder if test could be run with less than 5GB, which is quite a lot.
> 
According to the kernel commit 5d73320a96fcc,testcase for the sendfile 
of lengths greater than 2G (maybe offset+count) is OK.

IMHO, maybe we can reduce the size, but still a lot.

Kind regards,
Ziyao
