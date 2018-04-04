From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 4 Apr 2018 16:59:28 +0300
Subject: [LTP] [RFC PATCH v3 5/5] net: Migrate test_net_stress.sh and
 it's dependencies to new shell API
In-Reply-To: <20180403154717.22491-6-pvorel@suse.cz>
References: <20180403154717.22491-1-pvorel@suse.cz>
 <20180403154717.22491-6-pvorel@suse.cz>
Message-ID: <01e302f9-be2e-b120-6f07-42c595ca5ba0@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03.04.2018 18:47, Petr Vorel wrote:
> + rename it to tst_net_stress.sh, The new name states that library
> supports new API.

And we should also rename it in stress/ns-tools/Makefile.

Thanks,
Alexey
