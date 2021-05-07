From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 May 2021 18:52:21 +0200
Subject: [LTP] [PATCH] openposix: Add '\n' at the end of printf
In-Reply-To: <20210419081647.25941-1-zhaogongyi@huawei.com>
References: <20210419081647.25941-1-zhaogongyi@huawei.com>
Message-ID: <YJVwRfKarwKvm77G@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhao,

> We need to add '\n' at the end of printf, or the print string
> may be orderless with error output.

> For all of the files of dir testcases/open_posix_testsuite/*
> which referenced.

I applied your patch with patch program (corrupted to be applied by git am) and
merged. Thanks!

Kind regards,
Petr
