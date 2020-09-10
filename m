From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Sep 2020 10:54:04 +0200
Subject: [LTP] [PATCH v2] route{4,
 6}-rmmod: Declare variables before using them
In-Reply-To: <1599705028-12889-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1599705028-12889-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <20200910085404.GA23343@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Feiyu,

> When running route4-rmmod case, it reports the following error:
> /opt/ltp/testcases/bin/route4-rmmod: line 100: lhost_module: unbound variable.

> It fails because "set -u" is used in .testcases/lib/cmdlib.sh and
> "set -u" treats unset variables and parameters as errors.

Thanks a lot for update, merged.

Kind regards,
Petr
