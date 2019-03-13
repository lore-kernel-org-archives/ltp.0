From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Mar 2019 16:19:59 +0100
Subject: [LTP] [PATCH 4/4] shell: Use $FS_TYPE and $TST_DEVICE as
 default params in tst_mkfs()
In-Reply-To: <20190313140304.GC31637@rei>
References: <20190220162014.5467-1-pvorel@suse.cz>
 <20190220162014.5467-4-pvorel@suse.cz> <20190313140304.GC31637@rei>
Message-ID: <20190313151959.GA11120@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> This one is OK apart from the names for the variables, i.e. FS_TYPE
> should get TST_ prefix and TST_MOUNT should became TST_MNTPOINT.
Thanks for the review. Good points, do that + document TST_FS_TYPE.

Kind regards,
Petr
