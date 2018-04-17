From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Apr 2018 20:48:20 +0200
Subject: [LTP] [PATCH 1/1] network/vxlan02.sh: Fix duplicate parameters
In-Reply-To: <68b8a150-1dc5-258b-ca43-98599954c400@oracle.com>
References: <20180416221141.2781-1-pvorel@suse.cz>
 <1ea39ca6-a8c1-92b1-809f-8df162d36ee0@oracle.com>
 <68b8a150-1dc5-258b-ca43-98599954c400@oracle.com>
Message-ID: <20180417184820.6kq7xxuedd5rh2vt@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,
> Hi Petr,

> Not related to the patch, also noted that now vxlan03.sh tests
> have some errors when parsing the args. Not sure if it has any
> effect on the test itself...

> vxlan03.sh -d uni
> /opt/ltp/testcases/bin/vxlan03.sh: illegal option -- d
> /opt/ltp/testcases/bin/tst_net.sh: line 37: ?: command not found

Thanks for report, fixed in
06ee2b027 network/vxlan03: Fix getopts parameters passed to virt_lib.sh

> Thanks,
> Alexey

Kind regards,
Petr
