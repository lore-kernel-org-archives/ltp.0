From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Mar 2021 12:15:07 +0100
Subject: [LTP] [PATCH] setns01.c: Change TINFO to TCONF since TINFO will
 not update test results
In-Reply-To: <20210309040015.21891-1-zhaogongyi@huawei.com>
References: <20210309040015.21891-1-zhaogongyi@huawei.com>
Message-ID: <YEdYuzZQVtjMS91b@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> When ns_total < 2 in testcase[3], we need to use TCONF since TINFO will not
> update test results, and test will be broken.

Good catch, thanks! Pushed.

Kind regards,
Petr
