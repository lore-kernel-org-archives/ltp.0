From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Feb 2016 14:07:14 +0100
Subject: [LTP] [RFC PATCH 1/2] tst_acquire_device: clear first sectors
 of LTP_DEV
In-Reply-To: <56CDA654.3040802@oracle.com>
References: <1455975251-30056-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160222103408.GA5530@rei.lan> <56CDA654.3040802@oracle.com>
Message-ID: <20160224130714.GB8292@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Regarding the force flag. Yes, we no longer need it now.
> 
> I tried to execute mount* test cases with ext2/ext3/xfs/btrfs file 
> systems with the attached patch and they all passed.
> 
> So am I proceeding with a more formal patch?

Sounds good.

-- 
Cyril Hrubis
chrubis@suse.cz
