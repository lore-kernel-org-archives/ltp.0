From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 May 2021 17:11:39 +0200
Subject: [LTP] [PATCH] syscalls/mlockall03: Bugfix for running with
 option "-i"
In-Reply-To: <20210507020416.29792-1-zhaogongyi@huawei.com>
References: <20210507020416.29792-1-zhaogongyi@huawei.com>
Message-ID: <YJVYqywnA8GuMMN8@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhao,

> When run the test with option "-i 2", test will fail and
> report "mlockall03.c:144: mlockall() Failed while setup
> for checking error tried to lock more memory than the
> limit permitted"

Good catch, merged!

Kind regards,
Petr
