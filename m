From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Mar 2019 15:03:04 +0100
Subject: [LTP] [PATCH 4/4] shell: Use $FS_TYPE and $TST_DEVICE as
 default params in tst_mkfs()
In-Reply-To: <20190220162014.5467-4-pvorel@suse.cz>
References: <20190220162014.5467-1-pvorel@suse.cz>
 <20190220162014.5467-4-pvorel@suse.cz>
Message-ID: <20190313140304.GC31637@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This one is OK apart from the names for the variables, i.e. FS_TYPE
should get TST_ prefix and TST_MOUNT should became TST_MNTPOINT.

-- 
Cyril Hrubis
chrubis@suse.cz
