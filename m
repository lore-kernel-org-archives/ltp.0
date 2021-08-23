From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Aug 2021 15:58:25 +0200
Subject: [LTP] [PATCH v6,
 4/4] Make argument to tst_umount an absolute path
In-Reply-To: <20210804015539.GA22997@andestech.com>
References: <20210804015539.GA22997@andestech.com>
Message-ID: <YSOpgaQUx4cmuxpb@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Leo,

unfortunately not all tests has been fixed.
df01.sh uses tst_umount as a cleanup function with the default TST_MNTPOINT,
thus we should change it => I'll comment that in the first patch.

Kind regards,
Petr
