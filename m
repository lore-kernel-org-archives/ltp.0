From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 30 Aug 2017 20:11:27 +0800
Subject: [LTP]  Same tests running twice by default takes more time
Message-ID: <6e3d5368-dc91-4dcc-659f-2c0586bd9448@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Recently some existing tests or new tests that belong to specific
category were added to runtest/cve, it is reasonable to do so indeed
as they were designed to do the regression test, but I think it is not
good to run the exactly same test twice by default, for now there are
only 8, but this is growing, and it will take more time to finish.

what do you think? Is it necessary to make them just run once actually?




